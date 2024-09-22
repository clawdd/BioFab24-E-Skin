import serial
import csv
import time

# Configure serial port (replace 'COM3' with your serial port)
SERIAL_PORT = 'COM3'  # For Windows, it could be 'COMx', and for Linux, it could be '/dev/ttyUSB0' or similar
BAUD_RATE = 9600  # Set baud rate for the serial port

# CSV file where the data will be saved
CSV_FILE = 'serial_output.csv'

def read_serial_data(serial_port, baud_rate, output_file):
    try:
        # Open the serial port
        ser = serial.Serial(serial_port, baud_rate, timeout=1)
        print(f"Listening on {serial_port} at {baud_rate} baud rate")

        # Open (or create) the CSV file and set up the writer
        with open(output_file, mode='w', newline='') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerow(['Timestamp (MM:SS)', 'Serial Data'])  # CSV header

            # Record the starting time
            start_time = time.time()

            # Continuously read data from the serial port
            while True:
                if ser.in_waiting > 0:
                    # Read data from the serial port
                    serial_data = ser.readline().decode('utf-8').strip()

                    # Calculate elapsed time in seconds since the start
                    elapsed_time = time.time() - start_time

                    # Convert elapsed time to Minutes:Seconds format
                    minutes = int(elapsed_time // 60)
                    seconds = int(elapsed_time % 60)
                    timestamp = f"{minutes:02d}:{seconds:02d}"

                    # Write the timestamp and serial data to the CSV file
                    csv_writer.writerow([timestamp, serial_data])
                    print(f"{timestamp}, {serial_data}")  # Optional: Print to the console

    except serial.SerialException as e:
        print(f"Error with the serial port: {e}")
    except KeyboardInterrupt:
        print("\nSerial reading stopped.")
    finally:
        if ser.is_open:
            ser.close()
        print("Serial port closed.")

if __name__ == "__main__":
    read_serial_data(SERIAL_PORT, BAUD_RATE, CSV_FILE)
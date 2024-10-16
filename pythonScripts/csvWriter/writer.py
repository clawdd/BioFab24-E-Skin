import serial
import csv
import time

SERIAL_PORT = 'COM3'
BAUD_RATE = 9600

CSV_FILE = 'serial_output.csv'

def read_serial_data(serial_port, baud_rate, output_file):
    try:
        ser = serial.Serial(serial_port, baud_rate, timeout=1)
        print(f"Listening on {serial_port} at {baud_rate} baud rate")

        with open(output_file, mode='w', newline='') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerow(['Timestamp (MM:SS)', 'Serial Data'])

            start_time = time.time()

            while True:
                if ser.in_waiting > 0:
                    serial_data = ser.readline().decode('utf-8').strip()

                    elapsed_time = time.time() - start_time

                    minutes = int(elapsed_time // 60)
                    seconds = int(elapsed_time % 60)
                    timestamp = f"{minutes:02d}:{seconds:02d}"

                    csv_writer.writerow([timestamp, serial_data])
                    print(f"{timestamp}, {serial_data}")

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
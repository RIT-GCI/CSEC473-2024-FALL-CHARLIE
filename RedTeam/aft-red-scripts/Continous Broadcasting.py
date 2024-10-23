import socket
import time

def send_broadcast_message(port=12345, interval=1):
    message = "Who did that"
    """
    Continuously send broadcast UDP packets with a given message.

    :param message: The message to broadcast.
    :param port: The UDP port to send the broadcast to (default is 12345).
    :param interval: Time interval in seconds between packets (default is 1 second).
    """
    # Create a UDP socket
    udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    
    # Enable broadcasting mode
    udp_socket.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

    broadcast_address = ('255.255.255.255', port)
    
    try:
        print(f"Broadcasting message '{message}' to port {port} every {interval} second(s).")

        while True:
            # Send broadcast message
            udp_socket.sendto(message.encode('utf-8'), broadcast_address)

            # Wait for the specified interval before sending the next packet
            time.sleep(interval)
    
    except KeyboardInterrupt:
        print("\nBroadcasting stopped.")
    
    finally:
        # Close the socket
        udp_socket.close()

# Example usage
if __name__ == "__main__":
    # Message to broadcast, port number, and interval in seconds
    message = "This is a broadcast message"
    port = 12345  # Default port
    interval = 1  # Send packet every 1 second

    send_broadcast_message(message, port, interval)

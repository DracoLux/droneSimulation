import network.common.Command;
import network.server.ServerCommand;
import network.client.ClientListener;
import network.client.Client;

public class ClientAdapter implements ClientListener {

	@Override
	public void messageReceived(Client client, Object msg) {
		System.out.println(msg);
    
    String msgStr = String.valueOf(msg);
    
    String[] arr = msgStr.split("-");
    
    Drone drone = getDroneByClient(client);
    
    int x = Integer.parseInt(arr[0]);
    int y = Integer.parseInt(arr[1]);
    int z = Integer.parseInt(arr[2]);
    
    Coordinate dest = new Coordinate(x,y,z);
    drone.goToDestination(dest);
    
	}

	@Override
	public void commandReceived(Client client, Command cmd) {  
		// TODO Auto-generated method stub
    	if (cmd == ServerCommand.DISCONNECTED)
		  client.shutDown();
	}

	@Override
	public void disconnected(Client client) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void messageSent(Client client, Object msg) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void commandSent(Client client, Command cmd) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void connected(Client client) {
		// TODO Auto-generated method stub
		
	}


}

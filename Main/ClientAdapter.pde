import network.common.Command;
import network.common.Coordinate;
import network.server.ServerCommand;
import network.client.ClientListener;
import network.client.Client;

public class ClientAdapter implements ClientListener {

	@Override
	public void messageReceived(Client client, Object msg) {
		System.out.println(msg);
	}

	@Override
	public void commandReceived(Client client, Command cmd) {  
    System.out.println(cmd);
    Drone drone = getDroneByClient(client);
    
    if (cmd instanceof Coordinate){
      Coordinate dest = (Coordinate) cmd;
      drone.goToDestination(dest);
    } 
    else if (cmd instanceof LightChange){
      LightChange light = (LightChange) cmd;
      drone.lightColor = light.lightColor;
      drone.tempColor = light.lightColor;
      drone.lightVolume = light.lightVolume;
    }
    else if(cmd == ServerCommand.HOVER){
      
    }
    else if(cmd == ServerCommand.LAND){
      
    }
    else if(cmd == ServerCommand.TAKEOFF){
      
    }
    else if (cmd == ServerCommand.DISCONNECTED){
		  client.shutDown();
    }
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

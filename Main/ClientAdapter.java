package network.client;

import network.common.Command;

public class ClientAdapter implements ClientListener {

	@Override
	public void messageReceived(Client client, Object msg) {
		System.out.println(msg);
		
	}

	@Override
	public void commandReceived(Client client, Command cmd) {
		// TODO Auto-generated method stub
		if (cmd == Command.DISCONNECTED)
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

From: Alan Stern <stern@rowland.harvard.edu>
Subject: Possible problem with device_move()
Date: Sat, 28 Jul 2007 11:36:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707281123080.16987-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Cornelia and Marcel:

The only places in the kernel that call device_move() are in 
drivers/s390/cio/device.c and net/bluetooth/rfcomm/tty.c, so I want to 
check with the two of you.

I'm in the midst of changing the Power Management core to make it
acquire the device semaphore of every device during a suspend and
resume.  The order of acquisition is the order of device registration, 
which normally agrees with the way locks are acquired when going 
through the device tree (i.e., parents before children).

But when you call device_move() that might no longer be true.  If a 
device is moved so that its new parent was registered _after_ it was, 
then the two orders will disagree.  This raises the possibility of a 
deadlock if any thread ever tries to lock the device while holding the 
new parent's lock -- as might happen during an unregistration, for 
example.

Can you tell whether this will ever cause a problem?  Or is it known to
be safe because whenever you call device_move(), the new parent was
registered before the device being moved?

Thanks,

Alan Stern

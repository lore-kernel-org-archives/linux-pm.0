From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Possible problem with device_move()
Date: Mon, 30 Jul 2007 13:37:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707301334590.9339-100000@iolanthe.rowland.org>
References: <1185778420.5868.90.camel@violet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185778420.5868.90.camel@violet>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 30 Jul 2007, Marcel Holtmann wrote:

> Hi Alan,
> 
> > I'm in the midst of changing the Power Management core to make it
> > acquire the device semaphore of every device during a suspend and
> > resume.  The order of acquisition is the order of device registration, 
> > which normally agrees with the way locks are acquired when going 
> > through the device tree (i.e., parents before children).
> > 
> > But when you call device_move() that might no longer be true.  If a 
> > device is moved so that its new parent was registered _after_ it was, 
> > then the two orders will disagree.  This raises the possibility of a 
> > deadlock if any thread ever tries to lock the device while holding the 
> > new parent's lock -- as might happen during an unregistration, for 
> > example.
> 
> the Bluetooth subsystem or the RFCOMM TTY code to be more precise uses
> device_move() to attach an registered /dev/rfcommX device node (but not
> connected) to the appropriate Bluetooth adapter and the low-level
> piconet connection when you open (and thus connect) it.
> 
> So mainly we re-parent the TTY to the Bluetooth connection and after the
> connection terminates we re-parent it to the virtual tree (NULL).

What would happen to the TTY if the Bluetooth adapter was unplugged 
while it was in use?  Would the adapter's release routine try to 
acquire the TTY's device sem?

Alan Stern

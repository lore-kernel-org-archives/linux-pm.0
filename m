From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Possible problem with device_move()
Date: Tue, 31 Jul 2007 11:11:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707311104270.3520-100000@iolanthe.rowland.org>
References: <20070731103305.39b76a5d@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070731103305.39b76a5d@gondolin.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 31 Jul 2007, Cornelia Huck wrote:

> On Mon, 30 Jul 2007 13:34:35 -0400 (EDT),
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > As long as you never hold the device semaphores of both the parent and 
> > the child there shouldn't be any problem.  Could this happen when a 
> > subchannel structure is deallocated?
> 
> This is indeed what happens, since we unregister the child ccw_device
> from the (io_)subchannel's remove function.
> 
> (We used to do unregistering of the ccw_device via a workqueue (in
> order to avoid livelocks on a no longer existing bus semaphore), but
> removed it since it seemed to be needlessly complicated code.)

It sounds like you might be in trouble with suspend anyway (if S390
implemented it).  As things stand now, the PM core would try to suspend
the subchannel before suspending the ccw_device, because the subchannel 
was registered later.

Marcel, you might be in a similar position.  The PM core could try to 
suspend a Bluetooth adapter before suspending its child TTY node.

I wonder if device_move() shouldn't change the order of entries in the 
dpm_active list so that the new parent (and all its ancestors) get 
moved up ahead of the device's position?  But that might cause other 
problems...

Alan Stern

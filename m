From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Possible problem with device_move()
Date: Tue, 31 Jul 2007 17:27:43 +0200
Message-ID: <200707311727.44495.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0707311104270.3520-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707311104270.3520-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 31 July 2007 17:11, Alan Stern wrote:
> On Tue, 31 Jul 2007, Cornelia Huck wrote:
> 
> > On Mon, 30 Jul 2007 13:34:35 -0400 (EDT),
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > > As long as you never hold the device semaphores of both the parent and 
> > > the child there shouldn't be any problem.  Could this happen when a 
> > > subchannel structure is deallocated?
> > 
> > This is indeed what happens, since we unregister the child ccw_device
> > from the (io_)subchannel's remove function.
> > 
> > (We used to do unregistering of the ccw_device via a workqueue (in
> > order to avoid livelocks on a no longer existing bus semaphore), but
> > removed it since it seemed to be needlessly complicated code.)
> 
> It sounds like you might be in trouble with suspend anyway (if S390
> implemented it).  As things stand now, the PM core would try to suspend
> the subchannel before suspending the ccw_device, because the subchannel 
> was registered later.
> 
> Marcel, you might be in a similar position.  The PM core could try to 
> suspend a Bluetooth adapter before suspending its child TTY node.
> 
> I wonder if device_move() shouldn't change the order of entries in the 
> dpm_active list so that the new parent (and all its ancestors) get 
> moved up ahead of the device's position?  But that might cause other 
> problems...

Still, if the ordering of dpm_active doesn't reflect the relationships between
devices, we're in trouble anyway.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

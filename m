From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Wed, 26 May 2010 23:11:56 +0200
Message-ID: <201005262311.56190.rjw__6796.24645640633$1274916121$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005261352440.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005261352440.1328-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 May 2010, Alan Stern wrote:
> On Wed, 26 May 2010, Matthew Garrett wrote:
> 
> > On Wed, May 26, 2010 at 12:56:33PM -0400, Alan Stern wrote:
> > 
> > > I don't know how that works.  However an easy approach would be to make
> > > opening the device file (or however the userspace driver gets a
> > > reference to the device) cause the core to do a pm_runtime_get_sync(),
> > > with a corresponding pm_runtime_put_sync() when the file is closed.
> > 
> > No, X is far worse than you think. It's handled by mmap()ping /dev/mem.
> 
> Ugh.
> 
> Well, we still need some sort of map for how this will work, otherwise 
> things will quickly get messed up.

For now, I think, we should leave the unbound devices active, which is the
easiest approach.

> Is it necessary to stick to a policy that _all_ unbound PCI devices 
> must be active?  Even those which were bound to a driver and then 
> unbound?

At this point, yes.  At least drivers should leave the devices active and
let the core power take care of them.

If drivers always leave devices active, we can implement the power
management of unbound devices in the core in future. 

> Is there some way for the core to tell which devices will be handled by
> X, so that all others can be runtime suspended?

The problem is, there are other driverless devices that fail to work if
power managed at run time and that varies from one machine to another.
This generally is a mine filed I wouldn't like to go into without serious
preparations. :-)

> When a PCI driver's probe routine is called, it shouldn't need to call
> pm_runtime_set_active() or pm_runtime_enable().
> The core should take care of this before the device is registered.

Unfortunately, the core has no idea whether or not the driver is power-aware
until probe() is called.

> One reasonably design would be to make PM-aware drivers responsible for
> doing an initial pm_runtime_put_sync() in order to allow their devices to
> suspend (plus a corresponding pm_runtime_get_sync() in the release method).

I don't think there is a universal way to go.  So far I've implemented runtime
PM in two network drivers (e1000e and r8169, the patches have just been merged)
and each time the approach had to be slightly different.

Rafael

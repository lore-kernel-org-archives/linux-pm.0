From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Make system-wide PM and runtime
	PM handle subsystems consistently
Date: Wed, 16 Feb 2011 13:24:49 +0100
Message-ID: <201102161324.49633.rjw__44806.6949997612$1297917810$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1102141123370.1716-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1102141123370.1716-100000@iolanthe.rowland.org>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 14, 2011, Alan Stern wrote:
> On Sat, 12 Feb 2011, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The code handling system-wide power transitions (eg. suspend-to-RAM)
> > can in theory execute callbacks provided by the device's bus type,
> > device type and class in each phase of the power transition.  In
> > turn, the runtime PM core code only calls one of those callbacks at
> > a time, preferring bus type callbacks to device type or class
> > callbacks and device type callbacks to class callbacks.
> > 
> > It seems reasonable to make them both behave in the same way in that
> > respect.  Moreover, even though a device may belong to two subsystems
> > (eg. bus type and device class) simultaneously, in practice power
> > management callbacks for system-wide power transitions are always
> > provided by only one of them (ie. if the bus type callbacks are
> > defined, the device class ones are not and vice versa).  Thus it is
> > possible to modify the code handling system-wide power transitions
> > so that it follows the core runtime PM code (ie. treats the
> > subsystem callbacks as mutually exclusive).
> > 
> > On the other hand, the core runtime PM code will choose to execute,
> > for example, a runtime suspend callback provided by the device type
> > even if the bus type's struct dev_pm_ops object exists, but the
> > runtime_suspend pointer in it happens to be NULL.  This is confusing,
> > because it may lead to the execution of callbacks from different
> > subsystems during different operations (eg. the bus type suspend
> > callback may be executed during runtime suspend, while the device
> > type callback will be executed during runtime resume).
> > 
> > Make all of the power management code treat subsystem callbacks in
> > a consistent way, such that:
> > (1) If the device's bus type is defined (eg. dev->bus is not NULL)
> >     and its pm pointer is not NULL, the callbacks from dev->bus->pm
> >     will be used.
> > (2) If dev->bus is NULL or dev->bus->pm is NULL, but the device's
> >     device type is defined (eg. dev->type is not NULL) and its pm
> >     pointer is not NULL, the callbacks from dev->type->pm will be
> >     used.
> > (3) If dev->bus is NULL or dev->bus->pm is NULL and dev->type is
> >     NULL or dev->type->pm is NULL, the callbacks from dev->class->pm
> >     will be used provided that both dev->class and dev->class->pm
> >     are not NULL.
> 
> It looks okay, but I haven't tested it.

Unfortunately, it doesn't work on my Acer Ferrari One.  The problem is that
hcd_pci_suspend() fails for the EHCI controller, apparently because the root
hub is not suspended.  Do root hubs need both class suspend and bus type
suspend to work at the same time?

Rafael

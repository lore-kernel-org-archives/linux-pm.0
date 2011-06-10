From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 22:27:25 +0200
Message-ID: <201106102227.25391.rjw__1526.92650813169$1307737652$gmane$org@sisk.pl>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com>
	<201106102038.22725.rjw@sisk.pl>
	<20110610184222.GT26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110610184222.GT26436@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 10, 2011, Mark Brown wrote:
> On Fri, Jun 10, 2011 at 08:38:22PM +0200, Rafael J. Wysocki wrote:
> > On Friday, June 10, 2011, Mark Brown wrote:
> 
> > > I think from an interface point of view it's something like
> > > UNIVERSAL_DEV_PM_OPS() and friends, probably with some additional ops
> > > that can do the glue bits like enabling wakeup and quiescing activity.
> > > I'd need to think harder about what exactly that'd look like - for my
> > > cases the fundamental thing I want to say is that there's one suspend
> > > routine and one resume routine and I'd like some framework code to work
> > > out when they're called.
> 
> > Can your device generate wakeup signals?
> 
> I am interested in a fairly large selection of devices but broadly
> speaking any off-SoC device can generate wakeups if it can generate
> interrupts.

So, there are a few things to consider:

* Can the device do things like DMA?
* Does the driver use a workqueue?
* Does it use timers?

In all of the above cases your system suspend handling will require extra
care to make sure those things won't get in the way of the suspend process.

Next, what subsystem (e.g. bus type) is the driver going to work with?

If the subsystem is "smart" enough, it can take care of many things, like
"powering off", wakeup preparations and so on.

Now, there are a few combinations possible.  First, if the subsystem is
"smart" and the driver need not take care of the things listed above, then
very likely .runtime_suspend() and .suspend() can do the same and
UNIVERSAL_DEV_PM_OPS() can be used.  Next, if the subsystem is "smart",
but the driver needs to take care of those things, then .suspend() has
more to do, but very likely .runtime_suspend() and .suspend_noirq() can
do the same, while .suspend() may simply prepare the device for the next
stage.  And so on.

It's probably fair to say that everithing depends on the subsystem, what it
does and what it expects from the driver.  In the extreme case, when the
subsystem is like the platform bus type, the driver unfortunately is on its
own and has to deal with the whole complexity.

Thanks,
Rafael

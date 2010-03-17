From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Wed, 17 Mar 2010 22:46:32 +0100
Message-ID: <201003172246.32443.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1003171305410.1734-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003171305410.1734-100000@iolanthe.rowland.org>
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
Cc: Magnus Damm <damm@igel.co.jp>
List-Id: linux-pm@vger.kernel.org

On Wednesday 17 March 2010, Alan Stern wrote:
> On Wed, 17 Mar 2010, Kevin Hilman wrote:
> 
> > >> In my case, the driver's runtime_suspend and runtime_resume hooks are
> > >> not where the clocks are managed.  The actual hardware enable/disable
> > >> is done in the bus-level runtime PM hooks, in this case platform_bus.
> > >> So having the system PM methods directly call the drivers runtime PM
> > >> methods doesn't help.  In fact, because we handle the hardware at the
> > >> bus level, most drivers can live without any runtime PM methods, and
> > >> simply use get/put.
> > >> 
> > >> I've worked around this temporarily by calling the
> > >> bus->pm->runtime_suspend() and ->runtime_resume() methods from the
> > >> system PM methods, but am curious if that is an acceptable solution.
> > >
> > > If the platform bus manages the clocks from within its runtime-PM 
> > > routines, then it ought to provide a similar service from within its 
> > > system-PM routines.  
> > 
> > Hmm, good point.  Currently the platform bus code allows overriding
> > the runtime PM methods via weak functions (drivers/base/platform.c)
> > but not the system PM methods.  Below is a patch that allows platforms
> > to extend the system PM methods of the platform bus as well.
> > 
> > > You could do it by calling the bus's runtime-PM 
> > > routines indirectly through the method pointers (as you do now), or by 
> > > calling the runtime-PM routines directly, or by making the runtime-PM 
> > > routines and the system-PM routines both call a separate common 
> > > function responsible for managing the clocks.
> > 
> > Using the patch below, I am able to add custom system PM hooks and then
> > use common code to manage the clocks for runtime PM and system PM.
> > 
> > Comments?
> > 
> > Kevin
> > 
> > 
> > commit ca2173923bae3ba631e12698401ef0b59ec0433c
> > Author: Kevin Hilman <khilman@deeprootsystems.com>
> > Date:   Wed Mar 17 09:36:10 2010 -0700
> > 
> >     platform_bus: allow custom extensions to system PM methods
> >     
> >     When runtime PM for platform_bus was added, it allowed for platforms
> >     to customize the runtime PM methods since they are defined as weak
> >     symbols.
> >     
> >     This patch allows platforms to extend the system PM methods with
> >     custom hooks as well so runtime PM and system PM extensions can be
> >     managed together.
> >     
> >     Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 1ba9d61..a30f850 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -729,6 +729,26 @@ static void platform_pm_complete(struct device *dev)
> >  
> >  #ifdef CONFIG_SUSPEND
> 
> This probably should be CONFIG_SLEEP.

CONFIG_PM_SLEEP to be precise.

> > +int __weak platform_pm_suspend_hook(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +int __weak platform_pm_suspend_noirq_hook(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +int __weak platform_pm_resume_hook(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +int __weak platform_pm_resume_noirq_hook(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> >  static int platform_pm_suspend(struct device *dev)
> >  {
> >  	struct device_driver *drv = dev->driver;
> > @@ -744,6 +764,8 @@ static int platform_pm_suspend(struct device *dev)
> >  		ret = platform_legacy_suspend(dev, PMSG_SUSPEND);
> >  	}
> >  
> > +	platform_pm_suspend_hook(dev);
> > +
> >  	return ret;
> >  }
> >  
> > @@ -760,6 +782,8 @@ static int platform_pm_suspend_noirq(struct device *dev)
> >  			ret = drv->pm->suspend_noirq(dev);
> >  	}
> >  
> > +	platform_pm_suspend_noirq_hook(dev);
> > +
> >  	return ret;
> >  }
> >  
> > @@ -768,6 +792,8 @@ static int platform_pm_resume(struct device *dev)
> >  	struct device_driver *drv = dev->driver;
> >  	int ret = 0;
> >  
> > +	platform_pm_resume_hook(dev);
> > +
> >  	if (!drv)
> >  		return 0;
> >  
> > @@ -786,6 +812,8 @@ static int platform_pm_resume_noirq(struct device *dev)
> >  	struct device_driver *drv = dev->driver;
> >  	int ret = 0;
> >  
> > +	platform_pm_resume_noirq_hook(dev);
> > +
> >  	if (!drv)
> >  		return 0;
> >  
> 
> It looks reasonable to me, but I'm not actively involved in PM for the 
> platform bus.  Magnus Damm might have some suggestions.

Yes, I think Magnus is the right person to ask for comments.

Rafael

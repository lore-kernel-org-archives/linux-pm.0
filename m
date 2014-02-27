From: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/3] usb: phy: msm: use ASSIGN_*_PM_OPS variants
Date: Thu, 27 Feb 2014 15:52:43 -0800
Message-ID: <20140227235243.GC21032@psi-dev26.jf.intel.com>
References: <1393261707-30565-1-git-send-email-joshc@codeaurora.org>
 <1393261707-30565-4-git-send-email-joshc@codeaurora.org>
 <20140225183336.GH23275@saruman.home>
 <20140227190324.GC4421@kroah.com>
 <20140227234129.GA21032@psi-dev26.jf.intel.com>
 <20140227234425.GA32426@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140227234425.GA32426-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 27, 2014 at 03:44:25PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Feb 27, 2014 at 03:41:31PM -0800, David Cohen wrote:
> > On Thu, Feb 27, 2014 at 11:03:24AM -0800, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 25, 2014 at 12:33:36PM -0600, Felipe Balbi wrote:
> > > > Hi,
> > > > 
> > > > On Mon, Feb 24, 2014 at 11:08:27AM -0600, Josh Cartwright wrote:
> > > > > Use ASSIGN_SYSTEM_SLEEP_PM_OPS and ASSIGN_RUNTIME_PM_OPS in the
> > > > > initializer for msm_otg_dev_pm_ops.  Doing so allows us to eliminate
> > > > > preprocessor conditionals around the specified callbacks.
> > > > > 
> > > > > Signed-off-by: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > > > > ---
> > > > >  drivers/usb/phy/phy-msm-usb.c | 13 +++----------
> > > > >  1 file changed, 3 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
> > > > > index 5b37b81..c04f2e3 100644
> > > > > --- a/drivers/usb/phy/phy-msm-usb.c
> > > > > +++ b/drivers/usb/phy/phy-msm-usb.c
> > > > > @@ -414,8 +414,6 @@ static int msm_otg_reset(struct usb_phy *phy)
> > > > >  #define PHY_SUSPEND_TIMEOUT_USEC	(500 * 1000)
> > > > >  #define PHY_RESUME_TIMEOUT_USEC	(100 * 1000)
> > > > >  
> > > > > -#ifdef CONFIG_PM
> > > > > -
> > > > >  #define USB_PHY_SUSP_DIG_VOL  500000
> > > > >  static int msm_hsusb_config_vddcx(int high)
> > > > >  {
> > > > > @@ -609,7 +607,6 @@ skip_phy_resume:
> > > > >  
> > > > >  	return 0;
> > > > >  }
> > > > > -#endif
> > > > >  
> > > > >  static void msm_otg_notify_charger(struct msm_otg *motg, unsigned mA)
> > > > >  {
> > > > > @@ -1664,7 +1661,6 @@ static int msm_otg_remove(struct platform_device *pdev)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > -#ifdef CONFIG_PM_RUNTIME
> > > > >  static int msm_otg_runtime_idle(struct device *dev)
> > > > >  {
> > > > >  	struct msm_otg *motg = dev_get_drvdata(dev);
> > > > > @@ -1699,9 +1695,7 @@ static int msm_otg_runtime_resume(struct device *dev)
> > > > >  	dev_dbg(dev, "OTG runtime resume\n");
> > > > >  	return msm_otg_resume(motg);
> > > > >  }
> > > > > -#endif
> > > > >  
> > > > > -#ifdef CONFIG_PM_SLEEP
> > > > >  static int msm_otg_pm_suspend(struct device *dev)
> > > > >  {
> > > > >  	struct msm_otg *motg = dev_get_drvdata(dev);
> > > > > @@ -1731,12 +1725,11 @@ static int msm_otg_pm_resume(struct device *dev)
> > > > >  
> > > > >  	return 0;
> > > > >  }
> > > > > -#endif
> > > > >  
> > > > >  static const struct dev_pm_ops msm_otg_dev_pm_ops = {
> > > > > -	SET_SYSTEM_SLEEP_PM_OPS(msm_otg_pm_suspend, msm_otg_pm_resume)
> > > > > -	SET_RUNTIME_PM_OPS(msm_otg_runtime_suspend, msm_otg_runtime_resume,
> > > > > -				msm_otg_runtime_idle)
> > > > > +	ASSIGN_SYSTEM_SLEEP_PM_OPS(msm_otg_pm_suspend, msm_otg_pm_resume)
> > > > > +	ASSIGN_RUNTIME_PM_OPS(msm_otg_runtime_suspend, msm_otg_runtime_resume,
> > > > > +			      msm_otg_runtime_idle)
> > > > 
> > > > if the patch introducing assign_if() gets accepted, I'm ok with this
> > > > patch.
> > > 
> > > I can't take that patch at this point in time, it's just too ugly...
> > > 
> > > As are those crazy SET_SYSTEM_SLEEP_PM_OPS() macros, ick, who made those
> > > things?
> > > 
> > > What language are we trying to program in here people?
> > 
> > Since we're discussing this topic here, I'd like point my RFC which gets
> > rid of same ifdeffery in a different way:
> > http://lkml.org/lkml/2013/12/13/4
> 
> Again, why can't we just always define these fields in the structure,
> then we don't need any crazy, complicated mess for assigning the
> function pointers?
> 
> Again, the odds that this config option is ever disabled in "real"
> systems is so low these days, I have half a mind just to rip it out
> entirely as the amount of work spent on compiler warnings and the like
> in this area has proably offset any power savings the code was supposed
> to save on systems :(

That makes sense :)
Thanks for your feedback.

BR, David

> 
> ick.
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

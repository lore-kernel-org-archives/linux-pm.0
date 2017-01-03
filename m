From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] mfd: intel-lpss: Avoid resuming runtime-suspended
 lpss unnecessarily
Date: Tue, 3 Jan 2017 12:29:03 +0000
Message-ID: <20170103122903.GE2977@dell>
References: <1475125286-12167-1-git-send-email-yu.c.chen@intel.com>
 <20161216231942.GA12460@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38012 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758455AbdACMZW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2017 07:25:22 -0500
Received: by mail-wm0-f44.google.com with SMTP id k184so232375634wme.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2017 04:25:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161216231942.GA12460@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>

On Sat, 17 Dec 2016, Lukas Wunner wrote:
> you wrote on Oct 4 that you applied the below patch for v4.10.
> However I don't see the patch on your for-mfd-next branch.
> Maybe the patch slipped between the cracks, please double-check.
> I would like to use the DPM_DIRECT_COMPLETE macro introduced by it
> in a patch of my own.

Chen asked me to remove the patch.

> I also don't see a pull from you in Linus' tree yet. Please note
> that this merge window will be shorter than usual and pulls should
> be sent out before coming Friday.

Right, I was on vacation.  All sorted now.

> On Thu, Sep 29, 2016 at 01:01:26PM +0800, Chen Yu wrote:
> > We have report that the intel_lpss_prepare() takes too much time during
> > suspend, and this is because we first resume the devices from runtime
> > suspend by resume_lpss_device(), to make sure they are in proper state
> > before system suspend, which takes 100ms for each LPSS devices(PCI power
> > state from D3_cold to D0). And since resume_lpss_device() resumes the
> > devices synchronously, we might get huge latency if we have many
> > LPSS devices.
> > 
> > So first try is to use pm_request_resume() instead, to make the runtime
> > resume process asynchronously. Unfortunately the asynchronous runtime
> > resume relies on pm_wq, which is freezed at early stage. So we choose
> > another method, that is to avoid resuming runtime-suspended devices,
> > if they are already runtime suspended. This is safe because for LPSS
> > driver, the runtime suspend and system suspend are of the same
> > hook - i.e., intel_lpss_suspend(). And moreover, this device is
> > neither runtime wakeup source nor system wakeup source.
> > 
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/mfd/intel-lpss.c | 9 +++++++++
> >  include/linux/pm.h       | 7 +++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> > index 41b1138..2583db8 100644
> > --- a/drivers/mfd/intel-lpss.c
> > +++ b/drivers/mfd/intel-lpss.c
> > @@ -485,6 +485,15 @@ static int resume_lpss_device(struct device *dev, void *data)
> >  int intel_lpss_prepare(struct device *dev)
> >  {
> >  	/*
> > +	 * This is safe because:
> > +	 * 1. The runtime suspend and system suspend
> > +	 * are of the same hook.
> > +	 * 2. This device is neither runtime wakeup source
> > +	 * nor system wakeup source.
> > +	 */
> > +	if (pm_runtime_status_suspended(dev))
> > +		return DPM_DIRECT_COMPLETE;
> > +	/*
> >  	 * Resume both child devices before entering system sleep. This
> >  	 * ensures that they are in proper state before they get suspended.
> >  	 */
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 06eb353..4a788b4 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -786,4 +786,11 @@ enum dpm_order {
> >  	DPM_ORDER_DEV_LAST,
> >  };
> >  
> > +/*
> > + * Return this from system suspend/hibernation ->prepare() callback to
> > + * request the core to leave the device runtime-suspended during system
> > + * suspend if possible.
> > + */
> > +#define DPM_DIRECT_COMPLETE 1
> > +
> >  #endif /* _LINUX_PM_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

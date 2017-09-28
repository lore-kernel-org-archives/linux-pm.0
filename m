From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/3] PM / mfd: intel-lpss: Push system sleep callbacks to late/early stages
Date: Thu, 28 Sep 2017 22:51:28 +0200
Message-ID: <4467518.bxgQJkVqZ4@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <4332008.kXBLY0K23i@aspire.rjw.lan> <20170928191909.ftpm5ktabe6fnufv@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170928191909.ftpm5ktabe6fnufv@dell>
Sender: linux-acpi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 28, 2017 9:19:09 PM CEST Lee Jones wrote:
> On Mon, 25 Sep 2017, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Push the system suspend/resume callbacks of intel-lpss to the late
> > suspend/early resume stages to allow child device callbacks to be
> > pushed to the late/early stages of suspend/resume too, so as to
> > make it possible to avoid resuming the children if they are runtime-
> > suspended during system suspend going forward.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Tested-by: Johannes Stezenbach <js@sig21.net>
> > Tested-by: Rajat Jain <rajatja@google.com>
> > ---
> > 
> > v3 -> v4: Added Tested-by tags.
> > 
> > ---
> >  drivers/mfd/intel-lpss.h |    7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > Index: linux-pm/drivers/mfd/intel-lpss.h
> > ===================================================================
> > --- linux-pm.orig/drivers/mfd/intel-lpss.h
> > +++ linux-pm/drivers/mfd/intel-lpss.h
> 
> Weird.  What format is this?
> 
> Don't you use `git format-patch` and `git send-email`?

No, I don't.

I'm an old-timer, I use quilt. :-)

> > @@ -38,12 +38,7 @@ int intel_lpss_resume(struct device *dev
> >  #ifdef CONFIG_PM_SLEEP
> >  #define INTEL_LPSS_SLEEP_PM_OPS			\
> >  	.prepare = intel_lpss_prepare,		\
> > -	.suspend = intel_lpss_suspend,		\
> > -	.resume = intel_lpss_resume,		\
> > -	.freeze = intel_lpss_suspend,		\
> > -	.thaw = intel_lpss_resume,		\
> > -	.poweroff = intel_lpss_suspend,		\
> > -	.restore = intel_lpss_resume,
> > +	SET_LATE_SYSTEM_SLEEP_PM_OPS(intel_lpss_suspend, intel_lpss_resume)
> 
> For the diff:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thank you!


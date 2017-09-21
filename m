From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mfd: intel-lpss: switch to
 suspend_late()/resume_early()
Date: Thu, 21 Sep 2017 16:17:34 +0100
Message-ID: <20170921151734.x5vfsmfycm73wtdw@dell>
References: <20170920223152.100641-1-rajatja@google.com>
 <CAJZ5v0iB6=C953zPBYW8fB+XW7fq4fwyP2W4S=ocgNwWic+gPg@mail.gmail.com>
 <20170921084133.pptabevkolnwv2wy@dell>
 <1817408.bhcOjT5fdi@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1817408.bhcOjT5fdi@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rajat Jain <rajatja@google.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, furquan@google.com, rajatxjain@gmail.com
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Sep 2017, Rafael J. Wysocki wrote:

> On Thursday, September 21, 2017 10:41:33 AM CEST Lee Jones wrote:
> > On Thu, 21 Sep 2017, Rafael J. Wysocki wrote:
> > 
> > > On Thu, Sep 21, 2017 at 12:31 AM, Rajat Jain <rajatja@google.com> wrote:
> > > > Ref: https://lkml.org/lkml/2017/9/19/649
> > > >
> > > > The intel-lpss hosts the designware i2c controller device, which
> > > > needs to be up and running until all its i2c child devices have
> > > > suspended (child devices need to be accessible over i2c until
> > > > suspend_late() has been called for all those devices).
> > > >
> > > > So lets delay the resetting of the controller until suspend_late().
> > > > I thought of renaming function to say *_late / *_early but that
> > > > might cause confusion since the same function is also used for runtime
> > > > suspend/resume.
> > > >
> > > > Fixes: 0b471aaa0e1a ("Put I2C and SPI controllers into reset state on suspend")
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > ---
> > > >  drivers/mfd/intel-lpss.h | 7 +------
> > > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
> > > > index 694116630ffa..865bbeaaf00c 100644
> > > > --- a/drivers/mfd/intel-lpss.h
> > > > +++ b/drivers/mfd/intel-lpss.h
> > > > @@ -38,12 +38,7 @@ int intel_lpss_resume(struct device *dev);
> > > >  #ifdef CONFIG_PM_SLEEP
> > > >  #define INTEL_LPSS_SLEEP_PM_OPS                        \
> > > >         .prepare = intel_lpss_prepare,          \
> > > > -       .suspend = intel_lpss_suspend,          \
> > > > -       .resume = intel_lpss_resume,            \
> > > > -       .freeze = intel_lpss_suspend,           \
> > > > -       .thaw = intel_lpss_resume,              \
> > > > -       .poweroff = intel_lpss_suspend,         \
> > > > -       .restore = intel_lpss_resume,
> > > > +       SET_LATE_SYSTEM_SLEEP_PM_OPS(intel_lpss_suspend, intel_lpss_resume)
> > > >  #else
> > > >  #define INTEL_LPSS_SLEEP_PM_OPS
> > > >  #endif
> > > 
> > > So I sent this exact patch several days ago:
> > > https://patchwork.kernel.org/patch/9939809/
> > 
> > You did?
> 
> Yes, I did.
> 
> > Any reason you didn't send it to me?
> 
> Well, Lee Jones <lee@kernel.org> is very much in the CC list of it.
> 
> Was I expected to use a different e-mail address for that?

I don't monitor that one.  Better to use the one in MAINTAINERS.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

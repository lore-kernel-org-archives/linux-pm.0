From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] PM: Add pm_ops_ptr() macro
Date: Tue, 30 Apr 2013 09:54:09 +0900
Message-ID: <000101ce453d$39611b70$ac235250$@samsung.com>
References: <000001ce42f2$96128cc0$c237a640$@samsung.com>
 <20119404.Sfu5WntByi@vostro.rjw.lan>
 <000001ce449c$3e1ce0f0$ba56a2d0$@samsung.com> <517E63C8.6040809@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42422 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759619Ab3D3AyL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2013 20:54:11 -0400
In-reply-to: <517E63C8.6040809@metafoo.de>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Lars-Peter Clausen' <lars@metafoo.de>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 'Len Brown' <len.brown@intel.com>, 'Pavel Machek' <pavel@ucw.cz>, linux-pm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

On Monday, April 29, 2013 9:13 PM, Lars-Peter Clausen wrote:
> On 04/29/2013 07:41 AM, Jingoo Han wrote:
> > On Saturday, April 27, 2013 11:41 PM, Rafael J. Wysocki:
> >>
> >> On Saturday, April 27, 2013 11:54:50 AM Jingoo Han wrote:
> >>> Add pm_ops_ptr() macro that allows the .pm entry in the driver structures
> >>> to be assigned without having an #define xxx NULL for the case that PM is
> >>> not enabled.
> >>>
> >>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> >>
> >> First, I'm not taking any more PM patches for v3.10 (that don't fix recent
> >> regressions).
> >>
> >> Second, please add that macro along with a user.
> >
> > Hi Rafael,
> >
> > This macro can be used as below:
> > This macro cannot affect the procedure of suspend/resume
> > calls; thus, there is no side effect.
> > It just reduces the code size of each drivers.
> > In this way, of_match_ptr() macro has been already used.
> >
> >
> > --- a/drivers/i2c/busses/i2c-s3c2410.c
> > +++ b/drivers/i2c/busses/i2c-s3c2410.c
> > @@ -1218,7 +1218,6 @@ static int s3c24xx_i2c_resume(struct device *dev)
> >  }
> >  #endif
> >
> > -#ifdef CONFIG_PM
> >  static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
> >  #ifdef CONFIG_PM_SLEEP
> >         .suspend_noirq = s3c24xx_i2c_suspend_noirq,
> > @@ -1226,11 +1225,6 @@ static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
> >  #endif
> >  };
> >
> > -#define S3C24XX_DEV_PM_OPS (&s3c24xx_i2c_dev_pm_ops)
> > -#else
> > -#define S3C24XX_DEV_PM_OPS NULL
> > -#endif
> > -
> >  /* device driver for platform bus bits */
> >
> >  static struct platform_driver s3c24xx_i2c_driver = {
> > @@ -1240,7 +1234,7 @@ static struct platform_driver s3c24xx_i2c_driver = {
> >         .driver         = {
> >                 .owner  = THIS_MODULE,
> >                 .name   = "s3c-i2c",
> > -               .pm     = S3C24XX_DEV_PM_OPS,
> > +               .pm     = pm_ops_ptr(&s3c24xx_i2c_dev_pm_ops),
> >                 .of_match_table = of_match_ptr(s3c24xx_i2c_match),
> >         },
> >  };
> 
> Won't that generate a warning about an unused s3c24xx_i2c_dev_pm_ops when
> CONFIG_PM is not enabled?

No, there is no build warning, when CONFIG_PM is not enabled.
In this way, of_match_ptr() macro has been already used
without build warnings.


Best regards,
Jingoo Han



From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] fbdev: bfin-lq035q1-fb: Use dev_pm_ops
Date: Fri, 31 May 2013 12:32:57 +0900
Message-ID: <000a01ce5daf$8b228b80$a167a280$@samsung.com>
References: <1369829859-13405-1-git-send-email-lars@metafoo.de>
 <51A60F83.7070403@analog.com> <20130529192013.GA19468@game.jcrosoft.org>
 <001801ce5ccd$2dd30be0$897923a0$@samsung.com>
 <20130530071413.GC19468@game.jcrosoft.org> <51A70532.3070502@metafoo.de>
 <20130530104535.GF19468@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:18223 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab3EaDc7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2013 23:32:59 -0400
In-reply-to: <20130530104535.GF19468@game.jcrosoft.org>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, "'Rafael J. Wysocki'" <rjw@sisk.pl>
Cc: 'Lars-Peter Clausen' <lars@metafoo.de>, 'Michael Hennerich' <michael.hennerich@analog.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

On Thursday, May 30, 2013 7:46 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 09:52 Thu 30 May     , Lars-Peter Clausen wrote:
> > On 05/30/2013 09:14 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 09:32 Thu 30 May     , Jingoo Han wrote:
> > >> On Thursday, May 30, 2013 4:20 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > >>> On 16:24 Wed 29 May     , Michael Hennerich wrote:
> > >>>> On 05/29/2013 02:17 PM, Lars-Peter Clausen wrote:
> > >>>>> Use dev_pm_ops instead of the legacy suspend/resume callbacks.
> > >>>>>
> > >>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > >>>> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> > >>>>> ---
> > >>>>>  drivers/video/bfin-lq035q1-fb.c | 22 ++++++++++++++--------
> > >>>>>  1 file changed, 14 insertions(+), 8 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
> > >>>>> index 29d8c04..6084c17 100644
> > >>>>> --- a/drivers/video/bfin-lq035q1-fb.c
> > >>>>> +++ b/drivers/video/bfin-lq035q1-fb.c
> > >>>>> @@ -170,16 +170,19 @@ static int lq035q1_spidev_remove(struct spi_device *spi)
> > >>>>>  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
> > >>>>>  }
> > >>>>> -#ifdef CONFIG_PM
> > >>>>> -static int lq035q1_spidev_suspend(struct spi_device *spi, pm_message_t state)
> > >>>>> +#ifdef CONFIG_PM_SLEEP
> > >>>>> +static int lq035q1_spidev_suspend(struct device *dev)
> > >>>>>  {
> > >>>>> +	struct spi_device *spi = to_spi_device(dev);
> > >>>>> +
> > >>>>>  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
> > >>>>>  }
> > >>>>> -static int lq035q1_spidev_resume(struct spi_device *spi)
> > >>>>> +static int lq035q1_spidev_resume(struct device *dev)
> > >>>>>  {
> > >>>>> -	int ret;
> > >>>>> +	struct spi_device *spi = to_spi_device(dev);
> > >>>>>  	struct spi_control *ctl = spi_get_drvdata(spi);
> > >>>>> +	int ret;
> > >>>>>  	ret = lq035q1_control(spi, LQ035_DRIVER_OUTPUT_CTL, ctl->mode);
> > >>>>>  	if (ret)
> > >>>>> @@ -187,9 +190,13 @@ static int lq035q1_spidev_resume(struct spi_device *spi)
> > >>>>>  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_ON);
> > >>>>>  }
> > >>>>> +
> > >>>>> +static SIMPLE_DEV_PM_OPS(lq035q1_spidev_pm_ops, lq035q1_spidev_suspend,
> > >>>>> +	lq035q1_spidev_resume);
> > >>>>> +#define LQ035Q1_SPIDEV_PM_OPS (&lq035q1_spidev_pm_ops)
> > >>>>> +
> > >>>>>  #else
> > >>>>> -# define lq035q1_spidev_suspend NULL
> > >>>>> -# define lq035q1_spidev_resume  NULL
> > >>>>> +#define LQ035Q1_SPIDEV_PM_OPS NULL
> > >>>>>  #endif
> > >>> we really need to ahve a macro like for DT of_match_ptr to drop the #else
> > >>
> > >> Hi Jean-Christophe PLAGNIOL-VILLARD,
> > >>
> > >> I submitted the following patch. :)
> > >> (https://patchwork.kernel.org/patch/2502971/)
> > >>
> > >> --- a/include/linux/pm.h
> > >> +++ b/include/linux/pm.h
> > >> @@ -55,8 +55,10 @@  struct device;
> > >>
> > >>  #ifdef CONFIG_PM
> > >>  extern const char power_group_name[];		/* = "power" */
> > >> +#define pm_ops_ptr(_ptr)	(_ptr)
> > >>  #else
> > >>  #define power_group_name	NULL
> > >> +#define pm_ops_ptr(_ptr)	NULL
> > >>  #endif
> > >>
> > >>
> > >> This patch was accepted by Rafael Wysocki, and will be merged to v3.11-rc1.
> > >>
> > > Lars-Peter please update with and
> >
> > Since the code depends on CONFIG_PM_SLEEP and not CONFIG_PM I don't think
> > the macro will work.
> 
> se please ad a similar macros too

Hi Jean-Christophe,

I added pm_sleep_ops_ptr() as below.
Maybe you want it.
There is no build warnings below 4 config situations.
   a) CONFIG_PM is enabled.
   b) only CONFIG_PM_SLEEP is enabled
   c) only CONFIG_PM_RUNTIME is enabled
   d) CONFIG_PM is NOT enabled.

--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -170,16 +170,19 @@ static int lq035q1_spidev_remove(struct spi_device *spi)
        return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
 }

-#ifdef CONFIG_PM
-static int lq035q1_spidev_suspend(struct spi_device *spi, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int lq035q1_spidev_suspend(struct device *dev)
 {
+       struct spi_device *spi = to_spi_device(dev);
+
        return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
 }

-static int lq035q1_spidev_resume(struct spi_device *spi)
+static int lq035q1_spidev_resume(struct device *dev)
 {
-       int ret;
+       struct spi_device *spi = to_spi_device(dev);
        struct spi_control *ctl = spi_get_drvdata(spi);
+       int ret;

        ret = lq035q1_control(spi, LQ035_DRIVER_OUTPUT_CTL, ctl->mode);
        if (ret)
@@ -187,11 +190,11 @@ static int lq035q1_spidev_resume(struct spi_device *spi)

        return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_ON);
 }
-#else
-# define lq035q1_spidev_suspend NULL
-# define lq035q1_spidev_resume  NULL
 #endif

+static SIMPLE_DEV_PM_OPS(lq035q1_spidev_pm_ops, lq035q1_spidev_suspend,
+       lq035q1_spidev_resume);
+
 /* Power down all displays on reboot, poweroff or halt */
 static void lq035q1_spidev_shutdown(struct spi_device *spi)
 {
@@ -708,8 +711,7 @@ static int bfin_lq035q1_probe(struct platform_device *pdev)
        info->spidrv.probe    = lq035q1_spidev_probe;
        info->spidrv.remove   = lq035q1_spidev_remove;
        info->spidrv.shutdown = lq035q1_spidev_shutdown;
-       info->spidrv.suspend  = lq035q1_spidev_suspend;
-       info->spidrv.resume   = lq035q1_spidev_resume;
+       info->spidrv.driver.pm = pm_sleep_ops_ptr(&lq035q1_spidev_pm_ops);

        ret = spi_register_driver(&info->spidrv);
        if (ret < 0) {
diff --git a/include/linux/pm.h b/include/linux/pm.h
index bd50d15..999d652 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -61,6 +61,12 @@ extern const char power_group_name[];                /* = "power" */
 #define pm_ops_ptr(_ptr)       NULL
 #endif

+#ifdef CONFIG_PM_SLEEP
+#define pm_sleep_ops_ptr(_ptr) (_ptr)
+#else
+#define pm_sleep_ops_ptr(_ptr) NULL
+#endif
+


Hi Rafael J. Wysocki,
How about adding this pm_sleep_ops_ptr() macro?

My draft idea is below:
However, I want other's better ideas. :)

1. The case that only CONFIG_PM_SLEEP is necessary.
#ifdef CONFIG_PM_SLEEP
static int *_suspend(struct device *dev)
	[....]
static int *_resume(struct device *dev)
	[....]
#endif

static SIMPLE_DEV_PM_OPS(*_pm_ops, *_suspend, *_resume);

static struct {platform/spi/i2c/etc}_driver *_driver = {
	.driver = {
		.pm     = pm_sleep_ops_ptr(&*_pm_ops),


2. The case that both CONFIG_PM_SLEEP & CONFIG_PM_RUNTIME
    are necessary.

#ifdef CONFIG_PM_SLEEP
static int *_suspend(struct device *dev)
	[....]
static int *_resume(struct device *dev)
	[....]
#endif

#ifdef CONFIG_PM_RUNTIME
static int *_runtime_suspend(struct device *dev)
	[....]
static int *_runtime_resume(struct device *dev)
	[....]
#endif

static const struct dev_pm_ops *_pm_ops = {
	SET_SYSTEM_SLEEP_PM_OPS(*_suspend, *_resume)
	SET_RUNTIME_PM_OPS(*_runtime_suspend, *_runtime_resume, NULL)
};

static struct {platform/spi/i2c/etc}_driver *_driver = {
	.driver = {
		.pm     = pm_ops_ptr(&*_pm_ops),



Best regards,
Jingoo Han



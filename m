From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] fbdev: bfin-lq035q1-fb: Use dev_pm_ops
Date: Wed, 29 May 2013 23:36:22 +0200
Message-ID: <5152912.Hgl9OZ5vTi@vostro.rjw.lan>
References: <1369829859-13405-1-git-send-email-lars@metafoo.de> <51A60F83.7070403@analog.com> <20130529192013.GA19468@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:54345 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935151Ab3E2V12 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 May 2013 17:27:28 -0400
In-Reply-To: <20130529192013.GA19468@game.jcrosoft.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, May 29, 2013 09:20:13 PM Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:24 Wed 29 May     , Michael Hennerich wrote:
> > On 05/29/2013 02:17 PM, Lars-Peter Clausen wrote:
> > >Use dev_pm_ops instead of the legacy suspend/resume callbacks.
> > >
> > >Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> > >---
> > >  drivers/video/bfin-lq035q1-fb.c | 22 ++++++++++++++--------
> > >  1 file changed, 14 insertions(+), 8 deletions(-)
> > >
> > >diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
> > >index 29d8c04..6084c17 100644
> > >--- a/drivers/video/bfin-lq035q1-fb.c
> > >+++ b/drivers/video/bfin-lq035q1-fb.c
> > >@@ -170,16 +170,19 @@ static int lq035q1_spidev_remove(struct spi_device *spi)
> > >  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
> > >  }
> > >-#ifdef CONFIG_PM
> > >-static int lq035q1_spidev_suspend(struct spi_device *spi, pm_message_t state)
> > >+#ifdef CONFIG_PM_SLEEP
> > >+static int lq035q1_spidev_suspend(struct device *dev)
> > >  {
> > >+	struct spi_device *spi = to_spi_device(dev);
> > >+
> > >  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
> > >  }
> > >-static int lq035q1_spidev_resume(struct spi_device *spi)
> > >+static int lq035q1_spidev_resume(struct device *dev)
> > >  {
> > >-	int ret;
> > >+	struct spi_device *spi = to_spi_device(dev);
> > >  	struct spi_control *ctl = spi_get_drvdata(spi);
> > >+	int ret;
> > >  	ret = lq035q1_control(spi, LQ035_DRIVER_OUTPUT_CTL, ctl->mode);
> > >  	if (ret)
> > >@@ -187,9 +190,13 @@ static int lq035q1_spidev_resume(struct spi_device *spi)
> > >  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_ON);
> > >  }
> > >+
> > >+static SIMPLE_DEV_PM_OPS(lq035q1_spidev_pm_ops, lq035q1_spidev_suspend,
> > >+	lq035q1_spidev_resume);
> > >+#define LQ035Q1_SPIDEV_PM_OPS (&lq035q1_spidev_pm_ops)
> > >+
> > >  #else
> > >-# define lq035q1_spidev_suspend NULL
> > >-# define lq035q1_spidev_resume  NULL
> > >+#define LQ035Q1_SPIDEV_PM_OPS NULL
> > >  #endif
> we really need to ahve a macro like for DT of_match_ptr to drop the #else
> 
> I known it's related to this patch but someone should do it
> 
> Rafael what do you think

There's a patch adding something like that in the linux-next branch of my tree
(if I understand correctly what you mean).

Thanks,
Rafael


> > >  /* Power down all displays on reboot, poweroff or halt */
> > >@@ -708,8 +715,7 @@ static int bfin_lq035q1_probe(struct platform_device *pdev)
> > >  	info->spidrv.probe    = lq035q1_spidev_probe;
> > >  	info->spidrv.remove   = lq035q1_spidev_remove;
> > >  	info->spidrv.shutdown = lq035q1_spidev_shutdown;
> > >-	info->spidrv.suspend  = lq035q1_spidev_suspend;
> > >-	info->spidrv.resume   = lq035q1_spidev_resume;
> > >+	info->spidrv.driver.pm = LQ035Q1_SPIDEV_PM_OPS;
> > >  	ret = spi_register_driver(&info->spidrv);
> > >  	if (ret < 0) {
> > 
> > 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: Alan Stern <stern@rowland.harvard.edu>
Subject: Crash introduced by commit b8b2c7d845d5 ("base/platform: assert that
 dev_pm_domain callbacks are called unconditionally")
Date: Tue, 19 Jan 2016 13:22:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1601191312260.1312-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33517 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932271AbcASSWY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 13:22:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linux-pm mailing list <linux-pm@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>

Uwe:

Your commit causes my ASUS laptop to crash during early boot.  The 
problem occurs in platform_drv_probe(), affecting both the alarmtimer 
and the asus_laptop platform drivers (I can't tell which is the 
critical one).

The old code would not call platform_drv_probe() at all, and probing
would always succeed immediately because these drivers have no probe
routine.  But with the new code, platform_drv_probe() does run.  The
call to of_clk_set_defaults() returns -ENODEV, as does the call to
dev_pm_domain_attach().  The call to drv->probe() gets skipped, of 
course.  The final return value is -ENODEV, and so probing fails.  This 
causes the kernel to crash: blank screen, NumLock LED blinking.

The patch below fixes the problem, but I'm not sure that it's the best 
solution.  What is your advice?

Alan Stern



Index: usb-4.4/drivers/base/platform.c
===================================================================
--- usb-4.4.orig/drivers/base/platform.c
+++ usb-4.4/drivers/base/platform.c
@@ -524,6 +524,8 @@ static int platform_drv_probe(struct dev
 		ret = -ENXIO;
 	}
 
+	if (!drv->probe)
+		ret = 0;
 	return ret;
 }
 


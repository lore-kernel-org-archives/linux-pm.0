From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH RFC] PM/Devfreq: Add Exynos5-bus devfreq driver for Exynos5250.
Date: Tue, 4 Dec 2012 16:18:55 +0000 (UTC)
Message-ID: <loom.20121204T170759-102@post.gmane.org>
References: <1354264973-11214-1-git-send-email-a.kesavan@samsung.com> <000101cdd202$dc6e8310$954b8930$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38836 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479Ab2LDQUD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Dec 2012 11:20:03 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1TfvE5-0002ZI-Ca
	for linux-pm@vger.kernel.org; Tue, 04 Dec 2012 17:20:05 +0100
Received: from ABTS-KK-Dynamic-105.38.179.122.airtelbroadband.in ([ABTS-KK-Dynamic-105.38.179.122.airtelbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Tue, 04 Dec 2012 17:20:05 +0100
Received: from kesavan.abhilash by ABTS-KK-Dynamic-105.38.179.122.airtelbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Tue, 04 Dec 2012 17:20:05 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Jonghwan Choi <jhbird.choi <at> samsung.com> writes:

> 
> 
> Hi Abhilash Kesavan.
Hi,
> 
> I compiled in 3.7-rc8
> I got a compile error & warning.
> 
> Compile error.
> 
> CC      drivers/devfreq/exynos5_ppmu.o
> drivers/devfreq/exynos5_ppmu.c:56:14: error: 'S5P_VA_PPMU_DDR_C' undeclared
> here (not in a function)
> drivers/devfreq/exynos5_ppmu.c:59:14: error: 'S5P_VA_PPMU_DDR_R1' undeclared
> here (not in a function)
> drivers/devfreq/exynos5_ppmu.c:62:13: error: 'S5P_VA_PPMU_DDR_L' undeclared
> here (not in a function)
> drivers/devfreq/exynos5_ppmu.c:65:13: error: 'S5P_VA_PPMU_RIGHT' undeclared
> here (not in a function)
> drivers/devfreq/exynos5_ppmu.c:68:14: error: 'S5P_VA_PPMU_CPU' undeclared
> here (not in a function)
> make[2]: *** [drivers/devfreq/exynos5_ppmu.o] Error 1
I have submitted only the driver changes. As mentioned in the commit message I 
will post the arch side changes after the drivers gets a complete review. 
However, if you want to test the driver I will post it tommorrow.

[...]
> drivers/devfreq/exynos5_bus.c: In function 'exynos5_busfreq_int_probe':
> drivers/devfreq/exynos5_bus.c:388:9: warning: passing argument 3 of
> 'devfreq_add_device' from incompatible pointer type [enabled by default]
> include/linux/devfreq.h:170:24: note: expected 'struct devfreq_governor
> const *' but argument is of type 'char *'
[...]
> Need change?
These changes are based on 
git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git : for-rafael
devfreq_add_device prototype has recently changed and that might be the cause of 
the compilation error. Can you please try on this tree. 

> How to change the INT clock? I think you have to change
> arch/arm/mach-exynos/clock-exynos5250.c
> (If you want to control via clock framework.)
[...]
> exynos5_int_clk.ops = &exynos5_clk_int_ops;
This is part of the arch side patch that has not been posted.
 
Regards,
Abhilash


From: "Doug Smythies" <dsmythies@telus.net>
Subject: As of kernel 4.3-rc1 system will not stay in S3 suspend [REGRESSION]
Date: Wed, 7 Oct 2015 15:51:13 -0700
Message-ID: <001f01d10152$ab653de0$022fb9a0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta13.telus.net ([209.171.16.86]:37273 "EHLO cmta13.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbbJGWvP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 18:51:15 -0400
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Doug Smythies <dsmythies@telus.net>

Hi,

This started somewhere between Kernel 4.2 and 4.3-rc1,
but I only noticed it now.

The first S3 suspend after a fresh boot works fine.
Thereafter, suspends simply resume again immediately.

I get the following errors on my console:

[  152.697247] i915 0000:00:02.0: GEM idle failed, resume might fail
[  152.697258] pci_pm_suspend(): i915_pm_suspend+0x0/0x50 [i915] returns -11
[  152.697262] dpm_run_callback(): pci_pm_suspend+0x0/0x140 returns -11
[  152.697264] PM: Device 0000:00:02.0 failed to suspend async: error -11
[  152.697306] PM: Some devices failed to suspend, or early wake event detected

The issue is not limited to my normal way of doing suspend, using "pm-suspend".
It also happens using the "echo mem > /sys/power/state" method that Rafael mentioned
during the 4.2 cycle.

I have searched the bug reports and such and didn't find a related bug, (which
doesn't mean it doesn't exist, just that if it does I didn't find it).

I am about to start bisecting the kernel, but thought to ask here first, just in case
someone already knows the root issue.

Note: There was the e-mail earlier 
"Gigabyte P35-DS3: does not stay suspended with default "ug" wake-on-lan setting"
But he has had the issue since kernel 3.19.0, and I tried his workaround, without
success, anyhow.



From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH RFC 0/1] PM / Hibernate: no kernel_power_off when pm_power_off
Date: Thu, 20 Mar 2014 13:53:14 -0700
Message-ID: <1395348795-8554-1-git-send-email-sebastian.capella@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

Patch to avoid calling kernel_power_off when pm_power_off is null.
When pm_power_off is null, the platform will not power off in
kernel_power_off.  Currently, hibernate will call kernel_power_off and
then move on to kernel_halt.  However, this calls the notifier chain
twice with a different parameter.  In kernel/reboot.c, this is avoided
by checking if pm_power_off is NULL and bypassing kernel_power_off.

Mostly, this is a check if anyone is dependent on having the reboot
notifier called 2x if pm_power_off is null.  There are some panics if
it's called this way in some drivers.

Tested this on omap beaglebone black, but have not tried on other
hardware.  Please let me know if you can test this on another platform
and the results.

Thanks,

Sebastian

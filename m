From: "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH 0/2]  Quiet power limit notification
Date: Wed, 15 May 2013 06:36:55 -0700
Message-ID: <1368625017-6835-1-git-send-email-fenghua.yu@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58326 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932193Ab3EOUoE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 May 2013 16:44:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rafal.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

Power Limit Notification (X86_FEATURE_PLN) was added in Sandy Bridge
to give the OS the option of knowing when the package has reached
a configured power threshold.

Linux-2.6.36 enabled this feature:
0199114c31798af5b83841b21759b64171060d9b
(x86, hwmon: Package Level Thermal/Power: power limit)

It enabld the interrupt, and the interrupt hander
added to the MCE log and printed to the console:

printk(KERN_CRIT "CPU%d: %s power limit notification (total events = %lu)
printk(KERN_INFO "CPU%d: %s power limit normal\n"

However, these events are quite routine on some systems under some conditions,
alarming customers and provoking un-necessary customer support calls.

So the MCE log entry was deleted in Linux-3.3:

29e9bf1841e4f9df13b4992a716fece7087dd237
(x86, mce, therm_throt: Don't report power limit and package level thermal throttle events in mcelog)

Here we delete the corresponding kernel console messages,
and then we disable the interrupt by default -- allowing it
to be enabled by cmdline for diagnosis purposes.

https://bugzilla.kernel.org/show_bug.cgi?id=36182

This pair of patches applies cleanly back to Linux-3.3.


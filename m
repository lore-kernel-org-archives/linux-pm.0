From: Len Brown <lenb@kernel.org>
Subject: [RESEND 2] [PATCH 0/2] Rewrite power limit notification interrupt handling
Date: Tue, 21 May 2013 12:53:12 -0400
Message-ID: <1369155194-9535-1-git-send-email-lenb@kernel.org>
References: <1368741246-3998-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:47943 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab3EUQxk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2013 12:53:40 -0400
Received: by mail-qe0-f43.google.com with SMTP id k5so528089qej.30
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2013 09:53:39 -0700 (PDT)
In-Reply-To: <1368741246-3998-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org

[Excluse duplicates -- for some reason these didn't hit list archives or patchwork]


The "Power Limit Notification" (X86_FEATURE_PLN) was added in Sandy Bridge
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

Documentation/kernel-parameters.txt      |  2 ++
arch/x86/kernel/cpu/mcheck/therm_throt.c | 43 ++++++++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 17 deletions(-)

This pair of patches applies cleanly back to Linux-3.3.

Fenghua Yu (2):
	[1/2] x86 thermal: Delete power-limit-notification console messages
	[2/2] x86 thermal: Disable power limit notification interrupt by default

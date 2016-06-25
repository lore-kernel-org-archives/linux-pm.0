From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/4][RFC v2] x86, hotplug: Use hlt instead of mwait when resuming from hibernation
Date: Sun, 26 Jun 2016 00:18:18 +0800
Message-ID: <cover.1466844557.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49316 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbcFYQLK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 25 Jun 2016 12:11:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

Currently it is reported that, when system is trying to resume
from hibernation, the nonboot CPUs might be incorrectly woken up
and hang there. The reason for this is because of inconsistent
page tables across hibernation resume. To avoid this situation,
use hlt instead of mwait to put nonboot CPUs in a more safe state
and just let them watch the boot CPU to do all the things and
wakes them up later.

The first three patches are preparation for the fourth one, please
refer to [4/4] for detail.

Chen Yu (4):
  PM / sleep: Avoid accessing frozen_cpus if it is NULL
  PM / sleep: Introduce arch-specific hook for disable/enable nonboot
    cpus
  PM / hibernate: introduce a flag to indicate resuming from hibernation
  x86, hotplug: Use hlt instead of mwait when resuming from hibernation

 arch/x86/kernel/smpboot.c | 15 +++++++++++++++
 include/linux/cpu.h       |  2 ++
 include/linux/suspend.h   |  7 +++++++
 kernel/cpu.c              | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/power/hibernate.c  |  3 +++
 5 files changed, 65 insertions(+)

-- 
2.7.4


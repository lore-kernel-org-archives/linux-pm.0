From: Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 0/3][RFC/RFT] Do not delay the MTRR synchronization for
Date: Tue, 31 Oct 2017 17:58:03 +0800
Message-ID: <cover.1509438899.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Lukas Wunner <lukas@wunner.de>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

The original problem comes from a bug found on MacBookPro that,
the instructions run on each APs after resume are very slow, due
to the MTRR been scribbled by the BIOS thus it behaves like
running in 'uncached' mode.

Thus this patch tries to synchronize the MTRR as early as possible
by performing this action once the APs have been brought.

Test result shows a 6 seconds improvement on the bogus MacBookPro,
and 600 ms improvement on a Xeon Broadwell platform which has
88 cpus.

Chen Yu (3):
  PM / sleep: Introduce a flag to identify the enable_nonboot_cpus stage
  x86/mtrr: Add cpu id into the MTRR setting data structure
  PM / sleep: Do not delay the synchronization of MTRR during resume

 arch/x86/kernel/cpu/mtrr/main.c | 13 ++++++++++---
 arch/x86/kernel/smpboot.c       |  2 --
 include/linux/cpu.h             |  2 ++
 kernel/cpu.c                    |  8 ++++++++
 4 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.13.5

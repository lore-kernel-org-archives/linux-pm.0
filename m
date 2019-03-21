From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS handling fixes and sysfs i/f
Date: Thu, 21 Mar 2019 23:12:53 +0100
Message-ID: <1637073.gl2OfxWTjI@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86 <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi All,

This is a resend of https://patchwork.kernel.org/patch/10862699/ (with minor
modifications) plus additional patch to add a sysfs attribute for accessing
the EPB (as requested by Boris).

Thanks,
Rafael

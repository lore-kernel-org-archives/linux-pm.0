From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 0/3] cpufreq: intel_pstate: Handle _PPC updates on global turbo disable/enable
Date: Tue, 05 Mar 2019 11:23:48 +0100
Message-ID: <1755407.S0oJirvq9V@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

This is a follow-up to the RFT patch set posted previously:
https://lore.kernel.org/lkml/9956076.F4luUDm1Dq@aspire.rjw.lan/

Patch [1/3] causes intel_pstate to update all policies if it gets a _PPC change
notification and sees a global turbo disable/enable change.

Patch [2/3] adds cpufreq_cpu_acquire() and cpufreq_cpu_release() to reduce
code duplication after the next patch a bit (and Srinivas wanted the rwsem
manipulation to not be done directly by the driver).

Patch [3/3] makes intel_pstate update cpuinfo.max_freq for all policies in
those cases.

I've atted Tested-by tags to patches [1/3] and [3/3], because there are only
cosmetic differences between them and what has been tested.

Thanks,
Rafael

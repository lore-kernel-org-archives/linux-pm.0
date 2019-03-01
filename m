From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on global turbo disable/enable
Date: Fri, 01 Mar 2019 13:43:00 +0100
Message-ID: <9956076.F4luUDm1Dq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

This is how I would fix the issue reported in BZ 200759 (see this patch series
from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2).

Patch [1/2] causes intel_pstate to update all policies if it gets a _PPC change
notification and sees a global turbo disable/enable change.

Patch [2/2] makes it update cpuinfo.max_freq for all policies in those cases.

The patches here have not been tested yet, so testing would be much appreciated.

Of course, comments are welcome too!

Thanks,
Rafael

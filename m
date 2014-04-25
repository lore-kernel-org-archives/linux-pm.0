From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Cpufreq frequency serialization fixes
Date: Fri, 25 Apr 2014 13:47:58 +0530
Message-ID: <20140425081728.10258.63980.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, mroos@linux.ee, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org


Hi,

Meelis Roos reported hangs during boot in the longhaul cpufreq driver, after
commit 12478cf0c55 (cpufreq: Make sure frequency transitions are serialized).
The root-cause of this issue is the extra invocation of the
cpufreq_freq_transition_begin() and cpufreq_freq_transition_end() APIs in the
longhaul driver. I found similar issues in the powernow-k6 and powernow-k7
drivers as well. This patchset fixes the issue in all the 3 drivers.

 Srivatsa S. Bhat (3):
      cpufreq, powernow-k7: Fix double invocation of cpufreq_freq_transition_begin/end
      cpufreq, powernow-k6: Fix double invocation of cpufreq_freq_transition_begin/end
      cpufreq, longhaul: Fix double invocation of cpufreq_freq_transition_begin/end


 drivers/cpufreq/longhaul.c    |   12 ++++++++----
 drivers/cpufreq/powernow-k6.c |   20 +++++++++++---------
 drivers/cpufreq/powernow-k7.c |    4 ----
 3 files changed, 19 insertions(+), 17 deletions(-)


Thanks,
Srivatsa S. Bhat
IBM Linux Technology Center

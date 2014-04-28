From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 0/5] Cpufreq frequency serialization fixes
Date: Tue, 29 Apr 2014 00:23:54 +0530
Message-ID: <20140428185331.28755.899.stgit@srivatsabhat.in.ibm.com>
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
drivers as well. This patchset fixes the issue in all the 3 drivers and also
adds a debug infrastructure to catch such issues easily.

Patches 1-4 fix the regression in longhaul, powernow-k6 and powernow-k7
drivers. (Patch 2 fixes a different bug in powernow-k6, and it is kept as a
separate patch instead of merging it with patch 3, because I felt that it was
a bit subtle and needed attention in a separate patch).

Patch 5 adds a debug infrastructure to the cpufreq core to catch such problems
more easily in the future.


Changes in v2:
--------------

* Modified patch 1 to take error returns into account, as pointed out by
  Viresh.
* Added patch 2 to fix the existing issue in the powernow-k6 driver, pointed
  out by Viresh.
* Added patch 5 to introduce a debug infrastructure to catch such issues
  easily.


 Srivatsa S. Bhat (5):
      cpufreq, longhaul: Fix double invocation of cpufreq_freq_transition_begin/end
      cpufreq, powernow-k6: Fix incorrect comparison with max_multipler
      cpufreq, powernow-k6: Fix double invocation of cpufreq_freq_transition_begin/end
      cpufreq, powernow-k7: Fix double invocation of cpufreq_freq_transition_begin/end
      cpufreq: Catch double invocations of cpufreq_freq_transition_begin/end


 drivers/cpufreq/cpufreq.c     |   12 ++++++++++++
 drivers/cpufreq/longhaul.c    |   36 ++++++++++++++++++++++++------------
 drivers/cpufreq/powernow-k6.c |   23 +++++++++++++----------
 drivers/cpufreq/powernow-k7.c |    4 ----
 include/linux/cpufreq.h       |    1 +
 5 files changed, 50 insertions(+), 26 deletions(-)


Thanks,
Srivatsa S. Bhat
IBM Linux Technology Center

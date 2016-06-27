From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2 0/3] cpufreq: intel_pstate: trivial improvements
Date: Mon, 27 Jun 2016 18:07:15 +0800
Message-ID: <1467022038-924-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-pm@vger.kernel.org

The first patch fixes incorrect placement of __initdata

The second patch is to add __init/__initdata marker to some functions
or varaiables so that we can discard them.

The third patch declares pid_params/pstate_funcs/hwp_active as
__read_mostly, under the fact that they are mostly read and not
written to.


Since v1:
 - add Viresh's ack
 - fix the third patch commit msg: remove duplicated words

Jisheng Zhang (3):
  intel_pstate: Fix incorrect placement of __initdata
  intel_pstate: add __init/__initdata marker to some functions/variables
  intel_pstate: Declare pid_params/pstate_funcs/hwp_active __read_mostly

 drivers/cpufreq/intel_pstate.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
2.8.1

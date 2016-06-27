From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 0/3] cpufreq: intel_pstate: trivial improvements
Date: Mon, 27 Jun 2016 17:26:12 +0800
Message-ID: <1467019575-664-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5266 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751703AbcF0JaP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 05:30:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

The first patch fixes incorrect placement of __initdata

The second patch is to add __init/__initdata marker to some functions
or varaiables so that we can discard them.

The third patch declares pid_params/pstate_funcs/hwp_active as
__read_mostly, under the fact that they are mostly read and not
written to.


Jisheng Zhang (3):
  intel_pstate: Fix incorrect placement of __initdata
  intel_pstate: add __init/__initdata marker to some functions/variables
  intel_pstate: Declare pid_params/pstate_funcs/hwp_active __read_mostly

 drivers/cpufreq/intel_pstate.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
2.8.1


From: Huaisheng HS1 Ye <yehs1@lenovo.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_cur_freq after performance
 governor changes
Date: Mon, 24 Jul 2017 05:43:14 +0000
Message-ID: <1500875013-123321-1-git-send-email-yehs1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.193]:30537 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751616AbdGXFnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 01:43:31 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huaisheng HS1 Ye <yehs1@lenovo.com>

After commit 82b4e03e01bc (intel_pstate: skip scheduler hook when
in "performance" mode) Software P-state control modes couldn't get
dynamic value during performance mode, and it still in last value from
powersave mode, so clear its value to get same behavior as Hardware
P-state to avoid confusion.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.=
c
index 6cd5035..c675626 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2050,6 +2050,7 @@ static int intel_pstate_set_policy(struct cpufreq_pol=
icy *policy)
 		 */
 		intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_max_within_limits(cpu);
+		cpu->sample.core_avg_perf =3D 0;
 	} else {
 		intel_pstate_set_update_util_hook(policy->cpu);
 	}
--=20
1.8.3.1

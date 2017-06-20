From: Sherry Hurwitz <sherry.hurwitz@amd.com>
Subject: [PATCH 1/2] cpupower: Fix bug where return value was not used
Date: Tue, 20 Jun 2017 02:07:37 -0500
Message-ID: <20170620070241.21434.57148.stgit@Diesel2540.amd.com>
References: <20170620065708.21434.80154.stgit@Diesel2540.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [165.204.78.1] ([165.204.78.1]:16054 "EHLO diesel2540.amd.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751126AbdFTHHk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Jun 2017 03:07:40 -0400
In-Reply-To: <20170620065708.21434.80154.stgit@Diesel2540.amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: trenn@suse.com
Cc: linux-pm@vger.kernel.org

Save return value from amd_pci_get_num_boost_states
and remove redundant setting of *support

Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
---
 tools/power/cpupower/utils/helpers/misc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 1609243..6952a6a 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -16,10 +16,9 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CBP) {
 		*support = 1;
-		amd_pci_get_num_boost_states(active, states);
-		if (ret <= 0)
+		ret = amd_pci_get_num_boost_states(active, states);
+		if (ret)
 			return ret;
-		*support = 1;
 	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
 		*support = *active = 1;
 	return 0;

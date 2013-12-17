From: Alan <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH RESEND] cpufreq: Fix sscanf robustness
Date: Tue, 17 Dec 2013 15:07:31 +0000
Message-ID: <20131217150723.29514.53369.stgit@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44664 "EHLO
	alan.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754427Ab3LQPHT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 10:07:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: akpm@linux-foundation.org, linux-pm@vger.kernel.org

The cpufreq-set tool has a missing length check. This is basically
just correctness but still should get fixed.

One of a set of sscanf problems reported by Jackie Chang

Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 tools/power/cpupower/utils/cpufreq-set.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index dd1539e..a416de8 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -257,7 +257,7 @@ int cmd_freq_set(int argc, char **argv)
 				print_unknown_arg();
 				return -EINVAL;
 			}
-			if ((sscanf(optarg, "%s", gov)) != 1) {
+			if ((sscanf(optarg, "%19s", gov)) != 1) {
 				print_unknown_arg();
 				return -EINVAL;
 			}


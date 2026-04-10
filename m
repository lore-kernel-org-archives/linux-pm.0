Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249E3C2763
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827726; cv=none; b=SufB9OxnVJEnKGDxmtgU9RNz8BlwlL/lzrkfJIEc6xk3u8Il6MVifsI4B4RNu/k5soY/ceYDFESi5ekDayDUMeC5qbhXejjyWUL1D22XLIQJ+hTRED5a3edRrGjeIfb6oNacZJEDfzoqinkILJ2sfL/AYC8RGPM9eEGRFYY/OmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827726; c=relaxed/simple;
	bh=bI4UNw3VbfqKSVN6Pi+l2e7UqKr46jop4OD/B6jfSh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNMUJQdzarKvhEB7tUWTChvscbErx/GX7nhhjeM32OXVotRxuZUhSdxIJOEbygt7kc5e9pwi3zoPyOztWn0HkOzAhtaADuTJDo8k6YcipqF5ilNnTvbx8CFiYXmb7nWf39On6YdVQBDJ2yQytWtBAbQHV1y/iezQnZtZKyl8b+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4ir0f8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4ir0f8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC9BC19421;
	Fri, 10 Apr 2026 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827726;
	bh=bI4UNw3VbfqKSVN6Pi+l2e7UqKr46jop4OD/B6jfSh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=P4ir0f8V9XSbs4ETyZt5kC8k0uFiF1DfBx6MJ6Tk+I5gbZuUB0UrqlrXUwH80bTDj
	 h4+ElZDr7F/QYcJA+6/hmwO95B+vU0yrS0kWI+SnOtucYXEjPSyLABN63C99UFztfe
	 3LbjZTHkHzkzSTw5H2mNZY/lsx+tpla9zT0MtCtV0QKh0ZRvEnS5VzvdGYJw1OU8f/
	 GvBPUioDaAINdxlRBFC5aOfMXNoer8ETdnPsVaG83I5MVMPHoZSvO0RmcsieFGoByb
	 oYRJEyXd1/GZRg2sPiyGj0QBQJGOkXtHeAQeVpnTVtjDpjWDjJGTu7NLO1TY1ojm5z
	 uZzxXlv0JRPJA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 9/9] tools/power turbostat: Allow execution to continue after perf_l2_init() failure
Date: Fri, 10 Apr 2026 09:25:14 -0400
Message-ID: <ba893caead54745595e29953f0531cf3651610aa.1775827309.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
References: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: David Arcari <darcari@redhat.com>

Currently, if perf_l2_init() fails turbostat exits after issuing the
following error (which was encountered on AlderLake):

turbostat: perf_l2_init(cpu0, 0x0, 0xff24) REFS: Invalid argument

This occurs because perf_l2_init() calls err(). However, the code has been
written in such a manner that it is able to perform cleanup and continue.
Therefore, this issue can be addressed by changing the appropriate calls
to err() to warnx().

Additionally, correct the PMU type arguments passed to the warning strings
in the ecore and lcore blocks so the logs accurately reflect the failing
counter type.

Signed-off-by: David Arcari <darcari@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 34e2143cd4b3..e9e8ef72395a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9405,13 +9405,13 @@ void perf_l2_init(void)
 		if (!is_hybrid) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.uniform, perf_model_support->first.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.uniform, perf_model_support->first.refs);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.uniform, perf_model_support->first.refs);
 				free_fd_l2_percpu();
 				return;
 			}
 			retval = open_perf_counter(cpu, perf_pmu_types.uniform, perf_model_support->first.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP);
 			if (retval == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.uniform, perf_model_support->first.hits);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.uniform, perf_model_support->first.hits);
 				free_fd_l2_percpu();
 				return;
 			}
@@ -9420,39 +9420,39 @@ void perf_l2_init(void)
 		if (perf_pcore_set && CPU_ISSET_S(cpu, cpu_possible_setsize, perf_pcore_set)) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.pcore, perf_model_support->first.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->first.refs);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->first.refs);
 				free_fd_l2_percpu();
 				return;
 			}
 			retval = open_perf_counter(cpu, perf_pmu_types.pcore, perf_model_support->first.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP);
 			if (retval == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->first.hits);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->first.hits);
 				free_fd_l2_percpu();
 				return;
 			}
 		} else if (perf_ecore_set && CPU_ISSET_S(cpu, cpu_possible_setsize, perf_ecore_set)) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.ecore, perf_model_support->second.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->second.refs);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.ecore, perf_model_support->second.refs);
 				free_fd_l2_percpu();
 				return;
 			}
 			retval = open_perf_counter(cpu, perf_pmu_types.ecore, perf_model_support->second.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP);
 			if (retval == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->second.hits);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.ecore, perf_model_support->second.hits);
 				free_fd_l2_percpu();
 				return;
 			}
 		} else if (perf_lcore_set && CPU_ISSET_S(cpu, cpu_possible_setsize, perf_lcore_set)) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.lcore, perf_model_support->third.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->third.refs);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.lcore, perf_model_support->third.refs);
 				free_fd_l2_percpu();
 				return;
 			}
 			retval = open_perf_counter(cpu, perf_pmu_types.lcore, perf_model_support->third.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP);
 			if (retval == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->third.hits);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.lcore, perf_model_support->third.hits);
 				free_fd_l2_percpu();
 				return;
 			}
-- 
2.45.2


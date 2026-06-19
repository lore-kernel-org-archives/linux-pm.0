Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7FA33F5B8;
	Fri, 19 Jun 2026 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897046; cv=none; b=bbZxW1MSZ7G/set6vFdCiz2cXFFLWIrrfnSLF54ddoi4LtWHePOo87GfQ7loz2bhFm1Z1YCIxi1Ggek+4C+/bEIk/dnpolgs2Wm3ViMdNSQFA8KJPryc3kqhzKO6xtjuEJKNru95mv5DsKStTBymgy2PtRYrV0ajb92tybjgGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897046; c=relaxed/simple;
	bh=krZPvtYULMi+egue8OkCRs+JSzVCgrPTzhyU5fAqu5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BFTFAkzQ15YjTQ+5Dv7DxrYhDDOWpViksp4zGJFj0bM6bO41yk/YI6EvytiMwk9TAwQmetdedlPEJMkS1J85yjtT/ZjZI+uaGJaZCcotlwuQle54TtSa+kd6ka5QDiotRhgkWrEuH8mBgrqCRZcLlUygiSY1DWbiWhg7pLGVoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCMrwf+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCMrwf+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790711F000E9;
	Fri, 19 Jun 2026 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897045;
	bh=0fawesV4k8+32AEjO225g5qF0RCWhGeHD139ypLqfag=;
	h=From:To:Cc:Subject:Date;
	b=CCMrwf+aLTK6Yl3DMvuIILELR+bN3IGfcp/7lBbLftyeeeFUWf/dqGLKsdSz0OrKF
	 ZdqqFuXD1rrzBki6jFufabPi/ZsxHsUWg6/AxbEYJWa8SvValG90ymoNu6+UHyoA9s
	 ZYDBVjZvY6EPILCdA7d9/tI7vs8bz7VFc9d/02hlLwIA4CCl4eLL7oaupQ3dNxBxmn
	 VFnnT7YfG6ogxijZe7zw6FVteGGKfe8lDsl/BGzoWtca8eCEsbae1a0wvZSN84Keii
	 pCTDzg6q1koTvwaswNUqo7PlJsr2ciJTEjIEEHZOf2Z5EWTSLiYWDtLdAEckl4KQhc
	 ltNWxp1yPoPAg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Skip HWP_CAP reads in Broadwell mode
Date: Fri, 19 Jun 2026 21:24:02 +0200
Message-ID: <12920597.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When running in the Broadwell HWP mode, the turbo, max and min
P-state values are retrieved from MSR_PLATFORM_INFO, so reading
MSR_HWP_CAPABILITIES in that mode in order to update those values
is pointless.  Moreover, using the MSR_HWP_CAPABILITIES value for
updating them in the Broadwell mode may be harmful, so avoid doing
that altogether.

Fixes: de5bcf404ace ("cpufreq: intel_pstate: Clean up frequency computations")
Link: https://sashiko.dev/#/patchset/6005456.DvuYhMxLoT%40rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
---
 drivers/cpufreq/intel_pstate.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1197,6 +1197,9 @@ static void intel_pstate_get_hwp_cap(str
 {
 	int scaling = cpu->pstate.scaling;
 
+	if (hwp_mode_bdw)
+		return;
+
 	__intel_pstate_get_hwp_cap(cpu);
 
 	cpu->pstate.max_freq = cpu->pstate.max_pstate * scaling;




Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [211.125.139.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EA4594A;
	Fri, 22 May 2026 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408880; cv=none; b=fMD0JF38GMAo0EughueGAsaF0RpXGE+cgJubFb4quNS+jNmQhfmfkDOnHix1+JDp9nI5vP+smhJw0MzYTbwDcrYc3F5O1m1kTeX2EIodJcoNc02QIMl+cZvtGiBEOh68tBgj5NSprUGYLfu0Y2NrJ3VTMkonON6UB4bxLh0KXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408880; c=relaxed/simple;
	bh=8p0JzPEZut0b39POIwOqxTLkBbyPo/mRDMlNnFPOu4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7exOHTIS3v443oAzKDKCi19fVGmHe8im0Ht5b5r+DVdunJemcr8hIvVprOOJTnUiRZ02Sm55/HvrOILR/4Yws9T78vAaSF/2KcAtCzgsdzvwdbpXIVA7dzfBaPZ2aF5bmHWkBiqm4ePDxzzvOnm88fypOZc2YR/IiOX7jSHOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=IDtqOPNH; arc=none smtp.client-ip=211.125.139.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="IDtqOPNH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1779408878; x=1810944878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xqa5yCDGyms4AKLGSH6vTpMr1EZ4ek5t4+BSVfGfaX0=;
  b=IDtqOPNHgmaNn6vKnxjRpkX92vufzRGCgLr6CmHaEGv8ZrvX+yNPdAIP
   xfbMvFdMzv4umlrssh6J3PptLz2ucCb7v3GHv4wPnfwJJzPGP312Y6h2/
   RvAtWircGV3OMOJ1f5OUTjQ9UQD0Zqz799aCtcopNSm/Clp33J03dh9zY
   So8leaKfW9EMXigOWClUGq3XzZf47n0pHgg8lFTXAfBd6UzrscaFtMRu0
   Gd5NKnxpNvhldv8ToZxu29rww3IAk7/5vnejA8aiCXQsL7xzAl1K0IO5+
   P3WzWBKMm0qOtIRPRMwN6aLzI0V3qWz7MRQmEGTTc+U2/nG3WG2GcqLcS
   A==;
X-CSE-ConnectionGUID: mWSfB9FFSpaMjMoJvnC5Pw==
X-CSE-MsgGUID: 3zjKkfJ6S/iA0zV6AKL8Gw==
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 09:14:31 +0900
X-CSE-ConnectionGUID: 4SJVwNiEQEKxyTKvDZMoUA==
X-CSE-MsgGUID: 0hIQEsLDSH+ehvswlPwS6Q==
X-IronPort-AV: E=Sophos;i="6.24,161,1774278000"; 
   d="scan'208";a="56761144"
Received: from unknown (HELO asagi..) ([43.11.56.84])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 22 May 2026 09:14:31 +0900
From: Yohei Kojima <yohei.kojima@sony.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yohei Kojima <yohei.kojima@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Improve warning message on HWP-disabled hybrid CPUs
Date: Fri, 22 May 2026 09:15:58 +0900
Message-ID: <87f69971a9bf89fb4b51f128e8ae519cbaf5894e.1779406085.git.yohei.kojima@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve warning message on HWP-disabled hybrid processors to state that
intel_pstate requires HWP to be enabled on such processors [1].
Previously it warned that "intel_pstate: CPU model not supported", but
it was misleading.

[1]: https://docs.kernel.org/admin-guide/pm/intel_pstate.html

Signed-off-by: Yohei Kojima <yohei.kojima@sony.com>
---
I tested this patch on my PC equipped with i7-14700. Please note that
you need hybrid processors (i.e. Alder Lake and later) to test this.

After this patch, you will see the improved warning message if you
disable hardware P-state in your BIOS,

$ sudo dmesg -k | grep intel_pstate
[    0.478616] intel_pstate: HWP-disabled hybrid CPU is not supported

whereas this driver works as before if HWP is enabled.

$ sudo dmesg -k | grep intel_pstate
[    0.471387] intel_pstate: HWP enabled by BIOS
[    0.471388] intel_pstate: Intel P-state driver initializing
[    0.472593] intel_pstate: HWP enabled
---
 drivers/cpufreq/intel_pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 11c58af41900..99cac95537b5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3823,6 +3823,12 @@ static int __init intel_pstate_init(void)
 		if (no_load)
 			return -ENODEV;
 
+		id = x86_match_cpu(intel_hybrid_scaling_factor);
+		if (id) {
+			pr_info("HWP-disabled hybrid CPU is not supported\n");
+			return -ENODEV;
+		}
+
 		id = x86_match_cpu(intel_pstate_cpu_ids);
 		if (!id) {
 			pr_info("CPU model not supported\n");
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428735;
	b=qQwNrTg89hxeXlOpyeoi7eRek2l5B4/iGQRn3AXx1We1DknfqhR+c8bKkgE/rXVgOzNY
	 LV8D4NRZNPUs9KyVSE1bUFMfC3+pc0qlSHgoWHeAKSFVOAnQQbD49B0t3ZbsdIpWGHwFy
	 4BERpJbrgbY4AEIyxVpwlfCkfOpVKrYzRSXu8uhwPBbPKjqAqPRLhtp3AGO+LrKHKJman
	 TZcmvnqIsBUrplxOgbGbZQib9hyZMdyplNnq2Hf4zp83LnLzmgdNPL9tQ7KmtCtDTAp4n
	 xrLtgw06GK7LP39EdfnKeGVaQrW6F3dxT2o7I0NjK7MsMtbiuHkCPbNMD/DCuq1unBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428735;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=xXotjx4AgLEuu3hN6045sY9XS3lZGN/zMROmi8BYOpA=;
	b=jhFdCRcm90x8BmlG1/NYw8etykZgeYrBOAUTKnVYyvpN7D6QrwqVb2sm60ZYR/d6xLj+
	 hpEN4sRou+ciNHAyKAuhhKKFIrvZzpXsfAVoPeSJgMhlJNoUa6fhtU/queUErz03aJQ65
	 tvgOnZ2fU7IzwuQx18LfeRS2P8o0KhbvMIwFcevhtoVOXRBzNVAh1G05uKjTawbZtqKXM
	 Yp5jcuCsBUAcmhg58Y7TSCY5gP8aBX9ZtidmyNlOjtKhVwCpWdYodUh77wcMucdwVaY4n
	 Dim0DnwX5xVPu6TLf7dgChOtwuJlUl7JgKhqbRpbKRv0qbrWjLUdU/ZEAFcmTpW4Mvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ntP/wivs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7235C606A322
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntP/wivs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497B01F000C5;
	Mon, 19 Oct 2026 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428735;
	bh=xXotjx4AgLEuu3hN6045sY9XS3lZGN/zMROmi8BYOpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=ntP/wivs2e8kF40tF/drMJNaOl5gyeDMi/ZqXwFdJzC0y4LA3FWazFJsAI+qg9BMs
	 fnNhetGEyCe0mI0nUcNX8/4S6yFxrxxjxpU2wg/6XspJBYmX0nKVX8tOeNi8aW7Q3D
	 2KKcNOV7op2PrBVk4kk2X5ND5pCDpKdtMPKUaw6xjwCvusgR4fXzypfyeZJWqfw/3x
	 vUenqpivU3MrM7oKbaZozaCIFuLoJQHobHujzY8H0bcpYag1nir/OLC3uuvAzsQku7
	 Ewuyp7ZhMM7XHWVdnb+009uUv6wbMQ62FtKV5hOhf2HtXUDGjSqVzykNJFEOuo0VcW
	 deeRA3e6KT88w==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 10/18] x86_energy_perf_policy: Cleanup: Define BCLK_MHZ
Date: Mon, 19 Oct 2026 12:43:31 -0400
Message-ID: <a6aebf7e2c69130fd8be86c8dd763abad28d5d7b.1792428130.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Replace the hardcoded value 100 with a named symbolic constant BCLK_MHZ in
ratio_2_sysfs_khz() to document the assumed bus clock frequency.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c      | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 1a0c23cd4cc4..cfd9d8df6ec1 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -37,6 +37,9 @@
 /* Maximum HWP activity window duration in microseconds */
 #define HWP_WINDOW_MAX_USEC 1270000000U
 
+/* Nominal bus clock frequency in MHz - assumed for all HWP systems */
+#define BCLK_MHZ 100
+
 struct msr_hwp_cap {
 	unsigned char highest;
 	unsigned char guaranteed;
@@ -1161,7 +1164,7 @@ int print_pkg_msrs(int pkg)
  */
 int ratio_2_sysfs_khz(int ratio)
 {
-	int bclk_khz = 100 * 1000;	/* 100,000 KHz = 100 MHz */
+	int bclk_khz = BCLK_MHZ * 1000; /* Convert MHz to KHz */
 
 	return ratio * bclk_khz;
 }
-- 
2.45.2


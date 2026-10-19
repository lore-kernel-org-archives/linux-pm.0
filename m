Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428725;
	b=mgJ91kpTrE2NtwR+iPkLFJiWUTPu9MJXg8XWcYkFLqCbfbv+yclA9JfZwM9KOfZy22Ya
	 vYDP3i/Q+TRMEeyt5GhIZmdc/SSEk0AaB9XhGAR2o4zA/UWokGiWJ4rdUkgVM9BF/1rbh
	 0by8Bwe2pkz419a8PvzQeR95sap8cq6e8Yn5ygkMyWIP40vDM5dKe7dWHdIClaHuFZDQZ
	 8J2/1Dnu3gFfm3FEn3wSThswKAog19E2yWb6BgIBvdpHNwoVglVZr6XOdt1FP9OhVdvT8
	 OwP4AP1/z+iWRz7+xHLvPktBOKPqA6fpfXFsbDkRC62jss2xwLTiEqy5sCOoeRbcN0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428725;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=j+nzeC0gEQk4C7n+Jlg8yhdxjDOoW8ShvWMuP+P+E6g=;
	b=wh5VxscwRqASr82wUzdiW+b08C0ai+Dgq42Fzmpx38A6csZhZZvtPnvpPtJYxgekApfI
	 18vpoMD0ataI7YqIf5JSOfZ1RHRPXY8qLd0gQ7blWvUCYEBTlDv6uAeDnHBMP6fVBw/E3
	 d/Z5qlOHeUZHv7VOxmmIrrY5/QfLvOnSxkdMbWgGlTVOqsi25DHP9wq3bg5oy9ku+Nx8+
	 68TIdCavR/OytQbZtqRp1QtY5esA6XicJcSBxhmzTLme3p5OXtnYiwMbhog5CUyvjOni8
	 Zv7z0Z7ohyUhcaozwLJYXqltuBLfCRQsk0LORh4PIbMyIusFGh1vVjVLGK7B24gJH+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFL4JhR5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997D606A319
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFL4JhR5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CE71F000D4;
	Mon, 19 Oct 2026 16:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428724;
	bh=j+nzeC0gEQk4C7n+Jlg8yhdxjDOoW8ShvWMuP+P+E6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=YFL4JhR5rSYmAx3S9lnDwBJlYFv7jMo8a50b+NSsb5lMTCQQzjRwKka+axUbjQxZN
	 IrLsgZeOZXiCPgDVtnrVgHthBEGhI9qvyoIErPzDfbmhRYmaL2ugdNs+cgJg+M+8pH
	 nvJH56woLrBLvUXAkReZvki2tW2Zh0KesBGahV19xCa47FtzeLC9YEr11WyOl5kIbF
	 f8wt+2go5dRQCQzJeM/t3XyuAhE22EWOn0NCMhY1IhgKWLy1f6BWQJOLVzf0u/Pa3b
	 xwyw6DJ6BEPC63So2mB+k0ut+GfMnLHzdo5B/BAY3odMDE1MPUkMk2q+DGFUhANze+
	 DWpfET0R4ltSQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 03/18] x86_energy_perf_policy: Prevent unlikely buffer overflow
Date: Mon, 19 Oct 2026 12:43:24 -0400
Message-ID: <3a763b979bb1a9a7f76f2b3c9134ca0b580108b6.1792428130.git.len.brown@intel.com>
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

Protect update_cpufreq_scaling_freq() from buffer overflow
if somehow it was called with a huge CPU number.

Fixes: f1c35c73191b ("tools/power x86_energy_perf_policy: Version 2026.04.25")
Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index abd3cf2fdd39..3c4e376f6c77 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1166,12 +1166,12 @@ int ratio_2_sysfs_khz(int ratio)
  */
 void update_cpufreq_scaling_freq(int is_max, int cpu, unsigned int ratio)
 {
-	char pathname[64];
+	char pathname[96];
 	FILE *fp;
 	int retval;
 	int khz;
 
-	sprintf(pathname, "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_%s_freq", cpu, is_max ? "max" : "min");
+	snprintf(pathname, sizeof(pathname), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_%s_freq", cpu, is_max ? "max" : "min");
 
 	fp = fopen(pathname, "w");
 	if (!fp) {
-- 
2.45.2


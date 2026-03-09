Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AB1C860C
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045513; cv=none; b=UOD0QywDfmRHMAITDsheMrL5F2oAzbmvnkIsrG0w4m+DjwM+zGPxFJcXskNSvB+TqZtnR51Y54YIDa0KHGwipXpCKoxn/nij8JRSuFsKt5ezYVWqEKkYVUi1vCJ176CXPzFfoxrba9LEwgxoppvckraNivsMbsdyYtBOYmoWbu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045513; c=relaxed/simple;
	bh=fJBQt11K94sXPJH5Xa0dB975vLtwEQIZAktflNxFx+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsdsoA3QGUGlX+5CDL421ntlq0G48DgseNgG+gDyaKo3HNfvjyewR2X5jAkWs9pkAYzyyICp2zIw8D01HBP9R+noaGmGDHryTQ43ROVRCgmktpTx5qE6oHV92un+GJAa8AtLx5Qkcywpo0HKmgX0RmEuaBPEt+GguGsg3vso7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdRTDVZR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdRTDVZR"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a133502accso4247762e87.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773045510; x=1773650310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5SaBlIt9jLMT43Dt/ozM7A+Sj2M3L23PEksPli8HI4=;
        b=QdRTDVZRoHMGIbclkukaItfheOf5dG4evq2EbOGSGKNQK9F0fbRK/5nR4bpFSHyZ6v
         nx6/SjLB0/KNvnMQuDGfptDq32tFsAeXTRiVGqQDOMigffkhqvZG7T/dAx4oMxOyqBkJ
         /0vV5Cq9HV/6fLy5IKLclrZz+uLY/hK1pOV8FHEExj+TtWuIaVp1QWtIgNAIf+08lb+M
         qsfuFT6ipZ+SX4k6/yVmcWLQ18lGNJnVMa6CfMvOMig9NMxIybCp9nQJQPm+1H8efb2Q
         ykEVwVywNHz0Q035vq0iTHCcSEgR1+HTRBz3QeGTBGqPm95XGP3O7tf/wVvXfvc794Qx
         pJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773045510; x=1773650310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5SaBlIt9jLMT43Dt/ozM7A+Sj2M3L23PEksPli8HI4=;
        b=w9lQMhdaiQEQLsrdAP58wkYyUhkqPYSSHEWC1jVXvsM3PACnfuw7fa3tEw/GUM8zFq
         Rs4ufu9QjcB8eXEcVZ1WBBANMynohq47xpBFUUitUPgixH1SenCFAIUb06zKYrDAiSz/
         D77gxg1u2WAjzdTMt9HH2IDhpcXPMtghegsBjvmJVsxMOdKcP7Ln6YCVmCXZn4SRVgco
         bR/j+pmvdLpw6aMrVNNtWbhM9GCLP8naYlsxaephHcU3Fnh68Pfn3VSpOsYs4E2EET3Y
         lxTIWrEVys6xv9wGpM9x+2uSyAJd+3SUfbb9XDz5/AO+hyIslpCOFV3q01Gxrlz1byB2
         lwzA==
X-Gm-Message-State: AOJu0YyCOZ4CrM5IF4klUvTLvRgxEfD7zz4nw2cTIxFPCdOdrwyUI0a4
	/RTnD0RwanQYYaRq38pv3sSrBy8iZDDpXCDU9Xi2nAAi07JhYlSKjqNM0zKf+DZ3
X-Gm-Gg: ATEYQzwuJ1QtjJ4U7ZNDTZsG2rAf3khTlpFqLqLPd/K00AHzLiOtzNa8OF5mVTtZlHp
	0kre0IiTtyEzl6WQKnsseD/aWGqxrKSeRkdjf0Z0E/grvcQ31xheKAxMOBpLaKCF+2t4NtH5ykC
	l6pBCAs9kMzXvZJntpOPNnwDLu33w5yaBS1CAAkoYC4gVRNPWUtc9eoadaznNv89wMbEsDmoweG
	NppHTBNB5swQMw4VzKc11vQMnDpTGjiFwrluL6yRv9A9Qt1a3uUQEz3dY1e9wOy6z3cAa/VA4US
	OsgCkfKVZthdDIO7YPTqiTX5MkWIuS4q43+KMiMMSDduj1nyQMUYmq5UQw1j7zShSU9bRCKYtF5
	EHTFjbnr1sSEIxMOgxJhMJHSWLcdsZ0l67EW/+OpQQgP9mCK4Ppsi9X5npIbvJyEIS3gzTTTTK3
	PTqhq1KvRWyNMIpP6X6soROeXGYeep3X0359DsYkh+tPluvprDYCYZzyUj4zgv
X-Received: by 2002:a05:6512:3d24:b0:5a1:4287:15e6 with SMTP id 2adb3069b0e04-5a142871702mr2769342e87.35.1773045509689;
        Mon, 09 Mar 2026 01:38:29 -0700 (PDT)
Received: from abityuts-desk (176-93-227-108.bb.dnainternet.fi. [176.93.227.108])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d02b438sm2032166e87.21.2026.03.09.01.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:38:29 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] intel_idle: Add Panther Lake C-states table
Date: Mon,  9 Mar 2026 10:38:18 +0200
Message-ID: <20260309083818.79588-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Panther Lake supports the following requestable C-states: C1, C1E, C6S, C10.
Add a custom table for them.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

Based on latency analysis using the 'wult' tool, and power break even
analysis using the 'pbe' tool.

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 167eb72105baf..36f5766381172 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -994,6 +994,43 @@ static struct cpuidle_state mtl_l_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state ptl_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 10,
+		.target_residency = 10,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6S",
+		.desc = "MWAIT 0x21",
+		.flags = MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 300,
+		.target_residency = 300,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C10",
+		.desc = "MWAIT 0x60",
+		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 370,
+		.target_residency = 2500,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state gmt_cstates[] __initdata = {
 	{
 		.name = "C1",
@@ -1623,6 +1660,10 @@ static const struct idle_cpu idle_cpu_mtl_l __initconst = {
 	.state_table = mtl_l_cstates,
 };
 
+static const struct idle_cpu idle_cpu_ptl __initconst = {
+	.state_table = ptl_cstates,
+};
+
 static const struct idle_cpu idle_cpu_gmt __initconst = {
 	.state_table = gmt_cstates,
 };
@@ -1737,6 +1778,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_ALDERLAKE,		&idle_cpu_adl),
 	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&idle_cpu_adl_l),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&idle_cpu_mtl_l),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&idle_cpu_ptl),
 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&idle_cpu_gmt),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&idle_cpu_spr),
-- 
2.53.0


Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462D3233F4
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777101959; cv=none; b=AfBIhleyTEW5KRhyruSz0jdFpWXdZALC+1N3uPcUGAn1v5ZLZXFPiDbBy9X9TaIE/672TYykXGd2F3VL51ofEvkK2oPWD30qxP0KTdx/DeiRkTXD2no4D6ALIhvK5XnIOOzp/aDpw/Z8A1mqoyhu9g+MYPtwfeTxnfZIMz2a66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777101959; c=relaxed/simple;
	bh=fJBQt11K94sXPJH5Xa0dB975vLtwEQIZAktflNxFx+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR052TWSvY0lukhRsyHyX42G2tCdfahn6R43gZZVdvRaxspX7tregmU5XgC9BCdug2zHhJUUn0syZpisnYU1oCWuDiXHO+hFvy31fyTwsoQiSKLbwE64fiVJtL+8KINDQwkWH0EoXi27u3eHQhc1koNYc7vgfD8Pwiuq7BDduhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEJ3JEh4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEJ3JEh4"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a3cee3a271so8629637e87.3
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777101954; x=1777706754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5SaBlIt9jLMT43Dt/ozM7A+Sj2M3L23PEksPli8HI4=;
        b=SEJ3JEh4Az5Q1/MPbtHbbKzCJvF3OTcA6DtB9m5Xn9JmHrZ4+ulekRQVG1fBy+4LZN
         6oNjcjGWTMcyj/+Q2bE7ANO9IE6GZJnsIbGpEN1CGEKs2hwt8AdoJCgtnKBva6lV6rrH
         Xi5+UgyAyD+hYYX3UEnscK5hOWNDJko/rXCmLrHS2icNm05zZpsGcZ5JBaHr82iXbf3X
         A+gxzfb8T4Acvncl5EFRcMVdMLJcEvKTGSLovBvRAT9fmf1e1bwTxZjqN7DTKYR7Md8Z
         84k+6CvsIBeIWCyVjbxWx5cOHftxRQs2a1HK5fjgiwuunMPhDj1E272N6P9A14clxxkX
         6jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777101954; x=1777706754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5SaBlIt9jLMT43Dt/ozM7A+Sj2M3L23PEksPli8HI4=;
        b=KiqLVFEyGDfGBBbQU5nSpGVtTHbsTVV+7MrBc5deUM+hMtCcmO2ZnCPQLZ3g+OBV03
         E6ygRVZqzeOzLWdVGkl/kUrgTfwsHDjRd6wU7BGYA8AiTklbAFI4vH2STUGrB93iwsUX
         MwQUG9VzlhwaR4hsvu3kUpRVUvxXqpHEMmY81VOepAWGOflpj5/YnVx37y2qFhlsmKt2
         ldWeVw4n4/SD3A6Yb2NnK3Vrjqy9cjXtbqvm0IzUoCH+nRzuXHv00fKgtg7hkHrKMyQm
         /3s1GjGeswpXetFvAbkX7ihsTnr14EkPD8HlcFCnLETYUF+B0XyqSjsu/kqaAqHHRbb4
         pjaQ==
X-Gm-Message-State: AOJu0Yx9+5oLq8/IiVtoxGR/lU2ITSwaLQ6ShiKsPQ6bZ+CB4aHlBud6
	uekDm2nhrT5PTI24gPWv8j/ht7MbIt+SiiU0qWmyFwOfe8Mrw24/ECLiDwWqnaFf
X-Gm-Gg: AeBDieuvJrEx00lYz4ZBWjY/H/empa21z1++H3poH8ZIOyc1hizRyhxe1+PJCAUj2SL
	3b+r+reeJ1uI1h+vKKawImdb2FzIODd3ggrmnG4tM0dxSeZW/ajbbFFVG7f0FyDivkkkW2L31ke
	UyVxNppUbBWCb2nHD46iOKwfFLpktpxufmpFbY+g0CxYGRrP9AoOWiZgDQmNnFwRAdJbZvLi/as
	Zw9kEI/ea+0qfXoZNJJFfx8caSx3k9iWXY/TN+5d9tlfPsyAfv18zJWY1CtNaURuPMfsZUTUsoj
	C+iQHsdVl8HbT9NmRzWj4PboiVJc7GuF+3mOqzQJ5US8TI7WbC9sP831nRiKI7/87/1/VUYVJEO
	2Y9IIE77WgCfH319lDv7zNOfxoSScgFHVBSphpEV41Am1osJo4oipdWidgg1+Zzb452jl+3i4+4
	ThGF9dJM1M6uEvXcuXhG/AhtnH45lBS72vNFHx4kGKdCOeot0O14JEGFSLQTAmkYKFg+sD
X-Received: by 2002:a05:6512:690:b0:5a2:bef4:5dfe with SMTP id 2adb3069b0e04-5a4172bbe9amr9962457e87.9.1777101954345;
        Sat, 25 Apr 2026 00:25:54 -0700 (PDT)
Received: from abityuts-desk (176-93-242-43.bb.dnainternet.fi. [176.93.242.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f6666sm55070071fa.15.2026.04.25.00.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 00:25:53 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH] intel_idle: Add Panther Lake C-states table
Date: Sat, 25 Apr 2026 10:25:30 +0300
Message-ID: <20260425072532.358365-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425072532.358365-1-dedekind1@gmail.com>
References: <20260425072532.358365-1-dedekind1@gmail.com>
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


Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA84718F7;
	Thu,  1 Oct 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894359; cv=none; b=a2BF/b0OnrY8Av8+TaUnxyaozMwGM0jz87HcPIzDOgMoXdX9ADPwi1+QJMtspYNTzSqJNy8fvvo4SccTg6Hfzgx81fMxLVqORThx4sl4o1ru5GPePt50JKRBmXPy9K0PVKEcAUuiOE/H0GnNYFAQrrsi3BjNy/RXnHPDgfhwBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894359; c=relaxed/simple;
	bh=VcLlxeJBBxMCvrjkjVQ6pzl/eLzIAuFsUx+/H3WTRZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t78RCNB3q+B7hLIJQiT7dTPVpXoOnOKjEYijk8IFJq8NLMP8ALsXzzXpZ5yqN1AiejFGVGkM/NgtlbI6txrsBa/DBNUp0o40Q+F0q1LQJgJ8wYinPHkqchV1h/8ZP8XrpAlzVKhoZr7QFAuu6tein3qsP+1gi7/OuWWZ5fs3Kd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=oKxLY2gD; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=f90V8717; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="oKxLY2gD";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="f90V8717"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894350; bh=9204PGMBXM9Y4gKyD6dqjwa
	jumnPs6Axuf8uLKXbhsg=; b=oKxLY2gD/l8AGe6FlMev/Yrq4g7BKxr768Sb5+3NuPocWzwO0S
	ffpPVWSTatmO+/jbQ3O1OEbiavTlOaMN1rw/OrP8mlOSqCaAKFy3vR+OV/FeA7D6B9OsEHtahzV
	dECu/IIEpJWYOrNccLMznhhi9NbkRsgcqdx7zEEzpJbxpJI3HUcdEUoRmDK4WIqWxVp+CU/KM80
	b7pVm/B22427O9mP0i2fgR1odJh/EY85q01L+MQunRfmoNpC+lJhsqgwyMjvQVcPx6qjuvAtHpB
	tvRu3uDci1UG/meENkjtGWpIBS39vQCvldXoFjljApIbDZCDnFOsQKmt3jR0Iidq2Lg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894350; bh=9204PGMBXM9Y4gKyD6dqjwa
	jumnPs6Axuf8uLKXbhsg=; b=f90V8717Ab4C+LHuXtqNM/QrzKt6dT43eqpUJus8dZg96Z4tZx
	T4VtaJMRRIMvO9fb1AzacjbsxvWNCFtK+tBw==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 02 Oct 2026 00:38:31 +0200
Subject: [PATCH v3 3/7] pmdomain: qcom: rpmpd: Split SDM632 pm domains from
 MSM8953
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-sdm632-rpmpd-v3-3-95c47d0f26cf@mainlining.org>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
In-Reply-To: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790894346; l=2562;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=VcLlxeJBBxMCvrjkjVQ6pzl/eLzIAuFsUx+/H3WTRZg=;
 b=wRfbKIAVQwkrxPFOe7KWSvjXolN/Wm0CgZUKpuLHVfukzukEp/wt9jmSPMRSy6B6p/yB2BnJF
 dqy6KcOtaQMAwqGoGzIKJXO8Ey7akbzrHjTuhwH5rRz9qSCbWDHRdwp
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Remove modem related pm domains from MSM8953 rpmpd because MSM8953 MSS
is using mss-supply as regulator.
Split SDM632 rpmpd from MSM8953 because SDM632 MSS is using mss-supply
as pm domain.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/pmdomain/qcom/rpmpd.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 5f55fc791131..c37a79d6bc43 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -503,19 +503,8 @@ static struct rpmpd md_s1a_corner_ao = {
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd md_s1a_lvl_ao;
 static struct rpmpd md_s1a_lvl = {
 	.pd = { .name = "md", },
-	.peer = &md_s1a_lvl_ao,
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd md_s1a_lvl_ao = {
-	.pd = { .name = "md_ao", },
-	.peer = &md_s1a_lvl,
-	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_LEVEL,
@@ -703,8 +692,6 @@ static const struct rpmpd_desc msm8917_desc = {
 };
 
 static struct rpmpd *msm8953_rpmpds[] = {
-	[MSM8953_VDDMD] =	&md_s1a_lvl,
-	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
 	[MSM8953_VDDCX] =	&cx_s2a_lvl,
 	[MSM8953_VDDCX_AO] =	&cx_s2a_lvl_ao,
 	[MSM8953_VDDCX_VFL] =	&cx_s2a_vfl,
@@ -844,6 +831,21 @@ static const struct rpmpd_desc qm215_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
+static struct rpmpd *sdm632_rpmpds[] = {
+	[RPMPD_VDDMD] =		&md_s1a_lvl,
+	[RPMPD_VDDCX] =		&cx_s2a_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_s2a_vfl,
+	[RPMPD_VDDMX] =		&mx_s7a_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_s7a_lvl_ao,
+};
+
+static const struct rpmpd_desc sdm632_desc = {
+	.rpmpds = sdm632_rpmpds,
+	.num_pds = ARRAY_SIZE(sdm632_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO,
+};
+
 static struct rpmpd *sdm660_rpmpds[] = {
 	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
 	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -954,6 +956,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,qcm2290-rpmpd", .data = &qcm2290_desc },
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ .compatible = "qcom,qm215-rpmpd", .data = &qm215_desc },
+	{ .compatible = "qcom,sdm632-rpmpd", .data = &sdm632_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
 	{ .compatible = "qcom,shikra-rpmpd", .data = &shikra_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },

-- 
2.56.0


Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FA5437FE;
	Tue, 13 Oct 2026 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.36.144.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923190; cv=none; b=CtTMFt0GSv4L7E8aW5G9OSxqpWhjtFNo7tfjGu37Hvf5YyzOQu1Git/S6t5aAGlVr+gK3UY1+o8QwwUEy7Qm8EtQ3vTbUjbN0o9iyLN/tVTPwAXx2LIAMBfV5hEMWXtlAsE2fUDAJInfeuBnhsKeCzuQDcgkWEDV0fyhbGNCuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923190; c=relaxed/simple;
	bh=e7OaXtRaIUPN6KYJqgmrutd005XtXbDuy5qcL3itMZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4jNtKUgXkV50wZHXfjHDva+teT/gjetMne6V7MDuufEm3ZtBEPD6C+aj4baN15WTs4a65U66tcxUKKhJAGd7NNGbS3bDkZBBlVytCOGh8nOm2RyzAXAtpN4Bq2JsZZNL/NBRC11ZS1OKBAbhFCBPYmvNq0fHveNQmkMX47CAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de; spf=pass smtp.mailfrom=yoxcu.de; dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.b=JAq2c9tl; arc=none smtp.client-ip=194.36.144.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.b="JAq2c9tl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B0AA1D87E62;
	Tue, 13 Oct 2026 22:26:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1791923185; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SjLgg6eeaAg4win7q0F1mhz2B/Z2dOV+sRH+5a6YmUE=;
	b=JAq2c9tlV6izlK1l+nI3W9qsr9+PqKJaJK1chT8SpHRSxS7IV9oX8CSg/Sya22Q2RUOv2u
	eav97KdPSaAEH1+PsL15wow1yBMXpB1uQ0FmvZTO1LT7HyBYNyt7jCXN/ADCi6CYuOajyx
	MX6dt4w0Tcnnfy60fPyvhQjiba6yLrVTrI25+TYnhW2L/HxTI2B7WnMU6oTz9mXntImEIu
	1vq2vfMagfFqDdPbFGl2ahCtxiLejeRywJ30kmm7FuA+r0ObRJiunmXrh+GMMI0xfZFByR
	Esz3ans/hUL3wFftDZFWM1jQy1UiEJ7pD51pJde9BTUePbKG/cPKQRmn6sBF6Q==
From: yoxcu <mick@yoxcu.de>
To: Georgi Djakov <djakov@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH RFC 2/2] interconnect: qcom: sdm845: Own the ALC BCM to drop its boot vote
Date: Tue, 13 Oct 2026 22:26:11 +0200
Message-ID: <20261013202611.3070778-3-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013202611.3070778-1-mick@yoxcu.de>
References: <20261013202611.3070778-1-mick@yoxcu.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Michael Auer <mick@yoxcu.de>

On the OnePlus 6 the bootloader leaves a vote on the ALC BCM
(rpmh_read() on the APPS DRV returns 0x2000000f). No driver owns this
BCM, so the vote is never removed and the SoC never reaches AOSS sleep
or CX collapse (qcom_stats aosd and cxsd stay at 0).

Add a node without consumers for the ALC BCM on mem_noc. The provider
then owns the BCM and drops the vote at sync_state.

With this change ALC reads 0 after boot and suspend reaches CX
collapse. The average current in an idle push standby test (Wi-Fi on)
was 35.6 mA, against 43.7 mA with the ALC vote kept in the sleep set.

Assisted-by: LLM
Signed-off-by: Michael Auer <mick@yoxcu.de>
---
 drivers/interconnect/qcom/sdm845.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 1c434fd12ead..2a35ed7fce49 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1114,6 +1114,13 @@ static struct qcom_icc_node ebi = {
 	.buswidth = 4,
 };
 
+/* No consumers, owns the ALC BCM so sync_state drops the boot vote */
+static struct qcom_icc_node alc = {
+	.name = "alc",
+	.channels = 1,
+	.buswidth = 1,
+};
+
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
 	.channels = 1,
@@ -1250,6 +1257,14 @@ static struct qcom_icc_bcm bcm_acv = {
 	.nodes = { &ebi },
 };
 
+static struct qcom_icc_bcm bcm_alc = {
+	.name = "ALC",
+	.enable_mask = BIT(0),
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &alc },
+};
+
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
@@ -1646,6 +1661,7 @@ static const struct qcom_icc_desc sdm845_gladiator_noc = {
 static struct qcom_icc_bcm * const mem_noc_bcms[] = {
 	&bcm_mc0,
 	&bcm_acv,
+	&bcm_alc,
 	&bcm_sh0,
 	&bcm_sh1,
 	&bcm_sh2,
@@ -1669,6 +1685,7 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 	[SLAVE_SERVICE_MEM_NOC] = &srvc_memnoc,
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
+	[MASTER_ALC] = &alc,
 };
 
 static const struct qcom_icc_desc sdm845_mem_noc = {
-- 
2.43.0


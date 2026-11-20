Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177328;
	b=1B//6LLBh24hW1Y48fGRlBZPyMsTPdeOkPIler9f1fB6QAKul1oufL2wP0k1fINouyLT
	 QMA0YchcNBg78BZtqrf4/e+KRPX/i4o5tq1SvFJxlIGOtxhwFESsOg8MI9csDiKxV6odn
	 re8BZLxMxO0kuaV3RIDyKMa2r7p0T7uwnluf7j7MnKR/L6xtZ8jGu8su9k48z3Hu8KzWm
	 rP8/q6XDjRSQ6t1Iq4DKNBAajAFKlAcmLcrGmHtVqlk9trkT3BZP0nPQQ0tdSmT6m5IrJ
	 fTDL6UCIShx7LAC8RVeFuw691jwfPVC/VRSTlyjrSIYiB1+pE2z70p/P1uierMSlMrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177328;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=mJMykgsXy/IvLDQUJldjSJK+kP6sz76ONtXtW27Eff4=;
	b=lmCsYVKcdRoJ0tXhMZ8H0E6f9S5f/eD6vXvdZWLI0AtCD2QxBu9Tk0exc1jCMBq/IGmt
	 C4LYc/BBb7UTMX4d/xYXvUcmkX5PxrUdUzv54iPZGD4n1CHVWP5Fu1c7RMUszRT8zlx9z
	 gxfPk0W3Q1qRdCwrEbCYC62+mxWvDehyiq3DN3S3NeZOfudCvHYSI74hEy1u38zVNs2ur
	 WMLRaN9rGbFIAhBAsOwQEh7u0byIbS/NuUQSUVihYq6USnf81kpDWQsqX4HWuS0CwpWTY
	 rzS2lsX9CmQmBDnEFwjD2KU1whPVLwy9GAa7TeBV68ReRuu7+I0WhFG9iDQ7DYvfTrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=moETzJB9;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C0606A336;
	Fri, 20 Nov 2026 12:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 110C0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=moETzJB9
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C2991D86DDA;
	Fri, 20 Nov 2026 13:22:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795177325; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=mJMykgsXy/IvLDQUJldjSJK+kP6sz76ONtXtW27Eff4=;
	b=moETzJB9ktAP1PI/EU9z925wihL+ZmBXgnxdMcoGco3Tpa7Z/4wTWfztsUs9BRhGZLikpM
	hEySyN5LZ8VglEgJueeqw961IsoZpdJjXtaULGx0bktl4RpY0upAr/idRaR+mpjx42/h4B
	qtFcc6+nA2SgrEy1NG2tGQ/+P7h4+z+xrizpgvd0EUcy+DJzp75hVDkJR+9UdBV+Aj1nS9
	PDXhA+ZOrIK8xESS0XPLoCRShBqPRHiqu0LZHgne4A3zvXDrBNFTc2KCZBKg5+6fAc+RB9
	xZsVriuZN/qe6xOIdk/33tgsbp9QDLKvaOOozUF328hqMszI3Zc+TCt9V1Ge5A==
From: Michael Auer <mick@yoxcu.de>
To: Georgi Djakov <djakov@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mike Tipton <mike.tipton@oss.qualcomm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH v2] interconnect: qcom: bcm-voter: Clear the ALC vote left by the bootloader
Date: Fri, 20 Nov 2026 13:21:52 +0100
Message-ID: <20261120122152.198114-1-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The bootloader can leave a vote on the ALC BCM. No icc node maps to
ALC, so Linux never touches it and the vote stays. On SDM845 this
keeps DDR out of its sleep state, and the SoC never reaches CX
collapse or AOSS sleep in suspend.

Clear the vote when the voter probes: (12, 0) in the active-only set,
as the downstream kernel does, and (0, 0) in the wake and sleep sets.

Tested on a OnePlus 6 (SDM845). Before, cxsd and aosd in qcom_stats
stayed at 0. With this change, CX collapse was reached in 139
suspends over one night, for about 7.6 of 8.9 hours, and the average
current over the night was about 27 mA. The active-only vote stays
(12, 0) after suspend and resume, and the awake idle current with the
display off did not change.

Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Michael Auer <mick@yoxcu.de>
---
Changes in v2:
- Drop the dt-bindings change and the dummy ALC node. Clear the vote in
  bcm-voter at probe instead, with the code Konrad suggested.
- Link to v1: https://lore.kernel.org/r/20261013202611.3070778-1-mick@yoxcu.de

This runs for every voter on every SoC that has an ALC entry in
cmd-db. SDM845 only has the apps voter. Should it be limited to the
apps voter?

Ard, the code is different from v1, so I did not keep your Tested-by.
A retest on the C630 would be great.

 drivers/interconnect/qcom/bcm-voter.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 0880a287b0c0..f9d51f3d586d 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -390,6 +390,46 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_commit);
 
+/*
+ * ALC is not modeled by any icc node, but the bootloader may leave it voted,
+ * which prevents the SoC from reaching CX collapse and AOSS shutdown.
+ */
+static void bcm_voter_clear_alc(struct bcm_voter *voter)
+{
+	struct tcs_cmd cmd;
+	u32 addr;
+	int ret;
+
+	addr = cmd_db_read_addr("ALC");
+	if (!addr)
+		return;
+
+	tcs_cmd_gen(&cmd, 12, 0, addr, true,
+		    voter->tcs_wait & BIT(QCOM_ICC_BUCKET_AMC));
+
+	ret = rpmh_write(voter->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
+	if (ret) {
+		dev_err(voter->dev, "Error sending ALC AMC RPMH request (%d)\n", ret);
+		return;
+	}
+
+	tcs_cmd_gen(&cmd, 0, 0, addr, true,
+		    voter->tcs_wait & BIT(QCOM_ICC_BUCKET_WAKE));
+
+	ret = rpmh_write(voter->dev, RPMH_WAKE_ONLY_STATE, &cmd, 1);
+	if (ret) {
+		dev_err(voter->dev, "Error sending ALC WAKE RPMH request (%d)\n", ret);
+		return;
+	}
+
+	tcs_cmd_gen(&cmd, 0, 0, addr, true,
+		    voter->tcs_wait & BIT(QCOM_ICC_BUCKET_SLEEP));
+
+	ret = rpmh_write(voter->dev, RPMH_SLEEP_STATE, &cmd, 1);
+	if (ret)
+		dev_err(voter->dev, "Error sending ALC SLEEP RPMH request (%d)\n", ret);
+}
+
 static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -409,6 +449,8 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&voter->commit_list);
 	INIT_LIST_HEAD(&voter->ws_list);
 
+	bcm_voter_clear_alc(voter);
+
 	mutex_lock(&bcm_voter_lock);
 	list_add_tail(&voter->voter_node, &bcm_voters);
 	mutex_unlock(&bcm_voter_lock);

base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
-- 
2.43.0


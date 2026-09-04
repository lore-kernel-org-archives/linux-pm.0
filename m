Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3F433E9D;
	Fri,  4 Sep 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522946; cv=none; b=e4sO3Qvh4DzZpExFlF0CE8mJUJ1Rb4v4IVXePnWcQ1RXMJjnLpGOI8rMeqDRhd8lPNwRq8Pqbw83HffddqoHJlPOpMeSWqSgXh74BTdrqx9c6WMAp/p6KoEcj7e3NTYnQfJ+gPyk+RPaCAAAMkr2QyDoPTNvmux7pMzqZgPFNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522946; c=relaxed/simple;
	bh=78sqk5H7Lxmz4BUyx1zh85KTEGpS399Pnj9Wdvf2OjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tD7frjCfjQgmvHvsyQDm4AbkZ5hH104YgY1KMTgW2un+BQvPIlBr/K90PDQTaWdpdSd1btdxMLJMIv9MMaQEUax+Jyth5bfgp2lhNde7Koc2xYvSMTJcm9/Oj+fzfzvxNQt/EjSLj8APbdDPczgkqI8NasJ1PC4cLD8Yih/T1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPDfrjd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPDfrjd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAB21F00A3E;
	Fri,  4 Sep 2026 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522945;
	bh=i1e+iVX92LAvk1+uOyCaklFwP113Nslf61WHHfDzMFI=;
	h=From:Date:Subject:To:Cc;
	b=YPDfrjd6cCvKL4bZ8j7f6ofqLLZIp8sjSygASv7D7g0fK1z8nLZSXzcGU7TnC8ffo
	 SpfV73WEmOB32l1OF40iSQFLx4+uLTJDeyv4CTVnjoAewMlfdbUUNjVtT+U/nrlPgi
	 lWW+7BRdczIhFRhHgl4kNoO7vJNn8K9/aFtJ2xiXuB2ih92tmrkskOb+iLRNdjtwZY
	 IKDzMVPrT64A6bypGUmDKX3GLdNAEzFGt96nPS7na2VIL4rOyrGiEwjKDzXOueY3Lt
	 YEMBOBtFTF4XIS/g5DNkjc8dcpToOHqY+OAOUwF5eYonQFe6FXSIEBGmYxUEOhArxY
	 jOy3WVag8LILg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 04 Sep 2026 13:55:37 +0200
Subject: [PATCH] interconnect: qcom: use 64-bit SMD RPM bus votes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-topic-icc_rpm_64b_req-v1-1-37e24f1991a3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrBsYRSPxKqUEnY7tFNR0olIQ7
 260y7f4f4PIKhyhyTZQXiXKNCbktwzo3Y4vNvJMhgILiw5LM09ByAiR1zB4W3Ze+Wtam2NvK4e
 VqyG1QbmX3/W9P/6OS/dhms8Z7PsB1bCR5HkAAAA=
X-Change-ID: 20260904-topic-icc_rpm_64b_req-a610f6590597
To: Georgi Djakov <djakov@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788522943; l=2752;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=OkDSUi/LdA4pTBLQ7ya43ShjOBq9ARa4CWM0ri2JlmI=;
 b=HMp9bpuBIpTptLljnU3iP37MMC8bObxtvy8Dk30GhpS/Dw7FV+TxklD2g7rDixnqvl7WFkd+m
 pFM/8P5WPz3DQmnyLy7U/arRMx9H2VkfPQsQvU55WoQ0pGrOhtP6BD6
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

SMD RPM bus bandwidth requests carry a 64-bit bandwidth value.
The interconnect proxy declared the KVP payload as u32, truncating
votes above 4 GiB/s and advertising the wrong payload size to RPM.

Use a little-endian 64-bit payload and accept a u64 value in the proxy
API. This has always been the right behavior, even on msm-3.10 and
32-bit SoCs.

Fixes: be06f8e7425d ("interconnect: qcom: Add interconnect RPM over SMD driver")
Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpm.h | 4 ++--
 drivers/interconnect/qcom/smd-rpm.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index cdd5f444b152..b8fa786d3bfd 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -30,7 +30,7 @@ enum qcom_icc_type {
  * @resource_type: RPM resource type of the clock resource
  * @clock_id: index of the clock resource of a specific resource type
  * @branch: whether the resource represents a branch clock
-*/
+ */
 struct rpm_clk_resource {
 	u32 resource_type;
 	u32 clock_id;
@@ -167,7 +167,7 @@ int qnoc_probe(struct platform_device *pdev);
 void qnoc_remove(struct platform_device *pdev);
 
 bool qcom_icc_rpm_smd_available(void);
-int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u64 val);
 int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int ctx, u32 rate);
 
 #endif
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index dbc7ae50b02b..6ac9aef942ad 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -20,7 +20,7 @@ static struct qcom_smd_rpm *icc_smd_rpm;
 struct icc_rpm_smd_req {
 	__le32 key;
 	__le32 nbytes;
-	__le32 value;
+	__le64 value;
 };
 
 bool qcom_icc_rpm_smd_available(void)
@@ -29,12 +29,12 @@ bool qcom_icc_rpm_smd_available(void)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_available);
 
-int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u64 val)
 {
 	struct icc_rpm_smd_req req = {
 		.key = cpu_to_le32(RPM_KEY_BW),
-		.nbytes = cpu_to_le32(sizeof(u32)),
-		.value = cpu_to_le32(val),
+		.nbytes = cpu_to_le32(sizeof(u64)),
+		.value = cpu_to_le64(val),
 	};
 
 	return qcom_rpm_smd_write(icc_smd_rpm, ctx, rsc_type, id, &req,

---
base-commit: 32b6ef9a5d0eca44f9cd91f52f4faa89f145a0de
change-id: 20260904-topic-icc_rpm_64b_req-a610f6590597

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


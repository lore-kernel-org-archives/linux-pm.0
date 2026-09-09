Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A68585968;
	Wed,  9 Sep 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972140; cv=none; b=qLrRDrqjIl/pEHRB1sYkY+eipqnLkst5JrAMjOVelRuV/TUY0OuG9I36yqHqX7sAtX3+Xu5FzM/HAsyBjjYhxFmX9CMD3VG5j1sEPaOeVvOmsh5d7NLVK25iQQQHvxU8MTV/ytRFPHdcIWxCg4c6srEo9ocGfBmsGk5T9aN7qLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972140; c=relaxed/simple;
	bh=colMcQhGsvUQisGiDdEb/913gMwPxUjx5UfOhyIWaf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGm4t54UsW0pkREi4/Jo4P0H7otZYVUwSqststpBCXAZYNfRhwoigdZLMtuGKOhVDh/ocOw0KC4s7tD8/RO5wlZCNAgReZLGLksLkmXBLn0Bi5j1A2SjIYB3wf573ZITelgNnhWTLsn1JrGT4W5pszUSNGCXcyGUEbjLLC/nQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yve1qiA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yve1qiA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A331D1F00893;
	Wed,  9 Sep 2026 16:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972138;
	bh=c1NSwFJOt9Rq2u8EI/PLslmEct20Up/KRVRlPxjXiKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Yve1qiA7LG5Ihw/gOqT4z2ciYs92iX0yOA6SryZD4DU/+TMbynqCZB1GU4jy7K5tB
	 n+30at+j3gG6niot2nZMXDnAGqhR9ru1r0ZE4CU6C8w1g5IJxj6Nst+Cvc5EIb8RbD
	 xy/Oqg3y5rxlPeASfidiBKvI55q6tbx9GWoSCJj0anSKe7qsKcL69sAy5TnFJc3ATS
	 9bH5MVZ0U7t4UWf8U+JBV9OQEn9eh0JWzJQQRdKThKI5qm06THmXN1LTPxv4NcT4/Q
	 wIToUZC7z/Egv9FYBF5pD/PEJesaPoiMW/jkeRH10D8nZolKe98lb7sVgnCeGQ4y28
	 GULnWBJ/bQc8A==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 09 Sep 2026 18:41:58 +0200
Subject: [PATCH 5/6] interconnect: qcom: msm8996: Configure auxiliary Venus
 QoS port
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-topic-icc_rpm_smd_qol-v1-5-6dc5b5e97626@oss.qualcomm.com>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Adam Skladowski <a39.skl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788972117; l=804;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=Guepwd0CuDGgMGInIQXUtcEqVLXI53hk28wMJtQhEmg=;
 b=oE23CWNECwenZQkhuE1thx8PUG1xcD8ukKLTg08xNr3d03QEoY0QwBeNuf3H/+DOcoBN0cCL5
 2T2J2fA5LI6BiCKxndVOKHT38G19ftovBzXEmKXlzIyfqnauHnSNS+w
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Enable the secondary QoS port used by the MSM8996 Venus node.

Assisted-by: LLM
Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/interconnect/qcom/msm8996.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 882f9d2b6d4e..7fc808cc5975 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -501,6 +501,7 @@ static struct qcom_icc_node mas_venus = {
 	.qos.areq_prio = 0,
 	.qos.prio_level = 0,
 	.qos.qos_port = 3,
+	.qos.aux_qos_port = 4,
 	.num_links = ARRAY_SIZE(mas_mnoc_bimc_common_links),
 	.links = mas_mnoc_bimc_common_links
 };

-- 
2.55.0


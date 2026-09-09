Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4D5867DB;
	Wed,  9 Sep 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972132; cv=none; b=IaOWY2OXZAEwig6xoke3zAorkzZOga6aywGIB627LmmrP8j84PoSHpOJ63AYmnhd81P+R+0K8+BJQmH81FhdX5EvKwUFTHIFBsxGVJ4e8CrnCf8FR7usl0NeqkSv+KZ1xajc456C7Dd9q1vX6yNkdP4oh3mAPh0YAeDbI3vPvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972132; c=relaxed/simple;
	bh=ykZnuLH4pAqPrbYh9fFWACOZE8tDWlV4LwIVPGYI+PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hes2ZAShu4JeEGKinmBY0dsrSVfiMs+hpvNAPpqol0oaZ77GCtpa8Gb2c+SOKu3vvrHQi9bYuoWGMensKGkcUi1EUkZuOzIST4DloHJ2yBSX2KLEzsf5ZTWEqQjKqPE4P78F4RVI/qKAdw388MTKppx/KVF7unFVs7p8ssxk+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFKi8GtO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFKi8GtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1651F00893;
	Wed,  9 Sep 2026 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972131;
	bh=y8PoVu8aSaRIRZxFbqhcwKB7XCs+xPUwp92Rj5i/PSs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hFKi8GtORl7/9IIRUQZNuuDejhNEdmpZdqCvj//1vF1Q4N0OIUQgLfa4hUc0TjAq9
	 RjlnkyMf2TO8b7EMIE1jYujaZXE8yCtoTbUAixh+bQuXStEb3zbZUqb+SPc31HFKwM
	 9ZoxMezImWVKMhqss8bhdXmSzIfoW0cvd0y5p0RP89v3dJ2DIHQ1rbL+jyleSwG9Z8
	 h60mT6Fp/QKCf8R6RxDlajkXdXMT2jqwrPRtUAs5WStw7QAkNb11sQIM8tC+Ymfu//
	 1+mcUmmiUXdONslqdAFHV06oa4rwjGqvEoBuFVzaERZ5L/O/UfE+OQGyPsMv2BTGYB
	 71OQfub/PwqTg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 09 Sep 2026 18:41:56 +0200
Subject: [PATCH 3/6] interconnect: qcom: icc-rpm: Handle icc_link_create()
 failures
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-topic-icc_rpm_smd_qol-v1-3-6dc5b5e97626@oss.qualcomm.com>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Adam Skladowski <a39.skl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788972117; l=1186;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=4OietwpgRaB7dskRwb1aHQydl/vmwBVTXw0RtqdsnJo=;
 b=XF29T/95lJH5Jf0v1GctPJs9Stbn/UbL5lMyCbHooc1o2RXXd/f3QPVYaykSoQYd8g/4h105w
 efBZIQu6RFmBG7jQvV8jJ4CJ8bnbnuqpzsl3qbUVYSXvxJTR1nMeJ/7
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

icc_link_create() can return errors. Don't ignore them.

Assisted-by: LLM
Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index f571f002ccbd..5d8a41aede8b 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -583,8 +583,15 @@ int qnoc_probe(struct platform_device *pdev)
 		node->data = qnodes[i];
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
+		for (j = 0; j < qnodes[i]->num_links; j++) {
+			ret = icc_link_create(node, qnodes[i]->links[j]);
+			if (ret) {
+				icc_nodes_remove(provider);
+				clk_bulk_disable_unprepare(qp->num_intf_clks,
+						   qp->intf_clks);
+				goto err_disable_unprepare_clk;
+			}
+		}
 
 		/* Set QoS registers (we only need to do it once, generally) */
 		if (qnodes[i]->qos.ap_owned &&

-- 
2.55.0


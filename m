Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17F58B6D5;
	Wed,  9 Sep 2026 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972143; cv=none; b=jnIAw0i641Xa5gPEJoTcM2kDZKOYfvGL/ZE2FvBlB74B4gRy0JpTZQpFl9y3XJjZTBZ/jdxoWEvugMuzaPeNJccW+CQuk0XTJv3P0y1yE4FBrURvlXF2Jn/FG1YBdm9G5f6lBS+zZMIvaRf9LuT5W5ndFbkQ23kBz0gbp9drQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972143; c=relaxed/simple;
	bh=wYQCFXqH48ZLFdhzjjRSCUFa3Q0kbFjcEF+eC1LeN2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDGUJj9yR+Wp2Z8/MzMj26w7kwIyDv7Bir1F0+Ea63E8pmRxK9fzvN4hSAy1GhCcB1mjINMZE94XC/fj6bp3wCx4TLYj8SohIF9J/ndnZIjqgCRhCSB/toYCoEtKhRBZ5+xFf4YCQDUw02LB97RSHA44Bj8Q3CXFi7cW/Yid0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nje1edKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nje1edKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D78B1F000FF;
	Wed,  9 Sep 2026 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972142;
	bh=ConfJibyxipxTH9JVW04JGxe7tLVOw+GS9d3RJCp3z0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Nje1edKfQrxAnX8meZD1tIM8SYtYREz33T/hgww+bcnjJysSDKA0qdDgXj+dNAwla
	 YuLx6ht2XIZ8pqTQc2DHx/pWPFOBwySHfhdPzj5WF/fGXHGnzwFKFb5jSUmiKRvOY/
	 0zKEsMxHIR3H5uMmpw5sz4xjCzgU2GJPyRudkUKmHx3uFbrpJNu8XDpfi20+kYHcx6
	 SAO7BJ3khWcEmk0dlmMDzGRqEC+Am0b3W8swbJpPecgrVW+Nf+DrkLU9WQ01/7hKfw
	 f+nVDCQuNVjHuzYslSZz4SHd2NGT+GDCTMRl8wq6++vC5haHSphqFCxprgRh4KK8PD
	 b5s7tW53uk4fA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 09 Sep 2026 18:41:59 +0200
Subject: [PATCH 6/6] interconnect: qcom: msm8976: Configure auxiliary GPU
 QoS port
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-topic-icc_rpm_smd_qol-v1-6-6dc5b5e97626@oss.qualcomm.com>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Adam Skladowski <a39.skl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788972117; l=879;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=JkfBWEaftj2Y4hKi9rFBS8295BraOyAd/v0v8sIgbws=;
 b=1nlIlWTvlYZrhspew3MvBoAmy1Xd6lpJHvhSfpHKtZ7nBrTt5q51XeJeKEzsTHsIEBmZSxJYw
 VkG18S5QDhZAh2y+aDUiWljU+Z9e6ZfmLPMCm716iYGydKN+Hk7m5cw
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Enable the secondary QoS port used by the MSM8976 GPU node.

Assisted-by: LLM
Fixes: 6e3ea1f36b10 ("interconnect: qcom: Add MSM8976 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/interconnect/qcom/msm8976.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/msm8976.c b/drivers/interconnect/qcom/msm8976.c
index c219dcfd43b6..11100264ef69 100644
--- a/drivers/interconnect/qcom/msm8976.c
+++ b/drivers/interconnect/qcom/msm8976.c
@@ -454,7 +454,8 @@ static struct qcom_icc_node mas_oxili = {
 	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
 	.qos.areq_prio = 0,
 	.qos.prio_level = 0,
-	.qos.qos_port = 16, /* [16, 17] */
+	.qos.qos_port = 16,
+	.qos.aux_qos_port = 17,
 	.num_links = ARRAY_SIZE(mas_oxili_links),
 	.links = mas_oxili_links,
 };

-- 
2.55.0


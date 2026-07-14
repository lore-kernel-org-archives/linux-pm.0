Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6B370ADA;
	Tue, 14 Jul 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024927; cv=none; b=oCu0EP52uCsMS/8mw4hfRFH+rHCd9ohZSKZqUeuK+0baNoUCC0lbCLmZJlZ80jxKSRStkdq+QOKoj9pZYznS0wkMmRhGvhxvuxD+28plEZC/FRCGGWrdqDZ6X83V9nGt6d7NEALAC0FhSVT+Bk3uUbAXVj7mRJddi2CTKnh5i6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024927; c=relaxed/simple;
	bh=LTBMkiOmw98UTxWEbpAQ9H5QlhAKTpgEXEjclnTOmAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jdtWgwVJxGU/qnYLMx+D+vaeslbS66hGvutATk8bO9p/USYq+sueLj2abLhvD4QIMJpjPPncTTgO+edh3hEFzGhhfLLnyP5Iue3845OfXEY7R/W9uFiq7+d/GLOAqHS9053SlCUntGseyihXf4a/MWlXJjiOaW6wHvXYbrYieYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHr3YTi8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHr3YTi8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA166C2BCF6;
	Tue, 14 Jul 2026 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784024926;
	bh=LTBMkiOmw98UTxWEbpAQ9H5QlhAKTpgEXEjclnTOmAE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gHr3YTi8pKSiWEpP/wdKvUSQTH0i2dzJvyxIFBCvT58XPSFYabymZ0G07KdkDbDa4
	 qSupei/lgH8Dcz2caJOalvi3ITWOl/0U/EwN/A1lD1W/lgFVUeqqW7QxlnanzX9O1q
	 9oULsevwSyVNgOMncHN+rfCJJlQMmExjPVLqVN435ML9YH+W4DjISzep3SF4qXm7sA
	 i8qpIfMtFxSqnwFvgtVIKDiaJPivCRAXdHXIqvJpKMNldTMzoMilunvcLNq1dXIrB8
	 WT6b3+0VpQJkwWL24vyjqsFvPlN8PmSmm3eyF7qo8KqDEKqyLAtsUxUWW4WB2aX7EA
	 1LXXLFfis6qtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E89C44508;
	Tue, 14 Jul 2026 10:28:46 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Tue, 14 Jul 2026 18:28:42 +0800
Subject: [PATCH v8 2/3] thermal/drivers/imx: Fix rounding and clamp for
 i.MX7D alarm
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-2-d54d8690e16e@cn.bosch.com>
References: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
In-Reply-To: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Haoning CHENG <Haoning.CHENG@cn.bosch.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784024921; l=1614;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=1JBV0u3QEY1X06yF+bBAxZo8ixtbx4eg4tQIOMJHWHs=;
 b=LslAkJd+wyxZebCbOnxK6QkqPn42J1gBAC0+EEqd81HxjetCdZIuFcuu9dcZflFdJgFrONEix
 D0jBwdItWe3AExsdqpDQrGB5K5kdWq6HGSMGBbC1D+V0wco9qbQ3O3z
X-Developer-Key: i=Haoning.CHENG@cn.bosch.com; a=ed25519;
 pk=glQGwad/fosRS5gZUJYbLDPPLGe7rFTrTV2VxY/ySdc=
X-Endpoint-Received: by B4 Relay for Haoning.CHENG@cn.bosch.com/20260709
 with auth_id=860
X-Original-From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
Reply-To: Haoning.CHENG@cn.bosch.com

From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>

Convert the alarm temperature from millicelsius to degrees for i.MX7D
using ceiling division instead of integer division, ensuring rounding
errors do not cause the alarm to trigger below the intended threshold.
Use DIV_ROUND_UP() for non-negative values and plain integer division
for negative values, since C rounds toward zero which is equivalent to
ceiling when the divisor is positive.

Add clamp() to ensure the hardware register value stays within the 9-bit
range (0..0x1ff) of the i.MX7D alarm field, preventing silent truncation
if an out-of-range value is written.

Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
---
 drivers/thermal/imx_thermal.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 38c993d1bcb3..7f7d1116b9d6 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -240,10 +240,16 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
 
 	data->alarm_temp = alarm_temp;
 
-	if (data->socdata->version == TEMPMON_IMX7D)
-		alarm_value = alarm_temp / 1000 + data->c1 - 25;
-	else
+	if (data->socdata->version == TEMPMON_IMX7D) {
+		if (alarm_temp >= 0)
+			alarm_temp = DIV_ROUND_UP(alarm_temp, 1000);
+		else
+			alarm_temp /= 1000;
+		alarm_value = alarm_temp + data->c1 - 25;
+		alarm_value = clamp(alarm_value, 0, 0x1ff);
+	} else {
 		alarm_value = (data->c2 - alarm_temp) / data->c1;
+	}
 
 	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
 		     soc_data->high_alarm_mask);

-- 
2.43.0



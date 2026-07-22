Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504938F95E;
	Wed, 22 Jul 2026 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687945; cv=none; b=rrq/obR+TOiRIsWyxSa+hMT9tdLp5MDFqrBCPd2cbinSyNEpL5lu1N/eM+Geok3Pn89AUDArLaVQO5sQKpMl3xMBTmuWbtUzzQ51NHYwH3utBtOHL3+75HylKS4vHpP1qoQbWoTC1CigTIJzagfDkszi8Li04A110kFwF2oEhhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687945; c=relaxed/simple;
	bh=mhJJOiGSAySJ9mUo6G70qcgxDi+mETTMgMGHEkSRrZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWB94PNxWWGHc6gkTc77JpoLN//FQhiF4ORhNVlr87J8j8SC83WmxbdIP45gkpXys12O2zPBKxRrvrnWEdB8CGJoHi59EkjG4+seOeEkhxyr3A5EhJKNumC4+/JCJ6Ktl5lkVMhVmGICzh13MSjbBKaRW0vmTJPDq2sqnYW+4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbmKITDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbmKITDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E9A4C2BD00;
	Wed, 22 Jul 2026 02:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784687945;
	bh=mhJJOiGSAySJ9mUo6G70qcgxDi+mETTMgMGHEkSRrZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LbmKITDZEXXBQ/8IH4zFGCagaFgNSujRWX5VLt+adrB/x57qVc4itup7K6wnkjMyb
	 rFuYm6STR9yWOyn4nuAXr524KG/rhk6l40a5tP7p1c3l3YV/zaLfRpAXYTsY2bHDr+
	 4bleXFu0MJRVMTPmZMZvMI5iRVJfxRXEddBFI8xosozlWusSBSRkJfgeLiAStOKCua
	 VdnzYJKEwaBLOemWPnSI3OJ7e+OFZBIMExKNFEa10XGkVfMMdYPmwhHoOPVw2zJndj
	 972uAFe6Y99MMzhXWCmkk59a6xm8gbeE9lg2U/vtzGhIndZYC4DZeaBg5CMH/L2Vww
	 h08ZM2CuCdmgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5057FC4452B;
	Wed, 22 Jul 2026 02:39:05 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Wed, 22 Jul 2026 10:11:42 +0800
Subject: [PATCH v11 2/3] thermal/drivers/imx: Fix rounding and clamp for
 i.MX7D alarm
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-2-90e4e46c0a13@cn.bosch.com>
References: <20260722-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-0-90e4e46c0a13@cn.bosch.com>
In-Reply-To: <20260722-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-0-90e4e46c0a13@cn.bosch.com>
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
 linux-kernel@vger.kernel.org, Haoning CHENG <Haoning.CHENG@cn.bosch.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784687940; l=1704;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=9D7qX15817iSb+CvnZ+YgaTi5ivABKiNn7DaNl6d+D8=;
 b=dSw6FYxkkFm4fLIdK3ERIvfsuKpJ5CRCHad0nEFRulApxe/Ltr4d82vb9DxLAVNZPjv4gN7WY
 pEdrAkUTcVzA+8+TdoZVcNESzLrRQIHS+THTN+DIwlqbfGg2Z1ICtLv
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Haoning Cheng <Haoning.CHENG@cn.bosch.com>
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



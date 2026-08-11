Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51313FE640;
	Tue, 11 Aug 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480516; cv=none; b=fhgog3aFHcwHS19SJPPo4A3gAbLu6I03tgCyb/7gs/G1b6cFZFkE+U/3TEjmIfJk4hTNDa9AFoejTaHY+jBkrsnSFrBwtAhuXs+bzs9O9e1c2EeSMBvFOlNSPROsYTaiXquJj6OxhPnTl7pz1c+/BrqYmK6vPtbwCUMN4aOPyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480516; c=relaxed/simple;
	bh=uFM1obCRazEZ5yLSAJ1dVuTgdYFgMqkX05MVuYYS3K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H9GzHYh32nFOQGgPpAe01yerVEiXmsMkuvBsYv3z00n3TAJ342MdTdwbATsZP2Itv0gvgrrlmBvU/8bPvqqJF+pRJOUkfC1+EkgNnhnQ9SkUzJM6ssOjzR5Wn+MiJSaIAXiLueNOxk+OZqiB7KqNwlpQFQ8vC8ejPrZoXUpCnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEUejYcI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEUejYcI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83B4CC4AF0B;
	Tue, 11 Aug 2026 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786480516;
	bh=uFM1obCRazEZ5yLSAJ1dVuTgdYFgMqkX05MVuYYS3K0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OEUejYcID5k/IM8xxJ5LWP6VgbLMw+rkmu/LO4GT47lSNnhbZGv2FZQS/lxwYLDnc
	 NQT9+1N9h/PGrUqr3zMzSukFcxfI+ygn7B1mB/q6rB+1v7mlbf2UwVE4WPNyLJGFJ7
	 hmgc29/Vuy2mnrPGD8nGwPwWbt3jqqViFxwk8RaCdroGFcEUKjufC+ZFxcoJoKIQo9
	 dCJa5DmSd2anO5l/x2MaE83qtUTPbJbMETaNGlDCoXgYgKuN5315Nk6PIs1Q/thwvN
	 kNGNrfwgn6YYjsIRWg9JJyC1/rvkEsPmtZZ90Fa27b4eRVNsO0hIyot5n5bZ81Vtxn
	 avC5hXJcmcGTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDFDC5CFE7;
	Tue, 11 Aug 2026 20:35:16 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Date: Tue, 11 Aug 2026 22:35:06 +0200
Subject: [PATCH 3/3] power: supply: qcom_smbx: program AICL rerun time
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-submit-qcom-smbx-send-v1-v1-3-feec6cfa123a@snyders.xyz>
References: <20260811-submit-qcom-smbx-send-v1-v1-0-feec6cfa123a@snyders.xyz>
In-Reply-To: <20260811-submit-qcom-smbx-send-v1-v1-0-feec6cfa123a@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Robin Snyders <robin@snyders.xyz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786480511; l=1368;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=KqL6fkAKus1VfXlFaQFE4bSn/EnAURWbYSu61RmyM78=;
 b=O/bMHtYUWLUrjPRkO7HCQ0p5EH47F5WETJrS8QTvN+SIi3L34vlRH8pxEuNWoTDO+iNNtikJH
 GLuD8HZHzDOAo/OQ6e7nNYpywWBvPpvkeoVoFDmSIBNCIz7rJO3pVt5
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

From: Casey Connolly <casey.connolly@linaro.org>

The bootloader-provided automatic input current limit rerun interval is
not a stable software interface. Program a consistent three-second
interval during probe. This is required at least on SMB5 hardware.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
 drivers/power/supply/qcom_smbx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 09d9e0f95cb5..9e3e240b6813 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -374,6 +374,7 @@ enum smb_generation {
 
 #define AICL_RERUN_TIME_CFG				0x661
 #define AICL_RERUN_TIME_MASK				GENMASK(1, 0)
+#define AICL_RERUN_TIME_3_SECS				0
 
 #define STAT_CFG					0x690
 #define STAT_SW_OVERRIDE_VALUE_BIT			BIT(7)
@@ -1384,6 +1385,14 @@ static int smb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
+	rc = regmap_write_bits(chip->regmap,
+			       chip->base + AICL_RERUN_TIME_CFG,
+			       AICL_RERUN_TIME_MASK,
+			       AICL_RERUN_TIME_3_SECS);
+	if (rc < 0)
+		return dev_err_probe(chip->dev, rc,
+				     "could not set AICL rerun time\n");
+
 	if (chip->gen == SMB5) {
 		rc = regmap_update_bits(chip->regmap,
 					chip->base + CHARGING_ENABLE_CMD,

-- 
2.54.0



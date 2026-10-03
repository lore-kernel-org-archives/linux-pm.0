Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F738887E;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056723; cv=none; b=gClGeRgt3mSY8XFVA7I2dxULKefknQaUPaDxlzCEu+FQmnDf3yvCPCQTMQ7LwobiUjgARUBD6wK1JZuO5HUpUjleyKrZKrK/hzAk/lpOqfKBw0/rC66n3eyFSRHouztN58YicEB0yeVCbZwOdvE93/uLW9Br3fihTxBd3SatH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056723; c=relaxed/simple;
	bh=IeL0CNt1brVZoJhejtkx8PeC8iFiWFfNrPMIqAw6ve4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjXKMZH6oWhWUZ0ojKFfQDkfsYXitP3PP4r35cZqymIi8pTgmDaVB0lIA43wfCqM2qVbOjWewwBqZyt+vn/rEUIzoUPUj/hq83e2bUpviuJdPhPJGjsL1BCMq0G4WCB4dN0RH9kq2+XModSP+aUp3T6fyjmgHFnIIsLnr/qfQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkSdbBP3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkSdbBP3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8D87C4AF1B;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791056722;
	bh=IeL0CNt1brVZoJhejtkx8PeC8iFiWFfNrPMIqAw6ve4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bkSdbBP3CTHlyr5esI3+a5NX1QNQnd8cb8Z2L1U2CnZsGtBZqiHftvOvPx4KOLksp
	 ozDE3WQoBhQ2u4IuXCO8wAQJp+0ENlaPhVD0Ajr51CwGAe7MGBpAJZ/0qsfS8ocQZr
	 B5WcpJ+2o4QNa9sF1gXMOwLirigfxEwt3i9iHyIMxstIjRhl1AkO0/YeA5pBi5W1sG
	 aeZIGKa0+HjTLRRZpVlwvYexg23CtM5SL7muDGutPEdCApMbBG7s8uFQgQ0ph5ClD5
	 u0t9kx8d6J6Cx5VAuCyyNfYdeAwtlfW19Tpqoa2b1vwTu5GPAflJ/TJG/gUrhw3sWv
	 FEFnag7N4EY4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90876CA5FF1;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sat, 03 Oct 2026 16:45:22 -0300
Subject: [PATCH 2/4] power: supply: qcom_smbx: report charger state changes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-qcom-smbx-chg-state-change-v1-2-fffaef446932@gmail.com>
References: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
In-Reply-To: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, David Heidelberg <david@ixit.cz>, 
 phone-devel@vger.kernel.org, Richard Acayan <mailingradian@gmail.com>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791056720; l=1869;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=mpUf1RzVaBKlKxheQ+DSBomKvGODFWLew/V/Uw/UXeA=;
 b=koB/E7NznvJGzmAjNhPhr9v+r/QMVbWuCoPbapD9kH4RQJ+6njuatmj1jpYeGLv2F258zqoZu
 j75NSHx0sw/C9UZh/moZBJkHuZ/vkMQ2b+7/fMvLsAwA2N5puBhdK2b
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
Reply-To: fabricioakio@gmail.com

From: Fabricio Akio <fabricioakio@gmail.com>

Nothing notifies consumers when the charging state changes on its own,
as when a charge completes, so they can keep a stale status.

Request the chg-state-change interrupt when the device tree provides
it, and notify consumers when it fires.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
 drivers/power/supply/qcom_smbx.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index f5557b8cc92a..3738eb8638bc 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -762,6 +762,15 @@ static irqreturn_t smb_handle_usb_icl_change(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t smb_handle_chg_state_change(int irq, void *data)
+{
+	struct smb_chip *chip = data;
+
+	power_supply_changed(chip->chg_psy);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t smb_handle_wdog_bark(int irq, void *data)
 {
 	struct smb_chip *chip = data;
@@ -1078,6 +1087,21 @@ static int smb_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
+	/* Optional: not every device tree lists it */
+	irq = platform_get_irq_byname_optional(pdev, "chg-state-change");
+	if (irq > 0) {
+		rc = devm_request_threaded_irq(chip->dev, irq, NULL,
+					       smb_handle_chg_state_change,
+					       IRQF_ONESHOT, "chg-state-change",
+					       chip);
+		if (rc < 0)
+			return dev_err_probe(chip->dev, rc,
+					     "Couldn't request irq chg-state-change\n");
+	} else if (irq != -ENXIO) {
+		return dev_err_probe(chip->dev, irq,
+				     "Couldn't get irq chg-state-change\n");
+	}
+
 	devm_device_init_wakeup(chip->dev);
 
 	rc = devm_pm_set_wake_irq(chip->dev, chip->cable_irq);

-- 
2.55.0



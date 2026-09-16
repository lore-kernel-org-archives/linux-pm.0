Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACE3B6C17
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541380; cv=none; b=YODyYrRVStamDqu24+yypqSwK6tslvCLQD+vLWse5dSYQU0TQEP4kT8QvVL3ZWtYbtAOPdRK+iUTRlOuQKP33lIvHY5PD/NKzel0bh9rHTi//B3BCvHWbAzydZMMuXtpSqrhtb9BFOEV/dTlDlCkxD6ZQ9lDVrZgcGRbvRkDIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541380; c=relaxed/simple;
	bh=WaLcwwbFb8rX1CDgaQqDRNFIvDdJ8rSjM8AXnsfgA2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fh2ZhoVaXyouoSqqK1Ayj+vq16OWtUqPi2t0ausftUlZ/x4sKETiCBeaYCLRiIvcBi2XgN6mytal0zdJySnEgXGMEWftcW+WNUOV2movDbpbRNZEIrj/gGqLpOWmTJkIuo52ytvOI2Q51HZUvpNg2CU5Ks3tucLPY3Y4q8QmCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7aevpxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7aevpxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244A41F000FF;
	Wed, 16 Sep 2026 06:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541378;
	bh=OqHSrx/GJfot+r6LK9bnuB1n5fX+ZflXVWQj+Ng55ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V7aevpxRlnor8V7pRXa963gzbiF+fGOozTOluIuexmWhym5JcJAXycGmW9g1vJsKD
	 AMdVk6wiSyHDqK/r3yOBO2M9TI4Un8Q8Zr0ECSt96hWZU2n9J4Q3R6YWR3RLuklMPV
	 opC99cvxahgpM02h+MAwLalD83xwDVsLKzHWQkG2jYtZho1H9WX7tU59GyPRM+gVqw
	 lgEQMpQw7+/gaYFy6wNhFvpm4zOACnykTXcHAYB4mBQ3+nepk56p+aqdH9B2qmo+BJ
	 q1OBYQnNAkBpzjZiqXXMXHD13xjH5bL0CIOksaMWtcYNgFwnDmnQCEOU77wTzu4Seq
	 mvRcsBuj9a+hA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:33 +0200
Subject: [PATCH 11/15] power: supply: ab8500_charger: Skip absent AB8505
 main charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-11-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

AB8505 contains only the USB charger. It has no integrated main
charger, main-charger status register, or main-charger interrupts.

Avoid reading the missing status register, requesting the five missing
interrupts, or disabling an AC charger which was never enabled. This
lets the driver bind using only the AB8505 USB charger resources.

Fixes: d4337660d069 ("ab8500-charger: Add AB8505_USB_LINK_STATUS")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_charger.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 938c3923afde..c7225135af57 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -692,16 +692,19 @@ static int ab8500_charger_detect_chargers(struct ab8500_charger *di, bool probe)
 	int ret;
 	u8 val;
 
-	/* Check for AC charger */
-	ret = abx500_get_register_interruptible(di->dev, AB8500_CHARGER,
-		AB8500_CH_STATUS1_REG, &val);
-	if (ret < 0) {
-		dev_err(di->dev, "%s ab8500 read failed\n", __func__);
-		return ret;
-	}
+	/* AB8505 has no integrated main charger. */
+	if (!is_ab8505(di->parent)) {
+		ret = abx500_get_register_interruptible(di->dev,
+							AB8500_CHARGER,
+							AB8500_CH_STATUS1_REG, &val);
+		if (ret < 0) {
+			dev_err(di->dev, "%s ab8500 read failed\n", __func__);
+			return ret;
+		}
 
-	if (val & MAIN_CH_DET)
-		result = AC_PW_CONN;
+		if (val & MAIN_CH_DET)
+			result = AC_PW_CONN;
+	}
 
 	/* Check for USB charger */
 
@@ -3500,7 +3503,8 @@ static void ab8500_charger_unbind(struct device *dev)
 	int ret;
 
 	/* Disable AC charging */
-	ab8500_charger_ac_en(&di->ac_chg, false, 0, 0);
+	if (di->ac_chg.enabled)
+		ab8500_charger_ac_en(&di->ac_chg, false, 0, 0);
 
 	/* Disable USB charging */
 	ab8500_charger_usb_en(&di->usb_chg, false, 0, 0);
@@ -3724,7 +3728,13 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 
 	/* Request interrupts */
-	for (i = 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
+	/* The first five interrupts belong to the AB8500 main charger. */
+	if (is_ab8505(di->parent))
+		i = 5;
+	else
+		i = 0;
+
+	for (; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
 		if (irq < 0)
 			return irq;

-- 
2.55.0


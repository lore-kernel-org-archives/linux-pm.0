Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC253EDE59
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541372; cv=none; b=GuXFOMepTVeoBioQfh8I/QjmO8sBgbgvOSrofumFIcN6lwS5WzOvvvS3H7KjE81RMcFYZXe7iP2JwCpbJU06J83DcIHo04AiLYSXeYSuh5+w3aS/ZwFs3AF9e5i8UE0+xboaHj/z7eAb7Cg+L7VaE/81EmNvSKUXYxcWuOA35v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541372; c=relaxed/simple;
	bh=U/qdmq8vraaCB8EaXhDYkYE1UhlMJaPO1o8EatB08hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5JJ0TiyVCkXiD9EwHO3ZAUqNDkzjj8uc8mq8Mtft0gqQrHMJ2P8sDP3kxhCrds0VD4dkmNhC7ZczSUQ/psrAz/sHmIZDmFX6mLeo5DvT1ngpEwty0mhElSgieyaYEeN6AsfoImFups1xR5+I/bMp/pbfO5KeSJaMvK7IG9COyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIYaIwSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIYaIwSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE981F00893;
	Wed, 16 Sep 2026 06:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541369;
	bh=G6UyRvKusxgQJ/AmYBQxawCtg4kDeSSpXBweN3QNKkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cIYaIwSkCwFDYNHQJAtOPAN1yGealifTpvaDqfPZEpUy6A9kAFp2ALS+UFoZW2nCl
	 ETcIvrVUnehYj3ihmLVpMLbzJy2ogmc63gzHngzXGFpy5wayIHtFO0ut6xr86pAqkM
	 gClLCBCNsKtndNpr89o8g86KDJ9lVXVqVb7ytXTV8tbXK+mOsTxNAZZLeTnUP/rbET
	 UUSOOst0qK0DAaJmu+9haKWnP+kC4aVKt0HSvlJzUI0GfP/GM88hfZHHQxc5w9kqWV
	 0VNZab1QVX7TIU55mnTIO4SRfs6Gg6lMyRO9uCbs0LtquZh+dAiHrmPG4rYk7KJ8uO
	 Q4E/xEaUCNS9w==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:25 +0200
Subject: [PATCH 03/15] power: supply: ab8500: Correct register definitions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-3-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

The charger LED PWM register encodes its duty cycle as
(N + 1) / 256. The value for 252/256 is therefore 0xfb, not 0xbf.

Both output-current codes 0xe and 0xf select 1.5 A, while 0x3f
cannot fit in the four-bit field. Also correct the AB8505 BatCtrl
bit 0 current source from 18 uA to 8 uA.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500-bm.h      | 5 ++---
 drivers/power/supply/ab8500_btemp.c   | 2 +-
 drivers/power/supply/ab8500_charger.c | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 180a016b3662..b73fccdc76d2 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -151,8 +151,7 @@
 #define CH_OP_CUR_LVL_0P9		0x08
 #define CH_OP_CUR_LVL_1P4		0x0D
 #define CH_OP_CUR_LVL_1P5		0x0E
-#define CH_OP_CUR_LVL_1P6		0x0F
-#define CH_OP_CUR_LVL_2P		0x3F
+#define CH_OP_CUR_LVL_1P5_MAX		0x0F
 
 /* BTEMP High thermal limits */
 #define BTEMP_HIGH_TH_57_0		0x00
@@ -233,7 +232,7 @@ enum bup_vch_sel {
 /* BatCtrl Current Source Constants */
 #define BAT_CTRL_7U_ENA			0x01
 #define BAT_CTRL_20U_ENA		0x02
-#define BAT_CTRL_18U_ENA		0x01
+#define BAT_CTRL_8U_ENA			0x01
 #define BAT_CTRL_16U_ENA		0x02
 #define BAT_CTRL_CMP_ENA		0x04
 #define FORCE_BAT_CTRL_CMP_HIGH		0x08
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 90a61d9db72c..d5c955176dd0 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -42,7 +42,7 @@
 #define BTEMP_BATCTRL_CURR_SRC_20UA	20
 
 #define BTEMP_BATCTRL_CURR_SRC_16UA	16
-#define BTEMP_BATCTRL_CURR_SRC_18UA	18
+#define BTEMP_BATCTRL_CURR_SRC_8UA	8
 
 #define BTEMP_BATCTRL_CURR_SRC_60UA	60
 #define BTEMP_BATCTRL_CURR_SRC_120UA	120
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index ff38254d06ef..7e6afcf0ac7d 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -66,7 +66,7 @@
 #define LED_INDICATOR_PWM_ENA		0x01
 #define LED_INDICATOR_PWM_DIS		0x00
 #define LED_IND_CUR_5MA			0x04
-#define LED_INDICATOR_PWM_DUTY_252_256	0xBF
+#define LED_INDICATOR_PWM_DUTY_252_256	0xFB
 
 /* HW failure constants */
 #define MAIN_CH_TH_PROT			0x02
@@ -3063,7 +3063,7 @@ static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
 
 		ret = abx500_set_register_interruptible(di->dev,
 			AB8500_CHARGER, AB8500_CH_OPT_CRNTLVL_MAX_REG,
-			CH_OP_CUR_LVL_1P6);
+			CH_OP_CUR_LVL_1P5_MAX);
 		if (ret) {
 			dev_err(di->dev,
 				"failed to set CH_OPT_CRNTLVL_MAX_REG\n");

-- 
2.55.0


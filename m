Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AAA2BE7DD;
	Thu,  8 Oct 2026 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422856; cv=none; b=MsgfqhNjjd1ibn4CcluGlsY7yAHwF/pfqmYzlPmxBq9zXkNLDm4kc26/O/0th2aaWcOE7F0hmeW/Dwo5pYJ1BxWW5Ts/emyN4+Bpb8MMFn/lJT7gk/SD6mIhnqBp8gPTMdmBHYo2Q0soce+wvzS/yb0/qWb1qaaDDYIH8Q/MOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422856; c=relaxed/simple;
	bh=voiX5AM7a9CdZVhAJPZ3c2WAyTNR7dfeQq1wQyEyGwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KekjLZPGCt7SGhy7F+1riP0U0GgXtzFR08DQ6S5k6DMwoweKBnlpRD0pRcGG5TIrnXF8j1Mt/AeRT8j3UMiU1xx8fk5GXf4QXfhY6gNLp5+FCHUqXPBlAu3KySJ81TkB5Th3fKJG4KTZVH2ao6r8sAhA6jIWfgvDurF9cpGkBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcaREmhR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcaREmhR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 904BEC2BCB9;
	Thu,  8 Oct 2026 01:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791422855;
	bh=voiX5AM7a9CdZVhAJPZ3c2WAyTNR7dfeQq1wQyEyGwg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WcaREmhRT85/wBLe63GwqeyidTimys/j7bVfopyvpIhM/PNb5Rju5nzs+QetFW7/T
	 K7JKWpVWiGcxpmmZhgDR1I05jTIr/isgWpkznrVzeXnBY4BxxcMlVg8VaLQvOspGeA
	 Tf0cz0Jh4MO1QF1Fx73NqFiSYfhqYafdaOFvfzkycyXos9NE5xUZdgzYvq8jlhKF6Q
	 oZSKzyKIMPavqyB0xLdgLOMcA4s2A0wU+/hCqpFYNu12drQHp3Nsrso33TVogYAQRi
	 dVAl2ri1AwJBBsWZ0uAPHGBiYOvTHz+bvdeRUWM/3RsUwyfEsYK9/KirG4WKS/GiCW
	 yhQQ2q/g6w9PA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BBECA6007;
	Thu,  8 Oct 2026 01:27:35 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 08 Oct 2026 04:27:29 +0300
Subject: [PATCH] power: supply: gpio-charger: Report not charging without
 input power
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-gpio-charger-offline-v1-1-78740b558402@iav.lv>
X-B4-Tracking: v=1; b=H4sIAIDxxmoC/x2MQQqAIBAAvxJ7bkElI/pKdIjatYVQWSGC8O9Jx
 2GYeaGQChWYuxeUbimSYgPbd7CfWwyEcjQGZ9xojZkwZEnYlAZSTMyXRMKdvfWD26whhpZmJZb
 n3y5rrR9T+dHQZgAAAA==
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=HbkCeasNYbp+Pz+uItepD7+gWxGT00Yxhsd3N6nIWzo=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnHPjYxH7OtKfXcqbNAuL14ZvG6sl0XL3ya+YX92msbt
 SfiU46IdJSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJRGgyMnycq2sZXzX9/4m1
 2g4xcRMlYwyTlawU1DdW+C/74HmCVZyR4e9ZhXbZ69N39D7btbFZNGVj7rxTxy2yt2cq+s75K8l
 3nx8A
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

From: Igor Velkov <iav@iav.lv>

The status property follows only the charge-status GPIO. Without input
power a charger such as the BQ24133 releases its open-drain STAT pin,
and depending on the board the GPIO then reads as charging.

On Kobol Helios64 the board runs from its battery after a mains loss,
and the charger reports online 0 with status "Charging".

Report "Not charging" whenever the online GPIO is present and inactive.

Tested on Helios64: on battery the status now reads "Not charging".

Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/power/supply/gpio-charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 2504190eba82..2fdff5f8b5ad 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -101,7 +101,10 @@ static int gpio_charger_get_property(struct power_supply *psy,
 		val->intval = gpiod_get_value_cansleep(gpio_charger->gpiod);
 		break;
 	case POWER_SUPPLY_PROP_STATUS:
-		if (gpiod_get_value_cansleep(gpio_charger->charge_status))
+		/* Without input power the charger cannot charge, whatever its status pin says */
+		if (gpio_charger->gpiod && !gpiod_get_value_cansleep(gpio_charger->gpiod))
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		else if (gpiod_get_value_cansleep(gpio_charger->charge_status))
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261008-gpio-charger-offline-cf51542a10ef

Best regards,
-- 
Igor Velkov <iav@iav.lv>



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467799;
	b=CMaeHk5z93HALFoNqm/uNIOZfX7hqRZDD0NfnNf4kiBwgWBltjLq38pJv/+qvyf9FsJp
	 zH2MBymeNDonoviMIVvVH7cdqn6i7ICIkZXm498KYGFS635UBIRyYNwiJVEo48PH0Fzi3
	 hpz0MyF97fi3mEAnbHsCR9+wym7cD19VA3A4HmbLw68rI91GBqfN2iEb+icDM1UXrXhAd
	 8E4k9RZeWSE/8Tpg/exJ/FSPRI1H1FhETwO9DSZRTdEEkiYoLr2of8VFlpH3ZBilC7kjN
	 t1qrJhGquNlY5CLFVgCuX+I+vJwYUB4I79EtqUDTfSjLpuKpXfUlrlHuMbWQOnzvyqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467799;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QVPvIHQguRWgS45z+PI0g6Rpq7Vb348caqI1na1A57E=;
	b=uTQcLDmM7YCORcMyGER6KyA0POOitFJutLOfwdyNeJiMpSu6z0l8la18t7eMdHm01JGi
	 yldZvxZnjKW84ys43upbFw2YuyiW1IC07IFxcSmm3uvd15NAr3W89usuIDG7yP07kS0Pw
	 zrbvFyNauZ8WSQam93fWgNZLmcPy/X3a3alj1U4IdYSJPQQRHBqvyhPD+kiORPC2ifZYx
	 dv9hScI9djB11/E03sS2VGIRl7Q8YfKIN9zvF5bZoHB3IXLJiICgba8yhsux7W4I29h1Z
	 PoLEcQIkCJYiH8gLynsMM5Z8G7FZJ49pJk6RIq2GJN1nFQd/rTqsmPtMm+G7aKgBFew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PkvfMEFx;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94938606A31C;
	Thu, 12 Nov 2026 07:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94938606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PkvfMEFx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PkvfMEFxpeESPYxklVrDDW7PCboCO+/2EgWUOtgXP3JkKXRGh/8rS/+dsBZzku/N2OCMXqNvXpLL8
	 f5RYLSjhWxD2QS0E95IM0sW9R7Up7wa8nUbGqK5g1HWPyxUK5Kv5gSUPiJV6kKwHa7rto7F88JX+Rn
	 ny8kBFxUgazyeCa0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af567d3e07-7f08a;
	Thu, 12 Nov 2026 15:16:35 +0800 (CST)
X-RM-TRANSID:2ee86af567d3e07-7f08a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af567d2298-f67fa;
	Thu, 12 Nov 2026 15:16:35 +0800 (CST)
X-RM-TRANSID:2eea6af567d2298-f67fa
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] power: supply: max77705: Propagate battery health read errors
Date: Thu, 12 Nov 2026 15:16:34 +0800
Message-ID: <20261112071634.154426-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max77705_get_battery_health() decodes bat_dtls even when the register
read fails. The helper then returns success and can report a battery
health state derived from an uninitialized value.

Check the read result before decoding the battery status. The existing
health and property callbacks already propagate the helper's error.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/power/supply/max77705_charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index ca9ad041f1ed..f9878358e53d 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -278,8 +278,11 @@ static int max77705_get_battery_health(struct max77705_charger_data *chg,
 {
 	struct regmap *regmap = chg->regmap;
 	unsigned int bat_dtls;
+	int ret;
 
-	regmap_read(regmap, MAX77705_CHG_REG_DETAILS_01, &bat_dtls);
+	ret = regmap_read(regmap, MAX77705_CHG_REG_DETAILS_01, &bat_dtls);
+	if (ret)
+		return ret;
 	bat_dtls = ((bat_dtls & MAX77705_BAT_DTLS) >> MAX77705_BAT_DTLS_SHIFT);
 
 	switch (bat_dtls) {
-- 
2.51.0




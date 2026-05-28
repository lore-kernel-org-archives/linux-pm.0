Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A033783C0;
	Thu, 28 May 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985121; cv=none; b=mxEIA7RN1JzIjQDYNhw4J344U2n6OBPO7DhLEu37dX3EHSIX+0YRf6pxRJ5gwQKAksPaH6vLgE0csCzdb1LBCblvpOaaO37rPAdTea10ToBDPel/lOP45hmhAJz8gffOhzT26X8mtGr9kVvdNUxjeciX3emDPQ4jR5JrZGNw2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985121; c=relaxed/simple;
	bh=pi32dSd8TSx+SNWSMpom2JT7gL0RFRI7pQDQIaLDrq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1Imh5hFbu1TtL/5EpydA2gtRq+XySxfxrMSTfjUAnBMPZNdsgo5twX8GJFGSq86C7Aa92p2vaER194kSYpeOCuhghuPO9zX4rufoTc6iOFm2JVqkjI0OWVhD6AJhegMrII6ptxZepzug7ViQSNlB74LBhxHnBMfFKePR3hKNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=pass (2048-bit key) header.d=abscue.de header.i=@abscue.de header.b=JESNpXRa; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abscue.de header.i=@abscue.de header.b="JESNpXRa"
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde6:a200:bc59:4aed:9f3b:ec21])
	by srv01.abscue.de (Postfix) with ESMTPSA id 3ADBF1C6B98;
	Thu, 28 May 2026 18:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1779985111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHqLGlaDozhvgx5NZzsru55VUPorc1eitoMtmO4DGA0=;
	b=JESNpXRa3cm6PFAPSlqJBfPIlmjReSOg6uMvgWZy2Qq6joHokadBb7aSKadJV2jDzkKcrt
	IeiLsTFhIaRfgzR1069L++6+G52xPI+2Vxfw7buDF1kNruGt6nE0jUf7oh3x9xzs31NUXi
	rElS0NEqVblZrBe6xt0mlolD1gNt9rOVB/927MU7PYEWSV/6+ACHwYOzFA3ypcBTwjkpHj
	ogpTzMPh46IpUCEVXM/oDRX7zVuYzvTSj//83563LudeAFandaVAKo0+n1yZKZKsLwPmoH
	U+4EeSAPhk7Jd12QPohlN2dbZQ06Np/vsuHSHq5jT+Q3gTRg+kcwUjsJso+JeQ==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 28 May 2026 18:18:24 +0200
Subject: [PATCH PARTIAL-RESEND v3 2/3] power: reset: sc27xx: Add
 platform_device_id table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260528-sc27xx-mfd-cells-v3-2-25cd685d2743@abscue.de>
References: <20260528-sc27xx-mfd-cells-v3-0-25cd685d2743@abscue.de>
In-Reply-To: <20260528-sc27xx-mfd-cells-v3-0-25cd685d2743@abscue.de>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3

Make the poweroff driver for SC27xx-series PMICs probe automatically.
Since the device representing the poweroff functionality of the SC27xx
PMIC is not supposed to have a dedicated device tree node without any
corresponding DT resources [1], an of_device_id table cannot be used
here. Instead, use a platform_device_id table to match the poweroff
sub-device instantiated by the parent MFD driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>

[1]: https://lore.kernel.org/all/20251002025344.GA2958334-robh@kernel.org/

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/reset/sc27xx-poweroff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 393bd1c33b73..6376706bf561 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -6,6 +6,7 @@
 
 #include <linux/cpu.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -70,11 +71,18 @@ static int sc27xx_poweroff_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id sc27xx_poweroff_id_table[] = {
+	{ "sc2731-poweroff" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sc27xx_poweroff_id_table);
+
 static struct platform_driver sc27xx_poweroff_driver = {
 	.probe = sc27xx_poweroff_probe,
 	.driver = {
 		.name = "sc27xx-poweroff",
 	},
+	.id_table = sc27xx_poweroff_id_table,
 };
 module_platform_driver(sc27xx_poweroff_driver);
 

-- 
2.51.0


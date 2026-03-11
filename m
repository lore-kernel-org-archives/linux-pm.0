Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C43E0244
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230197; cv=none; b=B0EtpfWVdpJ3s28jWguI7O7p4PKcDRsaj1z5zgYfv1JFqxH6jg66uA/BCVS/VTZcbauoVnet3E6QPMTP71efSGxc2DrqZgnduHIDLq2gthPrnTQ94bqF+pBQFM/sU9RCOsa+8TpWKNe7YLjvZOXpwJSbTb53iFvCcZ1s4013Jd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230197; c=relaxed/simple;
	bh=HoUkMd3aj0s9m5BRWarIKv4NrOIfktIuX7B1xZTtvpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFXnh6VRuBsnk4nes2UOw9AKWYdbW7LL4SKlbE58Ki2wbeylkgL96jg92qLEarBXdkWZ1Dxb8x8+RW30c6/WBZ5QS6Ulopt1UeaSbgg1ssCdc871jbubSJdPouwcL9dPl9gCHxGaH8QNCNgc2XBIbLIC5U+8R9Bi81nqcCcILf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=X2FhkI4t; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="X2FhkI4t"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c4bde55cso5640784f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230195; x=1773834995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv4k2NFngBv6AeWEv4O9srLSbI6EPVNmV51Qs0A5klE=;
        b=X2FhkI4tvga1GxTze+NLLCSERrolw6A3LarebMCFdBqnrN7+s0DIb6YKM3GAQ+egyF
         n+DBFaN8L5KzZRSTtgGwYFL9FeQwdt8/7ATpHhcBVA4CpvKJE3E6WdA1alsMWvko059H
         z13H+l0uLT0W9hWQe46oORQnW3HD7enfA7dVpvNzGnnbffYFIn8JBnTrSwvMyRohq9zG
         2X0H/kSVHJ55vV3dR0B18FcJvwRW2/C+JRZaBO46VauR0dOt5rpgfEeb8cxWc9+InZPo
         owlcDnC0AKgM0JkWQazL1umJuA8JboGpzJhputar25x4s/svf3IjPSm+1lNPpO0WYzG9
         zxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230195; x=1773834995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jv4k2NFngBv6AeWEv4O9srLSbI6EPVNmV51Qs0A5klE=;
        b=Uot6qnWmbFmdESIRc/awRDbDxDsGcB2+xMG+ohvkFNG0demCnh6ZiAE9/g4+mvbxe4
         gFRXMzadNY2K68q1q/haBL8q0PejyowlURiasNLR4Wi4govs0zlIgQS0Lv8Nw2oywh+L
         /EJxlLoUEk6T7fiPH1qmC7+vEBoo3voeHCzDK+bH0aO5vJMnvfkQ/zJzExhfQEHt+ZWm
         o1+Ex4PkEubtS933Ci4xL92Klc572X+A/Tlk8wzwBz26UKmEYXbhIAzEnylvvtu7s2Uw
         /Nu/q11WZGXcPDZQ43skfOPNHtRQyYel8ukk8EUt1A1gUj180uz/LnIj+XKvXx9JVj1L
         Ndjg==
X-Forwarded-Encrypted: i=1; AJvYcCWagRQOLnE8Ju4XCU88gILiYRm77nEmkWd+lyIrjxc5Mb/V+qXmPAMffIaQkIT/UXgLKOP63LZjsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydHGz/uf45Rubht6xhTaSCCQN+a+XSwZo7WTC0O0FfM2I3fbvH
	pWaoDcGASlR06HMmZxO6YY5yo14s0dJG3ecelU2UQCazxh0ysbWcJ72jQMP+u2eCM08=
X-Gm-Gg: ATEYQzwDHr5KpRFV++K/QVCYlCEVXSwQFCbx7xdkCYrIvyRQYVTEeVKIU1jgFThGAc/
	C3yUXuBem2ccPriDPIq9PCnGJ757xJmZCRvXTG1iB+ug84jbKyJLMmjARX3gMpBEGA+1SLiC/Jf
	XFjcVq7ZDyWMuA0Smcl31UxNQqjjl0/f06vxQfjDp63cDEunGWdGlCoAbfDEjLWj7fd/yZi0DlL
	29lKBpuTJSYSDG1RfAL6kooQ/ufmja0qi54jNadTP8WJ0TmVqu0Ruo8Uw27siSZL81cgZzPCQw5
	vaf1EcYxXFnEpYZILruBMCGmm9Lg8lGsBdRlHjROTBhrkXu5RD1PiZdvMVDkHsFJSjhY0dL5Oqr
	k/hLyFKbLQfHyS27fnfin8dOwJITCSuNqB+zZpBqrVteJmpSeAcEcIJo1Lv4DWqznPiKnfBNFBQ
	QtXPvLrsJaMffNLkp0KRCe2hO8JP0WI1cfB6NLv9+aXMro8IxB1KXAOiU/acqU9JF+3FsStexqZ
	2vRUQ==
X-Received: by 2002:a05:600c:1f8e:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-4854b0bc6d4mr37888365e9.9.1773230194731;
        Wed, 11 Mar 2026 04:56:34 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:34 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 15:56:19 +0400
Subject: [PATCH v4 06/11] power: supply: bq257xx: Make the default current
 limit a per-chip attribute
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bq25792-v4-6-7213415d9eec@flipper.net>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
In-Reply-To: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=alchark@flipper.net;
 h=from:subject:message-id; bh=HoUkMd3aj0s9m5BRWarIKv4NrOIfktIuX7B1xZTtvpY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEhmc3B7/shqZc2cGvUFYsYzOfcmTAu8vv20PMvqz
 CMx2nrcHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEx14B+Gv5Lz7rxYy/alz45/YWjwF47Jksv/uVj48B9t5NVh82Y5wMDIMO/Krcr
 UWs4ZR43Slpk+6/nglnB5FcMVB5mS9cfF29ZOYAMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add a field for the default current limit to the bq257xx_info structure and
use it instead of the hardcoded value in the probe function.

This prepares the driver for allowing different electrical constraints for
different chip variants.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 7ca4ae610902..39718223c3f9 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -18,6 +18,7 @@ struct bq257xx_chg;
 
 /**
  * struct bq257xx_chip_info - chip specific routines
+ * @default_iindpm_uA: default input current limit in microamps
  * @bq257xx_hw_init: init function for hw
  * @bq257xx_hw_shutdown: shutdown function for hw
  * @bq257xx_get_state: get and update state of hardware
@@ -26,6 +27,7 @@ struct bq257xx_chg;
  * @bq257xx_set_iindpm: set maximum input current (in uA)
  */
 struct bq257xx_chip_info {
+	int default_iindpm_uA;
 	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
 	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
 	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
@@ -627,6 +629,7 @@ static const struct power_supply_desc bq257xx_power_supply_desc = {
 };
 
 static const struct bq257xx_chip_info bq25703_chip_info = {
+		.default_iindpm_uA = BQ25703_IINDPM_DEFAULT_UA,
 		.bq257xx_hw_init = &bq25703_hw_init,
 		.bq257xx_hw_shutdown = &bq25703_hw_shutdown,
 		.bq257xx_get_state = &bq25703_get_state,
@@ -675,7 +678,7 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
 				       "input-current-limit-microamp",
 				       &pdata->iindpm_max);
 	if (ret)
-		pdata->iindpm_max = BQ25703_IINDPM_DEFAULT_UA;
+		pdata->iindpm_max = pdata->chip->default_iindpm_uA;
 
 	return 0;
 }

-- 
2.52.0


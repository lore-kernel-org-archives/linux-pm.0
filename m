Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806598;
	b=Aer660O4o9fvw5gwOVmkXeGDDeyGJcXeK5yE+3OboKzgAuJigg8NcNuS4CAqdWkX1le6
	 MEXlX492CDCvq6o9N60CiZ0WV26wjJGZuNPHDhQ6tkzegwRrRuiXZHj0h1lJdBetJWL2T
	 QyhZbKpH578uX2mZXa6aEonbPYGFEFiFdQ5CoR3m8s0CMz62NCmLS4UGQGeSFBL7Wft9m
	 ElJcZXI+d5RpM7SByS9sdDcWSCN+PqbgjCnD/SIf6SMp1EEocCo5Efye66HPn8RUQeqfg
	 KYOyxfETp+qJOzGe9+jwYcoPy5+lWRiyhdGzccIFQ224VrvcTScDOeoRHTn//G2bTyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=jnEBKmIjlMDJzz7/vlO75PN6QRpLxAhezHtALAyCDMU=;
	b=bkr9lSvFa9wDslPS+GmhYXnGKb+OjKSv2llRASzFccYm8srZmBz8MgxzuEIVjfekc0Uo
	 z6swXhZQtG6sJ63ym2KiVzmBp87I9C9/QOBSim6NQgazjmQKgbFK4zTVDiwKVIwh/YgWb
	 juy2Du/cUSG/1NcYehrkX30q1SJGBMG7PecbvDB7C6TGByMXrL6j6L7TJjKx4jYsedXRB
	 jpT0ztqZTfbaSIAkZNmwpGny06NsBF31RQHNXBF3YuRa3DnbxS+rrgFKuOS8za0ynGnNe
	 Rncymv3WXawSd4zm9eDRcwF6QdInWI+CQPdbdN7FJ0lwNtV1T6oGMxx+1zoa45WHQqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q6nMvkMS;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CB606A32C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B69CB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q6nMvkMS
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d21051042so445810466b.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806596; x=1796411396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jnEBKmIjlMDJzz7/vlO75PN6QRpLxAhezHtALAyCDMU=;
        b=Q6nMvkMS/6xOHo8tE/uE7YyMfPdgwFb3iQHYfy7BS9+nniOwVyvXwLl7Gc+Y8gOBEp
         0xEWlBwnjHE1USHlsTzxhx1IVyxw8fN6u/S5+m/LVu3nkAFdbjnNP/macFHfBr1XHPJp
         DRqz7Y/njOVaLTmYQwOxAqzDAjOqV8+9JSJ/D5Y9F567spN+79C3nBx78HIl4iO4BHZe
         smXyOxA1OjQ37FA6Oj2ObUtFNBLWWOqyJTROPMq6v9lfnfYX2jvGP5vVOG/yUCgbIjn1
         hM0EN3tkLvA4ftyqUk4PF2f8H+cLRRuHqQSlGHEa1tb3KOInDPPxBm7xXGf2rYFGbB61
         whlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806596; x=1796411396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jnEBKmIjlMDJzz7/vlO75PN6QRpLxAhezHtALAyCDMU=;
        b=gl9zl1HKfNQ7Hjai5Vs5PbaRXNyBPp0uZL7F9tr0XZmi7dHWQnkuHI2h3i9R2AJ56p
         yEhnAbaP8mNdlLN6kSVp8/9V1bwSK3UoHiwMKa9bfq+TlGczj5KQVtt0mh85mMb+l35a
         MnIKCRKnHmVMfKDWwwYELwLGDvWn86VmqKO5N8Sf6qKluBQ57Eb7i3unr2wZAAn5v8XA
         0iyWqYtNvL1qAY2hrYwzR/+1bDaxFAiqUKPB9fXQwpj6hGNYceZ4FaJ+Z7XGa0dCTOiJ
         qGeapi5HogInYUsm03KyBe6ZSJtKLP/ciXq5DL5TYXHFE3cW0FCi4VnNWQRDMVBQGmaH
         nOdg==
X-Forwarded-Encrypted: i=1; AL+hErHNYOrVayidsR0Lytf7F3SVp+jNU2JLyq0SSnOzVemtsUFZF3bNTVMvYbS2N7IDs8YTmM3UDB1SSw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/t1CZlGhBnexXvod6L3turyDfPkk+hqDk+4o8UvBmb3b0gHj0Z
	olJHrEwEecGVtBaneY4CWqFSzMhCFTsq5yEUvbmvNgZV1xMuAiyCmOs4YgUZXxa/Zdg=
X-Gm-Gg: AZFdTZdeaQN9b0c6/OjKCsdwzGkSNqa384BwoCKYsNOAKq7h7UE84GwflMB0As/X98L
	pieysrpf4iYsZzUc8sbCUA7N59szEC9AA0p17CyFmYuKBrjjBfywPjI+E1MeLjD1p9XFbgolYbf
	0vaUAROpxooHdyZqVthWopytvgOKg/CpIfDGf7rVdDbl3zwhh7YAcfni96UzjVbL/BXmfmHazXF
	DTLa8sWcjTB3DvUctfINn9Dq424i09iM4QKVfx9TlQomjlMwddwH+vDhgtyJDZfxruITeIWe+19
	L0gCoeFtdajBqOcCEV2oMR0jCP1AG4q9uS3yIPLSIxOvZ52UvgdvlSl5NCMiw+1hOZlofCA2nb+
	S33YHY+TDLl/0Nf3oedkh/nLRC1Ad4Fc/C43WJ2EnravwIKob88BOTIc66kLmIKoBLuEE+nM6hx
	B+YP4RvWTo1q35bofDIY+ltFbCJg57ho+lHHDrSe+KCGfW00HrY4i1VO5xNMQ/K1l8uVeqNEavM
	d/VBXr5AtFQuAB4VGM5P3JRsyEfacYoomZsBBQIXvSTX6i4SKDwJetC49Wv7yq4EXFoTEJ7G0fu
	gbHBwgymlytSUVZOJR642Dy/oPSgmhhx98ZQ5O5ctu/YoUFbtqRHMm8KNksobBH0LRF6WE4bc/S
	5QILUb+ZT+TcdnhTSCg==
X-Received: by 2002:a17:907:1187:b0:c49:903e:1e19 with SMTP id a640c23a62f3a-c513a8595d0mr1656720366b.26.1795806596148;
        Fri, 27 Nov 2026 11:09:56 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:55 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:53 +0000
Subject: [PATCH 2/6] power: supply: max77759: report charge voltage in uV
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-max77759-charger-fixes-v1-2-b364a0862d72@linaro.org>
References: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
In-Reply-To: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

The max77759 charger power supply reports constant_charge_voltage_max
in millivolts instead of microvolts (for example
POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=4300 instead of 4300000 in
sysfs), violating the power_supply ABI.

POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX is defined in microvolts,
but chg_cv_prm_ranges, CHG_FV_DEFAULT_MV, get_float_voltage(), and
set_float_voltage_limit() operate in millivolts, and
max77759_charger_init() divides constant_charge_voltage_max_uv by 1000.

Convert chg_cv_prm_ranges and the float-voltage helpers to microvolts
so the driver reports and programs CONSTANT_CHARGE_VOLTAGE_MAX in uV.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index a75005c0b582..6876ae0a8188 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -25,7 +25,7 @@
 
 /* Default values for Fast Charge Current & Float Voltage */
 #define CHG_CC_DEFAULT_UA			2266770
-#define CHG_FV_DEFAULT_MV			4300
+#define CHG_FV_DEFAULT_UV			4300000
 
 #define MAX_NUM_RETRIES				3
 #define PSY_WORK_RETRY_DELAY_MS			10
@@ -60,10 +60,10 @@ static const struct linear_range chgcc_limit_ranges[] = {
 	LINEAR_RANGE(200000, 0x3, 0x3C, 66670),
 };
 
-/* Charge Termination Voltage Limits (in mV) */
+/* Charge Termination Voltage Limits (in uV) */
 static const struct linear_range chg_cv_prm_ranges[] = {
-	LINEAR_RANGE(3800, 0x38, 0x39, 100),
-	LINEAR_RANGE(4000, 0x0, 0x32, 10),
+	LINEAR_RANGE(3800000, 0x38, 0x39, 100000),
+	LINEAR_RANGE(4000000, 0x0, 0x32, 10000),
 };
 
 /* USB input current limits (in uA) */
@@ -310,14 +310,14 @@ static int get_float_voltage(struct max77759_charger *chg)
 	return ret ? ret : val;
 }
 
-static int set_float_voltage_limit(struct max77759_charger *chg, u32 fv_mv)
+static int set_float_voltage_limit(struct max77759_charger *chg, u32 fv_uv)
 {
 	u32 regval;
 	bool found;
 
 	linear_range_get_selector_high_array(chg_cv_prm_ranges,
 					     ARRAY_SIZE(chg_cv_prm_ranges),
-					     fv_mv, &regval, &found);
+					     fv_uv, &regval, &found);
 	if (!found)
 		return -EINVAL;
 
@@ -555,10 +555,10 @@ static int max77759_charger_init(struct max77759_charger *chg)
 		return ret;
 
 	if (power_supply_get_battery_info(chg->psy, &info)) {
-		fv = CHG_FV_DEFAULT_MV;
+		fv = CHG_FV_DEFAULT_UV;
 		fast_chg_curr = CHG_CC_DEFAULT_UA;
 	} else {
-		fv = info->constant_charge_voltage_max_uv / 1000;
+		fv = info->constant_charge_voltage_max_uv;
 		fast_chg_curr = info->constant_charge_current_max_ua;
 	}
 

-- 
2.56.1.839.g22a8290db9-goog


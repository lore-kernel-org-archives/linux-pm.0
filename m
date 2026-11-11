Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430597;
	b=XTCpXTAxLe9vBhk2wOy624VzK5+NtVE9eyW/BM1U7bg09KnfQ41CU0NYTxQnokRkj2wS
	 TDY0X2CB2HRni7peoD3Ge+wJB0Riq7IJmI7LGBWvxknCBzduHPF6DFU6umBjwPrJ7VnE4
	 JEJrKgAhyhsnbDXeCOo56DxPx6cwx5fq1PB0uWy899S8J9e9FdOsSf9Oibjr7LZxwsRF9
	 wp9AzwfinwBKnIUuPlGQ1KtKjdhSMwvLadDWzS3ik7hI3MzrcnZhNB23qRbUmkOBstLjq
	 zCdcgf95fJjEvosRIbZJ1BUc6PAnIVNpG9QeumiR6DQVHjTwHoyIdxbnyMFQUycr01g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HjOEWycR68mGwy6ar+uiqBKxOWb6Jsg7X9ya8m5L0hY=;
	b=Op3M5/Q4kVg1jLb2RgTppEqd9VOopLe2urUTymrv4O2l7ZES2ntMYZi6/8SiweUrA+tQ
	 wqpqb0tfrk6bliKH/lqAIQyl2LCMfFPJQ4oUZK6mnjKyvAFwSn5LSUDn5SPFkijUqnNdC
	 KC6VnHo9OmgENVrLufDyxHU36XrX8M5kMC3YuqIaA9raKp60swUr9iZq20jeyzl2SnyFm
	 SmNC6VLuZWpWBlIzIxBQncocmkuQ4dhJ4uC9anFwufsGTpLgdA/XhSg2wfQMOkjeOTyty
	 pstfWtZCDX4QbcyNMxaXHp5iMTuTTSTttcFYZzZhtbfz0z/HnQIhclv9O4+BhvfCRJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLK+K1Ls;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F8606A32A
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 20:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 785F8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLK+K1Ls
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-55e02e89f78so1152881b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794430596; x=1795035396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjOEWycR68mGwy6ar+uiqBKxOWb6Jsg7X9ya8m5L0hY=;
        b=MLK+K1Ls1b52yKsDnu/EWjZFc2/iWYTMLee8Z7SLKE7ijaKMErPBq6CygOIA5vCj/a
         Q2Ns5zG0Q8JjX8mumTsMtsNqniKHwxSC28LD4BpiE5xf4tvbehWlzrMJlP+Hhtkpv/Ei
         7CT4U2kLEAR8MDLcZIaid4Jms60RoDU3T+VrFEUJqBpRvs61Hj9mqyOz51gB8wYCf518
         Ui7O2Z9KYJrEAfuB2Y/+DEXMbziTm8YDOC8Ajt19p4WnJ4ut6be0S4rJdO1zTQdLRtDL
         L0o/8pQ/nHb02oPWP9Sw2nCzVQ6AYG/8QNs7ILmYTEUNQbbtSAHovk3A/jx0XyX8fro0
         gz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794430596; x=1795035396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HjOEWycR68mGwy6ar+uiqBKxOWb6Jsg7X9ya8m5L0hY=;
        b=uw/2LSecKbgjUD/FD58zW3YeFp4cdoP5gPAJxiEAv1QP9JDeDfeV7ZVtr3YjoUEyPd
         NXANYDt0hf2XcBHjYfk8ZS8YGp0TfmD4ukHlGxUKsqAvL0z1BAEtbG63Hdk+m7aAV9FI
         w11z8v2IZkMAsgzaMAD08aRa54Xh7C/4ETU64GTv00+7/4crr8ZGvs1R3UDVE0UlfqwA
         HKByqNsqhhQHMR+W9/jYUofq9XeaHD2x+fliK18yu8HNSltS/ZRjsQ/dLksanFCA6sDH
         OdT2yk7ejF93ISjHR/3sQiof1VtXpfn5H//VxTY2+GuuYDCaNjxTMILh1AKIy1s9BeXX
         PRMg==
X-Forwarded-Encrypted: i=1; AL+hErHM1e+/mflbu+TFnv3MZSTKwpgRWcGPeIx+X72PqM0Wo4id6L5kvqC9n8hIX3lBBsKhGLdZAiQFBw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/B0W3ukPDQpwr1RmVFL2lP0//FcB2MOHirpi3spOCt7rtmYLan
	jjUdWi1E8tTMFOUwcbYMojTZs5c74YQ4UASO/vBsf5EPPHtNqZn3jw61
X-Gm-Gg: AYBFou2i+fjRPUHzgcXzw1VuGau8hdRo0EcdaNRzJjQiI+/wmZGW0wFoc1e09DRVrOF
	lB93WrPCxrYiTxvCuQ5TMYNpf52+VaNZyqLD0WZbfI3SEIvZlwsF7YhdrRJCAIcdQqLPy6VL8hq
	6QD+PQ9wGnaV7E3V4DI/cVf1Jw7aXy5UllhNt8fV8GQqyJVy26luK64FPZLaRLO69PrIw7OZncL
	p5D5Yz7MXhk2Qb4SaFWmIG3kTUnUeujJ0Oryum2TY5q8lZ8Be+tOMU3Fm5359AvxxCLoNpGYECL
	LZsLZ1O0mRD6f42r/5za+OVppR7b3h+jNxEJI2TBBuRTOAnsHP5glLUuR4OnpJBqvvsVHoN7DjY
	l1H59qaaGT521ntL8w3ccDvVyx3Pl2JX23kru+xTTVWZxM27YuwcFop4B1Mf9kqFhAIvRDtQWEE
	foW31T7Ck4KpzDqS32Issv/J7vUHAOK+/zkHl5CXeA2nxiE3IBgWv1brsXfoyIVBzszB9lW1Bx8
	V/VinJe4muOa81Tu1iCph6GCMq0LSCUZ8yL6CATJkGYfbUhytkTxHDZUPKJ8HjS0OZlgGadHi3e
	l6aJQ4cbsHTJVY9fpxTnXaAEyoOJnw==
X-Received: by 2002:a05:6808:14c3:b0:568:2816:33bc with SMTP id 5614622812f47-56b98330b4amr3383178b6e.66.1794430596314;
        Wed, 11 Nov 2026 12:56:36 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56906036028sm6564231b6e.11.2026.11.11.12.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:56:35 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Jacob Cook <jacobmcook1984@gmail.com>
Subject: [PATCH V4 5/7] power: supply: rk817-charger: Expose boot voltage and OCV values
Date: Wed, 11 Nov 2026 14:56:25 -0600
Message-ID: <20261111205627.56652-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111205627.56652-1-macroalpha82@gmail.com>
References: <20261111205627.56652-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Expose PWRON_VOL as POWER_SUPPLY_PROP_VOLTAGE_BOOT and the current
rested pair as POWER_SUPPLY_PROP_VOLTAGE_OCV. The OCV value will
return -ENODATA while the battery is not resting.

Co-developed-by: Jacob Cook <jacobmcook1984@gmail.com>
Signed-off-by: Jacob Cook <jacobmcook1984@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 5b53cf288fcf..d334941ade5c 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -583,6 +583,14 @@ static int rk817_bat_get_prop(struct power_supply *ps,
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		val->intval = charger->volt_avg_uv;
 		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_BOOT:
+		val->intval = charger->boot_voltage_uv;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		if (!charger->relax_voltage_uv)
+			return -ENODATA;
+		val->intval = charger->relax_voltage_uv;
+		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 		val->intval = charger->cur_avg_ua;
 		break;
@@ -721,6 +729,8 @@ static enum power_supply_property rk817_bat_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_BOOT,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
-- 
2.53.0


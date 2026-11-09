Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236324;
	b=vEFYDnjZs1m2wJe57am08Wiln+YT0aDGF/3Noh1zMzaI5Ad2LMWMZ2L++UuJhX5yhYyl
	 tHYvw7Ag5oBVBMon1NAXuEgXoR4+xIwg9BosEXvjpTwKuszRGmCDyue16H9oatfwdDJbo
	 yjS7qcxiG7T1anLP+wwSdRzlTIRVR1Xg90gQt35mk5T0nu3Y5W9Btzh9sivEXH1R2i6FJ
	 NeKpWnF+AatoCG0PLV01EGZfvHulUL8QXeXXDj5bvjEbuU3JDYYD9HhXPm4xEizZS6bKX
	 r+9kjyteqWP1CBm1szoeSJIODr5wyKKTG615KrA1LT3ykQ9MY5UFNIYYAkWO06WOxEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HOe3P3bdXfzRt/rk1PMSRuU3ijfiEPXGoVY8shAg4P4=;
	b=uU15sTOyyFcK5aJ2GweafpXM0vtlB+YAKcuW4VflSHxQ8iY3YHlGVMAYfV1/iFHBjQJP
	 2fupvxQreDs6ywNm8KRSkKrthvBUmou/ax3UnwQMEbCifbDCjHqbGYr9zA/eRk7IYtOnF
	 8M95+/C5GonNWP6pCCDHNe0Yi1WCWJvz81MC56Iy6XNhuFQ+4nAkoIEj8pdsQ+4U9i0LD
	 HUP1CII7BoSHJioPKSaYhZaq2yBRyw/gtCvNvo3/CXaJXPS8VU1xkcJsLMiDmUEBWzqMk
	 8vvOOABNapC6EMSmk2H6y3Pjqrq+AZlX8U96oExtgEeoBUKJn9gZpS1wgGjHuEHRQLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="V5nDZ/2O";
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B9606A337
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 370B9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V5nDZ/2O
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4f699fe49b3so647977b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236323; x=1794841123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HOe3P3bdXfzRt/rk1PMSRuU3ijfiEPXGoVY8shAg4P4=;
        b=V5nDZ/2OnlC+L2f8aAvJdrRTKZ6KSgK6BrArs07f9Yi2RgULmsF5sogGaRFQfRMzqf
         z3wM5trnXuPaHRVCo+NSQj8fASPU/6RFROE5wk6ZCspQ6CM5KL6/352tEILACzyGMiZl
         NXkcwWgSskfxC8P9/sRF8lM2cyY/BAn8CaTLvDCMaB2ttHCt0s6hXhdMm9ts9Qg9CPZH
         /lchF0xzY2xvkweLnF0vLGtvJ+9eIhNE1Dl9pwmUCazapt9q1eT5lEjv1w6zDuQLYllt
         bnnK+1uTlgnhbUb894iGgeQJ98H20veC4TcQ9jfLprElMdVoezc8VxhUoOM0nmWxrjS3
         F/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236323; x=1794841123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HOe3P3bdXfzRt/rk1PMSRuU3ijfiEPXGoVY8shAg4P4=;
        b=0SUJzbPIeOumC8/6FbhLvoX8yfvntrj7MuMyVlVmWGhDGoE/TstjuviiHFHL1UVJMo
         VZfbRaUxm43VMTgDcRlbvB7TPK2GZfg1WkcQCROaYc0uMtwXjABS+6C6woZjkpEAAeja
         TXGxJDsXuTtntFvIvWdKMFrSjZgcbCp1tTZEw9L9Ki5Xi62zCqQRO4yN9yiReh6wC3ET
         6p1Q2yywwhPnvg6Dj5Oo4F7ENVy2Neoow1n+p3ZuzsuwmVgUFFsJW7o+KR7B14YXVdqW
         DYVaes0AucLqepXj2hJl4E1jZR10zdLKwY1LjqWAaaXss+EmHKVJBasvB9HnOss9ocFt
         XS9A==
X-Forwarded-Encrypted: i=1; AL+hErEVfQRFVGnSNMmTbWAbtkDYIxolSVid+bIxqfyVnc4MYYb9VHjEc3jby/9kN7xnmXkds+e2tyhPPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8LSfDIrykKyt0JPtR/f+iUuEFKpGzINWYCp9H9MbSKiqlL3QXy
	AB2r/6wQ8Zq1/cggLwxyh4qFdhMlzo3W+F5Gc0hgBuqv7bJKtKHNTI+w
X-Gm-Gg: AYBFou1h5s5QSt2nHslsFx6kghm+S8GCVUjS+xrFWslN/2T4p/tQKxTLtn6bA1E04NL
	ZJkVvOO4hQfon88YGHDLlo3zLtiGuOd1sic5CRLMw1dKKm0cdZ1DcgWbbZa8sX6/pvZyr/PEXe9
	7xlijifTnUiy/2K5YoGCl7X/bUCAVBUPssvE4gMAXzQjv6i8uLBraLXqil+D/5AgyZ1Zk+Ptmer
	LdPJJne3o2vJhRqTFFCvPpcBWuyMgT64QevFv/pxC0KEcmp+m7Zy/owdu+bQCsNF9N4mZhwyqRr
	GCzje/7MXg3DLfeOg9f3qgBkp4LO4hUYb8DpB19rzlwmGgSnlY5yL4mHxph9q6PtuqPsUjN+JJH
	H7U6TYyrWuNvrm3XJFV7rFFgUSki1gMAC3/x03MVgTN7nHC/x1wOgUZq8gEej7WnNrgR7SL48gb
	3ItxNjhxSF3hHXE8d2EqijSSJm32jXs54QaGs8St0gV6OTyd7iGh/xhS4RsxhndupjohaFNLheM
	wRWG7HQl6X0xLfUI8Nh+7XcXZLKHjPz/6TKHvnpO+g0WXXwUW5yeB9KBe4JtjFYz48X+ODF6tJN
	115+hTRVZsc4nYb0jLQwYE8zq9BLsg==
X-Received: by 2002:a05:6808:3c48:b0:540:5827:6d8a with SMTP id 5614622812f47-5681442f9aamr2752959b6e.66.1794236323292;
        Mon, 09 Nov 2026 06:58:43 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54ff0sm4667618b6e.16.2026.11.09.06.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:58:42 -0800 (PST)
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
Subject: [PATCH V3 5/7] power: supply: rk817-charger: Expose boot voltage and OCV values
Date: Mon,  9 Nov 2026 08:58:31 -0600
Message-ID: <20261109145833.1363319-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109145833.1363319-1-macroalpha82@gmail.com>
References: <20261109145833.1363319-1-macroalpha82@gmail.com>
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
index fe2c949ac5a5..ede89d84ab0e 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -565,6 +565,14 @@ static int rk817_bat_get_prop(struct power_supply *ps,
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
@@ -703,6 +711,8 @@ static enum power_supply_property rk817_bat_props[] = {
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


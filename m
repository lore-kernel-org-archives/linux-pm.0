Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630390;
	b=yVlqPOytO4aHnqfdJGfuarf6KxZ+vT6htQgpbh/YQeprtZ5ToZQ3gSlk90M1o9l/Mk17
	 +qoNxOg0l802HTf3W4AZ9+1g/8GcKJXZhOlrvF9goHyH09j1omh6BLrwIur+Ly2sByHVR
	 21U1hal2RY3fBhRbJobrM0j3ctFMrCggLAHGZXIQZhGN4AhlkvdZUhDPDQflZJD5xXxLd
	 6NxTkVE3Q2ZHkBMNIWI04sJFljUNCxm66OK0YPRwji0PlF8DUxqNCmyI5ugNni+dazj+s
	 Q+B8Gp6UgIWHiOP5AYEsvsKi33taNirY3ox9f9Gf4MBlATJ0lE09Qbz68IByQLlxpYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mMX9dUF/iBpcP6akVjBzxM3wKkMEuggyI4vc+241Ru4=;
	b=YaNjATQSDBu14t4/95dJZQxcqVILlx0mohPUBrqhjt57Rt0SlpdGqeh+yM4fQkhsAobf
	 197G8CIXWv4L666C6o5T3MaNViwV8asYULt96854Ba5IQpcW5wTO91TIyfR1OKB+oP6W4
	 qI/L9Xo5D4P4TZv10y+u8s5tiqhNIxA6+sa6oPmj7HhgYZ8La/dptNm6JbmCR9qDsRIZP
	 F9oISVY3VQucYkSaFiLdzLrc3KgSKRm50v8kOK6X7NztKwMzIjcnkbJEKgsA2pH5e5ZxK
	 hesX4bOIItowQjUj7igeY40tHI7iT9H+bPQC9Xzajd9h1/4cCa0W43vYRr93WmexrpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJKsD2jO;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CD606A596
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 14:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C1CD606A596
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJKsD2jO
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-843a4ca671eso1374710a34.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630389; x=1794235189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMX9dUF/iBpcP6akVjBzxM3wKkMEuggyI4vc+241Ru4=;
        b=lJKsD2jOfA4lnPSu8j1rIQCtN4zoffVkI3G9tVgDHn4nfixyFC3Yz35oZor+zUiKS1
         ej8GCF8VGCER7JBExm0cWwFT3VyayTrcvPI0AuyiudI+xth2UpFPdx5Q0qoApTUVoulp
         X2ATriQ6kxt5ZmTEmJjlpkNpcmQXJTQ5XUTOKvNRlK4BOK6avajHuX5BblSW8YswWa66
         B6Rkjfa/hNwKofpRdaoICR7ht4mGRJZHBTGpZk1Lnt+v8FM8M0ntQvtmfs+Y3YNSMltd
         Yq7kMMU7I1J1IHW4Kl/4Xp2H2Xj6K4ZxzUCYKhcz+pyGBPL1Yr7vPBd1S0Q1P48jM03q
         kqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630389; x=1794235189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mMX9dUF/iBpcP6akVjBzxM3wKkMEuggyI4vc+241Ru4=;
        b=io7l9wGcjBaW3QkwtgOo4lx6hkvdr6o/mjoRufd6L3CLI+gt4khxqloMfYrV5aJMvi
         z9MDjtFhivIUOHDar+xNdRKj+6rhNlWRwEx2E+74pxuXk9iHBaWfn8WBUxtFSmqjNDFA
         HlWek+++V9jf0auUn51JPoYQmVUkAup8ZjFezJuDdSO/feRq31q82oOnfctSk57cUN7N
         9ORO1+anZ1W60l6RZT2h3OyfXHmSmwp5jN4lABJ/gF3jMMeP72fYNkEZhfx6EAt2PclD
         +QimjnostmGp6FK9mjMjpcExy5BXXRD3M4WKwFByxn5n1Z6j6/iRI13LL4+uHCf3+Za3
         OZfQ==
X-Gm-Message-State: AFq9FYLPLe9BX5JfG7cH6FQJJZeJjJpPqBfW5VQpinlyy3suhVz2fpid
	RH6AXFP/AenqorYtDmKlSJofQ42DBfqfNyl6AQr8XuYN4TnWGLjwJims
X-Gm-Gg: AYBFou1GVHmZv0eR2mL1hErLoUR8Y5QxWswsZA3S9T6tWsErx0iAdZDbkpaw+TBxdFL
	UIdhoxjDFkthFdb8LQJSNlb1Hw7T1Yg9zuI1GXtfoA6Pj6Zdf6Cvia1bDo77NVOqJmUMXn3wUEg
	UTJMVWIGGffjKtHo0bzK2JnvteMDrQSZGlVNC+X83l2WG2JL2bCJRYeHzYD84t+GhVRNDjgNlbD
	LQ+YC8UXMWV6JbwD/yXgwICx3rANB573RU/wrO8BmuBe+q+QszuCsmDCxIuE8YGcFGMot5eb2yP
	gV8Yabf1AhV4OKtrIozxiDkVNF8SCbeGUiL7qN5XN3EUrrPzsul3HUlF05HeAv7ffpq7XXBJjGY
	PdKMqAdGCDiMIZIhJXiSFsQNL9YfHKRMLcGmniKubtsEVb8+n6Z+BFLwtF4XoJh9ZCeHk5Egh2Y
	TqQH6Rx9qO6yUP0wZA9Bm7R/9YzJjKxgLbvzJ8x9gsKc0nhcJJpcj77O5bWwpv7lIXLAJxEduUD
	7NcYpls1Ik/v8Z6aXgxKLvArJ0gf3tDZp0YWBVCzRhehtrtCU9xx4sDLyFvv5C87GZ0NeM3/7AB
	aQBjVvES0PHAlivImyNpwC41PjT2bA==
X-Received: by 2002:a05:6830:4411:b0:83c:2a05:c65d with SMTP id 46e09a7af769-85d365f91a5mr8464513a34.18.1793630389255;
        Mon, 02 Nov 2026 06:39:49 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b875sm9516327a34.5.2026.11.02.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:39:48 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Zetarancio <zetarancio@users.noreply.github.com>
Subject: [PATCH V2 3/4] power: supply: rk817-charger: Clear SYS_CAN_SD register by default
Date: Mon,  2 Nov 2026 08:39:41 -0600
Message-ID: <20261102143942.305293-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102143942.305293-1-macroalpha82@gmail.com>
References: <20261102143942.305293-1-macroalpha82@gmail.com>
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

The BSP driver for the rk817 charger by default clears the SYS_CAN_SD.
This register tells the PMIC that the system voltage can be shut down in
battery off mode. Though the BSP driver also included a way to bypass
this behavior, no boards have been observed using the override.

When this register is not cleared, it can result in a persistent power
drain on certain devices while the device is off, as observed by users.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Suggested-by: Zetarancio <zetarancio@users.noreply.github.com>
---
 drivers/power/supply/rk817_charger.c | 9 +++++++++
 include/linux/mfd/rk808.h            | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 0c7287ad27c6..d7d367211d5e 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1166,6 +1166,15 @@ static int rk817_battery_init(struct rk817_charger *charger,
 	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN, RK817_USB_ILIM_EN,
 			  (0x01 << 3));
 
+	/*
+	 * Do not shut down the system voltage in bat_off mode. The BSP driver
+	 * cleared this bit for all devices unless a specific device tree
+	 * parameter was used, however I have yet to see such parameter on any
+	 * device.
+	 */
+	regmap_clear_bits(rk808->regmap,
+			  RK817_PMIC_CHRG_TERM, RK817_SYS_CAN_SD);
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 72419d311626..2bc58de53d82 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -1297,6 +1297,7 @@ enum rk809_reg_id {
 #define RK817_USB_ILIM_EN		(0x01 << 3)
 #define RK817_USB_ILIM_SEL		(0x07 << 0)
 #define RK817_PMIC_CHRG_TERM		0xe6
+#define RK817_SYS_CAN_SD		(0x01 << 7)
 #define RK817_CHRG_TERM_ANA_DIG		(0x01 << 2)
 #define RK817_CHRG_TERM_ANA_SEL		(0x03 << 0)
 #define RK817_CHRG_EN			(0x01 << 6)
-- 
2.53.0


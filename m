Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199362;
	b=IHl/DiGjHG7Zf02yiCnLrXClVo1vklZK/D3DrfmqqkqMD4NIXDvDJSDYrcpqV5PN5dfz
	 jm4K6euOqqupgJqc4hXn5DEg+Ai4VNngvcet4NkjMUzucgyX7e9ag42Hn5ADt4Pe0O7EG
	 RUr6TmhHlTbf7aGOnVS/ogKTGV4+bfSujOD9Ci9noDvI9pdlBf2smRapQcEBFeBscy6+G
	 CrzFr9O+MPo8EdvFQrN9MTc+x2ZpSDanAsXUO5fzwrMJ5wGWu3MYJjXKoAr2mqc7Rt0K/
	 ipCZi+aOO0amlHifaH9sfQepOKMWLQs05wHHvafOVGfYDG1K76+u9/LcK5ynTPOmCdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GcfSxz5aPzlv2aH/G/YIDcSJdDCU+Fm7JWkQ7b1zh2Q=;
	b=T/zddCudq2W1daKgaQ4xX73bv9P+MsvwvLYdjpIkTO98B/oxsP/OlK/mInfsimwRJ5aN
	 DQoiEG3gHvxJPz9W/KWXBvmldT5+TMjlHCDhogUoNBfmtNxIWXjL0MKy6n00anlwe49eP
	 bOzf34KACOF8nTFVpKAZqTL4NxEeDF41fybZBJDGB5Ml3GSyfEoWEskiRrCs1162TJy9U
	 VdR6EzvK7mvs6Erud/llUBq0PTAq/f+zJ6i/c98a8WndtfOZKmSMfna5U6Z/IbMT4heSf
	 g9vsfi4xXGw5GaMzCW42zmQtozW3MHqeBCSzPXo6uFmKjQ7qQY9G12OVrlU4/YNG8uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PqESUav5;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAE2606A326
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 04:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DAE2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PqESUav5
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1185368eec.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 20:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199361; x=1794804161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcfSxz5aPzlv2aH/G/YIDcSJdDCU+Fm7JWkQ7b1zh2Q=;
        b=PqESUav5JLJfB7GFHFz4pi6OqzbIh2Lvb5yh1tDk8V+bR7Ts/QMMBHdwae7EREGtit
         JWNMDiD2JgjyyvBKcxNAKe+0Z5jYqbKUfgozwI2As473RcWJ8wGjpw/mGCrUgzllpHnQ
         f0CMCtUl/7r0kP5jQ88Mf9qyV/ay3eKbfqIQ2lerbKUVE2BFFnbpgj6TGuDrsQHXO1mt
         KGVmWw8dhlgjzrJ3GVoC+rm7OMXaNXcsZL6WDiGhvegrkDxpBQD4tbjbH+tkGPipqdJ5
         X/U8YFOeulDeDbmHBGVsNKi2sqiozYmrShupL0LnNkFu49a2kkyQaU/qCrPab0lCXZA7
         bX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199361; x=1794804161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GcfSxz5aPzlv2aH/G/YIDcSJdDCU+Fm7JWkQ7b1zh2Q=;
        b=fWicwt9OBYqvLZeO07ENtZ33/2iyqmYa8/2aScxBUJ0uY44zNYLzpWUe5L0SEJWIpG
         r1u2wI1MqQ+eNTWYyuGnCq5OR+3fX6pryd590SYa//iPultjNLlHESqY3VVHgPSZvi3Q
         pOda2QH8JJsX2t9D8btoHgEkgzOo6frksSX1YMxagWZNuqxGIRMC0tHEaM0KdiM2yNi0
         rd2X+uVrTobUuYl7lg+vAolgITX9IONeOXzfl3DcBJwymw0HTs9BGeHk5wI4ZQnlW/8/
         Bof7NMMv0whNZ5pTdrpU8u939i32drUQ9N9Khexiz0cNqyXZusiOZTigb3enJoYC/UfU
         Pw9g==
X-Forwarded-Encrypted: i=1; AL+hErFFRO7FdtelzPzSOzhUM6JTeEh8tYdpRqTj/y9EYHvFmiTkdDOQyWQgWefv/16L4g8mDt/9+4wE1Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z85EIR0m64WimjtiRGjqwLWDUClGdV0pg40HNuYiT3QOhCz0FvG
	wOQ2lD17Fjf0rfNXueDizmLmbHUX23MFlIjN+5dV+LKXll7e8ir04z3a
X-Gm-Gg: AYBFou0tkZZ5hdR/XXHWMt8uX2nFzvLqVAbBXCl1w7rYCpGD30zEhdP/EB5ZbqJ56UA
	zWtb2KmD+NZ6CNtPdWEYEiLf3ab4LiDXrq/0MwaMVJjksIZHoorxmhp/++rCjpJQrhJA5O9aQHR
	0o+aPv26IY4CbeMGa9lTx1Yhj/Yps4kW2IIEow0tm4/cr0jzKLX6ClTmGLxiUkayfyA5FZj/ZPG
	Ku8ckatvA4tUQsM/3YoHdc7jPPbs9PykgPHMm+7wAYnzZZHbqGSRy+WcVStTFuWfv4bT40WTbml
	ZSeSFPyztdftTY2u/5vcKBhCMtVvah08z3GQ9VvDo48tTXKLSNMYH3Q/R1zOlQrzT9yBuQuq7DV
	qrIv2+3q+NvuWHKTBkbmSGm3/117B/xlvnf0fgozvN66yA3/alpxDb+1ve4rNwCbZz+pKuSC66i
	Zq4fFmyf6QhdpqokJN7Res13U4AUyjNCwmASWutNpxRQuhtQXfwRyGY2TQ/rX/1QSEQA/LWCX+i
	msCpvxLGF5fa/J0RlRCijIuofdMVqqdIz0mEuVBiRacZUd9amyqumH42LpLdJgGggFp1PFcVSsn
	StvV9H2RzzQrDkdqfOK6niFgr3eIkvbjdtUoJYwdtvS0RjyF
X-Received: by 2002:a05:7300:1c0b:b0:366:2893:7421 with SMTP id 5a478bee46e88-3725d77d5a3mr5516181eec.10.1794199361082;
        Sun, 08 Nov 2026 20:42:41 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm10154026eec.4.2026.11.08.20.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:42:40 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] power: supply: ltc2941: drain poll work before unregistering the supply
Date: Mon,  9 Nov 2026 13:42:10 +0900
Message-ID: <20261109044212.1157357-2-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109044212.1157357-1-hj351016@gmail.com>
References: <20261109044212.1157357-1-hj351016@gmail.com>
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

From: Hyunjung Ko <hj351016@gmail.com>

ltc294x_i2c_probe() registers the poll work for devm cancellation before
devm_power_supply_register(). devres unwinds in reverse, so on unbind the
power supply is freed first and the work cancelled last. ltc294x_work()
re-queues itself and calls power_supply_changed(info->supply), so a poll
instance running in that window dereferences the freed supply.

Register the work cancellation after the power supply so devres drains it
first. Nothing queues the work before the schedule_delayed_work() that
follows, so the move is safe.

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 6ebb555..8f8a8f6 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -531,11 +531,6 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 
 	psy_cfg.drv_data = info;
 
-	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
-					   ltc294x_work);
-	if (ret)
-		return ret;
-
 	ret = ltc294x_reset(info, prescaler_exp);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret,
@@ -547,6 +542,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(info->supply),
 			"failed to register ltc2941\n");
 
+	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
+					   ltc294x_work);
+	if (ret)
+		return ret;
+
 	schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
 
 	return 0;
-- 
2.43.0

-- 
2.43.0


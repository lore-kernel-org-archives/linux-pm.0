Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236326;
	b=JKiQU+1ZIT9alzcAABKk/CLk8WhKopavgUTPFuW85THYbkQe7KORluIeVgEgC6wlXE9n
	 0cdZz3XKGEi3EOwEGX8pXsdf3MryYmcm/0pSqhsS5MC4QtDfzzJRox07YjggVUZTu2P9p
	 5v3JPw9VytbyKEj4h1b+LQ7rqZhmzJ7r+jp7swGsf0oSiJS2j7xjYMnlTTYkwPa4oHJza
	 wMoOtzVjo4oUBUhnzYVkFAsfk0pBsUCXcYQhuN8+9EMO7Odyfz4WviRUJknYlBr3xE5Kt
	 YaVnVu312i8HdH2qV2ukUePyiqq3GUl11r02hRXeDgsZxbkR5GsAoxN/vgAqSEGHutQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uyJBLSDoizhjOknUVT26QP6A4fvklwXxLKrc1fwBHFg=;
	b=uRXdaqXSjJw74c0G5Uise/dgoDFT59T6OyzZPTUSlPCKgY427yhZSSBJ3d7x4bSShYjD
	 4FZtlsuwqsZ5VlzV3rd6MpJT9/00FYrD93NvEAaWjhO3bsd4fAABeuujqvPmP3dNKsUbL
	 HuQNN32p3buPMDT4EJ9bTUVuy0UEApSiXk6v98nUI4Z0YuFJmjt0cmvzctvRUCWS5L+sc
	 Fh9VmIX7EYByy5wayg66+TAcTn3/6lmrAgZd9sZPL1ZUktCP+dcJN0nEfaWsXrW/bxXlD
	 AEx99N+fPdvzo1uN4eeXoklojjKRlnCA+Un4Y+Y7pltwLUutnb5yUetpQ1jfYM0upAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqh3RbWr;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0336606EE89
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 14:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0336606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqh3RbWr
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4a85c656c58so656453fac.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236325; x=1794841125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uyJBLSDoizhjOknUVT26QP6A4fvklwXxLKrc1fwBHFg=;
        b=eqh3RbWrHLGWZn88PN147+0r8MgNaXeEZZf62DGiqMSPEtlm8cR1aKu90KBPfT9NQb
         4HDsomILalwdZpJa//9siOMVVgwRxLXWiuXBZ1T6sXJD3EPMjIKWDQvcArHX0a7EafgA
         ofIYfRdDlW2EX2DdU4gHTqXGevSSkn3ykssuNgL14T6F3wOonCgbTGFmWzR+iLHgkIUL
         qvhnD0Jue6zl3Ib98Qv7oBVCDRNpN29VIOdKmJgcqPCyfS2T/B9IGehKQ2S5TjCPb9G2
         cktxmczQuM9UXXLORKib7n+WYu7LOe9MTVSDlwegtl3Id6NhxLh3ll/uVXzhN3LWje/B
         DU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236325; x=1794841125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uyJBLSDoizhjOknUVT26QP6A4fvklwXxLKrc1fwBHFg=;
        b=zpD4GXLYG5OK7L1g6cYEUtweh78lR0LEDtgZXqGplytCTHdt1wTmf69nI60dyRmCPy
         DEUaAMnQJiX8C54AGuKkdqvH0zAjlPMHznwr4W5pPIQdfBrge+QxtMpxZPlXYsSwVtfM
         iiJkqlJxNwB9CG0n3MM3F1mvnJahb9FXjhaRTQHI9rXf6IgjisW5CdxFX+dBGENC3vOQ
         cXHvGim7egYlLHHd1ybkWzKIDItMegBnUlWiy2JAhbH4dlM+EGiP72IY3hshm+/mGxir
         yH9ecAWC10vGcmWm20t92JCYWR2UuOeRO7hdmphCvWnOifvPs3AVTtM0mHIdB1fjUoNg
         CTeQ==
X-Forwarded-Encrypted: i=1; AL+hErHFJhE6PjaYj8RwmogurfLoNtHNhI1IxvLJVdDtJUS03qV1pD2iqk0XWAd5bomS1UJ7CWPHo+eUVg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8LROOFuG9TlNK++ELl2Ecsd/DEJakl7hJWsXafjA4j1vX0YTPw
	a6zw5yhobQIVsXJQ6bnzZ1KvSNxg1QLd3laWTtLaxpLMue7SXa8EDfQUnX/Oo6tk
X-Gm-Gg: AYBFou0orsWwBbRY3/DNIHGJqP0cxppP8pvJvreLW14hx46FpgDi3rJU5WaPvp3nXmF
	6E+d3qVOmpycxPnbXvlRF4rlg5ysSSFC6mjhTOappv938jkNABYE4rkqDjpESMOzi4WP0Mq6MJf
	J1IrVLSYDMLibykBC0vQbmkHR2wbPmhneXe7D1ARsXxL6LtacCKfckC8R8dxL04qzItn3hmT41C
	Wmb5ZsvfuflCLVfw1drX0jDiAeLpn2FuAxLmI065rH18Sm609OAge1GEpCD+CMEga1HywuTFqou
	e5SL7R81ptk7WTHjlxbFe7FjOE8KFUGSAG2s+nhIXpyBiOYatOGsmsmeQNRwwPsaqN7YNztkpzj
	K4svAzBhuPmqxp/p2GAk6G3viFyCBAWvIm/0qukQkqurHHqwPceDg0L7Vt5IDnJHdyzga7zfmiz
	UfN92zeZzfUciRgBWbaCBXxNDXARTTZEk90/HDAibsqRM/LhA0plToVwSK6VKUHl0VVA5miMK0W
	XwAuMWwY0f6F0TqWloKaW/HQM6r2z0HoY620fVO/pyGuFa8hHC1ESoDkTSm6lm3eA+lEb/Un2GG
	k6uz9vAYVzjKVg34XDB/ibli5PUEQA==
X-Received: by 2002:a05:6808:4f51:b0:564:347c:5aa3 with SMTP id 5614622812f47-56814207705mr3716027b6e.2.1794236324825;
        Mon, 09 Nov 2026 06:58:44 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54ff0sm4667618b6e.16.2026.11.09.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:58:44 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 7/7] power: supply: rk817-charger: Clear full charge cal on resume
Date: Mon,  9 Nov 2026 08:58:33 -0600
Message-ID: <20261109145833.1363319-8-macroalpha82@gmail.com>
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

After suspending, the coulumb counter may be off by a bit. Set the
cal_soc bit to 0 so that the gauge may be recalibrated again on a
full charge.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 0d1ec775304c..1f91703f2f64 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1377,6 +1377,9 @@ static int __maybe_unused rk817_resume(struct device *dev)
 
 	struct rk817_charger *charger = dev_get_drvdata(dev);
 
+	/* try to recalibrate capacity if we hit full charge. */
+	charger->soc_cal = 0;
+
 	/* force an immediate update */
 	mod_delayed_work(system_percpu_wq, &charger->work, 0);
 
-- 
2.53.0


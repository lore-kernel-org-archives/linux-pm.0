Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818783;
	b=aVEQcz8Lu0ylSJSyUAk8db+yIriDo2Jrsv860Jb5OlGiWtObgGptCcAa4F0IT2AziEzT
	 4qFpTqsqNCxSpBN/obz/jkiysxyyQdXQ3GDvJyJ+FnBqsZZZ4t/pCWbYA6b7J37tA3fTr
	 g3FcHVyxKZqd9ly0m6n0Ho1vLyryDeQFAPRlebtlTwn8yq4FNBRQyTkLesthrCYDGNBXO
	 v0cf1PIPBFJjyVGoPgpZwQidtqv9ZhJ3nKQMZ+qSrD2FHpHO6/qTQJaTjTbFqT7+WDQ0b
	 xGzs4+yU4Wj4uhbGyDFVjzDYQbNG1GAUip9hmNwl6Sm2LEW1VCqGXGcM2NFpBB2PY+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=k/KosUODM3E0fiMrzq8AJvlBOzlPE3xFAe43O33GX5w=;
	b=PhaKRb1I9iigdC+Yc5c/08UEurzuFNmt4DzWtR2qI1QR1i35GZkcBTMD29eEPK03JJ2y
	 TKJ8coxj+6TBnBDOgS+XRvs7tZZYu3xe+mUQaNlK4r2Mk65Mj+bIZ73sr/ShaKFt+wum2
	 AFwmX0PI4HqdfY3Ge/xBMC7AlcerL1Gkqem70uN2iOKeJjhptfWXDf4583qz90ANd8JxF
	 ecyt5SBEt25+ubl3kTx+zdB3dZjq6+q19+FCOyQ/AhcnRz1tUx656Cwptyf3CNEL42lYc
	 XcHdUAH75eIlAVT6nurbD6ah8jT6Vyz3fzpPXPTnG0MpXxnx9d5qWeYjeEB65BW8R4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wJ7wQms/";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824F606A336
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 22:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E824F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wJ7wQms/
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so7084012f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795818781; x=1796423581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k/KosUODM3E0fiMrzq8AJvlBOzlPE3xFAe43O33GX5w=;
        b=wJ7wQms/FbVFfSS9GId+NAkDIUaPJ09YungOD+wW1zjd1tf77BqwLwmlXhnQC6+BA6
         UL9lKsq1GyngUuFmiJOwcuVTmcWF3gbgQ60pPwqivQ6QV2IVYBTjsFFZJbF1z4Rjcgkk
         HyTZL83web5sRNEg9b6RdEXblW1miFnv2AuxhMGkTd+h9ezYCXoeR8KZ+DMkfoo2PHxz
         tKPZr7cFl8NoV7I6pgxzqfdWCM+EmPrxUWjYnCDBip3IC/OG6EvnJa3ivQ+WwIieYQgQ
         jO8vY+zcoe0FcKKaUu4jS9C+tfnyRec4VGwYcrbRCzgZQOgb66bo9BOKA8PgsSB+0YcL
         ZHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795818781; x=1796423581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/KosUODM3E0fiMrzq8AJvlBOzlPE3xFAe43O33GX5w=;
        b=XxAVmK5vEfGMrv8pz8IFx0HqsMngoCylvgzoZjuEHv0u3L6/gBydDkBrYFi20dMWys
         oxhYDsuK+pJgG1E+86vxCc+jp05dsEnnlqoQC93peXaMB7P8zmankXG8+86zrWtP4GsZ
         0+vbXxyGs8rTizhkNgQjZ+YkcfQrmXd/MX8eavXjoMFvsCVH90fQlaAytC7FZLynjsPK
         Psavs4mkHloml5xsf/ZT2rnofsFtfsV9tC5FH0sJ3Qu4A4KslKJRmYegXLqPijjAKerW
         rJMuFOiE+WCWNqx/2pEzwgaYLw1jWdoIzhgt9LlcmxVJ2pRpsJkJw1xbYYacmNZAZv73
         nbBQ==
X-Gm-Message-State: APuU4Z/pU+SX7zcNW7/KjFoPFVQGEBju5oPli6HaMyKd5quiH9imObCm
	la+4qcrHv3ayejgSyNZhoFr72Dfu4gz3iKnEf1ZgAGCtt9eie/yaVWPj
X-Gm-Gg: AZFdTZe2ciw+okGAcqMclYYYkfUEVI4JTjPQk+Wet9FsWbP4eiXuUoeQOTojFN2OiUE
	YSi2g2UtMdXqIBGIiP62VQyGZceTrZb8cAzKcnj2XddzxgYXfY/xNyHzWh+2u/0MOCMM7P4jHbJ
	GHzFMNKrlhNMLnVaW8poJZIQ/+KI3KlKOZXuKYJnEYbkZD41y2G18AvXlSv/ECBL+cO+0JXoSZh
	sBtsqGzXA3pG4dvRwsRxT4pjVGIz2sXfVybS7YGVHDwV6v+z///4Di70E1tqkfwd3s7JaQmnWRf
	b+Thd+XI6lgmFVAptOIv96EHz73arjCIhta2u4QRhatTQZcbrc55rzduT9WzXJUsJpuySK/mvm4
	fdvQ7citVk4VAWo/qGPo+Gna8edTR/k92SvhxdxfV8Bk/iyHEhKiKIPx0XgZWUsnCLYe45EzHfD
	qP3y3fer/qt1S3jh+NTZORDLCKyy/YcFpG3+2ByAzUAte5cswOuzfBM6fnAz1TLgXx0nyA+Z5Hq
	Mj5ZrWnhtrp4iAOOzABRPacyYpCoLiN+6yvUunXgsWC0xSkr18AAybQq8T2LmKiJ4a/2RTE3LJR
	gII+zZE6beKdQdCH0Jz3TzCy751sphZO
X-Received: by 2002:adf:e006:0:10b0:4a6:8012:19a with SMTP id ffacd0b85a97d-4abb18cb896mr35464456f8f.22.1795818781206;
        Fri, 27 Nov 2026 14:33:01 -0800 (PST)
Received: from [127.0.1.1] ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm50430285f8f.20.2026.11.27.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:33:00 -0800 (PST)
From: =?utf-8?q?Adil_H=C3=BCsrev_Tepe?= <tadilhusrev@gmail.com>
Date: Sat, 28 Nov 2026 01:32:54 +0300
Subject: [PATCH v2 2/3] power: supply: s2mu005-battery: make the alert
 interrupt optional
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
Message-Id: <20261128-s2mu106-fg-v2-2-2c3142e05aaf@gmail.com>
References: <20261128-s2mu106-fg-v2-0-2c3142e05aaf@gmail.com>
In-Reply-To: <20261128-s2mu106-fg-v2-0-2c3142e05aaf@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 =?utf-8?q?Adil_H=C3=BCsrev_Tepe?= <tadilhusrev@gmail.com>
X-Mailer: b4 0.16.0

The driver unconditionally requests the fuel-gauge alert interrupt and
fails to probe if the board does not wire it. Not all boards route the
alert line (for example the Samsung Galaxy XCover5), so only request the
interrupt when one is present; the gauge is otherwise polled on demand.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 drivers/power/supply/s2mu005-battery.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/s2mu005-battery.c b/drivers/power/supply/s2mu005-battery.c
index a76154e5a09..9798a62ffec 100644
--- a/drivers/power/supply/s2mu005-battery.c
+++ b/drivers/power/supply/s2mu005-battery.c
@@ -273,11 +273,13 @@ static int s2mu005_fg_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(priv->psy),
 				     "failed to register power supply subsystem\n");
 
-	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
-					s2mu005_handle_irq, IRQF_ONESHOT,
-					psy_desc->name, priv);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to request IRQ\n");
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
+						s2mu005_handle_irq, IRQF_ONESHOT,
+						psy_desc->name, priv);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request IRQ\n");
+	}
 
 	return 0;
 }

-- 
2.53.0


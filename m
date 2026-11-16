Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814807;
	b=sKufZ4BAksM6djtqm8ZkXAWrD6wZMtadpjmRBDVP8jxM1WWf6ruvUwNkOuhzf04ZYk9o
	 7bssrd/wa1cgCKPuGrYNbGwoF5OxeH3ngJLNn3fNacVDD1bq8kaTW7gHeCq+Drd+cnKc4
	 q5C7/hfbkw//Dv5lhRrFxMyxI6SDZjJMIo3bX43LfxVQbOlaAHiPTEe25ofuN8c5PhreJ
	 UQVh659I5B1W9CsIKM9zMXQxz0bp3i3L4JKv0OXQpmUSKcRlKzFi44KKUzmm+b3MHCcPW
	 b7TGU3PypW6+6a+kdAyUktqpoKfXgjCtFF/T8L0fEivtHcZ7hhG38EHL1dFDEkDvmeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jj+IS7H9YDNdNL8RPmf+32zqBN/ZdmMeOeOXwXdvnNc=;
	b=u0nBYTcZXTiGfm95NSr70PKiCRe86FA6QmdyLtIb05fJYqsGxKz2KvNs+NcJzVAaO0CP
	 G0Whlc9SoGoHu4Pve3V25Scdg2zwrfkAlSu1/aDAnBSofmKdhYrXOjpgJwOWUSRkeeNTP
	 hsL0soKP1ljawRi2wk3PykMf4pnbYmD+QEfS0wD2F7aReO8wv4QmwQh5ExnDvqEk/UQDD
	 Gb7u7MELaB2bR24vRPbiA2XWslyaYf6fca58oUk3UuoXXiifhZwL3gIEEvP6ty9ptT3xL
	 pw/FeN/QMNgLrSUWtsBi5VaKjHS6UWLjqeEMIdNpLcQuPhHgI9FmBRQreBsMLk9xIkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxlGkhht;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBE60A5BD7
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 07:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36FBE60A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxlGkhht
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49412eb1474so1438242f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 23:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794814805; x=1795419605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jj+IS7H9YDNdNL8RPmf+32zqBN/ZdmMeOeOXwXdvnNc=;
        b=uxlGkhht5mv0MZbfIcJWS5enQNYPPrn0khTfJVopt1uwsrxiZ38cqq8jkyosmbjgYz
         5F9SY3nvfwpt1mJZ+pG/oiXpK0xHYr4oiw+XvjyJRvIdKEXzPh1kL+mpBexKTB/MVvKD
         MgpEeKXUkOk4JV+xbZydfsFn6Sne2D1nhbU3MHCWs93T9sWewbPrGNF85ocnV09ToBB0
         Vg7hU3y/ugh8KYOTDeW4R9mSdVUIQrLaHSFx2WhDBxUKw/6LZyGTwCqB/G0UiEvIV+4H
         24WWuKcndH72pLzKUJEdSFdGFfoXMOwptllW1kitzbu7ZC59HiCYwUoz3cZ5St149oou
         b07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794814805; x=1795419605;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jj+IS7H9YDNdNL8RPmf+32zqBN/ZdmMeOeOXwXdvnNc=;
        b=2Eb4sepZ+2Lp21VvZCPwNUYpTKX1VnnSz8dmsgJuSFJK4GW7xp3kOP5fnx+VcqCNw8
         52htEh93AI2m3QMwGJvsRrKS/+btoFwLszgPPo/inWdyPYgJuPgQLTpMT++iygwgw2Yd
         pySS0tkrL9+uRzBHHK2ewlqvUwfs3vSm79nkWNTnHx8lpVKuik0GQwBzxLq5IqX6muis
         2b7Pv07wdYUYrAlZ2Zq1TNhUO7qkgALz4XvVt7JdIK0c9mosVmHfrMLswrdnn51tQ4aZ
         kvnUhByW3F12NlCprpltNBYxdr1i8qUQNYDYyGjf+wNdK5o9/sPQbVDq1kKjKdKFpXYd
         4Wqg==
X-Forwarded-Encrypted: i=1; AL+hErFtqSQMYVMtDiNoBQM7n6vSlDypAzVhxTWEWrODDDJcIipF9GrmtM2/dCpskrKgNCGNCo7bhzJXJA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/p4mQ7yRVo+TKqzvk/o45IRFeRWEBLxE/h5X7d9F9iMvTNQVJY
	H3e87ZBlSoXVzSLAhSxMt0obRc9aMjZqW+HfaziaIyQ3vOvXUzwGU6J6QShSM0PwLqwFJw==
X-Gm-Gg: AYBFou1bb6mCfNm8UjQrsZdZBSwAxswSqeebUsz69gF1N4Foxdh9kzZm+NBz41A/hT4
	cjU5ZiUCjUZvZnJBhRvxgIIyljzVGpPMzXeURLsLQGZRTf0PCnXw7ZaSnNqtTt9ZQLdvacbNrGv
	E2f8CqwWTagIViOHDuZu2xZj2XDkrzSKevZ9Pzv3pEQty2PJzYFOcxjfyQIAvkrY86tSoJg2k0G
	eTzJwscvzs/LWqEl9MYnyqb5uGEv2X/9MzLos/Toub+0U2MWDGqEYrr644yU93z7g5pSwTAUExu
	vZwG2B4IRBB3dSECU+44zmz9ZI+gfXjzifkNktMBxxQg3JQtPUKGL8+vkoSvVu198OypBKcRwnE
	L1U9W1kix7/PSOElJ2cyi4aY/RStlyZFBxokn4Zqy8H/iAN7E7TuX2AKR3RRtougINzdoRaRPRU
	Trg1SM0mw9q5IT4bC1mmZPH1yhezE0csfiZWV8nkWIp2ydX52zyWjJzgr8iPGRqzblDpdzFAL9X
	I/cxJaD/O7FP8Z1GWQaa2svrFv7LUjuCImwefkFAHV0+8NQgSdhmddKfD1ZMWc9M53FVxm5+rvQ
	7FLaf8m7YzYGfeOPnKu/cVesC1dcjDg=
X-Received: by 2002:a05:6000:40db:b0:48c:6fa4:fc89 with SMTP id ffacd0b85a97d-49c71e3e248mr22685484f8f.12.1794814805520;
        Sun, 15 Nov 2026 23:40:05 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm20354115f8f.35.2026.11.15.23.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:40:05 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v1 2/3] power: supply: s2mu005-battery: make the alert interrupt optional
Date: Mon, 16 Nov 2026 10:39:59 +0300
Message-ID: <20261116074000.355176-3-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116074000.355176-1-tadilhusrev@gmail.com>
References: <20261116074000.355176-1-tadilhusrev@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver unconditionally requests the fuel-gauge alert interrupt and
fails to probe if the board does not wire it. Not all boards route the
alert line (for example the Samsung Galaxy XCover5), so only request the
interrupt when one is present; the gauge is otherwise polled on demand.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 drivers/power/supply/s2mu005-battery.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/s2mu005-battery.c b/drivers/power/supply/s2mu005-battery.c
index a76154e5a..9798a62ff 100644
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030496;
	b=TesYYjUhHN6YNVYd4fPM+GySjDvPp9oA1/NshXXhI8KyQEjTGsuhb2aMVFYmsq0yvGcp
	 J/a/Q4JnrNlz9PuFhuGH9bI8mdcu2vrW+/O1oeA6nqx9AwjkaebJFNoErLGWFG/Zhi3Cn
	 bd0Id1zu6wsLJmlA+sFGyv4ggo35igne/N8aqkjXZM5s9Cu+drGcf5D2g3V0eASq3YD8d
	 OYXaL1b4St2i2sOK2fEXPFYu5qm/DeO9YrDAvixVbAu5bLSHSRFXB4wA5uwL3ayow4AXx
	 YmfbZjdtU7lSreKyRSq44kY8R3q/YU3lC5ZY+a5yZYHQOn1i2xmPtC+XkD9CLtpi9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8XBljlLKqRRjxilFeLavMMQSY8LIFYe2oIo8dfksQsY=;
	b=nS3j4/ZJFFNOEei84mBNWzglnfIJZEFX7sgDXJTxmWF6oLLxcsVy7JyHR02acpSwaRCN
	 fukQnZH2f9iRzF4hiS6RnjBbjLt3pttVvTJdjQeK3P184gc0+tIpYWdkZWPVjG+lkAB4E
	 FK/HnGACoWP4UyT23iM6S9VeX6h4vAtFr+dNroTu5BkMhO1Vgz6PtsSjer0iC1v5DUoIG
	 XgKY+nJXJHWSnzJkmj8sUsmVkygjsDN++Rgw79mF2BOWXwkFxrQGaaEWsGKc/oKSj7EEE
	 Gc7Rufq6JiJTAlSRmE+L90HoI83uinu1PwYJ78Y3WISSMgDGBGdBQGNXCMC5icG2HoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EwYlfBC7;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803260A3835
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D803260A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EwYlfBC7
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c468bd799ecso400413666b.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030494; x=1793635294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XBljlLKqRRjxilFeLavMMQSY8LIFYe2oIo8dfksQsY=;
        b=EwYlfBC7y6sK9HmzmqR2u4HIDTuI2mB+kmnUpY44ATrQZ3weahL/ok6C4hX1qN5gZ2
         77QrAz+T9DqUes22lkCusbX2urUsWGoEkGeR0z0QorqEIZQrRFEtPJi2NfvuJ+UPEm+h
         7AhePhQJipOlYvtWMJcw8pJAwFsmvd3n9AsxnWbTyQbSa3YwTX+NcyyaD6i2NraQMpc8
         8hldahE3dVukzlOz/HR+CaBLDCurS3HULfsxV6X681LnYh1mlzWwCP/B1vDi/X0all9q
         Jyr8kGHOekKyxt/BuU/rjkA/616VpvqaBfw5jEaJA8cOU0RylRPnO+4v19baWIeBUjok
         V2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030494; x=1793635294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8XBljlLKqRRjxilFeLavMMQSY8LIFYe2oIo8dfksQsY=;
        b=2rswaveoQFoKC4yyFB74dgiSj0chHZoVxw94BeWGS0l69J2lTmxFmOgLPF6g5wpvX9
         unFmjORE3chgwbRvwXcarEpGdmZ2vm1vuozkAX+jBxT7KRWnZFvQ/01VdeWOgu/GI/kr
         e7inHpOrln6gHDay0PYjQS4XfTyNUaNyyGGkF7g2suHe24iC4qv/6lh8ZoUmCId2cdi7
         zKxTaU09PS3MdZXtkGCZ8pC5QvMD8Gnz5dnDDpAL0phsm1pM+cBh7HRyIvxE30mCFFT9
         KcuvxlVHJfqhjPGIzYntx0BNiYh7hXM25jmPpBkikQHR9EgvY0WQixSXljqnLf+u4dQB
         YQCg==
X-Forwarded-Encrypted: i=1; AKwUvBxSvjQXuHTZD1JDybj2o8ZfKT8H6QrU5vvUG3oIPEMkh+6Q1cl2PjENCccLjwo9shwVuXwC/P+c2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYL/QNrZdeqk6qA5XptvH4+I7p/W8AtdEKEd9DUIl4jqrskLnUX7
	qa5AOzfTxyR5S5lC6gwj6X0FG/9skQd5G85YybbwzlRDwcE52g3FJqt1xh2J22QuvB4=
X-Gm-Gg: AYBFou30/+dKPbFtBpqp7ns46EbNFULN5R78fOnJxo2Tz+cLnk8Gc4ng/8ZD9QFRFuF
	5fNJgX2+9L3a4qGW4acS3yUxXEKTbn81HMTlTZmMTspvKpQhAT5+myHvgUnr6ttMpWDhF5RW68D
	YHfLeJZlHcyQ4axAM2ZOeqBGWokRqlFMRTWXm6fmpcrLd87yePEuFzYEL/bO8aGxqM+qlmPV9wd
	D/8YT9mZOedEJdjpH3r2IluZZCGgoHdIbJIsLMAuFzQHWzLNElGFVY5CiblEoezuWMU9k6vROEe
	FkJWH07nZIpWw355auBdzwENabZyLxmKnfQlr5QmWkbR38MqMr7yxL6IEFGCqlWwQ1q+3MSUi3I
	vlnrY4svWcNBJdJM/s7fXO3tJQWwlhIiI212QgvngydOJDQKe8HlYHYwOuhgciIVCA/lCa94duf
	iun321s3YjiMqcIGXnvhOxDgjFcZj7THTOJTfGHb1G2MVlgravfd3Qblanfh/ITmKpr9N/wJnS3
	cRY6KFZWAkAJACDCwYgCitunlxmjDgQEVAvOnrY/q/79j32yWrRZnNczaeSSaeyKCAdvTX+uR7c
	ss79siWZiPGJkOwrz/Q3wKi41I5PpS1xtLzo
X-Received: by 2002:a17:907:934e:b0:c3f:c10c:217e with SMTP id a640c23a62f3a-c46bde1ae70mr844808266b.23.1793030494296;
        Mon, 26 Oct 2026 09:01:34 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:34 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:31 +0000
Subject: [PATCH 14/15] thermal/drivers/samsung: acpm-tmu: Clean up probe
 error logging
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-acpm-tmu-fixes-v1-14-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Juan Yescas <jyescas@google.com>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=1985;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=kOAW7Lg+JKjNl6M31E1sd3Aqc9IKaM8OzTH6CkDn+zM=;
 b=fceObKfe3Qe6T3h1tEWJjQyeD7mlJyfyeyiJSmC5N1FBKp1boMaECY3jPD35CEu6HOV/xs+O/
 MKauJiAL0i9Cxh6ONNDpJvoqSRGpGH8P0VzDyGXY5cN2Z5CgcL3r3TF
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

platform_get_irq(), devm_thermal_add_hwmon_sysfs(), and
devm_request_threaded_irq() already log an error or warning message
internally on failure, so drop the duplicate call-site messages in
acpm_tmu_probe(). Also update the copy-pasted "Unable to map syscon
registers" message on devm_regmap_field_bulk_alloc() failure to "Failed
to allocate regmap fields".

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/acpm-tmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index fd491b4f305d..bce4674be58e 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -444,7 +444,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 					   data->reg_fields, REG_INTPEND_COUNT);
 	if (ret)
 		return dev_err_probe(dev, ret,
-				     "Unable to map syscon registers\n");
+				     "Failed to allocate regmap fields\n");
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk))
@@ -453,7 +453,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq < 0)
-		return dev_err_probe(dev, priv->irq, "Failed to get irq\n");
+		return priv->irq;
 
 	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_use_autosuspend(dev);
@@ -494,16 +494,12 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 		}
 		sensor->tzd = tzd;
 
-		ret = devm_thermal_add_hwmon_sysfs(dev, sensor->tzd);
-		if (ret)
-			dev_warn(dev, "Failed to add hwmon sysfs!\n");
+		devm_thermal_add_hwmon_sysfs(dev, sensor->tzd);
 	}
 
 	ret = devm_request_threaded_irq(dev, priv->irq, NULL,
 					acpm_tmu_thread_fn, IRQF_ONESHOT,
 					dev_name(dev), priv);
-	if (ret)
-		ret = dev_err_probe(dev, ret, "Failed to request irq\n");
 
 out_pm_put:
 	pm_runtime_put_autosuspend(dev);

-- 
2.56.0.257.gf7497c7d27-goog


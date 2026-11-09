Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199371;
	b=ovGH2M8k2DDTcIw7LOt02rNLPZx3Yzgo66/CEhQgdHGWCj3duHZPiq6dp0u+MOdoGoW3
	 MOLysWB36Xi6oEau8m7Hau489J5qqlctCUG/2HmAJ6HTafYik8eNeOwd5eiurz/qiKzb5
	 9lVvDaDTBwbXcrkGyBN9V34S/DLOWPQD/1OJyZsIxqsZgENMwZMuuhhAZ0RvRHsI8x9yF
	 eVY4jC6niQzV74QkW5UsCvpzaVD53y/OyHr17Ak96nMaHdf3WhHp4Da8O0hPo2cjmWkhr
	 us4KuzyylHPG2diPOWp/Heq36uN4qWxsr6cgfXbN7UMa2wlMWvAN0bVgDfYQy4tTwDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yZy6juQ/C2+U+L3WTVvMgyAkJHBU1cX+JxwPunI95Oc=;
	b=DfqIS9xIzyhhSlFMOfE6kDCyxwY2Jqo3MVNNwDzDXgubNd4yQlqnzpuAJF7htQHlcn+V
	 UcHEfx/J5006uARyAAQm81aYPcTA9BJakNu5ngaCsszLol0enPhaEGTEHw5z6IDAkx+5i
	 xTpYgQey8UZMXuxPIO7cobHQ8lzxsgnVosr4wtVuDtIb8nPl1wQeMjjMGt477eDNzHjAd
	 nYJwF9hDrhgPqQe8ztstAPkKGEOc+oy5jbAJ7ft9twnsaJpyP92K/tCqxrGKM0bgNYzRP
	 iPFJZtN9SmiBDAapA2+IAtLWt9N9exKhjpgwTN6mvlqVPn6poYLtSmt9ZyJ3nSDS68A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XkWijxTT;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE75606A323
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 04:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE75606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XkWijxTT
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1185593eec.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 20:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199370; x=1794804170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZy6juQ/C2+U+L3WTVvMgyAkJHBU1cX+JxwPunI95Oc=;
        b=XkWijxTTWAqwBLhYURWexse90j8lVvME6HjHujR/avU4s8oe2xbjRMSMCFK97tMZ0b
         O6vtS6ERCGtHtCCyAdVbQd6/PpIn38zebhx6WxFlGf0NJIRfX1XkoCxqRZKqmxmCCpgO
         9mynUDx4Jgh5HXko5DbENTlBkZFuAx48zd6c97EQG27tC55FN9ikxX3vl/5iR4pvYO/C
         PsF+hP6z6mbVbb04Rpe2Qy9lmsAoRXK5P5F+z0UKtMr4AyTxrzev5IWcY+WvuALVBfnZ
         Xrk3aVHeo/wYy7IZ0+8e9aAQY2Wo9+KtMHSbYRouYdVZZ7WxPh9Eh+qm/yNIeOxqhut6
         SuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199370; x=1794804170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZy6juQ/C2+U+L3WTVvMgyAkJHBU1cX+JxwPunI95Oc=;
        b=dufEzulXSWKGxUz1YSORB5GTm7g1EPDvPL2u3+IV4vHzp5xxU6FbrYAhphjmsu5Iaq
         A9Jg468kseo+sFnWjjJu8wl2ywVy58mI0SDEsFknAKnHNadcV88TdDVExFhS+b3HgslO
         IOh0KRrDkcQcN3O4Y6NyPxtud/cibsH8IivekOxzyfKNeO5bmWkDI6abySYAUV2USKJl
         xVHKhvP4ygWpMbNakRhSy+1R6Pxbhe/lUJovZuLFTXepuLP1l715p/Qn8qptUQCGc90t
         CrkKneCv+wd/KvwssPFhSNV1wxx76kWdRlqMqARowntYaOx/T573jGj+iLnGUHPEb4QD
         +gDA==
X-Forwarded-Encrypted: i=1; AL+hErHfvsvSVDhAGNbCeMIwd+XqskVkFCJ9tIudMNM+I19GSQincf2Fzlij4twSEOMTZfOdPZeMsYVpGA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8RxfKSw4mi8HjABkJ2KzajqVIcIKr+zNjTakv7ddalY6RmqKRg
	sQ4J1/L8EeKeoiCtJXWQ3gQh53ty6qci19cQU4VawPptEZ8Jjwra3EAj
X-Gm-Gg: AYBFou1c7lphFm4TT9YQ0ujW8E4GYgb3H8DSCvzqKD05n/FSQcXcSfQzXX5tXHXTfaj
	wXVZyFeC9hcfMgCngHlWfJKWV9UCW+9XhP6/YWarVWl5bNiUilrd2lYUoOvEpeHb0cU+QGL7Mki
	7KxyrAuukxoHYjeuspgYV/U4ispJlDJtpFxTFhVJWcYEpY945MdRMAkF09dpKl0Ht6KgXMeNrpL
	bpboceBtTYM2US2sGjhJTeU6oY6v1+1AQTI95DmV7ogGp1y7BRUkA9V/lcDlZ/+XSBeOCXmyvTS
	6LHjORLcK8GW5wBsJLUZKjP5X03YFcDPWWXsDzf659244zRO/X1MEQG0BwX5FBeWL4nXkMSVsS1
	nplHYSDDgHwi68z2t/kYeC01ubZUYIsvsCQXrlYvQlbFgxf4c8Xl9VQCHsI7loGka/wwqOaIR3b
	I26bkqInatyhzMt3W+Bs9Vzt3t9gu4Mw+Icy2zX140pTKJn8RIyBo765DG6ZqDE6a6yOP9WaF2Q
	BLphqNs5KBrhtc8FOJVXSz4t8z/gnIWs8TT0CANiOhY2BbPrNTKBAq/0o7fbyq4oqDif2seTB/V
	mXR8/TzW000mtYPmLC7GqObzpsuHJool8ADME0157mSxqAO6
X-Received: by 2002:a05:7300:da10:b0:36e:8e6d:a0c0 with SMTP id 5a478bee46e88-3725dd59dd2mr5386387eec.19.1794199370484;
        Sun, 08 Nov 2026 20:42:50 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm10154026eec.4.2026.11.08.20.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:42:50 -0800 (PST)
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
Subject: [PATCH v2 3/3] power: supply: mt6360_charger: drain chrdet_work before unregistering the supply
Date: Mon,  9 Nov 2026 13:42:12 +0900
Message-ID: <20261109044212.1157357-4-hj351016@gmail.com>
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

mt6360_charger_probe() registers chrdet_work for devm cancellation before
devm_power_supply_register(). devres unwinds in reverse, so on unbind the
power supply is freed first and the work cancelled last.
mt6360_chrdet_work() calls power_supply_changed(mci->psy), so the work
running in that window dereferences the freed supply.

Register the work cancellation after the power supply so devres drains it
first. chrdet_work is only scheduled later in probe, so the move is safe.

Fixes: 0402e8ebb8b8 ("power: supply: mt6360_charger: add MT6360 charger support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index b4d462343151..71c60ba012df 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -790,9 +790,6 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	mci->vinovp = 6500000;
 	mutex_init(&mci->chgdet_lock);
 	platform_set_drvdata(pdev, mci);
-	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
 
 	ret = device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt", &mci->vinovp);
 	if (ret)
@@ -828,6 +825,10 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	if (IS_ERR(mci->otg_rdev))
 		return PTR_ERR(mci->otg_rdev);
 
+	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
+
 	schedule_work(&mci->chrdet_work);
 
 	return 0;
-- 
2.43.0


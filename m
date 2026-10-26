Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030496;
	b=kKoERN53oLjpaW1XpCRjLMjaw0jedV0qVjMN8B3gMBmj0BOhNrgCXZvAivHXGvHwIar9
	 axZK5vuqrIgs/FuGMdzCUCULR9pe2UqQi3VaEdkYmWb0skXxupaNsCj4rILgkV2m34yUj
	 ZO4moQRYj/J2hDsqYStyAX95dnc1y34PvOfxOuChEg2Ni2xhSloo5KEe/kSIk+cRpln0p
	 iaymTRw0UC9qbnnQqnDiBw0rh0vDQIKA9lYgZ+tbdYdJ1lAxvdFJehYHOOiVYQUXj/vBj
	 uJfyQD74i1H7rMpJIKt2bZLFIBPb1RZNqulT4Xg9dZtJWFfAQ0FIDQabvnVMHHQwnpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=GHh0akm+nQYSDGsKa/K0+KoAPzN5SJ1wMHXDD2NJZ2E=;
	b=QJIMCUfvXnr11Y0VgoHgQaczTiJYNeIt0wrEZXa4eW8YTO9L14A1O99/DTUMFuGspLQn
	 r0y+9WBBUDU4tkVJH7bbFKqM10lRNKBxTf+2fcPaBEpwU487fdhWATaWEIWchlj+AAAYk
	 gOPL//dTCcqMdrowjKx0veK5xLajr+fgGSA9rzsZy+txg8s2HpvoR44GKWQQbq1zU6Xv/
	 Yw6n2RMmaMVUew7TCE4WZ9TJ0khfOOfjdbdAigZFBBCBodIu58HoJUnuaP/miVsWKYWjA
	 CYKl9YNNus8IdTOwuCuEDIQ0wzGXv0RnIciTT8JhuhbP8kSJAlmK8UjWNEFt2UtW9bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pn+IUgFv;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105460A383E
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7105460A383E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pn+IUgFv
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c413dea9ca6so504369366b.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030495; x=1793635295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GHh0akm+nQYSDGsKa/K0+KoAPzN5SJ1wMHXDD2NJZ2E=;
        b=Pn+IUgFv3ihsFrujjLWPVEANrB2ZFyUCoWIZUgTylairSLFBYGHxWQI/rU2Lk96xM2
         y39wmWgvbJztJltyJ/DVWgRsvyD89PcpWnPfWyEVKgWhFLwLGaQY2GLArR8qRobvPZaB
         Jt10M6ey0INtGaXCOwP9j2GjW8Whex/NewR684yHuDNJorf7EQavZRfdI25dLIrDftY0
         fsBZh+tD0hQYnPeoPm8BUvi9UUgfXl+IgdhfUecfP7mRLog8L9MAE3TVmSUV/0O1YFRq
         AhGTkiWcjcbyeCQG0JQm9dvzXG3TsOnlvNckdG1dv86hVoa1zxdEPDmh/eqVWK9twZZL
         71JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030495; x=1793635295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GHh0akm+nQYSDGsKa/K0+KoAPzN5SJ1wMHXDD2NJZ2E=;
        b=tAVlsYREA5nWGp3IdmkHBjlBd39LnCrqehneYO2sfDeo1WgiD9KdTATl5RQLC+XX9e
         fqbncU9Uql4z6qRi0+JlPKq/nvR8/YY0LTTg3rh3KFstsHK0l7d7GN3KTFINGxscyWAd
         RkFSscuYTe/XHIvjmYgEwFe0TbCQBl9CvxrVL6V7hpsoY5GwN/QR5OOO1M82DTcW0oWY
         2LG8vwt2o0Mn3VntYd39uz8BkNjuCLYMn4kKyK08QuZI8S37XMVI10nkOWiZFuyieZHo
         Oj1sZcXPRRnoPxCD9+YKSR8LTAY/40YoLjO4alaXWxQNXoZm5/6bGMyiIR1zy2wqMtK1
         lWig==
X-Forwarded-Encrypted: i=1; AKwUvByzeZuKJIO/RSoe8ix4RZakAVcKt1Eq2HgGA7A9VrkCksnuSK+bqdnO5QGkeFEm6bJ+6JqM1eJ6OA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLhJPhKywOVYzmRC/WlZVLdAwyUt914nOAaob7DZs5fndpbTa2r
	fUQ6rl449qGD+ZRjgTGanXKetJV3Ohy5orOpmZYHUgoNu2Zbjt6hvW8c+D0OkzmRwBM=
X-Gm-Gg: AYBFou07tGaafN8ZW9DYj0nVVZ89jjkjKxBy6x2Nalt6ipNBmYU9iaTpxQLu6m5lAv9
	qqDMmqXnGCfzE41uGffVWzXyIlETBeD6ygYldBFT45NfxxvA2OAvKwoD5fmu2iWRi+c9EyIhIIq
	5u9AjmvhCZq38DGtxiQk2u1TAkb9u0gzIZEmY1UUyeb6VxlB+BbD3FD+s4nQYDKTLl6pzrfdiVE
	otyg3jxcMYQHKtl9HNM1LAEuAhxJtEtiajBn3wmT4C+VWij6ho81xSswCB5rSOAQRRYFFHEcbEY
	PmCQwp98DINntFB3wBSE/Msq52uYVLtPx5oh7nlPRM0CRxs/UVsih+7Kmm3EEmSm/YecG/9nqpO
	n2b0/LsMHg88xf4EKy/lcBHPMy64xJvust/J9dn7yQ1CsG9vDis+uqNglmSHX75Kyd6WsTutKvC
	L/rJr9sYbVqO7e6lxmfqVi1w6yL2LZ3Yws8WxeREGKcqhTLy0b2lFi+N3L54D5mVnMp70dpVqXJ
	pMd2zJUxGJYP/GbS9LXe4g34ac5uLfpJ1zeTLMG+CyZ+BxUU3exDHFrsntgHYQEIDz7zC0PJjOk
	+sefW5/SpPPSKh1fr7rXwaZEIIupnnDrGE6i
X-Received: by 2002:a17:907:7b9e:b0:c2c:d06f:cf89 with SMTP id a640c23a62f3a-c46bdacc54fmr886243166b.2.1793030494893;
        Mon, 26 Oct 2026 09:01:34 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:34 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:32 +0000
Subject: [PATCH 15/15] thermal/drivers/samsung: acpm-tmu: Simplify
 pm_runtime_resume_and_get() error checks
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
Message-Id: <20261026-acpm-tmu-fixes-v1-15-0637431b7268@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=1473;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=lZVnFDVBHj1aJ/e5MIesn7vTgTEf09TNxBZ/LEj/mAo=;
 b=xzafQuLI4krITcIxtfwX7fRea8cl4qpZS/PU5TktcAFB9PnVEMuhm60+zlPME803xQgfWT0wq
 lnW1Df98m27DbAa2fERE3L8ODpFo5YZ7BhXIFwJqK9CL46OS5TS4oAU
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Unlike pm_runtime_get_sync(), pm_runtime_resume_and_get() returns 0 on
success or a negative error code on failure. Check "if (ret)"
consistently across all pm_runtime_resume_and_get() call sites in
acpm-tmu.c.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/acpm-tmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index bce4674be58e..7c30401f8fc7 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -161,7 +161,7 @@ static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on)
 	int i, ret, err = 0;
 
 	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	for (i = 0; i < priv->num_sensors; i++) {
@@ -205,7 +205,7 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 		return -ENODATA;
 
 	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	scoped_guard(mutex, &sensor->lock) {
@@ -463,7 +463,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
 
 	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to resume device\n");
 
 	ret = acpm_handle->ops->tmu.init(acpm_handle, priv->mbox_chan_id);

-- 
2.56.0.257.gf7497c7d27-goog


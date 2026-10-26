Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030493;
	b=BdQgsL2YoMHOu30cqzxTKdPYCpa8gRm2P6WGCtVWk9vJUznKMLdlVM48L9UkAIDkD8YZ
	 6JTfezI8PuD8Zk27wKxxMy8YbHsDeTF6tTgoteIhxDtCphDY5e83S4fApDxnmMd5hCXFH
	 NMPNbrlGGfjxt7BhqFTGHFIXnFCTUdiKY164y5nh54XMAKXiCAsRtDwqftdIagBFJJg2l
	 Cnf8fjwgd4ESlfJek53/mp58j0uMdRdbId4gMTAQ6bdsrkWsK9/X6Qrrgjm+25ZyolW6q
	 87lWV4iojWrKclXzioAXrfaRalON++BeMZhYT3es85FxN1MwffxMA+zhgrWEqNBbkTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=EYYENz//Yxu5meUYT9GGLBnB4hd0LOVAJcrkVCx2F0o=;
	b=U1i9bR1bKveDAI4wO/aXwK5lmSwBpCtY2KHeI1AhY72CFBlSzdvkWq0rV0VBO2bY9v3a
	 1F1mbus+0pwgXzYXSbxthvbUFkLNOAifle7f7ssH/4ecrUzVd2V0EWItyTU6oH5lhIovk
	 4dBGvL7FzIM1jEYUNXIYekZntWLQGYPrj5s0gmC5aQtNOM7LUMHdrcBSYou8hewvv77wQ
	 cXmLHOgat9BlYLd4uL0Gj3RcDOA/Kjv/GZ5bKglsy+Y+Ajs9Ou0oyYu9DLl59jih4pJY6
	 93kIDkcfwo16sJerElwIqu7mGhm9Ix3yCYG5VURa45YZFX8fyw50enVjoVO59E4Q6Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eDpLUcaz;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8960A260A
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17A8960A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eDpLUcaz
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so3692931a12.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030489; x=1793635289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYYENz//Yxu5meUYT9GGLBnB4hd0LOVAJcrkVCx2F0o=;
        b=eDpLUcazRiDZjBah+BQ+235CtKqivKy8dizImoSIltUcxBLs9P8eFG6BcUeCLcoEp2
         zHHosODwLt+i8Opy8qQpkEOIeI5lmN5CwO2SzdIszSeyUlPLkm/h3AzYL0dTaEkqSz/i
         I1ECbT4WkAbvaP5QHxK7gw9MiFoNfCdslNnlz8uGBRErtMCuqKXL9R2nqoPDWUXR2WsJ
         ScqpjU3oGwDKvWyu/KXBLqWS1KlnkPSDQeiHuxs6Eaa/56c3ZNDBboaumElUAZ8hQTma
         6EU6bJp4MMwS0p5dxPfcYA/zaLjJ+NK5n2Qk2VjRCYJfcVxP3mobukyeWZQZNV1XQRT8
         EVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030489; x=1793635289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EYYENz//Yxu5meUYT9GGLBnB4hd0LOVAJcrkVCx2F0o=;
        b=ulIXwDV9xTFJjQ/TudgZs7dgtgdDHMFcQ3Br7iEw3UUHJi89gqmeXdBg+ox1E54dST
         j2Cr3YFdKYwvTGuo+cNx9et1YF6OmOWbPbaQ6o8Hz38sTd1hhCT6mJ4e/tHXbASIs4pm
         LtSSpl3A7b5IdEDbWiXSMumRqby5yt49AkvcYjIjfpy1xTIPaDV4Wizh+mTVCs12mA+Y
         kjU1cW6sCOpEGB/D+rHvrWBDHRyW7R4tTGPh5R3HRQwHrTYMA2cSDuO9r1GcqJNHTTSd
         2w4C16CxFYrs/vY8zyHD5KEzzJUuguZDwNm68Jig4MKK2nmk1aYv7oaNukYAoNk+9Rbo
         TalA==
X-Forwarded-Encrypted: i=1; AKwUvBylvh2ji64DBEOma8COkfETLtNgWXNcwhmaiyy4AhHrZJcBTmW6Y211eiBJ0lzv+YLigd7JPbR4aA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLhRA28sGL8ec+ZzAHJ+WETtraQAofNDliyANhFc7asvWNRd0WL
	7w+V+wCKbjQp/daiDRYm8r07jnwBzN3k6VVLDbas1qXB/eXrqRFW7PTkDQ0VULYrOcU=
X-Gm-Gg: AYBFou3SxkkPwTLGOd35KiMaeoVPIIvfsd9RvxjjvvYuMerdfXF/JIvC1BvDQTpKpjP
	7+YYH8NTlsMfhZotHfNvrDwwiqpLwNnlrbVJatcocexJ39s6UjdEpobAZqYoSbsaj9syS8kCXzb
	u41eG1kdREs3sPET3EJgHckkZRU0xugg74/pe4p3UeQg4DRDhcMb4/2VZbbq88u++hKzIfCpwa/
	YAQuVTCLWwb9FX2Z5WzunKfHNrBC4trD0XViXbcSqBAN+V2c6IyHzzpAuUNmsV5AmeRZ8RKHvVB
	i7d0+fWc3pZ6ne0wrrCMJzGRHiERhcBAd+NoHNli6SeSHwHYpIcrzPvz8CpyAPWPwcdmW5l36Rq
	NdEsbYu0KlYEj8+Q2Yg2WF3WlavgXN2krbOL0F5DOq++7HJ1QC5dOx56iUa5hJBrC+qM7J3dJc/
	4mthvL0sUYyDOmp06J4HQs2kO4/W4QL8m3IGq6aJV0Rm0U5IdjfLOk64+jaf/viZmbAb+ZOtsGW
	MEfEiHjdeMSK+BzDFGRrTRBUUp2rTSIKiRscWmRe/3+7hF6kqjNYyMFsIxjgqeFbKaQPUTvM/1H
	dvBR/QScc4idbmx9WD/vpPqWW7LJcpoh/Mw9CK9+Pm364rxxR2YK0otbWvrrnsrmpsZDc1R6E+M
	fDV34uF1Wrw==
X-Received: by 2002:a17:907:724f:b0:c3f:cf2a:76a8 with SMTP id a640c23a62f3a-c46bde8b95fmr863838566b.28.1793030489246;
        Mon, 26 Oct 2026 09:01:29 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:28 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:24 +0000
Subject: [PATCH 07/15] thermal/drivers/samsung: acpm-tmu: Return -ENODATA
 when sensor is disabled
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
Message-Id: <20261026-acpm-tmu-fixes-v1-7-0637431b7268@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=1760;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=7lM3qIErXOkLrWCUvTMJgQuGSIk/cFpH48BW97n5ryc=;
 b=GQSw8sx0872mm/sZpXZuyYhnHTCUuT+ksnT5U3IgLXaQ+PhbVK6oVjYCsZsjB6Z5+rZvYxMqS
 7YQOm8auVUsDmEyQYgUOUVjIg/WNDpL9zUhK4lgRBg+nrXwLcA1OoQY
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

In the thermal core, returning -EAGAIN from .get_temp() instructs
__thermal_zone_device_update() -> thermal_zone_recheck() to schedule a
250 ms (4 Hz) retry loop with no backoff. If re-enabling a sensor fails
(for example on resume, or after an acpm_tmu_update_thresholds() failure
when polling is active), sensor->enabled remains false while tz->mode is
still THERMAL_DEVICE_ENABLED, causing an infinite 4 Hz retry loop
instead of backing off and disabling the broken zone via
thermal_zone_broken_disable(). In addition, hwmon's temp_input_show()
forwards -EAGAIN directly to userspace rather than -ENODATA.

Return -ENODATA instead of -EAGAIN when !sensor->enabled in
acpm_tmu_get_temp().

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/acpm-tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index 4257bec802c1..1f56c69af76f 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -200,7 +200,7 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	 * after PM resume.
 	 */
 	if (!sensor->enabled)
-		return -EAGAIN;
+		return -ENODATA;
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
@@ -208,7 +208,7 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	scoped_guard(mutex, &sensor->lock) {
 		if (!sensor->enabled) {
-			ret = -EAGAIN;
+			ret = -ENODATA;
 		} else {
 			ret = ops->read_temp(handle, priv->mbox_chan_id,
 					     sensor->group->id, &acpm_temp);

-- 
2.56.0.257.gf7497c7d27-goog


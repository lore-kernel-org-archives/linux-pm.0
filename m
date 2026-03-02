Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6053FD147
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458344; cv=none; b=uacrsCzXKThyCcNRBGPjnh/oKTnk5AAL51n+BCpBggIhyVqbQiJTXrZ7PP3Wi1sN8SGMNLoGRi88d2UmuW4BRmRGPGogxZowedvzOva4pt/yY0JDcCm4mCT3veS05OgoQ8BkO8WS64d2SPoYk2C8PKTGOVCrSPY7K+gOf39APYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458344; c=relaxed/simple;
	bh=/OAEYu8jHman9MxUf2Cw7PZoouqlJJESflhDoszAToA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXyzzBl6PKcw4tMaYaOTS8bMnF8PQzbvdgMLsfNL2UKdhVDL3R2Z4nHFVun39dSIJnrEmoYwmSLKGXquIsGZuJS7Vz7Kmw3uzwWbDowxBNUkOL6vWLe9br7VhJF/G7tBB2RLCqCGVMw3IsnDmit3RUdocglaTBd7OHua9HkrJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oo4MbrNN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oo4MbrNN"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65a26c220b6so5739507a12.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772458341; x=1773063141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bA8z6+Ihxqj6Q51dHeQDrm0g3jaymFmJkAFFDypHMQ=;
        b=oo4MbrNNX/QWN099HOszfX9ZuHVOxjnPx7WSEDstaliEMbdfAB9PQAb3Afr//lLTSo
         Syj4yJ8S9Fi20aVU3O8j1ogrLKQJOZSZd1TIcImrA39z8xkyTDhl0UFirWs73aqNxs/U
         1Jq51xLRsaSkbNGPZR/xetNhCxr+juIQHgN9/1kRIypl/7G3iMpTMEQ9D/GmaIbjltqh
         0PkUgbo6TSq5k56Dg5KqlFrGT/++RdXqHFi/LqORfV/nrVU6zb/XSaUmfy7q3wTuM/eP
         Ec+bucG+AkgvDFXFrTtMa+plH8Ultm7zB/Bib3aFun4uNgRoLIIkGxafXpINzKAyLLwk
         fjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458341; x=1773063141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7bA8z6+Ihxqj6Q51dHeQDrm0g3jaymFmJkAFFDypHMQ=;
        b=a/KSSyz3udpFb5/rVdU3wps6zkrR8Jze9+M+F2i0e6vkYMS22IkvNQXpWs0eKffR/U
         3Mb55ZuHp2M4h/gyHGnagWUs2KhWK4ebFkLjuqvgH8E0ySQ3SczK/C+MLfRFzJ3UjdNb
         wcTjeB7L9zr97vyT1vf1+SlkZz1gDVCjTeqPTXji9H0ecHC7h9R8GL1YHxvaFmbTENUm
         TlZeRnLQbmxRL/ayx3XVYq5VVYZBDIW+hyY6pj1HzkS9I/25fU1PqfBFxIKar5UlBTYs
         kyUpqDAQhNW5bD5Hu7GEeIDEaBVjxtZE4/uQmw3DxHeRGmLK01SzFFFz7hIKCTlSe032
         O3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+DyHjZgvSsLzOsICaeO4n6v5V7FSd7QmZzFvmWTGG9/I0ucsEOGQjtYqGr/kFlIhkZzGhc5YNNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3xCJ8BIr2tLpmVBt4akVF4dFnbHUb66Ye+xZC2KWdhIg1huX
	l99Y+jobJX9Kwd+Fm0nfhDOMWS8LjcdRTbjRag3GWn9T4RChBkzqzu7+IlBb7ApyZwc=
X-Gm-Gg: ATEYQzwgt5VYGjgxSIdUJmDuIE9ET69YMc41AgZZbW69eYFxaPBpNgLLmimasbQhm5H
	kXsawRmhtpk8b9NQUA/yNAugG06jGUHM+feFF3USxSSHTACma6B+c5frZmFlHL5ktFbuj3tfRR5
	fDN/KVNEFNW6hJTBvWaQuyJGOqsg/wvbEStZjY5ofZc3dnPdyB64QUMGO3TGeEkfZ5rSzdDdbU3
	mguZX7A/cjrNB3ifyvuoaQbTn5bpaK2UsRitvdO4KCUgXrV6sVJjj6aZGBe+SoaPsSf+qN8kZ3v
	y0sfj2ix1wgvSHB+u3qa745qCAmtobtISpfO9Hs18VNBW63h9LOEK9rhkMJ19j0CeiKEGlEzaoB
	k8/aoFspl5o30OD4G+wkUodPyGzcTjzkc5YA7LQWcmDw74USav3yhyQni9wWhVWN6w0cgxfS0QH
	Jlsxd0FenTNsd8QAdMm312tMuSKzZYeO/M4jLvBjqVxJHDp2QAV9CdZdUxcRiDZo+I5V2pR3mHk
	ywPengNknVI9jY=
X-Received: by 2002:a05:6402:40ca:b0:65f:a60c:5ed2 with SMTP id 4fb4d7f45d1cf-65fddcef5a2mr7747903a12.24.1772458341068;
        Mon, 02 Mar 2026 05:32:21 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d1c6sm3282988a12.17.2026.03.02.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:32:20 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 02 Mar 2026 13:32:07 +0000
Subject: [PATCH v3 08/11] power: supply: max17042: support standard
 shunt-resistor-micro-ohms DT property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-max77759-fg-v3-8-3c5f01dbda23@linaro.org>
References: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
In-Reply-To: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3

shunt-resistor-micro-ohms is a standard property used to describe the
value of a shunt resistor required when measuring currents. Standard
properties should be used instead of vendor-specific ones of similar
intention when possible.

Try to read it from DT, and fall back to the vendor-specific property
maxim,rsns-microohm if unsuccessful for compatibility with existing
DTs.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 0a6960bbf3a2..e21d2bd7e231 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -925,8 +925,12 @@ max17042_get_of_pdata(struct max17042_chip *chip)
 	/*
 	 * Require current sense resistor value to be specified for
 	 * current-sense functionality to be enabled at all.
+	 * maxim,rsns-microohm is the property name used by older DTs and kept
+	 * for compatibility.
 	 */
-	if (of_property_read_u32(np, "maxim,rsns-microohm", &prop) == 0) {
+	if ((of_property_read_u32(np, "shunt-resistor-micro-ohms",
+				  &prop) == 0) ||
+	    (of_property_read_u32(np, "maxim,rsns-microohm", &prop) == 0)) {
 		pdata->r_sns = prop;
 		pdata->enable_current_sense = true;
 	}

-- 
2.53.0.473.g4a7958ca14-goog


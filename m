Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903869;
	b=2uy3W6lxo8FP3bAubFsSjHd6HA+I6q486GWd+CfTJKHW61fjYPCy1wA+D9a7iDA1PANc
	 Lbi4fBeELLO9ww8bQ3E67LO0NM0pAO4mdUG/MQsB2uf2pUK+2Ywxr2i4ppPycmPaKs8M+
	 R2uGNit79Hvn0xVNx0yb5Vw/BTbZGqknI1XsJ1H7UWJykVlQ/Hd6q4XqSLDNwq47OjY6d
	 D2HqZouyBGXAoMnXiRsIdixTjcVUr064ZvV2/03/07D9vAvtF2xrDx1G02Roh3Fadi3sO
	 IULF3ZAqoKVl/1jFKglAmvmVOVKjfwQU9nJKoWGu7XLfDQgb79gDEMFmQpcykZnF0zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=EgrVZa2eZmqWGHTSXzSBkx9rK3FiMfFpfyVDiLiMkq8=;
	b=PJ+PRmtyOZnihB+uc21zu3VniI0QepDSgBppqiIeSi/uFAyOYA7cpE/4L9bG3u4VntaI
	 25rtKZE//DkzeDTayUF7or0aFxi4RimYN/APgSBy4wCwZHHjYFaQYGcyzRWSOf3wLvWcd
	 3wi5I9rjK54CHX2QZES1X/62PhdM043IgQEXOQdm09reJCwvg/ISNERjvT0DfBj7mYNJX
	 PrWB8T0xDrzq0j9VOhIQtFPirf+mU9tx7r+S48kwFyToEUnWcyYeAcR3KwXgZK2EpoTko
	 sv0eedwVprakcs87Art/1zImnwdt9nm//RQPH/mgykaqZzjQn+fw8WBlwI31Ys7uLcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=qJ0w7yjt;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BB606A8A6
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 08:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E87BB606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=qJ0w7yjt
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b7efd3bc26so3051580a12.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794903867; x=1795508667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EgrVZa2eZmqWGHTSXzSBkx9rK3FiMfFpfyVDiLiMkq8=;
        b=qJ0w7yjtJE1lC1zKPwOibwHew9VyeF40XwkE7/3yvx5PT+Ju5NAaJ4PAYpSd+gwHGY
         w7cc1v7y04SypaBVvpt0FdJ28SLaaLsSZoQeNlJY+q4fNMRgEosPLHV3CHWwRikNnAx1
         GmpPsBD7FywbCP4QoC/tQcG+Bwl3jGw0dQYN3ntPTRr5NsIOkJK7aiGBYTPyHA9B3Yhf
         m9wg2+ELiGZz1v/ioIhxWmVh2DL4jz1BZ6oJLEFOPFEMV0/0NSkxHHhQAeV0VysiAjI7
         ZrbLuE9PTGnkywNGKg28gayA6JsZ5rWJo/l+NwLWZQZynBQktGrHxtKU7fZkqerZZW1Y
         G6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903867; x=1795508667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EgrVZa2eZmqWGHTSXzSBkx9rK3FiMfFpfyVDiLiMkq8=;
        b=0BF2VT3ha1IF45JqOdHcRlXjsZ0nPmR9e55Ru8RYMBdWi2rMUku7dNKwk2XbaxwVx3
         kM3ReqeX7QaLcuJZNhF5W18IyiAVklmtHoEhizDTj1HwXwjzyDegHKcPsCeP12N/nCG5
         KLHJHYiMNTGBPO04MfAzL2DzNWnc7+kbZYqC8n14WzzvV8mdDR66R794N+oVVVxyN+V0
         2FXn1Bl/CrBZJBCE78s86WSZAk93lHDnuKhSyaDsTcxdwy6mksGkGbgFdQNR60MV0CYA
         G2bylvs8LKF5Q6Uud7MzIgnHQnWUbhhzCeUWqSsNJJktZrzTO5bTP6GpGNNPjDFc2WA9
         s5iw==
X-Forwarded-Encrypted: i=1; AL+hErEyBbDJaDprjXmRzPrZIBW9+jNwvV0jyMS0/zQY28ok+txU92644GGXEVtS8JOYHc3jN8ZGxYu+mw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8l//MmB0cAN1Qvay+0o83kP57I8JVlebv/dMMt90MS/cRFJWKs
	Cl/YnEzWG0kJYeQNW/UXr8ckHxauWqWxyWnw/eUl48R+EnduxvKE2o4qzzNKSh8Q6y4=
X-Gm-Gg: AYBFou0Y4VSzIviuqY0KBhYzPVOboHo+S19FMGsdp9/cSXIq6fU+lP9bUijRxN+UGyn
	9hV7bP8r0zmMuvJzluI8rNG1vSRlBxz3ZYPJMbsvJ/lch54BqU6DqUkL3Q2IhbxEUgwRPr+qoPj
	UUF8Pf/+Bnk5JJj9Iea4P79wjjoHmXmHWNlo1CVCjqT74aXpmLZULWp4Zrlm2y4Pa5Wkn7HsO4a
	JkueZhfQQmLveW7zHRF8LJV+AWy1p+SUsxma9xCMDa/VFxg/KjAigUKsrBwUFzKNp01z+vtKa1+
	ZY8GoWG4GNIzVx6OSqkLQM/bCJSgoakTfsW4bGSnDWnqbvDneOW3Xkg24ag7WMl2P00JNkq1cRK
	BfSegW7+wH8k7Xl62Sxz4X6B/N3LJODsA6IszNIqquaNiXjm8+7s9/xZccYiEi2qmu2eX3aWiyr
	qPEwUzDMM136OQVGR/IeReVZqLEqDn8gApS1ANocYflrsVGm2HUJeLe2I+aLUrmmnYRJG9IcMpk
	Fh1NgYGx5SxZimdqXPMwGW1N2XNojTTwfZgEH4FTFi6up6Vq5iBANlIdfJsjWgBlGZdAaebIrU9
	ChUWPdGHbpC+e3PO9vgTnnoityaQQNeVrN7iQHlqilJmHvNeI6ogyW0Z4/TE5c3h7J9Sx6InVYw
	R/h7y6YFLz5fnZZheZdfBJQCds5CLQRD9Dd/3x1SH9bjW5BiG
X-Received: by 2002:a05:6402:88a:b0:6b5:5530:c9af with SMTP id 4fb4d7f45d1cf-6b7c0bb79ebmr6791992a12.15.1794903867414;
        Tue, 17 Nov 2026 00:24:27 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm5616953a12.9.2026.11.17.00.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:24:26 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 17 Nov 2026 09:23:13 +0100
Subject: [PATCH v4 3/5] thermal/drivers/generic-adc: Allow probe without TZ
 registration
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
Message-Id: <20261117-bat-temp-adc-v4-3-14d5d309ebfa@fairphone.com>
References: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
In-Reply-To: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Val Packett <val@packett.cool>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794903862; l=2598;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=IewvetNZMf9FalFWEd0iq4I/lCqxZHq/FLtsO53H2jA=;
 b=K0QTEVwf1uzSjckbKxKpcCKrAkkngarK9NjPv21hTvhJ9thkoh3P+WGons6vpo/CWOd5JylkV
 h4KSZ3LpFcKCi0kZt4zAzExS9pRPsxol5yvMrSY/2FHbt73E/Xe8w2m
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

If the devicetree node is not referenced in a zone under /thermal-zones,
devm_thermal_of_zone_register() will fail with -ENODEV.

Since the driver is now also registering as an IIO device[0], allow the
probe to continue without the thermal zone.

We also can't use gadc_thermal_get_temp() anymore because we haven't
necessarily initialized tz_dev.

Link: https://git.kernel.org/torvalds/c/3762f5851ac5 [0]
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/thermal/thermal-generic-adc.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index c6a7a65aa6a6..b73cd47bffa6 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -55,9 +55,8 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 	return temp;
 }
 
-static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+static int gadc_thermal_iio_to_temp(struct gadc_thermal_info *gti, int *temp)
 {
-	struct gadc_thermal_info *gti = thermal_zone_device_priv(tz);
 	int val;
 	int ret;
 
@@ -70,6 +69,13 @@ static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct gadc_thermal_info *gti = thermal_zone_device_priv(tz);
+
+	return gadc_thermal_iio_to_temp(gti, temp);
+}
+
 static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
@@ -90,7 +96,7 @@ static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
+		ret = gadc_thermal_iio_to_temp(gtinfo, val);
 		if (ret)
 			return ret;
 
@@ -193,16 +199,13 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 
 	gti->tz_dev = devm_thermal_of_zone_register(dev, 0, gti,
 						    &gadc_thermal_ops);
-	if (IS_ERR(gti->tz_dev)) {
-		ret = PTR_ERR(gti->tz_dev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Thermal zone sensor register failed: %d\n",
-				ret);
+	ret = PTR_ERR_OR_ZERO(gti->tz_dev);
+	if (ret == -ENODEV)
+		dev_dbg(dev, "Thermal zone sensor register failed: %d\n", ret);
+	else if (ret)
 		return ret;
-	}
-
-	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+	else
+		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
 
 	return gadc_iio_register(&pdev->dev, gti);
 }

-- 
2.56.1


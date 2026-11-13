Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585901;
	b=Whgq51XctVQNFxQ0ue6iPAw1v4Z6s7L8JKykiiuqj/BGcTNbCjLcDuedRxkp6VGF0O5k
	 lCQLyxXxI7oatEu+Ifa3bk4bBG1OMRvA8PyDpWlJ9oIsSzV+lWkG7VVN+4nGHlato4NY/
	 7igNuf6wvX/gQj3cnKYYZYONGSAPwjRyvwwHq9/wpxsHxpDP8pb+F+IBbIsnQSTJii/tE
	 dj2JuhhtBD5fJnP8doKTNM1hYN3txsbrt+6YoBK8xCjt2rOPoPyrVkSVQXN+GFDejdtfx
	 50+954w2b7BWkk5FRoKOvWsi3htJXXDR7LLb7ydp4PWXqUjXicPO+jRbHAyS0RVpdVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FO0bSEZPctK4SYPQqqbCp52sfheQb98k2br9y1SkDKs=;
	b=GdAQXAE6yiux+6ja9yM7Kmv+0uV9v9Cw2oE9YNiajoef5WUySz9b7a86+5E7q+ibFo3a
	 DmnLcWIjOtX2ufhk/jFHCRIX4VEjLx8QlVmsWTFI/067nEsjHywe4uMFQaSi06NLw2Sjh
	 3i/foOZTsGMONjUR3t/a/LijP3xq2k5HoLrLIxFjqRi5rdZoFOYLZsYSOhTp+Wq0ZaAwJ
	 zhpvoUvB35xLoE8wawKJ09b5mzm7fv16ljrXsCbrz2afFsh5/v0s5O3GQfpLw90wveJB8
	 qPTsrgPoAZNmpkRHP2goJgH94XBLN8+mqH/DrmLQbElu1ia4LaFkDqZQARO9bfX+8SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b="UbcRd/9F";
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED3606FFDA
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 16:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBED3606FFDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=UbcRd/9F
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so2376420a12.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585899; x=1795190699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FO0bSEZPctK4SYPQqqbCp52sfheQb98k2br9y1SkDKs=;
        b=UbcRd/9FwWBdLAt5jyAX8bSLG00aIKvRanBB1yuP9xq1emw0f4SmvcZ8KpwCIjoSUq
         bgEKSheDRaM1VXBBhmS1+aEiaRkNbcxgfhOHxm3ypbyFeXnqUebBrxX3WrpusQjvZlcN
         Qoi13ObKTXUrQdg96Onqr0+BNJGgn8WqlDnl/bqWngrR28/VwudT8Dm302ZpSRkU3jem
         H3KEu9go6LCQSxTirg8LvOvTZFdLHD40dqigtl0xPT4KBKicv7zEhR97Sj9HqRRqlYya
         50caTAqTLqT/FYpXHQZ0Wn5tgKbOTHhheOCW0cJ1LuyiOf5OP1F86TdNjKW+UI+2VPfZ
         vInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585899; x=1795190699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FO0bSEZPctK4SYPQqqbCp52sfheQb98k2br9y1SkDKs=;
        b=1AFD2HZqNZ6mEJjZkqvS+q/tmHme4wRyC/VaHWEVyNLg8XTu8jq0udQo8OD/p5ENJ9
         HfBUsPOSjMeU4F4dpIaFswOHl7UOtDpLa/r+zK3Uo9cULK4qlUrcyo41A/pTq9HYnPub
         iV2Fy7STcthZaF1oocZXuBk6MGUtG/aGAT4cM0VT4sk8SBv2a59nHM7UCY9gLDLe8ge7
         89abYJMSgcrheqSDuV/iq12+1gPEr13s5M7rF14JcgvOzj7081qByCj4u+3oexBMTMka
         tpZJfVPBS4Kpis925fKjouWdQKYwyH8vVHzPNvHy0kr6tPkTQ4m5yG401rafw6jce8Ek
         Ppxg==
X-Forwarded-Encrypted: i=1; AL+hErEgMB83WCCzGOHx29+228CCYHRYXbaxfhC7rZ+Sh0LSdLCrf3ZAqXM8CU5clH0uSaMB4MxIfZTQyA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9PIEe9I+KikFCpQ6HrbB2ZWN6DrM0+/Q5KowBjDedSzHmWxNrE
	TMHiFBFU+H45KZjgMeEbhyyspIwtsRIysf3+7pJ/r/GJwHw6TLrLVGJHZV5XY42MnEI=
X-Gm-Gg: AYBFou3cM9pdKDLRwOfzaWEEUn2j1MstlfQn27JOebKI3naA/59n+yAppsRr7x84HVO
	SPvvuFxo16uPZDoVXvVxrlXVbH6q3aMzeloVRVLLTfQ9msg7XUG8HvJQ9s8xmRp32XGVM/lRjm4
	qQhIiHTLXthN6UI0f92CX+3owz3gMkx3J4GqiNRFPRcvjG3RxGwTH1M+03+x2zU/pcC984buAtc
	FDGeovB+7KusIo3CuxpQHvFVGsmKgfVBdiKH+vieO4EYckx2A+/QyMJJqDGp+gZ2jnUsUHv8dje
	PvMf1IBsLoYJLodBZf/p1BeBOttCYafnh1NDOCc4WkIEkSC/7tHkpSvQ/FAaEExYVio3YhlEnXI
	WQVP8oNrdr6FkAoGvJJi3S4A/QxoEt2OfdwQQdF4F/nYU8KH9hjJlmeWPzwLtjtAHkm4Xext5KP
	4+OWYficrtwLFO2iFbuWlWchA+KRgiXCu5j3O2iE5YxHxiPisEHkUFVOadmjlYXBR+x5U++ZJWg
	NsW6VU+yeJUaFojeUYo16NyPeg3cReX/PqHsfRZIzpurp302AKvlJ3QfCG8vkU1KYmfJA0BZnz+
	3BVNVQvXH8ATraLvnK4846ZcEDlAlmzf2+YBaqW7/1IUuwXSpVjyRAPDY9+yCmHciwdr
X-Received: by 2002:a05:6402:849:b0:6b7:c9d4:6b96 with SMTP id 4fb4d7f45d1cf-6b7c9d47044mr1699353a12.8.1794585899214;
        Fri, 13 Nov 2026 08:04:59 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:04:58 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 13 Nov 2026 16:56:42 +0100
Subject: [PATCH v3 1/5] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
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
Message-Id: <20261113-bat-temp-adc-v3-1-743979a8fd90@fairphone.com>
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
In-Reply-To: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=4306;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Ls9YOP9s76H+ik3WPl/H56mlsU6FAYkwGa/NKoyDkp4=;
 b=R2YRFU8uP5cAi2o3bXqmiSspceyOk5f/xOzUX7K2BBsMMg/O0iMgjMpLnMhrGAQUny70QlwBl
 qtDr/DTeAoaBpRRa50quPWV3UdAiGi4AjIKM55zMif+7z9CRpgHfylz
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the BAT_THERM channels with millivolt as output, which can then be
used along with information regarding the NTC in the battery, to get the
actual battery temperature.

A static lookup table in the ADC driver won't work since different
devices have different Ohm and Beta values in their battery NTCs, for
example a NTC can be 10kOhm & B=3435K.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c         |  6 ++++++
 drivers/iio/adc/qcom-vadc-common.c       | 16 ++++++++++++++++
 include/linux/iio/adc/qcom-vadc-common.h |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index d57ba8526e0c..24ac84580570 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -542,6 +542,12 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 0,
 					SCALE_HW_CALIB_XOTHERM)
+	[ADC5_BAT_THERM_30K_PU]	= ADC5_CHAN_VOLT("bat_therm_30k_pu", 0,
+					SCALE_HW_CALIB_THERM_VOLT)
+	[ADC5_BAT_THERM_100K_PU] = ADC5_CHAN_VOLT("bat_therm_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_VOLT)
+	[ADC5_BAT_THERM_400K_PU] = ADC5_CHAN_VOLT("bat_therm_400k_pu", 0,
+					SCALE_HW_CALIB_THERM_VOLT)
 	[ADC5_BAT_ID_100K_PU]	= ADC5_CHAN_TEMP("bat_id", 0,
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index b03cf584b165..09a13e2b0ef4 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -309,6 +309,10 @@ static int qcom_vadc_scale_hw_calib_therm(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
+static int qcom_vadc_scale_hw_calib_therm_volt(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec);
 static int qcom_vadc7_scale_hw_calib_therm(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
@@ -333,6 +337,7 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
 static const struct qcom_adc5_scale_type scale_adc5_fn[] = {
 	[SCALE_HW_CALIB_DEFAULT] = {qcom_vadc_scale_hw_calib_volt},
 	[SCALE_HW_CALIB_THERM_100K_PULLUP] = {qcom_vadc_scale_hw_calib_therm},
+	[SCALE_HW_CALIB_THERM_VOLT] = {qcom_vadc_scale_hw_calib_therm_volt},
 	[SCALE_HW_CALIB_XOTHERM] = {qcom_vadc_scale_hw_calib_therm},
 	[SCALE_HW_CALIB_THERM_100K_PU_PM7] = {
 					qcom_vadc7_scale_hw_calib_therm},
@@ -583,6 +588,17 @@ static int qcom_vadc_scale_hw_calib_therm(
 				 voltage, result_mdec);
 }
 
+static int qcom_vadc_scale_hw_calib_therm_volt(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_uv)
+{
+	*result_uv = qcom_vadc_scale_code_voltage_factor(adc_code,
+				prescale, data, 1000);
+
+	return 0;
+}
+
 static int qcom_vadc_scale_hw_calib_die_temp(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 3bf4c49726a7..ce037994b019 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -93,6 +93,8 @@ struct vadc_linear_graph {
  *	voltage (uV) with hardware applied offset/slope values to adc code.
  * @SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC using
  *	lookup table. The hardware applies offset/slope to adc code.
+ * @SCALE_HW_CALIB_THERM_VOLT: Returns voltage in uV of a temperature channel.
+ *	The hardware applies offset/slope to adc code.
  * @SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
  *	100k pullup. The hardware applies offset/slope to adc code.
  * @SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
@@ -114,6 +116,7 @@ enum vadc_scale_fn_type {
 	SCALE_PMI_CHG_TEMP,
 	SCALE_HW_CALIB_DEFAULT,
 	SCALE_HW_CALIB_THERM_100K_PULLUP,
+	SCALE_HW_CALIB_THERM_VOLT,
 	SCALE_HW_CALIB_XOTHERM,
 	SCALE_HW_CALIB_THERM_100K_PU_PM7,
 	SCALE_HW_CALIB_PMIC_THERM,

-- 
2.56.1


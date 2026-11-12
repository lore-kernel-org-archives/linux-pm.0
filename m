Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503376;
	b=FVAoUN3B0DjB1jOPsfm9LKVHZUhH8FJJQeyBdF1jsqO1pcnUSubwhNNs8ZITYXCAUPVr
	 +xE9PKtyF/PyNaWQGZrSKCuntpUOYLlxyhJ+AiwUSqC2/P5MpPbwDATxM5G0Ag1WICqb+
	 +WvlK4EoeU8hqikNAYzsgkz1r5wi2MTwNTGykW3j5Qy3xxvvDFsRtV7GrjvA4HzHGOKp/
	 xHFaH/7R/aKaTPxWqdKvSLO1ClQT5cPMmo7HZNPo+FAioh+V3EC67vP5WidIOdO3L6DSQ
	 BfR9VUPvpreEjVQyttYVwQ7E0OYo4+5OOhMrePt4047A+/h6O2EjnTyuJEQQ+1k4WhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503376;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KP1JdI3LAGwl+0wH2rIIsGhgKcmcgw/sG8waMUn76dY=;
	b=Nw5Lwst78xsAnGmvaob1gG+PuN/+ahdfGXlujN5VJVd9AtFEk0DPB3BXZpKL6j+t9IjB
	 NYYHPowxXQLHDuBIKczcMRUtI4gwW3RWb4MNhs50tsCj6TOZlSj1E08GQZdlc6MSNzy3e
	 2cizVX8XBmra6xevd6Pd/GjDl3jatEbl1NZ+AFGaqpCm1H/FOpxHe/1p0jzaowuXA3S6j
	 X2WQmx27fzMvpTwiEne2yfnjZqtmrgjg3n9/v6uMwryDYUUPPOlgUC8pT2xer7onv0M7f
	 Z2EAD6aeXyyelj1KX16lV/BGbyYNPjcZdcnttsI/1t/0WF0P4c/1R7yluau0FpFe90w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=F7eXa39Q;
	arc=none smtp.remote-ip=95.215.58.190
Received: from mta1.migadu.com (out-190.mta1.migadu.com [95.215.58.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD18606A89B
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD18606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=F7eXa39Q
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rHBbY6wUiRXUSIKaXV3BHpBvZUXlc1KXuZaN1eMIdp4=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794503374; v=1; x=1795108174;
 b=F7eXa39QL7GO9Vl2RceT7cGbxLQDZn6LP5mOSTmicdPRyEGQO6TxhvJFh/zlDviKZrDob0k7
 M8wBrXzGlXpx0UFORAGxdjc242BuMTPFoq9XPiIIANfQBI7xZLbd4D+Hi/dwzLc0Gi0DynKrcj7
 fdwIFFYP9/OJeRK3RnodAzHrt0DJ2N9oL0BE1b34kLYtH39zmfBArC34uqAL+djSK389RFD1Ky8
 9DhJPkQsvEKnQCFe3hzQ1ZjwyetLxgncuLV23s9a1kLu963ravg87mXTaOJbKjuYQL8Z670/+xD
 4pPYESEKNwyKHhCBeJvwXWyQd8BtC5bybi2TQv0M1WMUQ==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id be20e513b24f0ae8;
	Thu, 12 Nov 2026 17:09:33 +0000
X-Mizu-Trace-ID: be20e513b24f0ae8
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Val Packett <val@packett.cool>,
	Marc Lainez <marc.lainez@gmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iio: adc: qcom-spmi-adc5: Add ADC5_BAT_THERM_100K_PU
Date: Thu, 12 Nov 2026 14:07:29 -0300
Message-ID: <20261112170841.2189322-4-val@packett.cool>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112170841.2189322-1-val@packett.cool>
References: <20261112170841.2189322-1-val@packett.cool>
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

Even though it existed in bindings for the longest time,
ADC5_BAT_THERM_100K_PU was never assigned in the driver. Do so.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index d57ba8526e0c..c27ff89429f5 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -542,6 +542,8 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 0,
 					SCALE_HW_CALIB_XOTHERM)
+	[ADC5_BAT_THERM_100K_PU]	= ADC5_CHAN_TEMP("bat_therm", 0,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_BAT_ID_100K_PU]	= ADC5_CHAN_TEMP("bat_id", 0,
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
-- 
2.56.0


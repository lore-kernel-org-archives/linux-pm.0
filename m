Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903870;
	b=ZYIrIdXjFDUF9XBWFVXvrZfMZKLdoAxrcV6ZN/HZOWaXRzP5hZ6KqiqL2kGjVqrOn8TJ
	 gaPRBxz7UcCexNA72rTiUv9nSDhcTIPZcPP7KPlnOb8Vvmwa2AMB4j0mojqDIij2CHVHI
	 hY52f6QglyWPalepcFn/hPhggeMAIi5eA4hGnkpIlu6+CInJ3uncuVKPNbY8nK9toxsSP
	 Uig0+yVGS3GaT7nzlW6uN/5tklq+Lern8AOiOPZueSzAnAMFYOTH1PYrA5Y/AD6GMC3PB
	 TM72z9gHqal9P3JwcSa+4ZCitwsK0MsTs7G65RNTTnhZZM/3NCjdcZqWSwcg2oWFmUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=xw3xnb7M3ni/K395S76W5M9HsZ1EBFx8fzPBd64UQdY=;
	b=5KxLsol4KzXIh7NVkaR/JZBrleVCKTRYWTkTNu8/Ogr5ifCCIPCqDwKahA4ABenpSHww
	 rUMbWHkqgdVs01Vn83uomSG0YQ9Mm/YQV0dHZxOku1jg3jDlQeVJIMhjuqDsU+vSu2TnX
	 Zve+5reNv1T8I3YCfKgD1EuJbyskhXYjYeeY66b6vUOA1zwHXcyhQ1B5/VcJx7JW3pP5T
	 Fh0x3BhWc8Z5D83dZ+SLZHC5aeQZP5yrBJqD/jLE2PEiR9F+2+2wD5vIgq8fbnM553AsX
	 mRutfMYuRrW+DtL7RA1RWIGC/P4pHIhNHgKZ7P+cfRuHWmOO619xh/XzNgmXrd1LRJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=SHbfSFnd;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1460A2603
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 08:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D1460A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=SHbfSFnd
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50aaad19fbso345739266b.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 00:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794903868; x=1795508668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xw3xnb7M3ni/K395S76W5M9HsZ1EBFx8fzPBd64UQdY=;
        b=SHbfSFndESk1yY8b/OsbMm/euo3XP110OsJVHrsLsdYSpOY39tPL6ns+z+sdP0oJFk
         khgUnzyP3YKajHvNhpszCJiaRzKRtMHkVX8NHWr2m6xdTSFCkJU4ClvYmgNS47iMqn4G
         MHFIuQFpZCo4vBGjxab09RtA+7HfZ2oVkncRvzSkTZ6cfeuB7KTtE4BuPY3EDJRdjcQy
         rShqUqiojPjqHm1NaYlFFxn4ErPnsIL6rn0ToRgLYlEY44TbdaQYdlDTMUIDSsEtNCTE
         K//0K3ZfoWwvtEJJmfmTtkf3aQ0EqnWbrYdeUoEqBUPRYmpIiWaE/5EELg2nOLU5GFEt
         jkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903868; x=1795508668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xw3xnb7M3ni/K395S76W5M9HsZ1EBFx8fzPBd64UQdY=;
        b=tfjTk2iZKEQIqapV9wc9Jur22ZTpXm+VAVO++p79cRS3WAb16+M9zEAPsSQtDvOkfi
         Sx89catlqGITCkBFmHc8rx03176cI7s1tBYvXwXSUGxJJBBrks/fYLKRtyDKyDSzcWLr
         HTqotdPnn4dLTEVZjkMobVqDiAs2XOBP/gY8IdiLU2rgZ6gG8Rn2gHdiPwf+YWf4+7LP
         svm76UGywSF4BpXoX7ACsjd5nARn60arKwkd8pkBHNR7uKj9abFn2+LXpnqLNnxtaNmT
         1ErG5YWL2aDlG0kTw5YJeYAwaVTbOjg+ChJPc3JXhpKiCYe0Xw9EDwGgXMqtkDe0afv6
         0Bxw==
X-Forwarded-Encrypted: i=1; AL+hErGssnJiqAvpmxiOml7IceZ4Xgzmk62fVKj03YIHGh5XtHtBD6d5QypC8nt0j9M09vJJkIlEjMYdHg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/UPLvebM5eCivr5TLr/UcXdCmx20PvByoh7vNCWXSJzU3DpTSF
	44Ubnub4ga06/OzceU9xpHKgPr31BOKOBGW1BW04qR5rewQfaoo4Kq7V5aHKn526VVc=
X-Gm-Gg: AYBFou2W+RntXYxTgyAS54dScm5mNVXpSEKg4fI5hmOPVfs1EUtfKTrRnIR2GQ/t6dj
	DX0tOJknOSYtNNu/2x81tdgsJzXvOw6R2r75maqN+LCAk+tvXB7Gt41QgfHWSFw6NuaHqGJ6jia
	NoMCb4PA6ilP6xEpWq7TotoWAwtF00PXXgp83uZEBNxWv+jJ1Wd1JEhTKbaNZ1uCT7L2odatWST
	nCf1vXigEIdmD8oJYX1xgI3MbUGT4iRYQHpfcJQYKaWXltO5sDyPCOKysSu9eVI6O/XvxaB0xfe
	2iM6XBjX9chNW0HUF3lZ2EvrbVKDNNhLNgL1jQav+X4kO5uMwwkeB7h+axmRxeLQKB6ZIf3e9+h
	1TSs1j4Cp/bAeCKksX8Cz41bhm55qnvnrIX5pV/wn8wZan+VNwkZIPR8CHN8Tm0alHAVvPS32FW
	ICnQ7/m1EzntylaEoD0zAxmWhZY77+OlAs+vrCnGDBjQ7VFcQBSwMzvgA5ZJ9K+cD65bKixPm73
	RTa1xtX6plmwa1YhCRxKWyDFPdaF34WGQl7wJp0Y2mjYK23BSVZ+NMv3XFTYdyuCjvnH0voeKWQ
	tuPIshH7dLKrkVkd3rlo9EDLkAaSav0EdRWm61zpXCEo3gb1YJF/OjcOUR+40C7jOq+Phv+TUK1
	KLtcGuvNb9rK9We5nExNTqeq1RAOdZOfJB5pEKWNmzYkToZ2V
X-Received: by 2002:a17:906:7315:b0:c42:fc8b:6c7a with SMTP id a640c23a62f3a-c5096550449mr1132986666b.41.1794903868527;
        Tue, 17 Nov 2026 00:24:28 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm5616953a12.9.2026.11.17.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:24:28 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 17 Nov 2026 09:23:14 +0100
Subject: [PATCH v4 4/5] arm64: dts: qcom: pm7250b: Define battery
 temperature ADC channels
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
Message-Id: <20261117-bat-temp-adc-v4-4-14d5d309ebfa@fairphone.com>
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
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794903862; l=1412;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=b7mnu5CgjN796/wKAPryTmfFj9uk8BxPsgl2XchGimQ=;
 b=IEavwQRoBZ9J/7BaFptQKLVBcbOzlROC3o7elEG/KJxaOX+vWhvHEkOrTZSwFs3fttmOJJc3Q
 PHcebENwoAHAURwSzKsaLbonycN9YknjNtC/PDT1eB5SmaSrhF3UTW2
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the definition for these ADC channels to the PM7250B definition.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 43cab07126c5..91e83587adf2 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -155,6 +155,22 @@ channel@1e {
 				label = "chg_mid";
 			};
 
+			channel@2a {
+				reg = <ADC5_BAT_THERM_30K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_30k";
+			};
+
+			channel@4a {
+				reg = <ADC5_BAT_THERM_100K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_100k";
+			};
+
 			channel@4b {
 				reg = <ADC5_BAT_ID_100K_PU>;
 				qcom,hw-settle-time = <200>;
@@ -163,6 +179,14 @@ channel@4b {
 				label = "bat_id";
 			};
 
+			channel@6a {
+				reg = <ADC5_BAT_THERM_400K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_400k";
+			};
+
 			channel@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;

-- 
2.56.1


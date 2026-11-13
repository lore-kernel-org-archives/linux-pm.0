Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585906;
	b=x/T554LTQeB6Ur7c0TM2MCdUbftHFCCwidJo+hGlyz4aEESZsDqtvXCOZLjO9vvBYq/F
	 al74z0HP1oc7JHNd0GVMy5gJBAW/4hKfO2z/7kLOm5RuDjB3lMP8IXkl4N5ROqNtptDrL
	 SMFBmE5acJtJH7YYPmhSmqc5byQ+pk2hLTU8Hpa++QJXEY3WAYzUI7sNS5S0frHOMmrDN
	 9mQacgBqe/ylZe7uQIKcY4dE+0KHU1RQuuNP3xv1c0Pj6NSO7Og1Haa9LzlyxYuIxPxnn
	 1ktvkm7+6gA7V9filM5xFW0SVfx+MSFoUuWdOjxf05KR1NK40kUcZaT6At5UnGpfC+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=7Kw3jpXIq4jFZtKzMcPDKxBZyvXYg2GOy824z751lHM=;
	b=czDPUaQ7B2Kl4/NotRUJtNXijlVLZLwpEUwl8BjCxNXQEqkY1wNlWokpoGYeEKQleN75
	 Nv2FwmNaBUQRF+U2xZgndGxOg4xQhcLZQhZlzRj5KAgzRuGfMDH9WlzclMa2dUaYQkoZH
	 2357FswtmVuqKCv0j2wUuGTBd9KpGqmAyanicPfIZ1eOg9vChVOrqmxBQerMGDfzALSDB
	 xgUcDsH3v6Zvqm1P74o6uXZOqD8lwvaRAipMkJE4fMeai42NPrtGVdF8LbDCSKTO0ybQU
	 5bGSYkYMtrbZxUCD1UpRSQkOF846AepV38zY1X8eNDMkUgZCSpi9v5LBXD6udHyBPsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b="SOb/xgQc";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F2607620A
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D2F2607620A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=SOb/xgQc
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so2200485a12.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585904; x=1795190704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Kw3jpXIq4jFZtKzMcPDKxBZyvXYg2GOy824z751lHM=;
        b=SOb/xgQcyJqJV3fKqjmRGGbJgehdAOrhA3EbTniYpSFN9VG1M8/QE6f0G5SaWLB67B
         wX3cksYY2S+OXmZfAKrm8S8bm9fssk/Fd5med7zF1L0uhNZbzjHhV4WfOcS70B2DmX4w
         MaOdUK8lcTnJ0ABUJzCvWVLoRpVNd0U0vaEcEV0JlfPZy+HDNcjk9VG5yr5GCHZPdcBi
         tVCkSDlzKAy1dBv9LaTKGzdR+x9fwiUA+4Ekkz0C5Nqb/re+BZ4MMule3tszbeJ2zRXY
         SVBlR96YUFt/di8TxXsZRllTLOy+i9T5HIfJBglIHabYyg+5kJb7RjoYoU1/9WHf1WWe
         MyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585904; x=1795190704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Kw3jpXIq4jFZtKzMcPDKxBZyvXYg2GOy824z751lHM=;
        b=mHIj5vlAIQlqnyWYcO+cwQhyCgTAKHDY/Ryz59ssGhMn5kaFKfWqyMmyiVpstbWSAQ
         1Je/SPOS1jLOsxTX9Sg3TCpSILQ9vhXoWF3xi1LTA6OBGgI3/M+7+v6OA2ZECoDYZaQ3
         8gCnTcNrVuRFCVIoRBWIJ83flj98k0t4p99aJKc/XfCW6zV4FklxCA2+x+esJK8Y2Nn5
         H6C9r+hJOMQv28oPAAVnefcKMuQqs0eJdbMUVY+03ryg22Sz5KFfRPT0QAjrQ1JfA8w5
         D0wDPoVFsby59J3Ey6rWZr3huU1sa1iucL66EfyaoP36D9G68wcJmKbAJej4GxXPm6ql
         wbmA==
X-Forwarded-Encrypted: i=1; AL+hErHjbXRbqMk7CxN59M6Gv/CYbnWY/G80HM01LONOneGbBjQ+8L3kR60aakSIalrcP6eTkdnisCPECw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/rWoYCaRmqdn+iZ04dOsaNTr5FxIJUw4mJz4BoaoPH3ToEF+m9
	KYCeHd55oEt7MsRiLg4YpnPr5f7CKLudBA5SqB/olbPlsMlmUlHWOvJxwZSLEtgB9Iw=
X-Gm-Gg: AYBFou07KUbIpZIoiHen9JadaB/Ym1/3Bt6rq/IuE4uibOBLMu7MZ6qYgYarzh6j0av
	aA3kx/ElTfl8OMqw3679mCsUuw+6mRhY1047tBrBnI2y/9HEou+2R3aHDp4neI7Vj9hzbqyzY78
	xOvd90kgBi1293SESrfQ19Gsh/+1Y3spcTCNQSPXB1LPa8sRH4MLuYZ/BsPGn97H80Eax2ab3kw
	wTRcK6avMy/rQwJCDmUEoJ7FZrx4BJ+BBK24CKTrhEOYxS9J8lloWTqeQ7peehfVSqUY/uf+EQf
	0Pe5flo9wRCoXU31pab46f0GEKC+OowUIWJM3EKIa4XsHT8+aihzLjmw3bHPH6B7gZLE8Yeoie8
	16wQV0F4f2cIElUJf7mhyA7zt92wZ1Y3IwBH9qAHHz4xiCMbVUhzmMagj1y3nw9lWsPd0TRSq6X
	pV9Uj49P5wdMWXO0hRQwdufvdW3gD7zMgHGIkvadB2qqTsGm7nk47u5JdxcfAobyp1AaQzE0EsR
	Jcy3NDDudtiz+RvVDtlltoNHfOxEGy2HFtAxxTO1KcC5XhDvolLm9MB5S/r8SlsbI24byU7g6/o
	76g75grCH7TWzYQ5b2VNyEi+45jiteENwm7KGfvIDOhfiSn/9N2t/BA1kkhYrw5Hr2yPvL4q12S
	OFClYaS8=
X-Received: by 2002:a05:6402:222c:b0:6b4:d1ed:95b3 with SMTP id 4fb4d7f45d1cf-6b7c0d200eemr1933559a12.41.1794585904556;
        Fri, 13 Nov 2026 08:05:04 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:05:04 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 13 Nov 2026 16:56:46 +0100
Subject: [PATCH v3 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add battery
 temperature node
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-bat-temp-adc-v3-5-743979a8fd90@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=2551;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=BTbJE+uVkaO8/e9NHFNdcxadF4slrFM2xvgSTnvAGGo=;
 b=cVBBAj087LJNnomjguZpThneLwRiRu9MSVg4YxOXarDvVQijERMPCJyr2UsYdSnMUUXSAZRwj
 dA3YJuS87CcBsIa8XButhSk1nsJGHUrL0+mPVI/KRuZHfjefLVspIaC
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a generic-adc-thermal node to convert the voltage read by the
battery temperature ADC into degree Celsius using the provided lookup
table.

This will later be used as input for the fuel gauge node (QGauge on the
PM7250B).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 +++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 37aa272019cc..0b8c6f353f96 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -96,6 +96,89 @@ memory@efe01000 {
 		};
 	};
 
+	bat_therm_sensor: thermal-sensor-bat-therm {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		#io-channel-cells = <0>;
+		io-channels = <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
+		io-channel-names = "sensor-channel";
+		/*
+		 * Voltage to temperature table for 10kΩ (B=3435K) NTC with a
+		 * 1.875V reference and 30kΩ pull-up.
+		 */
+		temperature-lookup-table = <
+			(-40000) 1673
+			(-38000) 1649
+			(-36000) 1623
+			(-34000) 1596
+			(-32000) 1566
+			(-30000) 1535
+			(-28000) 1502
+			(-26000) 1467
+			(-24000) 1430
+			(-22000) 1392
+			(-20000) 1352
+			(-18000) 1311
+			(-16000) 1269
+			(-14000) 1226
+			(-12000) 1182
+			(-10000) 1138
+			 (-8000) 1093
+			 (-6000) 1049
+			 (-4000) 1004
+			 (-2000) 960
+			       0 917
+			    2000 874
+			    4000 832
+			    6000 791
+			    8000 752
+			   10000 713
+			   12000 676
+			   14000 640
+			   16000 606
+			   18000 573
+			   20000 541
+			   22000 511
+			   24000 483
+			   26000 455
+			   28000 430
+			   30000 405
+			   32000 382
+			   34000 360
+			   36000 340
+			   38000 320
+			   40000 302
+			   42000 285
+			   44000 269
+			   46000 253
+			   48000 239
+			   50000 225
+			   52000 213
+			   54000 201
+			   56000 190
+			   58000 179
+			   60000 169
+			   62000 160
+			   64000 152
+			   66000 143
+			   68000 136
+			   70000 128
+			   72000 122
+			   74000 115
+			   76000 109
+			   78000 104
+			   80000 98
+			   82000 93
+			   84000 89
+			   86000 84
+			   88000 80
+			   90000 76
+			   92000 73
+			   94000 69
+			   96000 66
+			   98000 63>;
+	};
+
 	msm_therm_sensor: thermal-sensor-msm {
 		compatible = "generic-adc-thermal";
 		#thermal-sensor-cells = <0>;

-- 
2.56.1


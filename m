Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903871;
	b=hDNXW78ViTNyEYRT70PXl7eHovTS2ba/Xo7hupnII68Q2Rls7+kCcLs4sUBiXB+ZZVej
	 vUynILP0cAlH9BkLtVgEIw0iDD/HQSHzk9iY7iqDUS/hPk1HFsgvth7ox5aUcxv3UFiPb
	 UEsTKBPBppLi2GOJxivdIj0BcrKYaBlpadXgKM2Pe1O3g/ESIvy834sc9ZOkz8TsB7hMb
	 uKRBCb84Hw68i58EYLM3URVRWDXONcw7GSptMPsQVFncMYFBAaSIn7kDja/oQRlBb2v0x
	 v3xECaKssQSWhXRgpk0ioY4oAsfRk7Zy7pAWsLV/IAfVobDVVyQQGA0j5C7RG7ivudA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FIAdVkEWa+YKpNqjyEpkUHZm+KoAzH84s76F1+g9tmo=;
	b=ntwhDlnlL+m9PNASr98qexeUq0bHFacZE8ywBZlT/hvsmrtEZ3n+nPLLGnlcYVxdTN4t
	 z35eZM95Os4aEJ/KuDwbJctHTnBaL/c/xVJGVCbc14DYAFxhGEEmGn57B4H5tdZ0mrXDR
	 GR54e1E6I3/axcZ+pw5K1Ncx356ndfh3imJq1thHCTLKxAcZaQRGQZ2gb0R55MeDjPd/w
	 scIXlw9XHbMVDzNkf319t4ho+rBah2pbbS3FcMM3/jOsUJeboXPCbpVmoSTjxC+eEohgA
	 TkgCeyUDR/AA1rG4EysclZFjsLKEpUquoT9VfdXcfUdwA2VDiGx0YNV3mPfk2slHNuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b="m5rd/aHW";
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142E606A89A
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 08:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6142E606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=m5rd/aHW
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b571979178so6724548a12.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 00:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794903870; x=1795508670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIAdVkEWa+YKpNqjyEpkUHZm+KoAzH84s76F1+g9tmo=;
        b=m5rd/aHW4x8+LC4Hoff/y+voqA2dzKC/QkkgsLWsQFHr+HtEIpj0YzM8GS/0DT4I4/
         gwV4XFvMdtCFyCncu1foTtxnDag3pLIodRg9GKg4EOvngWrgE7sZf/xsl6V+6Ap5bEyj
         IfqsLVRwRZ3PRMZAO15NX/asAngzwzq9p1KuCe5/mpybyPr7EGhUvziZOlA73MmTyKbC
         C0w+7/iASWvgEdcoZAcQ+u0CcLjvDSlVePv0LRLBtM4mwr3FChD8MUkxDKZFSxIvNkyy
         vVEs8Kiu6GDR0RjpRDwnNpojC2/T6aoCDk0SEKATRH5nXRiR+Xqd4hY0eQczVQSmDFra
         uDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903870; x=1795508670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIAdVkEWa+YKpNqjyEpkUHZm+KoAzH84s76F1+g9tmo=;
        b=oTBl7UKvj1zF6Ap4bSNGrdxfWKSMV3hRanyVnGOgyNjXCipvViqcFdXi2fne6jRQWM
         FeRy+sfvkKWfx7WrxBJUSW130BOBwJBGSDb2NxJubBOPXGtucPs9VxilnC5iOgI30SrO
         bQWhp7vVE96Wj4moriCjN7JcrxMEIDigZIS6o/YGnvmIGNmCpueTlBoUYM7sKei1jiR/
         8H7a4sMBV9rjOsHQlWyp+Y4IozCSPn1TTgyGHfjpaeWfRVpeT75LhPQNWt2sL0fD2Xaw
         ch0Z7x2iqA0zjfJHAj0p8wC6JvnvrrT91P/BV5OjsjYIf6iDXCcFsZehfnNdiITVYwGu
         Qkhw==
X-Forwarded-Encrypted: i=1; AL+hErHmXW27PfBov7iKXxB7nOZn90fmV/7Xa+ukSwDj65AKXpohqeGaoO3PJhHxkl7+tPMK4PcN76uS4g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/DZzMbYJWh3vs+kXrgttcs5JcfNpfoqCLH62FaFm7v4nTybYgu
	7UvSJGOWAPMbFw+tilfAxtc9s4P9uXRBVv1PPgCmExvcbBQg4Kgvzo38aJ9uE9Rmrxk=
X-Gm-Gg: AYBFou0VQpGNTXDJQrlicNaSQhfZ0U7PnHuJpljgDoprEMMo/2zUPJU2xx7+E7olu3g
	SH0AvA25NoSgEwqbkce6JslevnmlgiNDak3VKDbYKZmTKDsg2mWv4ccgTZ3PhAyxC5pybL4xrJG
	XWh9MbTPC5fAH5M1wLvw1EfnICOh1/eA40CM5EyXVHjjA/GyNY/+egzFSED1YH2MT4ROeC+ZGbw
	61t1GUSqaJigTCvbNSWDy48RecYLCcUUyPSPXewfbFe2f6eogtkL8cMCxb+zNTUXg4Iq0WGwlFd
	YeQ0tGVSYVDV1o4KuskFRbOjNwyX3qeiq0jW7BVpVqNqNegNBVwZwyuSsrB0aLgKq6g8u6mM3aI
	JcXU2OeTpYMwwi4TqgroCAD9CWSw2BpVSn/0gcqPp3xqVAWSknRiV/cFPA6Pi0yY9G6Miu0z5du
	3cBlFuOxC+ISDj2995qcl163SI4eWYUpW1IAp+uQuy6ifikER7zxiZxVlBIOm0Dv07SjOOCKSX3
	H/SxKgE0+D1dbLSY03+k+8P7GaxT2xNH+VIn08uyCwTogQ1AKj+bMeYFigBjOP/WZeKcxN9jHgc
	FUQORIljIEwNXDvSinKll04aaCeND3QbQU+rDcj5Ofk9WcokhxPEpzTEcLOkKmrHSzny5KBQWRp
	K+141ndY42POCIWzl75ejik+C+T+cuAZX0u79pu4sKQsgextB
X-Received: by 2002:a05:6402:4349:b0:6b7:cad6:a020 with SMTP id 4fb4d7f45d1cf-6b7cad6a0cdmr8624241a12.8.1794903869734;
        Tue, 17 Nov 2026 00:24:29 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm5616953a12.9.2026.11.17.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:24:29 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 17 Nov 2026 09:23:15 +0100
Subject: [PATCH v4 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add battery
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
Message-Id: <20261117-bat-temp-adc-v4-5-14d5d309ebfa@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794903862; l=2686;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=UM7jmORMPxSdPO1xNc3zcibihjU+NS+ZaaeZNpYbWE8=;
 b=bSCoKLweeKiJ1WF6rrWxDJ5PvVPJnM1jcFj2jNkvwbajxykkdKa/8c/FNqE+qSnRKKtFDBFZe
 6H+h7QU7eoJBq1AUVzYpXMfKx8YKghowLXcfI8OqIxgz9zMVaz1nDYE
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a generic-adc-thermal node to convert the voltage (in millivolt)
read by the battery temperature ADC into degree Celsius (in
millicelsius) using the provided lookup table.

This will later be used as input for the fuel gauge node (QGauge on the
PM7250B).

The lookup table is generated using a Python script:
https://codeberg.org/lucaweiss/batt-ntc-calc

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


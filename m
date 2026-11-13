Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585906;
	b=ELcx0y4OkybrdP1i7H/Ow80AgjFoxC2WTH+l9dfBz20UcajgKBR4AY2rWZywOUNV7RJw
	 XIV26S95ilvR1hyoV5j16Rzg4YEHqXpiiXZFzFu+kkHhi4/kpXJUXHE9YZ2+cQc+zl47n
	 c5jmLCFKMPIHJkiHNv4l8ipVan01HT4HAN65dY3tiuhFMa//M6Pb4oDCukxWXjR919AMV
	 NhOB7qrGw7Cvc3YXPXEs7MK9B1z1B/FwRFKmlY/ucpLl4STBl+sOYuKYbFiaNlztEKT5v
	 vJz2wDnSo7wJgIlwlxqdFVr/OKTLmlxxNkZUPwY9buO2gdURtb4ZfF3vsISMpbnXkmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=xw3xnb7M3ni/K395S76W5M9HsZ1EBFx8fzPBd64UQdY=;
	b=3ZkhEG6HZl/lyK3lgNjayqg1kxxR753k4DmPOGJvHth6temNYRkc2SpKGceLmAdarPeM
	 EL1jxOUJIpmzHxs1suTYrr98UYvxjtLiPw5cTTA5pABeZa0Bqu+fGHkX+J5SYMUfGB4uM
	 iGzjWgZM0hy2nwTy8z0y1uYsf0KEi+3ypATR/RbFTVpgicbm4zSciMikA418JdGsqUb/a
	 1/SqO493iKvMP3mK4e01Ci4NYS9dbMe9pCQ+BqjkBvGNKRMT50LIyx3Zytkqbd2M5i85x
	 w4n7AV5hFXSz/U1WX38fqQVvp2B+8ajpQYeJ38X0Vh5DS8nYRY3a3yBBWw0Ip2w3lRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=CsDLFnXt;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B895606FFEB
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 16:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B895606FFEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=CsDLFnXt
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso2265773a12.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585904; x=1795190704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xw3xnb7M3ni/K395S76W5M9HsZ1EBFx8fzPBd64UQdY=;
        b=CsDLFnXtB3WQ1uRAtL8aws3SolQHAtawncLSuzZPxSkA+bkQI1GAq54XPJex/Ud0wa
         EKWnT7UnEAVaqSpnyo32Ah/rEBa4EZSOOv9HFTpYrKnAHHrMrFRvbXVX+l/zeWSK00uR
         cyQhJpE2bgjnpBr6UKRN1a2QuYXr15PO7++KJLHnTIf4ZtGjlMFN68qoP4H+j+lT/kIf
         jqdG+IjYbtGtMwJzN5AaX31+8wOvMxnMu2IdVCLPO/xrb3qg7HNBi8Hsy4Q4gXuwTdwl
         JF7s93f6rXH0EgrcPxwC2lWZygZuw9kytyklugU2pHYTmMHAj4xrfTMrhfrtwxuJhyK4
         1qVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585904; x=1795190704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xw3xnb7M3ni/K395S76W5M9HsZ1EBFx8fzPBd64UQdY=;
        b=DerPe0PQjRLMswqh+pgsAgND7IV8D+CP+AEqYaVq/U42CdX4Oa+CIsPFebN6ipsxuq
         NB4k0CuMcc9Q2EWwjhimid57BdDc69Hjz/TBAjRsWMSPM+2L5fgLZXy7wI6Gr1QwG5S3
         fMmNfAIhP3Z2KIwGJFxmJPas/rBrE+OMKyf4OrSJSfwT3xAps0IUed8JYUvWQY9cSYbE
         5XUOjcnPQY5/z++vyN9gijC3lu2NuSgkVYsAtU8lTwg7tQ6yQSQtuQQnLiPmMZ9DSe92
         6UArERHgtSNhnE5uICNwPXmi9OAfOpsL1pe2VpfkKoa6zkMLPUpzMzb8LsZ9+JASYGI8
         ujSA==
X-Forwarded-Encrypted: i=1; AL+hErGfJL0ztS68Fbga6NiKp+gPqV8U3x9oJ42VFh2G5mlcDMSRG0LaeJIIunZowu67aQy+yO2PKzu80g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+E48jatLs/cdbEcJ0kcZGhHRGQYpU67QqyruuYoAd466dwPJoo
	bSUV6ADJoK5i5shARnccTZPsFerfvC5Z0slHk3YbNDban8tQJVk5sS36xp5lgQmlzUs=
X-Gm-Gg: AYBFou2qma/ZP10U5VnmKjHQtTW0LxdjFyQgUEogG2dcOGATROxo8RIb+gjzqsFVeNr
	g9KSqguiXqRnm4Fm6e9jyPVeCP9xKKSIXwkwCJPUeg97EoqJj3X7TERGUOYga5NKg8mzbdqFvHE
	hX9tgzwZVPjGvgHlEDpUOakQ55zG/d+PnX/QfdJTcEiLeEfXCCM1uOVaH7bDBt0AJ7LwfmkubRs
	a1njpByBNtjVObnA+6pX8nCjvtgvC5oQkzRBrOvC+qfVG4b0oXw3GtEWLb/Oid/8TMvnF1WlfKs
	WkdHrJ7nAnvIRuE0wYwfnASi+IDyFzAo/waK2o6vaqk/oJ4ttcUZlrZPf7q6G2QaXwvBrHBkE8U
	yjUAsMNbK6ljys4ww9HNFYvoA8LcgBlapoy4Qe1fJkggSQuBTKnWvQh1qWVOQOZ4u/hdJH5jmhf
	1CpefLBYYxMe7ia/hkL5RuRcI66XutiwkOtmJz3G1VeTqdSQWDrSMe3fToKiESLPC7RQKX11wyV
	i/1SNzVb72UmYJ8PM1EcbzPxBznzV//u5KFXae+0c6rW0+dAporzqM7YLSIxJIA5fSwUp6G94sI
	7rAXCDmbp4PTrv0woRw1ftgx1kgMSRyhVqDuGczLYkzms8BoYfxEkKExSgvLDJQGhiJfKehEU0W
	3sORkP50=
X-Received: by 2002:a05:6402:c4d4:20b0:6b7:8ace:4bdc with SMTP id 4fb4d7f45d1cf-6b7c0be5dc0mr2076346a12.29.1794585903767;
        Fri, 13 Nov 2026 08:05:03 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:05:03 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 13 Nov 2026 16:56:45 +0100
Subject: [PATCH v3 4/5] arm64: dts: qcom: pm7250b: Define battery
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
Message-Id: <20261113-bat-temp-adc-v3-4-743979a8fd90@fairphone.com>
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
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=1412;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=b7mnu5CgjN796/wKAPryTmfFj9uk8BxPsgl2XchGimQ=;
 b=39kPDo0KhTsrVvnjKB5C4HJbyboZEw6GYyL3G45auk6/fdnDjvSVTwlOddsdPKaBb22KYj5re
 PV5Oqu4IxGcAOs2aPblfI2Ry7nV+J99UGRYwq9dKkZe/+PFdMxVRJ42
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


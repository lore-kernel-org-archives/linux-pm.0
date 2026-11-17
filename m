Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903868;
	b=zDrizChwNR70UX9NgY+neRSe2JEPIYhFR1HdMRwLaW+5Oh7CzpqWbp82VmrEJFGeYbDq
	 j4m1Kn1P3U/CW/uPRXnT6luZt58XwLJAzaFxaT66gXTR9Yt9Qr3/Ymx7dpjved04Yyh0J
	 e7UiEKDwqX4dtaDnnB4moueh4zk6GzwxH1qWoftsENB3l5wkZeyuhwdpPBSaoM6d2jlOP
	 vWfLMOs4x/Kre8cbNOHJq+qHaLv3FM03XISiveQq1bzGaq39I+HvszTImuE0ZqtYdcWOF
	 ZGHOJMM0AASL24aT56Ee0JaA/h7FdoNPI+XpC8LvbTBKwVDFnEt/2s/DICLunw0aUzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
	b=rLXTQBMkgf8llrKqQyBY/WA6Pav6K7aSW5kNsJ+I4KFttyEBOQJ3cro8w+TteSgSBCwi
	 v1Vc5Jaez6gKbBFrEfiD4CJsFJ/w/zkfL8gC+VDULM0bM+Zbu3VN6YCoInzz2lINp5KnJ
	 kbFvxRU7cdOOY1dtaW0oqmLU1lOiWzFBbyaahPWokLvo00vTZM4gx3Aee2HubVY/bemie
	 XWawk5W12P8nX76k33wf3/yTLX9OsU4hl/fP24Vjb+dRi7OdrgfrHi2r6wklFLRHGpmm6
	 WOEONy9g71lR290+MRS7QDjCeNaJgLxaplaQ2Fkui5aMsKdyw4Fy6jVxPE+LywVVe4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=OOSmJG84;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF90606A897
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 08:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF90606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=OOSmJG84
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so4986736a12.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794903866; x=1795508666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
        b=OOSmJG84RijGLublSYWVTMpImlN/WVaYVWH8oU+ddcnl85mJ/nXFQyXqkaCNhDH+47
         KhPkhKvIgNqhs/kM6bF4Bjnb8RAXPDNiq+6SRu1e4EJd5VM2sQCBSKFGSnfCqWk9sOeV
         MIVJpk5h3nFj9f/1YrTEHJMEXcWrwO99d/pZ5BtX58KFjfbONFw225vcTxt9ec8AUS/y
         2axT99gaXokVpb6sSCIlV0RXDZWOkSp2aDJuhAZhA3KYRVANLXZ0bHRnUjRTl+KsPlKC
         aKx7YZKcZ3YEuWgllL/cLAeG8Fp9dk+/dWZQ1/7ZMIicNIKl+4smwKMlxNp6B8uf2lWw
         hoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903866; x=1795508666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
        b=Iwfj2ASLVbgP6bYxWfMQrv6hcUkgJX7rDS8cnzAA8mao6RYptAK+xZq9n419824R47
         90Cqs/OrgkyV/drerVm89BJFAhQACBaqvK2Y8RCZtXYH3Ijy8osEPjXp0/IcBp/swboR
         GJVDhZPXb7Sf07/gb15FK9kY88O1jHN497yykSbP0MZQQrqnBCwtqvrQtNKbGlcVD+RT
         Rk7vKw0oodK0AfNIc2AOk877Lv5RJLHdHBXW4Lud+UWVl0FOhi6DLm46fHyOZUHxxVnx
         z2vVM28XpbQT5J5STLEpHm6heS1AS1EFpReXWOFAju9ewjgjPMWvFGI5iNZekWYmMs0T
         kqkA==
X-Forwarded-Encrypted: i=1; AL+hErGGSCpwGF2sDdY5vSUJiWTAniyiaboSEXRElph0e77OL5x3NOdrIP511+868S1uPRG8R+Ax5/iDFw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8o3K7SNB3ZJLONIpbVSvlIBtem3FC4bHJTXMRRMwdy9EZ+MrDu
	17NatCAnPBzxzhrJnCj4f9u0xnnyFk2ug+mKQ2Vaqh03UcSEnA+C6Jdtq30xPj4l9O8=
X-Gm-Gg: AYBFou2PugSCYrL2dDMZ09EQ+VoyL4soFg7U6/LX1WmV2enjTNwWvs/4DuW8GP5yePd
	E0uXFIdTqOSIxP+yTnveIMKox/4iVAOUrayVnOh9zlQi9EtBYtU6ABoEzUBgYgT8vUqtSES1Vor
	9uYyev8dGgWbR23YFt7bId0AeFqY7fPytTC29dDxGWnl6g0MOAswhhKw24ASG14NBK7WGfdd0lJ
	yuU3GQV03viMs54NnwYwYcBTVx3UerUD/wH2Zp9hJ+32jho9DvF7Ks448xnL928gb3ot2Yp4Mfu
	jyFsRNXcB34Oavf9tsJJRgEa7DR1EmP9n+HKY+mz9ZS+t+8iAE1/6u7j1sy3gxhkIANNjCYdqCH
	QEy9MVWKKndTxedy5rzX3AgclAJTCiKfemnIke4BkzDn09N+Zcb3TRRyAAih4XxspwumuoHQA+J
	A6nHtiCY/6Ur8ilGFTWdU9OueYIYdwW1U9DzS9HnJ09Iu6oQH3x9/PxUE/alUQ5jcd7PjvDNxfs
	dwEXCd9SUMcPUZ+DQWlTcHjkjTuHBAT61IU26FYO9qoz1PKI04UrAGIiT/zwYmdhYJ0+iWyzWuD
	A2LwJFWv026QLedUaeZ7FZ+9FF+YRx3UxrxVpYyPfdmc8S0kp9Mjnrnk434/2VP/XS4lmn9+GgB
	s8mlIltRlT740BzhHuoEMMQF88Keq9bfmPXyW5PBUY73p0oSe
X-Received: by 2002:a05:6402:210d:b0:6b7:9ced:824 with SMTP id 4fb4d7f45d1cf-6b7c0c6f70amr9699533a12.26.1794903866141;
        Tue, 17 Nov 2026 00:24:26 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm5616953a12.9.2026.11.17.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:24:25 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 17 Nov 2026 09:23:12 +0100
Subject: [PATCH v4 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
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
Message-Id: <20261117-bat-temp-adc-v4-2-14d5d309ebfa@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794903862; l=1375;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=I/NJZJX7ehckBNBNEstT8hdZRvbJ5dgDjnQjjzYNTLs=;
 b=Va/ZiG9pLV9kgIqnenCHkblc6VfgP1Axc4rzf1uTf/VYu24H6meIDJzjF7cPq8pDHyZN9T6da
 Mb3xtpa7EcBDjzIwW6JQazspouxo37NOrWeZduY4MV8OdBzf5BelcoA
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the property to allow using this sensor with io-channels.

This means that the output of generic-adc-thermal can be used as an
input into a different node.

As a specific example, generic-adc-thermal takes in an ADC io-channel in
Volt, outputs temperature in degC, which can then be consumed by a fuel
gauge driver to provide the battery temperature readings to user space.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
index 12e6418dc24d..317fc39ed46a 100644
--- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
@@ -24,6 +24,9 @@ properties:
   '#thermal-sensor-cells':
     const: 0
 
+  "#io-channel-cells":
+    const: 0
+
   io-channels:
     maxItems: 1
 
@@ -58,6 +61,7 @@ examples:
     thermal-sensor {
         compatible = "generic-adc-thermal";
         #thermal-sensor-cells = <0>;
+        #io-channel-cells = <0>;
         io-channels = <&ads1015 1>;
         io-channel-names = "sensor-channel";
         temperature-lookup-table = <

-- 
2.56.1


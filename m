Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585903;
	b=YEliTxN0g4cLAE0yrOa1EEwTujqVf5gkwTnpCj4oWD9fApDS/F2SAjx3G5kGg9II2tFL
	 vjLLaitKFANk7lEyigx2wgv/be95r7s/8FL3KkAIanp2OMmjRqP9Hag0BE8iLN7l21oCT
	 9T9rqJCdObHmycqfmp8rku+GjS4kP6t9XakXrdYvUVh3dzxTH+vZb6PGP87Nu/W3HYR2a
	 YxtVDyT0qysnZi2tTNwD/0Uaj1ovt3S+rzeJWFd2mLi4EuBhJ1MFjgPAWoPTAgHLCuHJp
	 xd7nPySF00/xeHunh6Bg4CHgfovCXXLyhx0SnSdKm2JvE+62YtZNbNL9qibFuGn7AqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
	b=nehSAUU6h5iAZVGPEFSfsknNNyLbbPirgWTiOGhpQyWH27/+2rpOlqZDS7mFI59cKtbo
	 6aWtog7dyAnIrWX7W1SUf/1STH41aToYOKlGI3CDGp5Wt5gB/YL2zsGzH8q79IZTCSGO/
	 Z0f8e5tdiRd9xPhFv5DTvDfJiGV8arqUil/vXSnDQQ6dlIRsca33yVR+zlsEMMI77Dl7s
	 +ZWnwiaecjiYQmKhV6tGWBMfIT3wHQGZN6xNvu5yCl4heA1Mo0pviVGh+VdRh5bDFDtHX
	 5Gu1ReDY+LyH5IQ7jmtyEA6c5Hc7rSuOg4v5HxA5NB8mvT6BpfHcCrKWSf0/t2k6OVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=NXWuRo4o;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD03607094B
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 16:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CD03607094B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=NXWuRo4o
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b7ddb99db4so194619a12.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585902; x=1795190702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
        b=NXWuRo4onYFiw2I9QVxX5OPcgg0tUYOXHsV+WLZ1UsLq8W44JTs5HZvfoNvfPYwfqZ
         aVOf4cZpXSmdau56AKXJsV6WLFeanx3/L6Gy6RdjXG+kl/zXHoy4cJaHlVW/zPs9kBuO
         oemMwQSPJYV6h+bJqG1F2EHGrXxt0dOlLnWgwF5Ulcpq9oM3p2swIXKrikcx1BuL3LKA
         qkXPq+g8+NN0qbt24tDmj702nIBntuPk1JB/r2+AInsFcJ5NXND1Shy8zA+xJm/itwf7
         6pWUpFjQRQUasOfYu6ayS094qOl1VpxnYcWG7zeE1bwzTUM3WF9GOAAo4Y/Fbxs7+9Rr
         ydCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585902; x=1795190702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
        b=fbn+T2jYXIe5WXytLbrfvdryGpYU6QBGJKTQhtGw7jSQdym+TaUOwvuth3RFb3yAxh
         J/wst79SymNo6oEiZS/v87fN4exU0DUsL2D0+lMe5EraQBILklsOF2DEWXrSDxLWx1mG
         +VmRdRxbs8L6DUZ+GqaHNt4TRHAaVKMS5K1YVsYEnqdRUs0+kpynUyroN1UDmSWexFBV
         UxQz5APYO0JkxmKEvKYJzfeTQ8TjwWP+v+LVWSD11nfKSZVaqdvwHfRangjZcstusqyP
         0+rLc3lTFk+bN6o28sQOIJBrXbJFq3VMUNxAIah7cSzoAdvCr1m51fiWqap3a1O0Xuz/
         MPyw==
X-Forwarded-Encrypted: i=1; AL+hErG90WIscw8Qwm6jbOgLBvR8zNjb0PwqvpCVK4M0n6xMO2UxQp4IJMKkQEBwEU6KvISkJYbzjDgpiw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/LpHFzZOQSnnzCy3tTVevFt/PhS3Ici5U7/I2kxpQvs6nhdNGY
	tp49seQvtZMllAalR0MDeFHi/6UUAlYiShFFsn91oDbxFHEMIxnSslEj4t1/+z3mBsQ=
X-Gm-Gg: AYBFou2xbiDXKQ3pnmbonx7DQlvXKDMzRZvNaERzzCKI2mW496K5weFwVqKPHXAfsJg
	OHwsJO8dmSo5/R3B0iLFJPNaqgVd5hyYjU8pE6rI5lVZwo+tYANrVOm+qI7fGR1KUf3xsWnquqd
	8yu6P3Qwt5VMj5rXmytDK4A10gv2lXOoQRxmDo4KO0/LG7orteZmOtKiPT/01yKaQ+7koOy6qYF
	rihPzNzxWe0VhizoikESHc/N+8zIe93TDpVcAKGzs3kYoZ7dqTi5MgpBMFkTezzxJEn6VAkJDnT
	lMIG36mhrCoCZZlV8y5kx1FwqLArax5ialxQ/OUgtUE+uR9cZwintVbqoyWacTZUSLVnG+iUaKQ
	UtDFPwHRqgz5prHWGRjyvgHgAv5TxXOeBsdeH7ULjLQY7aGHaX/yWpb8dkcOMRoRZC25xsx7G+P
	8PvumsSK5zdi3BbU+Y1l1erQgI//j4EhjhzuHWTs2m/w7e6xdZqlsG6WC8wKkNIQCoGpPTy4v8Q
	Ue3HtpbgKyEGij22Rt1Uf9fhfIa0ZALkc0NNgrLpyJmhkdTZpYJYXd/rfojBlipkjVju++M3v+8
	xb7HIwnJMXKOQAWr2efjaNoFshixBJD+fEF1TrIAZ5QEwvmHCKVfgnoF3+70qy3fwEmpzdEurIC
	H8vIOwSA=
X-Received: by 2002:a05:6402:c6d3:10b0:6b5:8719:6d51 with SMTP id 4fb4d7f45d1cf-6b7c0c1661amr2023087a12.32.1794585900329;
        Fri, 13 Nov 2026 08:05:00 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:04:59 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 13 Nov 2026 16:56:43 +0100
Subject: [PATCH v3 2/5] dt-bindings: thermal: generic-adc: Document
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
Message-Id: <20261113-bat-temp-adc-v3-2-743979a8fd90@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=1375;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=I/NJZJX7ehckBNBNEstT8hdZRvbJ5dgDjnQjjzYNTLs=;
 b=Ht22iLsedKZL83BN0JDY5PWcB8ObVo0t6BTxz26Nw19xpDmgxebf+ud/QHUeqUQWi425ecQ3+
 SxCjc8QTNEyDHbneK6kZJZLlWO3P5cfHB1Ugyxv5BwyqSTZWKUV7rxS
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


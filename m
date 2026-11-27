Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807418;
	b=JvgUH6Snw2BeEDA7vaFfb/YvJ6R7OCh47jf5daaaXxKJXPZPypaSHwzn1zecPLl0Ren7
	 uY1BLj3xaPdIZYWQTW1NXV0F/n2uYZaJ6n2IZAr5XN/WBmkXYOP6rYKzziq/+0CDKS5oP
	 UOrrOpf3jbPBl7N03kk+AFEB7GwoLmU0lBFdMAD9CcRSZGzu2cc+tLB/F1sVrU5HhqEKG
	 0tJDNqpI8Ok/RSTK0hfcFIvE2uCzX+Y5ABZJdzUiniWT0an08wpu/VE/skwuE7rw1wHuh
	 AAy8xmXazDh7nv+bx9SbJPxTUQ0sv2b4j30r03XG82ICYkjmajY9unOyMX6KkD6Besg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JmMbAru76i3/EAV08D1zHQqIy9AdABlMufjy77cw/JQ=;
	b=jLXo8pbY7S9nQavxFnQQdx73MTlfe2RhcOvDeaGAnYR8YLfTlg4JMUNMbDnnotS+OgiV
	 jFJBg1YsgfvKPYH/RDpQzJvoFR9g9pOsOjc++ZUXU8KL+QLsn41JpZFvSGDVmdorcHbLu
	 3QtQhrOP/Lk0kCT9M+kG/iCm44mu4r/qkbCC1nPE1KYDbrnvjaV2bxDAe5tOFpRrYuHcF
	 nrsbXQrGmlcVUXEMXF6fyMX6JVbH/QBkkXgb4XGQHv2pgxMH3x9SS2TCWFxx4gLX7H5Eo
	 gKM+2Qsn1g1FW4/hspFsHdAlNeX8i7sWbZyAKe5IRDAW86hfuEFpTf0NtfhKztX8Hsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h6THYbIo;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FA6606A332
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8FA6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h6THYbIo
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-48e9476e26aso2938299fac.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795807417; x=1796412217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JmMbAru76i3/EAV08D1zHQqIy9AdABlMufjy77cw/JQ=;
        b=h6THYbIoz1ldUtaSzNkK7DX7MkS0vJY7RdqAIndbb5cuQfcjZc510dXWDAfDv9Vda0
         bTG1v32cE7HQIQCAaADfkNyepIZ5ttcVcIsxfDR0NsM4qRdOqlN6pPWMLFjV7jdirrE2
         s73Mqy89uFAE4hR4IRpu1oF+G+ehC5Cf3ZcT0OGpgsNTLKZllhygOZ6N1E7vY0cHXqwz
         gV1jNezLhnrA6xiic09urrMPYw07zRCgdH3F1JE9bW7dwolXpHukJoYyEBFI8XagvwnE
         RfG6X+CBIesTysncSZAeEydiR0EJGh60kfLS18bHXaube9zKUkBHizNvS41UnloOuGKP
         fS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795807417; x=1796412217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JmMbAru76i3/EAV08D1zHQqIy9AdABlMufjy77cw/JQ=;
        b=Pn6TYnTyz9eNpYebajBSkkydy6Tiqb2GW3KNQMRBiHK0SqbpZCEvG381gjX18wF5Up
         0M/frtIpyCN2OYBcTaXWMpLojmkDKJ3OPgOOIuMxMrAS3g3FpPl8FLiFHv47SwC3iqIf
         glwkABGYcQS+gKtWZsiUeiigvQkyzicg1kOXALRJeYyaC77EStdDVBsqWspIUZL7zHIr
         lGrHp7HZwG7hyfjOdKRNh1CYwIluVlOVbe+Q9PZ8Q3HniauTf1gwAbsgp+Qon6i8VFh1
         IUP3yYwHcV1ksGwjJNYFHo8n8wi1GyrC9tvjcK9L1vX0qKbU2HmUPKhCDKRnnbqyALJf
         MEwg==
X-Forwarded-Encrypted: i=1; AL+hErHotDO3TNAfh9f9yabmOwwIT3rvxPgkHif7G+eyyghizqYdHmjty7MGCxCwm+k8zi6ZvjByFzbLPQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+yNRXFQb35FYkTTxWZcyr2c4g4G7ZXPpT9gZc66Bm5+ky4JsON
	97UftkZJ1l29bG+AI2VivalmyVz3910wFY97oYz00wnztNT0fOiRi53U
X-Gm-Gg: AZFdTZcz59MjyqP63lR7TX2YJ2INhJ2zYXj/LZ8LfMq33Nj3hvnwbU0RLjyNs6HXuTd
	vcTHnDgqVSybyMCkC7fvvm06k8Hzev8cEYvf3s9tVcIOrCXZveZA7/w+vaPnWCC+IjxZO2ApQBk
	rr5rJvtNMfAb/GU+ZBFCjOFDDxeG2g7tuBJsyQIVzEEk3YIvKdvX2nxO3NIrxZI2vUGXw9qYwzW
	JO//QthfmZ+ZK1bjRgJLlpmbkzpSFtdkDQ5KCJBrCeAaxKgFmvpllyTkpqhVvOrVhd5O42kLqeS
	FVej11eRKQzyI2lf4cxXVi/7AsLJTeflLXcqgGq7x7O5VW3G/4w/pMVewrw7rGCnFzliHlA9PBU
	Uj8GFBNkTZoBrE1+Q6lFdcU6iWLLq5yMblLYCGE8YtOYW/5ZvLFB8LDgcLQztyDwrfnlFmQQJ9f
	vcHaDIQe9Rx3OCviwLraEZWGEUcSdohIQay7rpzT0QyQlk5CIx6ol7Qk9qIsy+XRPARlE26sXG5
	RIT3Ttu1uKk2kMvgUjH3fK1Jd9cyCwkWamTS2igjOcwnt6dRnTVaJ1R08cTpH0xzfYC0uKDGxM0
	NPM9E8iWANCDmLT7tduSg4FP8O3oAA==
X-Received: by 2002:a05:6870:e06c:b0:4b3:fa20:cafe with SMTP id 586e51a60fabf-4c739d49cf3mr14683763fac.48.1795807416715;
        Fri, 27 Nov 2026 11:23:36 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60891cf6sm24044850fac.13.2026.11.27.11.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:23:36 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com,
	linux-pm@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	xsf@rock-chips.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V5 3/3] arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro
Date: Fri, 27 Nov 2026 13:23:30 -0600
Message-ID: <20261127192330.610452-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127192330.610452-1-macroalpha82@gmail.com>
References: <20261127192330.610452-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Cellwise cw2217 battery gauge to the Anbernic
Vita-Pro.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts b/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
index e66803b5399c..d4abd497f355 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
@@ -954,7 +954,25 @@ hym8563: rtc@51 {
 		wakeup-source;
 	};
 
-	/* cellwise,cw221X battery manager at 0x64 */
+	cw2217: fuel-gauge@64 {
+		compatible = "cellwise,cw2217";
+		reg = <0x64>;
+		cellwise,battery-profile = /bits/ 8 <
+			0x5a 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+			0xab 0xb5 0xae 0xc0 0xa9 0xa4 0xcf 0xaf
+			0x96 0xff 0xff 0xd7 0x9a 0x83 0x70 0x69
+			0x65 0x65 0x65 0xb8 0x81 0xd9 0xaf 0xd9
+			0xd2 0xce 0xcd 0xcb 0xca 0xc7 0xc8 0xc5
+			0xc2 0xba 0xa8 0x96 0x8a 0x85 0x7d 0x7a
+			0x7f 0x88 0x92 0x93 0x94 0xd3 0xff 0x5f
+			0x20 0x00 0xab 0x10 0x00 0x91 0x68 0x00
+			0x00 0x00 0x64 0x3c 0xa0 0x89 0x00 0x00
+			0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xb2
+		>;
+		monitored-battery = <&battery>;
+		power-supplies = <&sgm41542>;
+		shunt-resistor-micro-ohms = <2000>;
+	};
 };
 
 &mipidcphy {
-- 
2.53.0


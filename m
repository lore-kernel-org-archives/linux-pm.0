Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C24399DD
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752442; cv=none; b=eq9gPHxfZ4sivamu+IGfN0j6jx5LQmDJ0SI2NDHCYCJ3VV2Ang7BeTTO7qXnRLdgQtUN+oUAJCqSmsHGnw/Vypkvf5TEgkfVwfifJrYtmob9bWs0cnfZ3B1KG27i7yt3U6nMeSj5X8fC2c2iyWj48Ooi9bSe4XgWna0gmliCACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752442; c=relaxed/simple;
	bh=H7gc8EHhrE54TIGFPE01knw9jDcZnFRii3hzkCBNdj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrjMqO8fd5EZQ5bceaHpoqJzPue4tk0S+XrxdAeelsjDUWMtm/+IyR40I7eZfbtyXbynJ46Em2vhFWGr/HIesQ/1dSui8kGs6yyIgaAIKwdLt3vnxhOkuILEp4eL3TIFOtQf3Ls3w03YETzDK6e1GYZJNllY5KcGYKO4CASUUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8J+vOW1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8J+vOW1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso49883045e9.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784752439; x=1785357239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xSx084TFnzGFnpguxyZxDPEBlEGv6khf3RChBzg4a7A=;
        b=T8J+vOW1WnvBTMuGrEM/5Z18gXbjghjBtLBxp+ynT0rH7LAt5xaG/LxBczsd8/4tuA
         8IGt225FXOk+A76Osekdn/rTWIzX9eq3ix++pygsuk20qJIGl1QVhFIU/YFIpkhtpjrW
         ybn9OC42ivb+m43IpuntDgDhPl8vOyZ0t5jP/Eta5at6xGfsY87szQVOnp09P3XEo/BQ
         GuRjmQWSzH1cUVSrluA0rbQGGDDLB3b0L0Kxt6mrxYO8fEEhgKX5d6AtOtTZ85BZImrK
         yFpCpD/rjUWhTaNPpbXZPsD5OofHKO8unM9ChwPuiXO94PXgRpzNhRyMVPLzJ+TYkWps
         H7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784752439; x=1785357239;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xSx084TFnzGFnpguxyZxDPEBlEGv6khf3RChBzg4a7A=;
        b=g7hgOhscx5sQ/fpEbPYmxREiETi1e8MvoNXKx/BQSYdIVGZqzgCg6JUYk6TtHWxL+c
         wN9VDMT/8frdSXSFhH3tAwGD6tE+vDcJ/9BKLUuZZU8nEyXqKZLGkEHRScC7ecwuAYjz
         mqMqREy/uHKLY8EcpiH39xZYsRKlHXrsviglZQ7Ti4zPFLOTC0zCQzhMhlXUSfHrljvq
         L30Ffhvav9tlJbbJs4uNjl39AVYXF414rnUUTmIE+iRWJB7xBU9F6CaAGd+1CATFACur
         CCcnCrsYoMy0CAc8FzhZn+noqeM8K63dxAw5C0GwDoKl7Njy35jyMm0ekOyrMfUdIho4
         P/yw==
X-Gm-Message-State: AOJu0YwtSDIggbaAhUy5cwk8Bf41BgW1A3RdbAhz6hJHC9Fhg/uJ+fWo
	67Kenag0LF9DfVBlXQDlRU8svD9i7BfhI6pvLys8qR+FVRMWoCTFaTQRrPaAoeI24PCUYg==
X-Gm-Gg: AR+sD11erTTR5DMmSNy3AnjUpxqcpLi9pu30SdhSn4HOqmHE7yoMH+J9cCPQ90TovzJ
	DgFpD6KGWWAhOXxy/RJpLvOcDrNIzN8pWH+XR3Ci8WahDqPGTk4jnbxSRNQaOaC2JeHe1GyKauL
	jquODsXSuMNMXdeyVb18al42FnPFiboThnblaLxFLLxBUBd1bbfBoUMXUTuo67u+/SPr5smajo6
	gd68fhBfwIbLsBO7547+a9FOHchTf81GyT+KbsOHVzMygmm+tiEXAvwgdfiysOL0jsEG12W1N0D
	yQ7W8MOWUPwT1/8ssGQcifPH+y/6UIpwu26e1yBc0qWlX3vLCkpshTY0B/Nxw067xSAdY2fIQz5
	2jGDCFS5eydtgQztiXp4tcIyxn3x63Coa7m01HOhZvy1yQzRH8gulL1qx2ipmMrJ9rzwkbjEcIO
	HRpH9SG5zkr7f6N29SCcbKiUd3
X-Received: by 2002:a05:600c:3152:b0:495:3fe1:4ce4 with SMTP id 5b1f17b1804b1-49573ce8ef3mr3009655e9.26.1784752438954;
        Wed, 22 Jul 2026 13:33:58 -0700 (PDT)
Received: from coolemuke.fritz.box ([2a00:6020:b320:1a00:c256:1463:a40b:d8c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956ab2f0a2sm63134945e9.1.2026.07.22.13.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:33:58 -0700 (PDT)
From: "=?UTF-8?q?S=C3=B6ren=20Hantel?=" <fugininsane@gmail.com>
X-Google-Original-From: =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>
To: linux-pm@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Rossak <embed3d@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>,
	Claude Fable 5 <noreply@anthropic.com>
Subject: [PATCH 1/3] dt-bindings: thermal: sun8i: Add binding for the A80 THS controller
Date: Wed, 22 Jul 2026 22:33:39 +0200
Message-ID: <20260722203341.2917852-2-fugininsane@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722203341.2917852-1-fugininsane@googlemail.com>
References: <20260722203341.2917852-1-fugininsane@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Allwinner A80 has a thermal sensor with four channels which shares
its MMIO block, bus gate, module clock and reset line with the GPADC.
Register-wise it is an early version of the THS found in the A83T and
later SoCs, with the THS registers starting at offset 0x40 of the
shared block.

Add the compatible to the sun8i THS binding. The A80 takes a bus and a
module clock plus a reset line, so the existing conditionals already
describe it correctly.

Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Sören Hantel <fugininsane@googlemail.com>
---
 .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 3e61689..718c44d 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -18,6 +18,7 @@ properties:
       - allwinner,sun8i-a83t-ths
       - allwinner,sun8i-h3-ths
       - allwinner,sun8i-r40-ths
+      - allwinner,sun9i-a80-ths
       - allwinner,sun20i-d1-ths
       - allwinner,sun50i-a64-ths
       - allwinner,sun50i-a100-ths
-- 
2.43.0


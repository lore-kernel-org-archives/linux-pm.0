Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451280;
	b=PUDCCHxjSdiQ5ioQHCgxM1z94ALFMfMYvqdzs1A/zOUHWK2jZmJqxq0O0cjswzdKWxm0
	 fMaXvJCgLnIgHlELldyl0rjCF232X0a9aUiEzfbr+ull0nLdk0PIsE7mbUtYZHvR3Reaa
	 BmVFqSOvn7o4YfhMy5l3BF+BcNLAHj0qbw1iVUdu61WLO5v0ygAJFDEI+t/nc8wjQlYN2
	 xACe4ncNp5fjDo9oi9UXReNE84fJgXyqDg50MSViF9XsNTmT3vNAyddpAB+C+BBaT62H2
	 28tNY2ywJ0K9wv/nnZXZJJDMXXT92Ux3U3set7rYcTw2wr/ilp1+JqoPPmGQUpftrcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=/15IrbGrSqzjrFkWTCPOJpVsfqAYXsYamlcuLjCS3GU=;
	b=aEtbpSIEhMLv8dLNkCK7XcYLRaACI01fEyASFPgGxZkY9qnf4Y1tAAIgj8xHBINR+G7B
	 nKfHE5U656c4a9StJgO8bZgZ53gMDdhZXoxG4tu7nUrqSCqc+EgHvOh7Mad6hwR0gdl68
	 IfAEJ1UMTkk2osv3OEXh1HW4kTZUfvqYZjBiu+K2UEEOk1kT0So86t7Nn6OYNgr/NYwmu
	 7RN+R9/h2Bc6yPokK4lrlyPeXiuWZutOLloGiw/rY7Ug5FlRilMu+umhD8mSLqfl+r1fc
	 DAQfnNGm2jJrZH6biLbGbDu4ZRzCjsj5jRv/WogokvseJu7RQHQxO2dypsVOBLkml6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZRqGf34y;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB19606A31A
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 23:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EB19606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZRqGf34y
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso28568615e9.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792451278; x=1793056078; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/15IrbGrSqzjrFkWTCPOJpVsfqAYXsYamlcuLjCS3GU=;
        b=ZRqGf34y0L2eaTOSXNXcCgx4ey13Hi7lSgKxcZ0hiG25fHhTSQI1FthwlV2MaYeOb5
         glKUEdq7peqUf4MIHsxgmepWpSL62cxxCalMyUNXAIXpm4/OHELNEWv4/RcRn756OiSX
         3/LVXdjrH1J961z8ZMv2m4VX3z3u+a4HsRcUfXfRnu+wWiSYJMxwy+woiMmcYh/SDi68
         jZNeAy2zgEbYvvqax8+ubrDyE2idFkQRf79iV/w4mC9+K+sV+S7ers84/XK+ayYPU2FR
         QEerbhnp9XwEwm4uolQzzkFRik5aEi7Bk5lVrJo4s/XLChGWFWgoHMlUnu7Yv+aRxfb2
         +EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792451278; x=1793056078;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/15IrbGrSqzjrFkWTCPOJpVsfqAYXsYamlcuLjCS3GU=;
        b=jA0Qjt8ytAQ1kuXf+//MAzrCcN18PLlz6CvX4a0PRne1ex0YWMT9Y2QxZAmgEpZI+Y
         07XOGpY338NWOppkaL/e24N4jtFbYE/aq+Pl+Q/4LycvSXKg0n3I3XDexIJ2QJxznjwu
         ZIYO3XCTQ6a1n4WWjM56kolNtREGRGdqDQbPmcVNlwoMiyHj3zlKTvzNJKu0C5vVWhbe
         plWCFh3aSa3GDQCF83TvmgiPnxK6Olk3PI+aXASLh03SJpWZXbXeBatPR6ivBqa/S7rl
         ayZrkODG9Xsx8/QjW45T2t8RgHQGYYTmffecnnIHj375HIfNUHsegxGNA3HaCTByo3x/
         jHkA==
X-Forwarded-Encrypted: i=1; AKwUvBxDfVud/bwreWjj1ialBNDcS1cxN4p8OxruKpH61WgSlMO7+yEvZVUsMBQi35Hboaca8JfOhSDLmA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI1AGlCj8gHjDziamw8dA0wVJrxEV5MI/J3Gt1OkDsqOkCZeZQa
	t82sE3g5UOaPZQdwMuhJhavvAr2c6qb9O/P7To8LnTWwQ0+roCG+IKLFf3DeLsYgTm8=
X-Gm-Gg: AYBFou28nqUd/Tlwwru6jfytTbZCYIsu0tKoNJVerpohEGe4/sLWsLbTHDvZYbXN4+I
	yg40ByAbZRUPALKyCdlfUrvGuP8dj8MEu5rgCHI057zVA3JBdI6m8MCwX+6T6T3aihp7szoraiW
	2pm7QZIf/MhoePsHhXQN0l2DKkDU23xl0BSI/0iqPo3llyfGCh8yO2lwCb9vnMI6d43KHeYCPaw
	Qk2QI4Twc5Aweqsr3MpoGMS4SR4NBfk0kSLZba4SvPmd1GdCzBmFlJB3SMCETeafwpM1Q4B6I3n
	YqYd7nwXj6JdSU89sGBRSFs9EjcfRLiACyOEtxSEgHvrdl5Z/HlDWFTHCAT4DPjWueMc3eG28xt
	+u1/zugAFbihr0OairUdxaeU3p5sBmMqsHlCPdbpNSXuVh3TiKysQAPpQIahZKxpuidFOHdHb2b
	SyKBPIT7IuP3JqkZNEdNFW1kg0/ZWS9WIVbGYUIEOLd6+mXVDwHydhXBXsXy29QdCaAlseiHFeS
	TxLe8nfqxOPwdzR5RIyW/TOFMpvAX/r6wGOFgDZ0nzXcY0OQ76i72OW69qM6Q==
X-Received: by 2002:a05:600c:5494:b0:4a1:e0e3:7fe0 with SMTP id 5b1f17b1804b1-4a1e0e3802emr144230465e9.12.1792451278361;
        Mon, 19 Oct 2026 16:07:58 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.85.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f6631abfsm4083445e9.1.2026.10.19.16.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 16:07:57 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Tue, 20 Oct 2026 00:07:54 +0100
Subject: [PATCH] thermal/drivers/samsung/acpm-tmu: fix platform_driver name
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
Message-Id: <20261020-acpm-thermal-drv-name-fix-v1-1-71f72280583b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMmi1moC/x2MSQqAMAwAvyI5G7AF16+Ih1ijBmyVVEQQ/27xO
 AMzD0RW4Qhd9oDyJVH2kMDkGbiVwsIoU2Kwha1MYVokd3g8V1ZPG056YSDPOMuNXLuG5tLVY2k
 h9Ydy0v+7H973AwXwlsNrAAAA
X-Change-ID: 20261019-acpm-thermal-drv-name-fix-e7c8af5c7b52
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3

The platform driver name is set to "gs-tmu", likely a leftover from
the downstream implementation. Update it to "acpm-tmu" to match the
module and driver file name.

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101")
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/thermal/samsung/acpm-tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index f9802080acd7..4b89a2cfaaea 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -637,7 +637,7 @@ static const struct dev_pm_ops acpm_tmu_pm_ops = {
 
 static struct platform_driver acpm_tmu_driver = {
 	.driver = {
-		.name   = "gs-tmu",
+		.name   = "acpm-tmu",
 		.pm     = pm_ptr(&acpm_tmu_pm_ops),
 		.of_match_table = acpm_tmu_match,
 	},

---
base-commit: 3d229ce89862b8e82d71a9e11d6f840ca272a6d6
change-id: 20261019-acpm-thermal-drv-name-fix-e7c8af5c7b52

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>


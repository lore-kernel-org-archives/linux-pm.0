Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A345D5D2
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432978; cv=none; b=CqsYT2ix4AfJEYZdodn0e92I5AnkTfgSRX8m9f4ONi4tFB1JTRLa2LVgIl/4sk3Z1rDb9/tlqbABrYSNwKW0/wSp2XUtE7Y8sGoWQWCHPA5VL9cpaxg1SYiytC+bwgcsA81U0Xg4MO/Yxj27GYkXwKum8SZ0zzD4UfA42PtOF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432978; c=relaxed/simple;
	bh=lCM8EQsBst0/957ZeT7Tb/NPB18E0n8pF89y5rHIWKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvhmOLaqp0/uk6+vXr0dJaW1kDfXPivmgI2RGfAOULuDf6h+PtsJGhmcX3oawQJ13aeJArLj8Bd5ohwfOJIEkAJ3R8fKSCi2E4SIJ6t+o+o/MObDv2YKMOGbXHMnV8l5TMxRRsZYxWB6LNUmnu/fZgTs+MhOYNsGkP6zEIoOWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjC75jVT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjC75jVT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so1939355e9.1
        for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432975; x=1791037775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49roW1ruXbW44fjndJnGBTTIlml58m6uMeiJnFp92as=;
        b=kjC75jVTkIO0pZ4u9gjex3h7Nh6bypmxH//U1UAivot2ORQkj0+oqtXf41OdNK1qRc
         WiSYMoWfEntdF8K3bvc6ihvmDnSYbqAVmpCqOApDNYpzlcULfEozQdYCM48S4WG1OApP
         s/WmFLJL4eBya7rF8WgYj8ngXxESDvHYT7s8dymWHEgp1O1Y70FPhmCz7x8rATKB9Fvs
         bfYedg2fyg/1L3S6pCSVDsK71sdjqK52IGu5sHaN8OAXwxUt4BVBizL/Fgp7vIESHTHQ
         N+/dtgN8tmkLehBYA5DXiXyvNTrz2shP4JObT13CRe8f+rvwvvYxFBgIy4uolc7aQuSE
         nq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432975; x=1791037775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=49roW1ruXbW44fjndJnGBTTIlml58m6uMeiJnFp92as=;
        b=D553ZHuKuuURM3WWPoEGZw9TuxtFIycGv47oUi6zPdZu5iXmi8CGmCRXHGWrq1Xef0
         Sox9aluMeRpiYGDmsUQyHRfflAoeajxd2rxCORlPUmipblwP+9L+zI9+rQUiOPA3XfXT
         NAPG8bozmaAqJ4r6pBIKUJ2K6/lADZBDuy/J0iW5sRstkvp2rbVgmpIxjdSCL2J5sLKB
         0epq1woYOr6zCvf3BG31U/yA+n09i/JN50jOjabJEmZLRzwsWkMf6S2a0W/F3Tpqk4ny
         doLgZRcI6n/zYNjpAiQiWALOvgyP290P3kEChB4SCJWZVEkfVBuNaRkp8VWa9eAxSAmu
         IUXA==
X-Gm-Message-State: AFuF++kt535/8Ea4XQdLWOI8RrczqwjcZYRmlebPmxQoTpCUOvqzDE0I
	vGYeIGMSY6wvwcVbPHiUCyGHZ01LtO5uVxS2y/s+eK04M+Vz+QxJY70l
X-Gm-Gg: AYBFou2omUW9MccJm1P2YqIR7VSTBh1fHonWK/Lw1+dC0hCBKN/JX7E7JcPFi59PolN
	NjQhJOnFRUiilDsQts+BMHlNxH5azMgG+9r2VfKv4rFg1F7TTiX2GbAH0Kg7Ry6dGu+puUxdAq8
	ivS6sYp6fzWDJ+Mbo325X1ijaYD5AW7MnZRY0XzJBixAvJtYdatnoTbwEtltylibk2XBXIoNk43
	hb/HS7xgJRsaFFhNyxR/ykmaVn5BXkSgXCVMB+BQb9OS8jcTNOrtcxkF69m20e10ZvHRkvqPiQp
	fCzxiJM1bJtxGK8V9hd9t/p6xBYRhffsV/VIznMrf4XbehobLGDJfYT00MMaVXdnDobaQVE588l
	0KKJ+4gXE30FQT3/RR+dkafswlZBAl3T4iUeHfnKa/K+vWhbi8L13IhCkCxbkuMcHoVvVLLVJ9T
	JgtysNO161xjuzMvTgeXDvt+50FlilsKNIA3kh8i9cLsTL/BtRcJDsCklju8owMG28ChGmuH8j+
	8hZ7NAoLwmwSUcnm5o=
X-Received: by 2002:a05:600c:3ba9:b0:49f:fe48:d177 with SMTP id 5b1f17b1804b1-49ffe48d294mr24981565e9.32.1790432975572;
        Sat, 26 Sep 2026 07:29:35 -0700 (PDT)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm98116395e9.4.2026.09.26.07.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:29:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] power: supply: generic-adc-battery: Fix temperature IIO channel conversion
Date: Sat, 26 Sep 2026 17:29:05 +0300
Message-ID: <20260926142905.206215-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926142905.206215-1-clamor95@gmail.com>
References: <20260926142905.206215-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Temperature IIO channel data is provided in milli-degrees, while
POWER_SUPPLY_PROP_TEMP is expected to be in deci-degrees. Adjust the
existing logic to reflect this conversion properly.

Fixes: 33088c0513818 ("power: supply: generic-adc-battery: add temperature support")
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/generic-adc-battery.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 185f55d2fd709..f11a5c794e7e8 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -90,12 +90,17 @@ static int gab_read_channel(struct gab *adc_bat, enum gab_chan_type channel,
 	int ret;
 
 	ret = iio_read_channel_processed(adc_bat->channel[channel], result);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&adc_bat->psy->dev, "read channel error: %d\n", ret);
+		return ret;
+	}
+
+	if (channel == GAB_TEMP)
+		*result /= 100; /* Convert from milli- to deci-degree */
 	else
 		*result *= 1000;
 
-	return ret;
+	return 0;
 }
 
 static int gab_get_property(struct power_supply *psy,
-- 
2.53.0


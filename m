Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39B40802B
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449936; cv=none; b=b66g2SyPPfXuMznTzfduODQHVCNXd3WrLkKh7FO9TTR7Cfy9Na/l46alcuaFTmLCo3TseyLGXQpJ8QWw84Y7suwTU5cHWf9LOef7tmeq8DlauFqAEF5M5HqctEVberHOfpUQltkb7g8Otlt1ruCsRT9xPY0QtaYu+NTWAJ38W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449936; c=relaxed/simple;
	bh=ihhu/GEm+uqCbuT3u186bfu9O3Hq8yZsgSx6Y24WwhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOimkzRUQbZ5O75fa5SNY5lVvpghbw9CKmDmIDgaqazh6fjSHpOemhnG5r2DmMvso7OlvXAw5ID5avjtUsDX6YO5Wn8+VONLVYxkgKHFnIIeveDCjSCMoKgsS3OdQD/AsDrCXRZjGOKpeY7HnNrQBFvVFbfE/XNLdrm137Htasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdW8HILo; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdW8HILo"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so38150825ad.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789449931; x=1790054731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQubKTox3I80hScamzBIXxVmWMWZlyR15SjYB1u9qiM=;
        b=hdW8HILomqXU4LWH/c2oE5xgswDPGpDcQHPEhiWWXd59Zth9M8Sgm8XBH/a4Fc1Fau
         C27+UbuVKtuPUyaaOidrChvZRDub6vDK3/t0CuArpUtEYyuj3Mi1eL928QIFxrvnoqer
         1gBTw5IFs+0xJP0Fquk2UdDyVKOn/Tl7s6wgJWeB1R1mzVIYdVPI6sOzINh8jxjojcdR
         0hUxWkT9MJoYwTFkPIvmEsHJor46ssNqxVgGjb/JnqOAVNbuw5UiiRDnGJj+8xzI3qPc
         7APmJpmX4J2ZGs9jM56JgKTkJCLeQXj25FplfghchZsoNBHzbogQRHVSmrE0syax7NE6
         tSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789449931; x=1790054731;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yQubKTox3I80hScamzBIXxVmWMWZlyR15SjYB1u9qiM=;
        b=0RUATA2bueWIEhlIdtTAC83ChVO+9lwCpL2HU6BV5wzD0/3tZOJWuN13muQawQNFmP
         BZGy5pAAzxPLCzLsTZ04Ce1fzpBT3R0lXWb9HHKaModU4jzpZyEm9NdAybhmseE/gaVi
         U0w4rzT9AFiyh+2A7olZjwA0JS+YVHRSJcLaa5ZjXwbobuDMXJF0N2I2fLJ9/cFkTaq+
         vF5t86pPI5m2KZYftZZJppHIbyJAqz3kIR9M1HfP6QrceLVSEdHq9CAsBBNmtok+jsof
         Q2GCBefrJpQsecdo53TRzGteh2j3CCzy3MDwWKargpqLh1zV1RTBlzb83Dqs/MtXkcJF
         0wfw==
X-Forwarded-Encrypted: i=1; AKwUvBwJeJurQ4gIdweYKChB6OURcz2BlhnB/O6xf/erNcLMhg6pBTy8GjKZw6mAOdkf4HkY3WI0iiqjAw==@vger.kernel.org
X-Gm-Message-State: AFuF++lRiYRwkxWMZsT55fD5oCWj3pZL9SnpIBFb37af0FYAPn8cqeOV
	dJrXxRvPKhchKpj+he7aYgWzIdDqK7viajfaJMR+/hKoUnWKGxUcoonT
X-Gm-Gg: AYBFou1cDynIvL2tzVtUNR9x+2MmerdRTncEaJeUxXci1vH2+JTcTlsL26Nlszmu5wH
	s0dK3A9CKUZSK6+IG/HmK3hnK9iMhdYpxhg025wsZzeLf9fbrlvKVpQ0RxJJF39o3wYvoXZmu7v
	KyQs4qYPAGfw3/1iMavto9uipzrhgQKT2D0owESdJ5GoODxlNIls3WbdSI2Vywq5FVqK0gDjmDa
	3z7YhiX0QxFwHeQ6CklSIQgzXowM6eGYh4VjdRWCFehfG357mI4vTebz/w5e71ESaZjHSIKdXqL
	ecdbG+TGsPj/LgV6Pe4AwVS4wPTpklHNcngRvXAEWfXmfZ9jxJzoFZtOi9kXZygv6QnLOyMST1o
	vVRQbInpYHf4I8PRN76sI32lCwYnP712NezZ5meZ4W0iwFi5dKGy3yAhZBV9+MF5o82/31zAGnk
	/+8NbjJHviOs2l227hFAyUHWREJl3WFsASCharwV5UkH4lxUsZR7R9Jp0AjsgxBNa6I6JM1B3De
	Sbmgwjwkw==
X-Received: by 2002:a17:903:8d0:b0:2d7:107c:917b with SMTP id d9443c01a7336-2dd6c46714bmr123949285ad.0.1789449930877;
        Mon, 14 Sep 2026 22:25:30 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cff67aasm59718445ad.79.2026.09.14.22.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:25:30 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] power: supply: max17042_battery: Make the fractional LSB macros safe
Date: Tue, 15 Sep 2026 05:25:29 +0000
Message-ID: <20260915052529.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fractional LSB macros expand to a plain division, so they only work
when multiplied first and evaluate to 0 anywhere else. Take the value as
a macro argument and apply it with mult_frac(). No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202606062322.TyvCPB3l-lkp@intel.com/
Assisted-by: Claude:claude-opus-5
Assisted-by: Claude:claude-fable-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 30 +++++++++++++++----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index a53970af56cbb..861b5dbc11c1e 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/math.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/power_supply.h>
@@ -57,10 +58,15 @@
 
 #define MAX17042_CURRENT_LSB		1562500ll /* 1.5625µV/Rsense */
 #define MAX17042_CAPACITY_LSB		5000000ll /* 5.0µVH/Rsense */
-#define MAX17042_TIME_LSB		5625 / 1000 /* s */
-#define MAX17042_VOLTAGE_LSB		625 / 8 /* µV */
-#define MAX17042_RESISTANCE_LSB		1 / 4096 /* Ω */
-#define MAX17042_TEMPERATURE_LSB	1 / 256 /* °C */
+/*
+ * These LSBs are fractions, so they take their argument rather than
+ * expanding to a bare "n / d" token sequence, which is only correct in a
+ * "value * LSB" context.
+ */
+#define MAX17042_TIME_LSB(val)		mult_frac(val, 5625, 1000) /* s */
+#define MAX17042_VOLTAGE_LSB(val)	mult_frac(val, 625, 8) /* µV */
+#define MAX17042_RESISTANCE_LSB(val)	mult_frac(val, 1, 4096) /* Ω */
+#define MAX17042_TEMPERATURE_LSB(val)	mult_frac(val, 1, 256) /* °C */
 
 #define MAX17055_DQACC_DIV		32
 #define MAX17055_DPACC_FACTOR		44138
@@ -138,7 +144,7 @@ static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
 
 	*temp = sign_extend32(data, 15);
 	/* The value is converted into deci-centigrade scale */
-	*temp = *temp * 10 * MAX17042_TEMPERATURE_LSB;
+	*temp = MAX17042_TEMPERATURE_LSB(*temp * 10);
 	return 0;
 }
 
@@ -214,7 +220,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto health_error;
 
 	/* bits [0-3] unused */
-	vavg = val * MAX17042_VOLTAGE_LSB;
+	vavg = MAX17042_VOLTAGE_LSB(val);
 	/* Convert to millivolts */
 	vavg /= 1000;
 
@@ -223,7 +229,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto health_error;
 
 	/* bits [0-3] unused */
-	vbatt = val * MAX17042_VOLTAGE_LSB;
+	vbatt = MAX17042_VOLTAGE_LSB(val);
 	/* Convert to millivolts */
 	vbatt /= 1000;
 
@@ -330,21 +336,21 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * MAX17042_VOLTAGE_LSB;
+		val->intval = MAX17042_VOLTAGE_LSB(data);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		ret = regmap_read(map, MAX17042_AvgVCELL, &data);
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * MAX17042_VOLTAGE_LSB;
+		val->intval = MAX17042_VOLTAGE_LSB(data);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
 		ret = regmap_read(map, MAX17042_OCVInternal, &data);
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * MAX17042_VOLTAGE_LSB;
+		val->intval = MAX17042_VOLTAGE_LSB(data);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		if (chip->enable_current_sense)
@@ -473,7 +479,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (data == U16_MAX)
 			return -ENODATA;
 
-		val->intval = data * MAX17042_TIME_LSB;
+		val->intval = MAX17042_TIME_LSB(data);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
 		if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055 &&
@@ -488,7 +494,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (data == U16_MAX)
 			return -ENODATA;
 
-		val->intval = data * MAX17042_TIME_LSB;
+		val->intval = MAX17042_TIME_LSB(data);
 		break;
 	default:
 		return -EINVAL;

base-commit: 4fc88ba435dadbc05990951e3f3fbd8ccd2df140
-- 
2.43.0


Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BFB1D1E62
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709428; cv=none; b=jyLy6f/ixQlk0Dy88StobpEIm94uXiezHvfjwz4xDlq7/2AEC32ImWs35UvGcGCHFB6ZWJNwVEZRWg9nKHM6EOW7IuDg3HRBjqmDNCqFsUlUP947qPcFjmfE7HPrgi305sGT36o7ZIVCmzXc3kVVXhMqpOTqNBg61rHWduq1AP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709428; c=relaxed/simple;
	bh=i1opjJ5noztG7W4quqfSUG+1/LQxGlVrZchANNNBAU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSHdyTTLWS+eaBkuFy7NmG8ck4++muBPTmwGEtXOEBEvZ0jGdjQQJSsbWL4i0AkG5LSEnxQDE8z/yP+dTxdNmUq4JszwFyngY1CPKfs4CAAtl2If0SNJN8YzIXl9BiRAdCWof9aF7XWgYZGy7MNMB4tPAnKN2vXS0isOK+EoQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JM4CDIAt; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM4CDIAt"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7180dc76075so73814a34.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729709426; x=1730314226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzWEx+54nXqRyexqxBK02Ff4DIq6Md1prk1WFWanhYk=;
        b=JM4CDIAtEBrdB0V6LnOcAPN1u1Ny7xTJxfmIp6blqQIJ+1sUpqAIuMQ2VSMK3Is34W
         t9opcjP//1AiaQh1LsWHc8Ca+NCCNW7mhUVSrztFXdo4fwrKhWsLWdfpNYnBTrp5EVUK
         bajUAt+Oa7PQ2u4aK0bVoVJ68wDJuUOGvfIIibRG3tBpjfxQatTcwjwBqnchVTQJ0yev
         xPNj+pKV4jffOIj8bBDPftcrJQjamtNqq8h6bzBYCaOW58J4GrC8iirEK0FQRTORYwZK
         S7ECGdQJcKiZR6beYwJvu94yKyttw+dOWJd0IBdGwMUXXdfVUSaRYpkRw/tw6FviAyMa
         E5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709426; x=1730314226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzWEx+54nXqRyexqxBK02Ff4DIq6Md1prk1WFWanhYk=;
        b=PE+7g/IbVKUEkfADcVITfcjxaS55G+JUb6u9haZX61z+0OVUIXC52HKU64iUhU62tG
         KPVFWONuIK8koxpCqjjestHJI9IUF8a4OmISyFYlw4lbYOejYvXmhJVcLwzRRiY3Rcko
         VwK/ORBSeFwbEX5rIzknJufdy46Vr0NMumqYNuEWkL035MWgjG+iIWIXzv9Jar9xJtaD
         G2lEkIv2+yQzVaN/0ZuqzOKNqn2N/NV8IufhLxE2/uwrhjUKROVDxt0Ftswc9rk+XEvP
         ulTEb7Rqf0RaE0InhApPCT4rvPQWsHgRCSIb0MZXUfJYAo3DRsesrBmwc0/oCc0GCRCf
         GiZg==
X-Gm-Message-State: AOJu0YyvS2yoFtdRmzlyg8IZgrC7o/GX9XLbx6/lfhT2Yzxy7qTjlo48
	psJotBr35izEpHKYZgVXhYYhwiVLshsQQRTkFGIWWsoJ3sarxEf/8UY43w==
X-Google-Smtp-Source: AGHT+IHWRTElqaKFG/p97TiMXmH37N7VT0S2iCKBdvdFt11k14I2JQfm9J4D2BPKNoxV/zwXOWG3+Q==
X-Received: by 2002:a05:6830:2691:b0:718:194d:8ab with SMTP id 46e09a7af769-7184b331716mr4380810a34.27.1729709426143;
        Wed, 23 Oct 2024 11:50:26 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb52609sm1860667a34.40.2024.10.23.11.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:50:25 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: wens@csie.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/2] power: supply: axp20x_battery: Use scaled iio_read_channel
Date: Wed, 23 Oct 2024 13:48:00 -0500
Message-ID: <20241023184800.109376-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023184800.109376-1-macroalpha82@gmail.com>
References: <20241023184800.109376-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Change iio_read_channel_processed to iio_read_channel_processed_scale
where appropriate.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_battery.c | 33 ++++++++++++++-------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index f71cc90fea12..fa27195f074e 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -354,17 +354,18 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 		if (ret)
 			return ret;
 
+		/* IIO framework gives mA but Power Supply framework gives uA */
 		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING) {
-			ret = iio_read_channel_processed(axp20x_batt->batt_chrg_i, &val->intval);
+			ret = iio_read_channel_processed_scale(axp20x_batt->batt_chrg_i,
+							       &val->intval, 1000);
 		} else {
-			ret = iio_read_channel_processed(axp20x_batt->batt_dischrg_i, &val1);
+			ret = iio_read_channel_processed_scale(axp20x_batt->batt_dischrg_i,
+							       &val1, 1000);
 			val->intval = -val1;
 		}
 		if (ret)
 			return ret;
 
-		/* IIO framework gives mA but Power Supply framework gives uA */
-		val->intval *= 1000;
 		break;
 
 	case POWER_SUPPLY_PROP_CAPACITY:
@@ -406,13 +407,12 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = iio_read_channel_processed(axp20x_batt->batt_v,
-						 &val->intval);
+		/* IIO framework gives mV but Power Supply framework gives uV */
+		ret = iio_read_channel_processed_scale(axp20x_batt->batt_v,
+						 &val->intval, 1000);
 		if (ret)
 			return ret;
 
-		/* IIO framework gives mV but Power Supply framework gives uV */
-		val->intval *= 1000;
 		break;
 
 	default:
@@ -519,13 +519,15 @@ static int axp717_battery_get_prop(struct power_supply *psy,
 		 * The offset of this value is currently unknown and is
 		 * not documented in the datasheet. Based on
 		 * observation it's assumed to be somewhere around
-		 * 450ma. I will leave the value raw for now.
+		 * 450ma. I will leave the value raw for now. Note that
+		 * IIO framework gives mA but Power Supply framework
+		 * gives uA.
 		 */
-		ret = iio_read_channel_processed(axp20x_batt->batt_chrg_i, &val->intval);
+		ret = iio_read_channel_processed_scale(axp20x_batt->batt_chrg_i,
+						       &val->intval, 1000);
 		if (ret)
 			return ret;
-		/* IIO framework gives mA but Power Supply framework gives uA */
-		val->intval *= 1000;
+
 		return 0;
 
 	case POWER_SUPPLY_PROP_CAPACITY:
@@ -564,13 +566,12 @@ static int axp717_battery_get_prop(struct power_supply *psy,
 		return 0;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = iio_read_channel_processed(axp20x_batt->batt_v,
-						 &val->intval);
+		/* IIO framework gives mV but Power Supply framework gives uV */
+		ret = iio_read_channel_processed_scale(axp20x_batt->batt_v,
+						       &val->intval, 1000);
 		if (ret)
 			return ret;
 
-		/* IIO framework gives mV but Power Supply framework gives uV */
-		val->intval *= 1000;
 		return 0;
 
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
-- 
2.43.0


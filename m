Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625103750BE
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894165; cv=none; b=gIAT8KA4KFPIxicWT6OVrxu11JYjqbTpGEopd2u2UcqKcGmJnUYJ5fhgIKFrtmzEQsQXQ2s5v6YW4w/LzwIla1FHvoJk40N8Paine01XDV6Gu8BUjz9iNqoKF/o01XE9qI2Mh8fG9jD+CTmI4R5bWh2obP0tOje4HYp6GCc3iLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894165; c=relaxed/simple;
	bh=ekYyjbGDCMIjKTojcaxhwQ+AMRhdvTKOaGTvjM0ayMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euiGjPxeCrXlFfNSParlLfjXyn98UiJDnp4+/rR+wiwxkfT5fX3t3xtOSMamSZ6HjTy+ukRAYC7JaJPka2q8J9cf9a2DssjXcrwgzqAiEdFY6IKoISfFR5JOpu2SQ99Y0Up1166YphX+7ao1aXkssyLEtDbUAM70rw0nIE0aVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWb4GEdq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWb4GEdq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso263230a12.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785894160; x=1786498960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WtsicDUzlvcscfC5dX4W8BMmJ9vs/CpiKg/Y+8Yj9KE=;
        b=ZWb4GEdqrrrlv0oCe5ue9ABZJ+TAXWSJ6Fkvrv6mi/rdkZ2TDVVqzNJ+aIckx1iPX9
         f6HiZXK4tDl1qCmsbQAZY1oTP2sc44yCN3OYM0HULT5VQYFkBsPUt1PvO6zOCo0HvexS
         cPnJsvzxnGlbFyDKKFEMA0Ew31wU+P7lcFan6PIjxkcgzZ7QqYhyYTupn8eNHAoWfxFf
         796t5fQzxwbMBn8tDuhgHkBGX9EkToxTVQntw88dzh7BvdUZom89DBF1qtWwOVnbKLzA
         2phMf/CBYQ3pNO9TXxcD9XaYOOycNPSryUC1+JxjRowmD6uZUEITqyqqcT8zMDfm9Mur
         G7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785894160; x=1786498960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WtsicDUzlvcscfC5dX4W8BMmJ9vs/CpiKg/Y+8Yj9KE=;
        b=pazTBEj58KpbE3gFxq3fDiQnkx9pbQAmLSgUz+OvySWTvgnmLfLbqaqdLcz0Vg0aKE
         HjZVgyISy0udTxasADwZ4rv+C06XeXphEaOaXWGzpYAVluLKpX3No/0wQs/5PQCcpNmL
         /rukzFd9b1jW+ambwkmRkcXsapH9KN+o8cL6KtIcFZll+YhT4SAlsoxmcVGZaEjMZh4K
         oQ1z+IwMojckoCV8Ao/3yy1eNqJ5WH17rk1fWLTbulcoPegNxXKwZD57qfbAbJcm+93N
         3cagM3/wSY/A4Gsh1sDMVitSrGlDGMZeM+SeWH7qv74HSHFlYbTwwAsthWoqOkikVc0t
         R2Bg==
X-Forwarded-Encrypted: i=1; AHgh+RrbUIq7STqSKPQu93+TbE1Hii4wkrz3ccF2zLuhUCyPLREMN6XfnZMsnHVCI/pM0qs/EK99ey0Bjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAaHpuKodRUx/gs4k6pOtiTU0BGwoB+wZkEKQ2YvoU3tIquzzy
	OriiO1Zg90bYzoWVzw403jfjqnyHSLmbfU8dGmn53ThZ44pHC9TUTxUf
X-Gm-Gg: AR+sD13xPuU4legeENb5lr1XHKE8s3OvCp5pqROG0tmduN8eyX6MnxmwLesCwhD2XQG
	CFOUn614cDKQfpLQ33YpwL+23+CQbrHudhG9hyw8Am10BndHy0wRNp8eiMteoUhAlkjrgEU4TAc
	WVaZRqI7P4PsZttm6FaihcUdeN+uYGuVA8aMJSykkijClxsZxloU6W7uskB5bgRhvJ8owYkXONa
	ofFyxMu9kb1pAhDrOh5RT4hmzlSJ/FQt8b/1QYYkrhFxEAGIrvPhKgArrOHYVWjPrpzsyFy/ZXV
	HKYMndO6/ugV6/eMHPt3JCw/4mtFuODNdJLVi9cZr5c63xMGvdJlKsUch7F16leZp/pooE1lpFt
	mk0qVCR9GZAp3XqZ3ABO48BwMM80K4OQmTmmXt+Sucy/uN3trOpgDYi6qS36Jc2bKE/TXLaLFiI
	pxA7dHeTD++GCjkgF0y794j1+webRYOr7rF2BHgLZ89v/C/Eh3di1Nwppdb16CTMSxI1kPwxGvV
	FOwEVE5n9OD8YUWhZD5co361HnqeZ+OxpyxUsWX5Gw7F7vqmW7/oz0Xpyz7
X-Received: by 2002:a05:6a00:6c95:b0:847:8449:2bb6 with SMTP id d2e1a72fcca58-84f2e022798mr3333888b3a.4.1785894160046;
        Tue, 04 Aug 2026 18:42:40 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::6868])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e507c38sm333744b3a.43.2026.08.04.18.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:42:39 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: lee@kernel.org,
	sre@kernel.org,
	linux@roeck-us.net
Cc: patches@opensource.cirrus.com,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH] mfd: wm8350: propagate ADC read timeout instead of returning 0
Date: Tue,  4 Aug 2026 19:42:21 -0600
Message-ID: <20260805014221.16412-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wm8350_read_auxadc() logs an error via dev_err() when the AUX ADC
read times out, but then falls through to return the masked value
of `result`, which was left at its initial value of 0. Callers have
no way to distinguish a genuine 0V reading from a failed read.

Return -ETIMEDOUT on timeout instead, and update the wm8350 hwmon
and power_supply drivers, which call this function directly, to
check for a negative return and propagate the error rather than
using it as a voltage value.

Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/hwmon/wm8350-hwmon.c        |  9 ++++--
 drivers/mfd/wm8350-core.c           | 14 ++++++---
 drivers/power/supply/wm8350_power.c | 45 ++++++++++++++++++++++-------
 3 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/wm8350-hwmon.c b/drivers/hwmon/wm8350-hwmon.c
index 10e17bb79895..a455e1c5476c 100644
--- a/drivers/hwmon/wm8350-hwmon.c
+++ b/drivers/hwmon/wm8350-hwmon.c
@@ -23,14 +23,17 @@ static const char * const input_names[] = {
 };
 
 static ssize_t show_voltage(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+			  struct device_attribute *attr, char *buf)
 {
 	struct wm8350 *wm8350 = dev_get_drvdata(dev);
 	int channel = to_sensor_dev_attr(attr)->index;
 	int val;
 
-	val = wm8350_read_auxadc(wm8350, channel, 0, 0) * WM8350_AUX_COEFF;
-	val = DIV_ROUND_CLOSEST(val, 1000);
+	val = wm8350_read_auxadc(wm8350, channel, 0, 0);
+	if (val < 0)
+		return val;
+
+	val = DIV_ROUND_CLOSEST(val * WM8350_AUX_COEFF, 1000);
 
 	return sprintf(buf, "%d\n", val);
 }
diff --git a/drivers/mfd/wm8350-core.c b/drivers/mfd/wm8350-core.c
index fbc77b218215..3120c6b8fa3f 100644
--- a/drivers/mfd/wm8350-core.c
+++ b/drivers/mfd/wm8350-core.c
@@ -188,6 +188,7 @@ EXPORT_SYMBOL_GPL(wm8350_reg_unlock);
 int wm8350_read_auxadc(struct wm8350 *wm8350, int channel, int scale, int vref)
 {
 	u16 reg, result = 0;
+	int ret = 0;
 
 	if (channel < WM8350_AUXADC_AUX1 || channel > WM8350_AUXADC_TEMP)
 		return -EINVAL;
@@ -221,19 +222,24 @@ int wm8350_read_auxadc(struct wm8350 *wm8350, int channel, int scale, int vref)
 	wait_for_completion_timeout(&wm8350->auxadc_done, msecs_to_jiffies(5));
 
 	reg = wm8350_reg_read(wm8350, WM8350_DIGITISER_CONTROL_1);
-	if (reg & WM8350_AUXADC_POLL)
+	if (reg & WM8350_AUXADC_POLL) {
 		dev_err(wm8350->dev, "adc chn %d read timeout\n", channel);
-	else
+		ret = -ETIMEDOUT;
+	} else {
 		result = wm8350_reg_read(wm8350,
-					 WM8350_AUX1_READBACK + channel);
+					WM8350_AUX1_READBACK + channel);
+	}
 
 	/* Turn off the ADC */
 	reg = wm8350_reg_read(wm8350, WM8350_POWER_MGMT_5);
 	wm8350_reg_write(wm8350, WM8350_POWER_MGMT_5,
-			 reg & ~WM8350_AUXADC_ENA);
+			reg & ~WM8350_AUXADC_ENA);
 
 	mutex_unlock(&wm8350->auxadc_mutex);
 
+	if (ret)
+		return ret;
+
 	return result & WM8350_AUXADC_DATA1_MASK;
 }
 EXPORT_SYMBOL_GPL(wm8350_read_auxadc);
diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index b0eb6e0ce8bc..111373027905 100644
--- a/drivers/power/supply/wm8350_power.c
+++ b/drivers/power/supply/wm8350_power.c
@@ -19,20 +19,32 @@
 
 static int wm8350_read_battery_uvolts(struct wm8350 *wm8350)
 {
-	return wm8350_read_auxadc(wm8350, WM8350_AUXADC_BATT, 0, 0)
-		* WM8350_AUX_COEFF;
+	int val = wm8350_read_auxadc(wm8350, WM8350_AUXADC_BATT, 0, 0);
+
+	if (val < 0)
+		return val;
+
+	return val * WM8350_AUX_COEFF;
 }
 
 static int wm8350_read_line_uvolts(struct wm8350 *wm8350)
 {
-	return wm8350_read_auxadc(wm8350, WM8350_AUXADC_LINE, 0, 0)
-		* WM8350_AUX_COEFF;
+	int val = wm8350_read_auxadc(wm8350, WM8350_AUXADC_LINE, 0, 0);
+
+	if (val < 0)
+		return val;
+
+	return val * WM8350_AUX_COEFF;
 }
 
 static int wm8350_read_usb_uvolts(struct wm8350 *wm8350)
 {
-	return wm8350_read_auxadc(wm8350, WM8350_AUXADC_USB, 0, 0)
-		* WM8350_AUX_COEFF;
+	int val = wm8350_read_auxadc(wm8350, WM8350_AUXADC_USB, 0, 0);
+
+	if (val < 0)
+		return val;
+
+	return val * WM8350_AUX_COEFF;
 }
 
 #define WM8350_BATT_SUPPLY	1
@@ -257,7 +269,10 @@ static int wm8350_ac_get_prop(struct power_supply *psy,
 				 WM8350_LINE_SUPPLY);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = wm8350_read_line_uvolts(wm8350);
+		ret = wm8350_read_line_uvolts(wm8350);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	default:
 		ret = -EINVAL;
@@ -287,7 +302,10 @@ static int wm8350_usb_get_prop(struct power_supply *psy,
 				 WM8350_USB_SUPPLY);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = wm8350_read_usb_uvolts(wm8350);
+		ret = wm8350_read_usb_uvolts(wm8350);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	default:
 		ret = -EINVAL;
@@ -308,8 +326,12 @@ static enum power_supply_property wm8350_usb_props[] = {
 static int wm8350_bat_check_health(struct wm8350 *wm8350)
 {
 	u16 reg;
+	int uvolts = wm8350_read_battery_uvolts(wm8350);
+
+	if (uvolts < 0)
+		return POWER_SUPPLY_HEALTH_UNKNOWN;
 
-	if (wm8350_read_battery_uvolts(wm8350) < 2850000)
+	if (uvolts < 2850000)
 		return POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 
 	reg = wm8350_reg_read(wm8350, WM8350_CHARGER_OVERRIDES);
@@ -356,7 +378,10 @@ static int wm8350_bat_get_property(struct power_supply *psy,
 				 WM8350_BATT_SUPPLY);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = wm8350_read_battery_uvolts(wm8350);
+		ret = wm8350_read_battery_uvolts(wm8350);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
 		val->intval = wm8350_bat_check_health(wm8350);
-- 
2.55.0


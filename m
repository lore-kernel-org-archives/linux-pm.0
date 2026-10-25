Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896534;
	b=5BCIs7vrPk9X/v17QXknhfORrHPf9ZMvzrHX109UlnknT92fXugvi/LD6lSFZt+khPm9
	 aBxfNrxy2r0PouvWfo5Plkzz2PNIEqFKtgV6b1Ayk+fCM6WXm9pQVyK6a8pwQcH8ATaG/
	 IsxlJO7L8hoidHcAUaLDA31u81X5UyKboGkiWvfgg+ielLCY1HaGpTu/MpOi7cvmWY/68
	 1LonwNWD7esk/Mu0cwPt2jk4YMkgZ7GcYT3JuOBN5wCJZG+N2LcO1YSGB/Ko9oGGkPjku
	 zBDkIraLsXKBWn8vlg2QCrHWi1A7laAiYhpeUJzQJJUQWIrc0mUxYQNgJcEUT0V6+SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=bsCc8WogS7pv5G/7UNqDoKJ6Atze4+f+9ywZLQF5iks=;
	b=gnquGOP7kA7XTMMH4pg298zTjuvzkIfshBeDQ/X4JMNoGZh4yTK48QoBrB6ya+uIKR16
	 fmViZOghZl9at1ie6WTB1W95i82MLqyUTvn3KwVkmzN5A0JsoZQwWEzPL5SU47JPJ6maG
	 pDyw6JEL4FECb9K9fW6htncozc43AKoIMHQ7R/j7Ws6dVE1kkaUvCNj7hzCJFfnsbCLKm
	 MvChys5Z8lEyuI6XeTlymNjMFegw9O1B8v+W1fesVZ55yxuqRMR+2HTuy9RVC+ohYVSlV
	 GnQHwyVyz9WahCHmPSqDyIAzY8hJnsqTZ3EXUOInaRTok/5cIVVfDUkbK42D5ED3bQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OYs8CzpH;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280F60A2602
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 02:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6280F60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OYs8CzpH
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so3391649c88.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 19:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896533; x=1793501333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bsCc8WogS7pv5G/7UNqDoKJ6Atze4+f+9ywZLQF5iks=;
        b=OYs8CzpHYRXpUiTQk7OetNemLq7hcPXWzbi+UX+IVDlL+n9mS1RE9nN0ToXAStUZNF
         KgMrHbbw8PMO/AeDA8aqcFbOfQKob4UrBUHIqw85KjPmAS8vrCjyX5RED5dKEovhcOm/
         pmiQkfyN2J9Q6MtmbyDMQoees1AtkqOXlgrwlzf0XSwkSkuKxkrgorW+ySUth6MjUsyy
         7sRYkXwJiux+dZJdfrZ+qNi0fRB44FTyljW/I2l9/thalqWaDqdAzMFFOSIkeJD+vxTY
         2tx4iGVQP6RHhxIy2hNzKBvHOrvDvs4OTW5TvaHe3sybFKMpPUIgcEIctiZNAwKyl/PJ
         1xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896533; x=1793501333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsCc8WogS7pv5G/7UNqDoKJ6Atze4+f+9ywZLQF5iks=;
        b=HsRxEuAoEnMv2BnJKDZ8BunvlX4QMBUwyweM46cysBJ2TU8oydVEvvSoWL9GFETbt4
         zr3z3xU7mwd6El3PzWJ3+mdNiZfHuieVOnnBDKUYgl0CWsJhOwSk4B8PdkgcOTWIsjl+
         saoLpJuTb/DBPvgX1O+ow4IjOIm7uLcsXNLRUbVjTG+UNzMn+ONt0DvzjS2W9I2nJyK1
         JsLLTFev7cnvsp6mHTE9w6htKzqBCgzHgybSdHA9cvoV/n09DOaSBDrS/BL17TArjG+2
         OHaFjbgnN4lB+n07VFAnR+LyM7cFgiC1xUgyx24H/16yoNpddq77xDD5vTpmHHVkU8gd
         0PdQ==
X-Forwarded-Encrypted: i=1; AKwUvByOe+VL4V6KuziZtOHlTLCZIS8m9rWUsb4YnS7Ov+agxra+0b5NjwV8encRSQddiobpxmnZ83RDRg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKV91pbW/OsC5WeZkPUesRoCe7Xu+0vHzV86a7YotzLkEQVSdIS
	u3lfreljo7U6e7e4mpPu8S7BOOcgiISjgmVRlGDBtsy7kz0iDA21oeHp
X-Gm-Gg: AYBFou3FjYZcvaQW61Fztr5nmVE41asj3+waPuICK4qu2slOWPMcJRMFVRMuCtQvn2M
	ZhBBdZOJOOVrl2aZxh7fFHF+3OH14c1phloLiLYAm3z1G0cWD3/I5SAEnKqNOiy+ldaNAW7vN0l
	LPN4mJBFcRE3yfoLOTJaAu3qbRoySCQ+SvxZA2HFOw2+7PC3K+IEoTm3zyA+MLMAgvC9RBiyR69
	bkOXBq/ZxpkZfoSR49iSYMcpVw/WVeugRWvnBp1D9vpTrCgS6uagzWpkP0KgsOrM/XgQ7JhgbDv
	S/RPCBCUejeQrh2LL/vAanhCqk7c6HynstSrdPAzSVK/DGbccOWbfNuKE4UHIautlIkDuIgVGQ9
	fggyGn1Y/AjW1sD3SuBMAXGzskPh5E9wPOPyOv32OG1At4k+YeA6392OUeYQoEVeHcpNE6ZkRj7
	LPfhj68v0cq8DJC6CZKr0ku3dLA+h7jmOzHIzM46qs1bw74jtgj1eO3VwFfC8dhYgxpw2Tq+ivs
	8H6YIppv42y/iqCBBdxzU5eXFhDgMu+Ou6i57HmugiEFjzJyhQVopt307uXYlOY/P+tLUB0tykY
	oKqpRT3TerW6i7YT4UUYJvtUxzcOwHnqqbxJcACFgyc=
X-Received: by 2002:a05:701b:42c5:20b0:143:4450:e1e6 with SMTP id a92af1059eb24-19935fcae7cmr4685115c88.35.1792896533217;
        Sat, 24 Oct 2026 19:48:53 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:52 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:44 -0700
Subject: [PATCH 4/8] Input: elan_i2c - use 4-argument
 i2c_smbus_read_block_data()
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-4-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Convert callers of i2c_smbus_read_block_data() to the 4-argument
variant, specifying the buffer size to avoid buffer overruns.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elan_i2c_smbus.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
index 0287441cda46..c5091601587a 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -59,7 +59,8 @@ static int elan_smbus_initialize(struct i2c_client *client)
 
 	/* Get hello packet */
 	len = i2c_smbus_read_block_data(client,
-					ETP_SMBUS_HELLOPACKET_CMD, values);
+					ETP_SMBUS_HELLOPACKET_CMD,
+					sizeof(values), values);
 	if (len != ETP_SMBUS_HELLOPACKET_LEN) {
 		dev_err(&client->dev, "hello packet length fail: %d\n", len);
 		error = len < 0 ? len : -EIO;
@@ -120,7 +121,8 @@ static int elan_smbus_calibrate_result(struct i2c_client *client, u8 *val)
 	BUILD_BUG_ON(ETP_CALIBRATE_MAX_LEN > sizeof(buf));
 
 	error = i2c_smbus_read_block_data(client,
-					  ETP_SMBUS_CALIBRATE_QUERY, buf);
+					  ETP_SMBUS_CALIBRATE_QUERY,
+					  sizeof(buf), buf);
 	if (error < 0)
 		return error;
 
@@ -138,7 +140,7 @@ static int elan_smbus_get_baseline_data(struct i2c_client *client,
 					  max_baseline ?
 						ETP_SMBUS_MAX_BASELINE_CMD :
 						ETP_SMBUS_MIN_BASELINE_CMD,
-					  val);
+					  sizeof(val), val);
 	if (error < 0)
 		return error;
 
@@ -156,7 +158,7 @@ static int elan_smbus_get_version(struct i2c_client *client,
 	error = i2c_smbus_read_block_data(client,
 					  iap ? ETP_SMBUS_IAP_VERSION_CMD :
 						ETP_SMBUS_FW_VERSION_CMD,
-					  val);
+					  sizeof(val), val);
 	if (error < 0) {
 		dev_err(&client->dev, "failed to get %s version: %d\n",
 			iap ? "IAP" : "FW", error);
@@ -174,7 +176,8 @@ static int elan_smbus_get_sm_version(struct i2c_client *client, u8 pattern,
 	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
-					  ETP_SMBUS_SM_VERSION_CMD, val);
+					  ETP_SMBUS_SM_VERSION_CMD,
+					  sizeof(val), val);
 	if (error < 0) {
 		dev_err(&client->dev, "failed to get SM version: %d\n", error);
 		return error;
@@ -192,7 +195,8 @@ static int elan_smbus_get_product_id(struct i2c_client *client, u16 *id)
 	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
-					  ETP_SMBUS_UNIQUEID_CMD, val);
+					  ETP_SMBUS_UNIQUEID_CMD,
+					  sizeof(val), val);
 	if (error < 0) {
 		dev_err(&client->dev, "failed to get product ID: %d\n", error);
 		return error;
@@ -211,7 +215,7 @@ static int elan_smbus_get_checksum(struct i2c_client *client,
 	error = i2c_smbus_read_block_data(client,
 					  iap ? ETP_SMBUS_FW_CHECKSUM_CMD :
 						ETP_SMBUS_IAP_CHECKSUM_CMD,
-					  val);
+					  sizeof(val), val);
 	if (error < 0) {
 		dev_err(&client->dev, "failed to get %s checksum: %d\n",
 			iap ? "IAP" : "FW", error);
@@ -229,7 +233,8 @@ static int elan_smbus_get_max(struct i2c_client *client,
 	int error;
 	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
-	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RANGE_CMD, val);
+	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RANGE_CMD,
+					sizeof(val), val);
 	if (ret != 3) {
 		error = ret < 0 ? ret : -EIO;
 		dev_err(&client->dev, "failed to get dimensions: %d\n", error);
@@ -249,7 +254,8 @@ static int elan_smbus_get_resolution(struct i2c_client *client,
 	int error;
 	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
-	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RESOLUTION_CMD, val);
+	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RESOLUTION_CMD,
+					sizeof(val), val);
 	if (ret != 3) {
 		error = ret < 0 ? ret : -EIO;
 		dev_err(&client->dev, "failed to get resolution: %d\n", error);
@@ -270,7 +276,8 @@ static int elan_smbus_get_num_traces(struct i2c_client *client,
 	int error;
 	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
-	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_XY_TRACENUM_CMD, val);
+	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_XY_TRACENUM_CMD,
+					sizeof(val), val);
 	if (ret != 3) {
 		error = ret < 0 ? ret : -EIO;
 		dev_err(&client->dev, "failed to get trace info: %d\n", error);
@@ -297,7 +304,8 @@ static int elan_smbus_iap_get_mode(struct i2c_client *client,
 	u16 constant;
 	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
-	error = i2c_smbus_read_block_data(client, ETP_SMBUS_IAP_CTRL_CMD, val);
+	error = i2c_smbus_read_block_data(client, ETP_SMBUS_IAP_CTRL_CMD,
+					  sizeof(val), val);
 	if (error < 0) {
 		dev_err(&client->dev, "failed to read iap ctrol register: %d\n",
 			error);
@@ -384,7 +392,7 @@ static int elan_smbus_prepare_fw_update(struct i2c_client *client, u16 ic_type,
 		 */
 		len = i2c_smbus_read_block_data(client,
 						ETP_SMBUS_IAP_PASSWORD_READ,
-						val);
+						sizeof(val), val);
 		if (len < (int)sizeof(u16)) {
 			error = len < 0 ? len : -EIO;
 			dev_err(dev, "failed to read iap password: %d\n",
@@ -454,7 +462,8 @@ static int elan_smbus_write_fw_block(struct i2c_client *client, u16 fw_page_size
 	usleep_range(8000, 10000);
 
 	error = i2c_smbus_read_block_data(client,
-					  ETP_SMBUS_IAP_CTRL_CMD, val);
+					  ETP_SMBUS_IAP_CTRL_CMD,
+					  sizeof(val), val);
 	if (error < 0) {
 		dev_err(dev, "Failed to read IAP write result: %d\n",
 			error);
@@ -493,6 +502,7 @@ static int elan_smbus_get_report(struct i2c_client *client,
 
 	len = i2c_smbus_read_block_data(client,
 					ETP_SMBUS_PACKET_QUERY,
+					ETP_SMBUS_REPORT_LEN,
 					&report[ETP_SMBUS_REPORT_OFFSET]);
 	if (len < 0) {
 		dev_err(&client->dev, "failed to read report data: %d\n", len);

-- 
2.56.0.257.gf7497c7d27-goog


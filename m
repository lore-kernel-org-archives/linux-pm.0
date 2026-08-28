Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF3233939
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927015; cv=none; b=VJ1TGHbyu0Gfq1du55h/KwmXtpuWz/sMG7l4FmacZeljs8mi8nuOLmqCy7xuRsBrcLjV1jDXOcK1ZJWSEuPuNIk3f6wxb6n8gJyOhRxZy5sbfO21lCGaXr4msugp4aPE4JJN8hn0nRdEzbzrhB5LoEY7rSvACrAyUD7m4dTDyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927015; c=relaxed/simple;
	bh=9Yw6VjPITEuzUrcjxbchMA6ceT3AAjGsCBIeRJAsVHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nePg1CsrYI2RvVX54fNo8HS4nZ7HK56aGn6uXLshGUNvdkfuzGedETwwfP59YRJsHll4ZvtYc6UQL2qG+aOknkVdxVtCdORbnxEAe2wdDLOqCp6UAGLjSSaI8kgDk0qck9+Aa1WI6wRUf+8CEP4GSm0dVj5XvXBQsjOXHh41N0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1D7oStQ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1D7oStQ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f0167e59a3so652061a34.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787927012; x=1788531812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2uVjedXiby+yAIFlJ5omJ3cMiFZpK01YVGgulAaPBNM=;
        b=J1D7oStQ9HmXLv5WpAaJksPtg2z7nFzePXmMJIBUhFPg1zAYnWvBh2Mo8iERUrMwzP
         +UseIra80W06YAA/aFU71k6IFDLULwEketfN8kCLduGw0ckulXkgSiDuxPZQClX3dzI/
         xnUJa+lgJPwStHcDRvwWFt7Jq/RhkBuYXyeOZ3UaazFWm9caiygPkUs8ib5Q33np6yKo
         2SuSFoQJgjxyD/pMAs0H1Oi8fLmxDDjYgCNRzszBaffX5J9/n+BYkPZftqX/TR3patum
         59Gsf6LvXhforU+9Gk0V27yu/ayO6IaLHv3lC9b0qDPX5jce2oiXnK0WTtZ2nbiKrVRh
         /yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927012; x=1788531812;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2uVjedXiby+yAIFlJ5omJ3cMiFZpK01YVGgulAaPBNM=;
        b=EunUm1Jc8nWi7OABXd9mIabCf5Kg5G3Hjd7WD2HPWDqADjoPlaUN65pqySqT20Nv81
         01lxMpzvq3j4I2SPmYK/pSx4a6BQzc31wdutlKUdILiI7Cag2CvJd+7O1l3mdfnjIBKg
         bukuddxnq7QekqdK/SbRdYtaiUIwfNfikDtS19jGlWxQToq79gQo/OjAxYf9R0P24X6U
         twDVVr2oI/hFldRFMsq6x4xaVn7fCHBdhY/5Z4v+BPd2fZAoX1jncFr9ySuRfdD5VPZS
         La++VyVq0U4y5dUFuxA/K/dIDHIn18WxXqFp+Plo9oggxUex8E6JCr1qDyyJp2IZy6rf
         bYbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0+V9IRCV4XvlRDxxckIuAjsRCRtVrHD3J8bjnzwGL/rL9C0E2Lp/tJ58G3u4UFtRgnCqcX2uF6Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nCl9O5JGfukKLjUZ5tPTW5ljIebk1F+sEG/Eg8xkHUU341qCuA
	oJ5KAVSQvNMZXH6o36OcxVK1+1DQCHEaJthPgMuP8JjaFwZf67dqcKNr
X-Gm-Gg: AR+sD11RtFNTgvzH24Fuc0gR29EWyQeLCbSMpFDWSy8X50KVSMiOHJiYbybeW3M1oIP
	mlUeiqc/uwQg7sPiXLdoWMs5mrHrsJNz3pjB4zqQ3763DE4RlXS8D9Umrg5mMy0aFWnaZhKiGDr
	yxKHRsLy1GPL+Y7rEg2qxCz90tbTGSiQ3n+mJXsMq/wCkriRZDEO4jC6NB+1k9bAG8uy1l3DSvy
	mX9HmslKb1ktJPAGQVHhprthxP3ZgtLmBsjxSkqAGX13VBYudstHyk+IIqPJj9OXehwvbkaf7/o
	Tn7A5yUeXBxjSX9ejSwT9Up40RYNG0Xv2+lkHZ3NQO1sfxktcuvDxFs2wuDVe4ZhVU/mWaebq9b
	yQQUSDpbPsuPI0+3fmmozOg1NzaioF/vOXj2QExDrvyKEn/p2RTLUljqn/4J9rhIk11Ks1MPCjW
	4wAzcpZR3ci0iBBqejpWx6P4C3zQ3ozPquqRlAGr0IOTvY8FJhZkVeLjQnOm0U
X-Received: by 2002:a05:6830:2715:b0:7e6:f31c:47bd with SMTP id 46e09a7af769-7f4f231a4aemr9069327a34.3.1787927012099;
        Fri, 28 Aug 2026 07:23:32 -0700 (PDT)
Received: from sh170r6 ([47.221.33.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa99f86fsm1336591a34.22.2026.08.28.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:23:30 -0700 (PDT)
From: Matt DeVillier <matt.devillier@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Matt DeVillier <matt.devillier@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] power: supply: cros_charge-control: adopt EC charge state on probe
Date: Fri, 28 Aug 2026 09:23:15 -0500
Message-ID: <20260828142318.1881516-1-matt.devillier@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825120929.13168-1-matt.devillier@gmail.com>
References: <20260825120929.13168-1-matt.devillier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver previously always forced AUTO with no charge limits at
probe, which discarded sustainer thresholds and modes set by firmware
or firmware setup before the kernel loaded.

For command versions that support GET (v2+), read the EC state into
the driver cache instead. Valid sustainer limits are adopted as AUTO
with those thresholds: while the sustainer is active the EC may report
IDLE or DISCHARGE as a transient hold/discharge step, which must not
be exposed as inhibit-charge or force-discharge. Sustainer off
(-1/-1) still maps to Linux "no limit" (0/100); other invalid limit
pairs are remapped the same way with a warning and pushed back to
the EC so the cache stays in sync.

If GET fails, fall back to the previous defaults and SET them on the
EC. Command version 1 still cannot report state and keeps forcing a
well-known configuration.

Signed-off-by: Matt DeVillier <matt.devillier@gmail.com>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
---
v3:
- adopt_ec_mode returns bool
- single-line send returns
- v1 init path uses goto defaults (Tzung-Bi)
- add Acked-by from Thomas

 drivers/power/supply/cros_charge-control.c | 151 ++++++++++++++++++---
 1 file changed, 133 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index e0f168624807..56420e1be7bd 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -21,12 +21,22 @@
 
 /*
  * Semantics of data *returned* from the EC API and Linux sysfs differ
- * slightly, also the v1 API can not return any data.
- * To match the expected sysfs API, data is never read back from the EC but
- * cached in the driver.
+ * slightly:
+ *  - EC sustainer off is lower=upper=-1
+ *  - Linux "no limit" is start=0, end=100
+ * Also the v1 API can not return any data.
  *
- * Changes to the EC bypassing the driver will not be reflected in sysfs.
- * Any change to "charge_behaviour" will synchronize the EC with the driver state.
+ * While the sustainer is active the EC may report IDLE or DISCHARGE as the
+ * current charge-control mode; that is an internal hold/discharge step, not a
+ * Linux inhibit-charge / force-discharge request. Valid sustainer limits are
+ * therefore adopted as AUTO with the reported thresholds.
+ *
+ * Sysfs reads come from a driver-side cache. On probe, command versions that
+ * support GET (v2+) are initialized from the EC so firmware or firmware-setup
+ * programmed limits and modes are preserved (unlike earlier behaviour that
+ * always forced AUTO with no limits). v1 still forces a well-known EC state.
+ * Subsequent sysfs writes keep the cache and EC in sync; changes that bypass
+ * the driver are not reflected until the next probe.
  */
 
 struct cros_chctl_priv {
@@ -44,18 +54,23 @@ struct cros_chctl_priv {
 };
 
 static int cros_chctl_send_charge_control_cmd(struct cros_ec_device *cros_ec,
-					      u8 cmd_version, struct ec_params_charge_control *req)
+					      u8 cmd_version,
+					      struct ec_params_charge_control *req,
+					      struct ec_response_charge_control *resp)
 {
-	int ret;
 	static const u8 outsizes[] = {
 		[1] = offsetof(struct ec_params_charge_control, cmd),
 		[2] = sizeof(struct ec_params_charge_control),
 		[3] = sizeof(struct ec_params_charge_control),
 	};
+	size_t insize = resp ? sizeof(*resp) : 0;
+	int ret;
 
-	ret = cros_ec_cmd(cros_ec, cmd_version, EC_CMD_CHARGE_CONTROL, req,
-			  outsizes[cmd_version], NULL, 0);
+	if (resp)
+		*resp = (struct ec_response_charge_control){};
 
+	ret = cros_ec_cmd(cros_ec, cmd_version, EC_CMD_CHARGE_CONTROL, req,
+			  outsizes[cmd_version], resp, insize);
 	if (ret < 0)
 		return ret;
 
@@ -94,7 +109,114 @@ static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
 		req.sustain_soc.upper = -1;
 	}
 
-	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version, &req);
+	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version, &req, NULL);
+}
+
+static int cros_chctl_get_ec_status(struct cros_chctl_priv *priv,
+				    struct ec_response_charge_control *resp)
+{
+	struct ec_params_charge_control req = {
+		.cmd = EC_CHARGE_CONTROL_CMD_GET,
+	};
+
+	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version, &req, resp);
+}
+
+static void cros_chctl_set_default_state(struct cros_chctl_priv *priv)
+{
+	lockdep_assert_held(&priv->lock);
+
+	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+	priv->current_start_threshold = 0;
+	priv->current_end_threshold = 100;
+}
+
+static bool cros_chctl_sustainer_limits_valid(s8 lower, s8 upper)
+{
+	return lower >= 0 && upper >= 0 && lower <= 100 && upper <= 100 && lower <= upper;
+}
+
+static bool cros_chctl_adopt_ec_mode(struct cros_chctl_priv *priv, u32 mode)
+{
+	lockdep_assert_held(&priv->lock);
+
+	switch (mode) {
+	case CHARGE_CONTROL_NORMAL:
+		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		return true;
+	case CHARGE_CONTROL_IDLE:
+		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		return true;
+	case CHARGE_CONTROL_DISCHARGE:
+		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
+		return true;
+	default:
+		dev_warn(priv->dev, "unknown charge control mode %u\n", mode);
+		return false;
+	}
+}
+
+static int cros_chctl_init_state(struct cros_chctl_priv *priv)
+{
+	struct ec_response_charge_control resp;
+	s8 lower, upper;
+	int ret;
+
+	guard(mutex)(&priv->lock);
+
+	/* v1 cannot report current state; force a well-known EC configuration. */
+	if (priv->cmd_version < 2)
+		goto defaults;
+
+	ret = cros_chctl_get_ec_status(priv, &resp);
+	if (ret < 0) {
+		dev_warn(priv->dev,
+			 "failed to read EC charge state (%pe), applying defaults\n", ERR_PTR(ret));
+		goto defaults;
+	}
+
+	lower = resp.sustain_soc.lower;
+	upper = resp.sustain_soc.upper;
+
+	/*
+	 * Valid sustainer limits mean "auto with thresholds". The EC mode may
+	 * be IDLE/DISCHARGE while the sustainer holds or bleeds SoC; do not
+	 * expose that as inhibit-charge / force-discharge.
+	 */
+	if (cros_chctl_sustainer_limits_valid(lower, upper)) {
+		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		priv->current_start_threshold = lower;
+		priv->current_end_threshold = upper;
+	} else {
+		if (!cros_chctl_adopt_ec_mode(priv, resp.mode))
+			goto defaults;
+
+		/*
+		 * Sustainer off is lower=upper=-1 → Linux "no limit" (0/100).
+		 * Any other non-valid pair is unexpected; remap, warn, and
+		 * push the cleaned state back to the EC.
+		 */
+		priv->current_start_threshold = 0;
+		priv->current_end_threshold = 100;
+
+		if (!(lower == -1 && upper == -1)) {
+			dev_warn(priv->dev,
+				 "invalid EC sustainer limits (%d/%d), treating as no limit\n",
+				 lower, upper);
+			return cros_chctl_configure_ec(priv);
+		}
+	}
+
+	dev_dbg(priv->dev,
+		"adopted EC charge state: behaviour=%d start=%u end=%u (ec mode=%u)\n",
+		priv->current_behaviour, priv->current_start_threshold,
+		priv->current_end_threshold, resp.mode);
+
+	return 0;
+
+defaults:
+	cros_chctl_set_default_state(priv);
+	return cros_chctl_configure_ec(priv);
 }
 
 static int cros_chctl_psy_ext_get_prop(struct power_supply *psy,
@@ -152,7 +274,6 @@ static int cros_chctl_psy_ext_set_threshold(struct cros_chctl_priv *priv,
 	return 0;
 }
 
-
 static int cros_chctl_psy_ext_set_prop(struct power_supply *psy,
 				       const struct power_supply_ext *ext,
 				       void *data,
@@ -305,13 +426,7 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	priv->battery_hook.add_battery = cros_chctl_add_battery;
 	priv->battery_hook.remove_battery = cros_chctl_remove_battery;
 
-	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
-	priv->current_start_threshold = 0;
-	priv->current_end_threshold = 100;
-
-	/* Bring EC into well-known state */
-	scoped_guard(mutex, &priv->lock)
-		ret = cros_chctl_configure_ec(priv);
+	ret = cros_chctl_init_state(priv);
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0


Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFE45A2BC
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587088; cv=none; b=UcXS1tXg/4peAS9gAIjvYiaAprIqUsuG0NPLqOC0D38wARgChBzSSHyn6Cn8z5POk4JNJABefBWXPcEoU3/4Ox9x7IvoibO722LaFOhSNItjbshooYdY/+8TebigL1deyzlk54wOwM0v+Ilxb5XHEp4fzBmZKmlYNb+QTONzqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587088; c=relaxed/simple;
	bh=Me5WofGk/SZRmiK89R50NVJUk7M/6dcktu4uRTpjcUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1jKvBXa0FU4fqRINY2CF56kVL1ask3kVoh3RSNgcevCsbueyzXc6jkh9hqQs3hZESosYvO50H8IjzeFucuVYiiJpO+Cagpu6rtQOvZ8sQSeROO62UCiSi/EiIL9OeLaQZnaJLw+ICBgcmnneEsZaRmvyBXAZkVg421wmqUGPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfyTGcsS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfyTGcsS"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbedf433a99so3545652a12.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787587083; x=1788191883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BY3D6q63ODXVixus4xdfU0vp7F5Ma7CkAlm3CVp5Okg=;
        b=lfyTGcsSPt4l2BxqWhFjXxBWPvko8VmSFkU+/3lnPKr2biMU/hhiGWOaSHMj7aXfPQ
         OHYPaziI3oSq16tke+iCPHx8LrP4S464o70TFxwLLTzwQPrW7vb95071Fojev4I/+UDK
         h12qUrT4C4eb4kwBiTYS3IzpoCmOHjpfxfNZA2lN+7UFuOlhKfXWHocNLnRtWsZjyPjP
         XfKQ9ZcEOkG7t1GZ5TCi5kkuYSkINVaN4AUOPvsTyyUc9v4caCgrqzij643UIwdGbuYs
         VpZ91qhfrQ+4fn6n2qlrspHy5xuptcm3D1WDK4AYqZAZaNS7CAnYxE8bdZl6Tp04Lt+5
         yHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787587083; x=1788191883;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BY3D6q63ODXVixus4xdfU0vp7F5Ma7CkAlm3CVp5Okg=;
        b=UvTpCL+Pe0EEzCLotUUB55rciXrbiJPpawEI4/ZzZpR5PL2inGOy5Q2v4ojQkrD5D4
         xW+NiUbn+MQEc9hZ+8rHe5+iLeg7p5WyK02Sb7pt4sKIsJNf+fzND2m2Gk0Et9ugnoCW
         s+FnoTR2yF1Eo9NQ3P0lDio0+o2blutQc1E2I7+KGOz2nUx1Z1Ngg6beMhqafUe5WXd7
         /5sy/zxXtxoA6HEMoPgPiSGCMggbJ6IS9UCFtvFb2ieMC/o39oNTOVhBXLLXXLW0N++t
         e5OPFPVpBGVMIx8fKDwShCHdvDW1p3kk3LJWFB3s0sNdacO5SD9ESKqPZDG4hMofIpls
         IIkw==
X-Forwarded-Encrypted: i=1; AHgh+RqiOcCgXMSZfcAgtlLxqCh/EPLc2ysiXBd2l6d/Z05FwBN3m2rEaEp4JhDxTuC7ekaFGMkI0mEfdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kO3ovDPi1eQwehLr+7mwa+ONfspzFg2kjpCzIv21CoDyLZyLiZ
	NOmXAq3/icNCkIrIXoO0ZIFzVU+zEJ3NP3fkPabQcJuY59AV10IssAAo
X-Gm-Gg: AR+sD1164/8Z4QW8l16cp296KapuvzkJtyh+jlHUq/bQgi34CNcCS3pXadPkLUQEcri
	UlmS9kLc/+69HGuBcYVeJREplCFewXyngOJ4pswnMMttmuwYWI2pfoPCBfUPdwu7qbL35b4+f2k
	cPxxSKrIRAK8jzW89Du51KMaqjpaGZqcgle8ZFnD7WhWnVdLAQChNBuVTa+RYDjbKmBWCb5HXpS
	rflCZZ50swqAMbTo2XNa6ggRLN1v05lGPqfNqFPRHz6LANDcisk8BTmgINqQQLkfyQeanSbWJDh
	VrwMVhLafg2vTIUcwK3ZFKgq85O4nrGfyuGryQ4/AWVIjqbDdekBRcMgBNHs9uXXWs8Vtoic8UG
	YiEkmBVrgDyne7fAAppWAEbDvuHzNL+PYaLVEb1mvF2SWdOjLfnSuPZ/qEQnrvStcNgNi7r//Au
	ZiYnNvHDQjAJRd07OqgIWpkUrWh2OjtpeLVYzVgn3/Haev/bzU6CevRJHCxkf0Ug==
X-Received: by 2002:a05:6a20:1605:b0:3c3:b57b:6285 with SMTP id adf61e73a8af0-3cd3003dc4fmr58213911637.13.1787587082858;
        Mon, 24 Aug 2026 08:58:02 -0700 (PDT)
Received: from sh170r6 ([47.221.33.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm29943267eec.7.2026.08.24.08.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:58:02 -0700 (PDT)
From: Matt DeVillier <matt.devillier@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Matt DeVillier <matt.devillier@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev (open list:CHROMEOS EC SUBDRIVERS),
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] power: supply: cros_charge-control: adopt EC charge state on probe
Date: Mon, 24 Aug 2026 10:57:18 -0500
Message-ID: <20260824155736.1186510-1-matt.devillier@gmail.com>
X-Mailer: git-send-email 2.53.0
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
pairs are remapped the same way with a warning.

If GET fails, fall back to the previous defaults and SET them on the
EC. Command version 1 still cannot report state and keeps forcing a
well-known configuration.

Signed-off-by: Matt DeVillier <matt.devillier@gmail.com>
---
 drivers/power/supply/cros_charge-control.c | 159 ++++++++++++++++++---
 1 file changed, 142 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index e0f168624807..fd620317cfba 100644
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
@@ -44,18 +54,20 @@ struct cros_chctl_priv {
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
 
 	ret = cros_ec_cmd(cros_ec, cmd_version, EC_CMD_CHARGE_CONTROL, req,
-			  outsizes[cmd_version], NULL, 0);
-
+			  outsizes[cmd_version], resp, insize);
 	if (ret < 0)
 		return ret;
 
@@ -94,7 +106,126 @@ static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
 		req.sustain_soc.upper = -1;
 	}
 
-	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version, &req);
+	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version,
+						  &req, NULL);
+}
+
+static int cros_chctl_get_ec_status(struct cros_chctl_priv *priv,
+				    struct ec_response_charge_control *resp)
+{
+	struct ec_params_charge_control req = {
+		.cmd = EC_CHARGE_CONTROL_CMD_GET,
+	};
+
+	lockdep_assert_held(&priv->lock);
+
+	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version,
+						  &req, resp);
+}
+
+static void cros_chctl_set_default_state(struct cros_chctl_priv *priv)
+{
+	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+	priv->current_start_threshold = 0;
+	priv->current_end_threshold = 100;
+}
+
+static bool cros_chctl_sustainer_limits_valid(s8 lower, s8 upper)
+{
+	return lower >= 0 && upper >= 0 && lower <= 100 && upper <= 100 &&
+	       lower <= upper;
+}
+
+static int cros_chctl_adopt_ec_mode(struct cros_chctl_priv *priv, u32 mode)
+{
+	switch (mode) {
+	case CHARGE_CONTROL_NORMAL:
+		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		return 0;
+	case CHARGE_CONTROL_IDLE:
+		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		return 0;
+	case CHARGE_CONTROL_DISCHARGE:
+		priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
+		return 0;
+	default:
+		dev_warn(priv->dev, "unknown charge control mode %u\n", mode);
+		return -EINVAL;
+	}
+}
+
+static int cros_chctl_adopt_ec_state(struct cros_chctl_priv *priv)
+{
+	struct ec_response_charge_control resp = {};
+	s8 lower, upper;
+	int ret;
+
+	lockdep_assert_held(&priv->lock);
+
+	ret = cros_chctl_get_ec_status(priv, &resp);
+	if (ret < 0)
+		return ret;
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
+		ret = cros_chctl_adopt_ec_mode(priv, resp.mode);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Sustainer off is lower=upper=-1 → Linux "no limit" (0/100).
+		 * Any other non-valid pair is unexpected; remap and warn.
+		 */
+		if (!(lower == -1 && upper == -1))
+			dev_warn(priv->dev,
+				 "invalid EC sustainer limits (%d/%d), treating as no limit\n",
+				 lower, upper);
+
+		priv->current_start_threshold = 0;
+		priv->current_end_threshold = 100;
+	}
+
+	dev_dbg(priv->dev,
+		"adopted EC charge state: behaviour=%d start=%u end=%u (ec mode=%u)\n",
+		priv->current_behaviour, priv->current_start_threshold,
+		priv->current_end_threshold, resp.mode);
+
+	return 0;
+}
+
+static int cros_chctl_init_state(struct cros_chctl_priv *priv)
+{
+	int ret;
+
+	lockdep_assert_held(&priv->lock);
+
+	cros_chctl_set_default_state(priv);
+
+	/* v1 cannot report current state; force a well-known EC configuration. */
+	if (priv->cmd_version < 2)
+		return cros_chctl_configure_ec(priv);
+
+	ret = cros_chctl_adopt_ec_state(priv);
+	if (ret < 0) {
+		dev_warn(priv->dev,
+			 "failed to read EC charge state (%d), applying defaults\n",
+			 ret);
+		cros_chctl_set_default_state(priv);
+		return cros_chctl_configure_ec(priv);
+	}
+
+	return 0;
 }
 
 static int cros_chctl_psy_ext_get_prop(struct power_supply *psy,
@@ -152,7 +283,6 @@ static int cros_chctl_psy_ext_set_threshold(struct cros_chctl_priv *priv,
 	return 0;
 }
 
-
 static int cros_chctl_psy_ext_set_prop(struct power_supply *psy,
 				       const struct power_supply_ext *ext,
 				       void *data,
@@ -305,13 +435,8 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	priv->battery_hook.add_battery = cros_chctl_add_battery;
 	priv->battery_hook.remove_battery = cros_chctl_remove_battery;
 
-	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
-	priv->current_start_threshold = 0;
-	priv->current_end_threshold = 100;
-
-	/* Bring EC into well-known state */
 	scoped_guard(mutex, &priv->lock)
-		ret = cros_chctl_configure_ec(priv);
+		ret = cros_chctl_init_state(priv);
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0


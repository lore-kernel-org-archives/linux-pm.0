Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971038757D
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659785; cv=none; b=aaQDnkWw7qZ9SZZg1kRIz6sa8ZOxmd+RRGuH+EoMm+Z2gJU3kTK5AZQtmal5/Mt6jRyXTOAjquicU4/ou35cdOTzRb8G0ceSJG3Rv+jHd4VUmEtUXY7NDn9EqMESAWjwgTVNOTlttOP8OdMzD8sySweke+dyGqvvOada9vB/lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659785; c=relaxed/simple;
	bh=p4w3kM1xBlw+O8A+jpbUYSaYyR3vT+KL2j0ol5JtwHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpEIGDuoGdOo6oPxFFqOOPWcoDZVzHf6EYpBXlJxfgyOrp+JTWwMxQHWaDhoLysp0oYMc+KTCGmaZ3nHcLvfVQG5go+1S8CMOiMc1CGKge8Xs3wGSX+eiBCdnMr5bbwlBUtQUUh9zntvWYraNz3N34RbSTya2aGcli6cTi9r7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieoV15o/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieoV15o/"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ee125ec926so5057181a34.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787659782; x=1788264582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pbhHIeykXIEDLlwFFQF85kHueArjWfOYa3UekMf5/zw=;
        b=ieoV15o/xfRCHR3WHVGNYGtwcrCCed4SBnepQeEERh8c112gezMLybRpz+0Sn0kP2b
         XV4g+Bh/XZu6+cWUp4/xEwSY5GItMf7LsWwl/AGcwla7HeKV3Bwdvm2rzFVZE9e44voh
         fWpH0zgTGXKpTvGOL2iC2EPykQDPNsXQEYs6qLTqsLrvHyRjo5BxWOhZXOgWZ71f+Gqb
         hTPTnUSwjWWff+AzO7Ct5xupqDBlkXUocWm+7GYAItQyMLgKr4Nm7fuKBeUJune7ebMs
         nPQvR3wf160TLqKCfb6l5m7DQVx+ONQSartsiFrTRvd1wJmVh+bSzjn52PlenihQKxNr
         NEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787659782; x=1788264582;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbhHIeykXIEDLlwFFQF85kHueArjWfOYa3UekMf5/zw=;
        b=SBN8CkZnDucrOp9Qlb9weNZASMLGOkMvpg5KkWMYW1EbTZGB1UNGmx20yk8qKwsZbX
         KzGCN194h1EieTLryFQ+WkZfrrl48iOEYa9llhyaPbQZC/AITusXA+l4azG2/r/Lz2yU
         708uVOD5ttnQdJPnISIVK7P8/suddNnM/0zgXWT7+JNuRQXLuPpL4aBTCR0S94NyDFR/
         d24kghL0E/ZVbg2KzdEwE9Ql4BEfXTtnQuI/CGHYfH0zCxipe7cKhyI//TuG2A912QIS
         qrriJOzDYcV4yOi2CrIEEXerUOnkz2KqYvz+NzdLewm/Euut304BYUyRx6+c7ILhan19
         Mf2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpMxObXA5w3tDiSH+gdmjG73FVzdtUXXnNNiXEnjL3imkpkuEn3Wqf0AFjzUAPIXP7a4yxyVT/14Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lAZGH3bSGrD+lT4J7F/Iswqaq8SCpCkZ77KUCSDBh2PnbVaY2j
	9U7C0KjG9F7ikijEFshx+7vuCMn8rH9G022pEi395nEncdtHrbalSsKG
X-Gm-Gg: AR+sD11r863/tVKYX9N6di4sAg74DprjjWN6hsYiZKzNmXoY4PS2IEUd/X+69GY2Ue+
	SkYYWhYenfnldUBDitgYW2AUpXGcD04UqixI14iOiTc739E2IWuVqd4+KYzCHVSERka5Nu/r/P7
	Wl4U2LSqa62Abdapfw13S9e5bguLrmrFLIV7sbmX7s5C2hscGGP/RX7SEu22v9xdlzuFNJIbkIE
	eVvKdCyVEtS4ZO0Q3C5Z55D7OEzdwtEngZM58DwV73opD59hz1UWFbeEiOYUEOwSlukk1zrnQMa
	wnXr9UHm6t/F7KMEhLquzP6OwBDGCrHKkazsBZmm3JRoqEDWNoIGn23piy8qBruf4VqOERcFtU5
	07y+Y6aKscYk6md0Q15v3IcMAV+PlHX2Pb0To1qYHtZCsQQBJeOUzvZgOBEptyEgn2D85Gldvsi
	+LV8lpVryy3HffwnSah1maYoYur+R73iI9nejwexcFWlhxUj1wm3iXJT50AcjHrZzTZQlRfKc=
X-Received: by 2002:a05:6830:7003:b0:7e6:f4a3:1df5 with SMTP id 46e09a7af769-7f4612ec7efmr39453403a34.1.1787659782025;
        Tue, 25 Aug 2026 05:09:42 -0700 (PDT)
Received: from sh170r6 ([47.221.33.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fb1c290sm6635788a34.8.2026.08.25.05.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:09:41 -0700 (PDT)
From: Matt DeVillier <matt.devillier@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Matt DeVillier <matt.devillier@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] power: supply: cros_charge-control: adopt EC charge state on probe
Date: Tue, 25 Aug 2026 07:08:59 -0500
Message-ID: <20260825120929.13168-1-matt.devillier@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824155736.1186510-1-matt.devillier@gmail.com>
References: <20260824155736.1186510-1-matt.devillier@gmail.com>
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
v2:
- zero EC response in send helper; take mutex inside init_state
- reconfigure EC on invalid sustainer limits; use %pe for errors
- address lockdep placement feedback

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


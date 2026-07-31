Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D733DA7D6;
	Fri, 31 Jul 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492036; cv=none; b=iE/YpX4zSIyehVpWaq0KCyygdf5MXFT3tE/IxtpkT03fLuI8ox+n+AJuGqJtV3tdwfAbu4mz9B00iWSPs0WGDgzTTbiCIiWLgEgcOHB6QX8CnPaYekbEZsCpFnV4SMe6rbDe08QPYZ7PZpZjwkf5iwpkv19qIiUThSdL8YZ0jMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492036; c=relaxed/simple;
	bh=wqx/RCL9c6lZkVHvvmNz55ZvphR4grfMr6OMQ5/mwXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cd7WWqWjs4bpY70Y9eSgBQfojPMS04ZldkH9YxlpEyOXEObiExrYeIktK54ZAIAHfyeomlR6FTYem4nXD3PpV1m47Qc0dd/rFC/XOrQfFSxhuV551vdBnLuyo5h46ZW2UmUX6BYZNS1sJoV9E1ol5ZnjOZpAWyfyCw9OVD6B8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CA28E202C88;
	Fri, 31 Jul 2026 12:00:00 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wpk24-002Bno-22;
	Fri, 31 Jul 2026 12:00:00 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wpk24-00000001F2w-2AhX;
	Fri, 31 Jul 2026 12:00:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
	Francesco Valla <francesco@valla.it>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v12 4/6] reboot: extend psc_reason with power-on and reset causes
Date: Fri, 31 Jul 2026 11:59:57 +0200
Message-ID: <20260731095959.296056-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731095959.296056-1-o.rempel@pengutronix.de>
References: <20260731095959.296056-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

psc_reason covered only the protection reasons. Extend it to mirror the
full POWER_ON_REASON_* vocabulary - power-on, watchdog, software,
external, RTC, reset button, CPU clock and crystal failures - so a
provider can report why the system last powered on, not only why it was
shut down. New values are appended to keep the existing numeric ABI.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

---
changes v12:
- new patch
---
 include/linux/reboot.h | 28 ++++++++++++++++++++++++++++
 kernel/reboot.c        |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 4c5327dd7645..13f004ad1066 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -225,9 +225,28 @@ extern void orderly_reboot(void);
  *	management errors, or an unrecoverable hardware fault requiring
  *	immediate response.
  *
+ * @PSCR_POWER_ON: Regular cold power-on (e.g. via a PMIC power-on request).
+ *
+ * @PSCR_WATCHDOG: Reset caused by a watchdog timeout.
+ *
+ * @PSCR_SOFTWARE: Software-initiated reset or reboot.
+ *
+ * @PSCR_EXTERNAL: Reset asserted through an external pin or reset input.
+ *
+ * @PSCR_RTC: Wake-up or power-on triggered by the RTC.
+ *
+ * @PSCR_RESET_BUTTON: Reset triggered by a user reset button.
+ *
+ * @PSCR_CPU_CLK_FAIL: Reset caused by a CPU clock failure.
+ *
+ * @PSCR_XTAL_FAIL: Reset caused by a crystal oscillator failure.
+ *
  * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
  *	value is useful for range checking and potential future extensions
  *	while maintaining compatibility.
+ *
+ * The reasons mirror the POWER_ON_REASON_* strings in
+ * <linux/power/power_on_reason.h>; keep the two in sync when extending.
  */
 enum psc_reason {
 	PSCR_UNKNOWN,
@@ -236,6 +255,15 @@ enum psc_reason {
 	PSCR_REGULATOR_FAILURE,
 	PSCR_OVER_TEMPERATURE,
 	PSCR_EC_PANIC,
+	/* Append new reasons here; the numeric order is ABI. */
+	PSCR_POWER_ON,
+	PSCR_WATCHDOG,
+	PSCR_SOFTWARE,
+	PSCR_EXTERNAL,
+	PSCR_RTC,
+	PSCR_RESET_BUTTON,
+	PSCR_CPU_CLK_FAIL,
+	PSCR_XTAL_FAIL,
 
 	/* Number of reasons */
 	PSCR_REASON_COUNT,
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 929496be20c0..3e262c4450c5 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1101,6 +1101,14 @@ static const struct psc_reason_desc psc_reason_descs[] = {
 	[PSCR_REGULATOR_FAILURE] = { "regulator-failure", POWER_ON_REASON_REGULATOR_FAILURE },
 	[PSCR_OVER_TEMPERATURE]	 = { "over-temperature",  POWER_ON_REASON_OVER_TEMPERATURE },
 	[PSCR_EC_PANIC]		 = { "ec-panic",	  POWER_ON_REASON_EC_PANIC },
+	[PSCR_POWER_ON]		 = { "power-on",	  POWER_ON_REASON_REGULAR },
+	[PSCR_WATCHDOG]		 = { "watchdog",	  POWER_ON_REASON_WATCHDOG },
+	[PSCR_SOFTWARE]		 = { "software",	  POWER_ON_REASON_SOFTWARE },
+	[PSCR_EXTERNAL]		 = { "external",	  POWER_ON_REASON_EXTERNAL },
+	[PSCR_RTC]		 = { "rtc",		  POWER_ON_REASON_RTC },
+	[PSCR_RESET_BUTTON]	 = { "reset-button",	  POWER_ON_REASON_RST_BTN },
+	[PSCR_CPU_CLK_FAIL]	 = { "cpu-clock-failure", POWER_ON_REASON_CPU_CLK_FAIL },
+	[PSCR_XTAL_FAIL]	 = { "crystal-failure",	  POWER_ON_REASON_XTAL_FAIL },
 };
 
 /**
-- 
2.47.3


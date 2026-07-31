Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586D3CE489;
	Fri, 31 Jul 2026 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492022; cv=none; b=rWMuRPAduveuWHKKKqjJWVrP5k5KRQvIell9LKoPJJ+BTyCUnGhDdTHN9eDQhhWHUkWI7M7jknoOTX4xOPy3xms4ennnFuYvuyS9ga9egj6AAM2kGxExS+e04DYFPRg/FIj1vqBJcwMtbIpmq/UDIy7sED6jQnrsrZUSsfo7xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492022; c=relaxed/simple;
	bh=jgNMoFkk1lOX2dWjBWBk97ZtsAagpRt9a47jcgf3wcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbLvWtD5y3wTEGOhr/SraBIw5UzgqWrU9vqDxe4fNWhvhdwBlDUMzFXIWmN/VdyrOlflQp+DLHA7gl9ukH/Fla1SMXYthjAokxL6fPgnh+OPQc6q+dnCGAZ3Jrpb0I9cVo7bLr2NbsAvJUmEsbjG/97ppzAxVXmXecDLEClLMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B3E3F202B54;
	Fri, 31 Jul 2026 12:00:00 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wpk24-002Bnl-1l;
	Fri, 31 Jul 2026 12:00:00 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wpk24-00000001F2P-1oVi;
	Fri, 31 Jul 2026 12:00:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
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
Subject: [PATCH v12 1/6] power: Extend power_on_reason.h for upcoming PSCRR framework
Date: Fri, 31 Jul 2026 11:59:54 +0200
Message-ID: <20260731095959.296056-2-o.rempel@pengutronix.de>
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

Prepare for the introduction of the Power State Change Reason Recorder
(PSCRR) framework by expanding the power_on_reason.h header. This
extension includes new power-on reasons:
- POWER_ON_REASON_OVER_CURRENT for over-current conditions.
- POWER_ON_REASON_REGULATOR_FAILURE for regulator failures.
- POWER_ON_REASON_OVER_TEMPERATURE for over temperature situations.
- POWER_ON_REASON_EC_PANIC for EC panics.
- POWER_ON_REASON_EXTERNAL for an external reset source.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
changes v12:
- add POWER_ON_REASON_EXTERNAL
changes v10:
- add Reviewed-by: Sebastian Reichel ...
changes v6:
- add POWER_ON_REASON_EC_PANIC
- s/POWER_ON_REASON_OVERTEMPERATURE/POWER_ON_REASON_OVER_TEMPERATURE
(cherry picked from commit a6fb08a81864e2ed17cebba9f249af3d44e42c3f)
---
 include/linux/power/power_on_reason.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 95a1ec0c403c..13e61ace14f5 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -15,5 +15,10 @@
 #define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
 #define POWER_ON_REASON_BROWN_OUT "brown-out reset"
 #define POWER_ON_REASON_UNKNOWN "unknown reason"
+#define POWER_ON_REASON_OVER_CURRENT "over current"
+#define POWER_ON_REASON_REGULATOR_FAILURE "regulator failure"
+#define POWER_ON_REASON_OVER_TEMPERATURE "over temperature"
+#define POWER_ON_REASON_EC_PANIC "EC panic"
+#define POWER_ON_REASON_EXTERNAL "external reset"
 
 #endif /* POWER_ON_REASON_H */
-- 
2.47.3


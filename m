Received: from outbound.ms.icloud.com (ms-2002f-snip4-11.eps.apple.com [57.103.74.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC82282F3C
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114890; cv=none; b=fJEd3Ga+/7MdRPb5EF7s1Hb8K6/fi2bGdvXH2uPliUxovJC8b9QFGF7GnSTyEoEfbTwSVtWy1xZRg7RL7///MfnzCvPklIrjH+EHcrvZkYZFFHzSTmEnxGeOzY5vvss5/uDvJR0tGRckuuGNcHbp9nsooOnJEJjH4bWuEFH7UVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114890; c=relaxed/simple;
	bh=Yqp/LmF9qrJkcia/VgTBRXCKiUuaIEfWjsyxGKJkpB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxf/39bYJgbOr4KhHjrAFGCyvQqYlI3C5rkC4Iuo51HbEieOYEPsOYfmoRPh2wLxgKUQ7LUUW/skvKaUV7rQcWEbKpqwMCntQsvex2T2sQUrXBTIiYc66fa5HE/l6tEYBKIAeTDIu5w61C233bPbR2+GnYWHxGkeG9Mf+qsJAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bGJIbAor; arc=none smtp.client-ip=57.103.74.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bGJIbAor"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id AFBCB18000BF;
	Mon, 27 Jul 2026 01:14:43 +0000 (UTC)
X-ICL-RepId: 019fa123-7605-7381-b48c-330795e1c65c
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgVdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114887; x=1787706887; bh=XdUvF0EQuxD680pl2WtiZ8e1yNIhOS0Z+TO7jpktRZs=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=bGJIbAoryV0sxGYeI6mHngFTzzwlNJJtfieeP4FM1CLp23pObPdGOjdh09Lrx72ZRLOSeVv9E2hblS8ZBw9ZrEN2+zy+lgs//uALl59+13zaTmnskNLEY4iE7RJHTkOOE6Bb2OP9W9e2UyMzzL9oNSdjXD+/c93qdS3gLPY+/p8O0q5Ycurivlz56JNBqeTJHe5yynSTlf98P1pY3tOwXEjId/UptCjVQm0WtUk1scJBdC3E3NsdeQgFO35K/rz9v6Et8JfRb/ivRZGLblivI8aSbFBqIsnTWaPT2Dok/ocW1bnq0QO8lGMpI/UiY8CrEp3sH9FK39Rfd9bOliOJKQ==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id 9C45918000C9;
	Mon, 27 Jul 2026 01:14:41 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v4 06/11] power: supply: max17042_battery: Retry failed MAX17055 initialization
Date: Sun, 26 Jul 2026 21:13:04 -0400
Message-ID: <20260727011319.621794-7-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX0Zqx+NmqDR/a
 LS/vrGvlOuVtFU4x/3N6AGFMJRSJ4+e7mg91ezpjVCUnmkjFJAaNITdYZeys3kawPYh/QWNYf68
 k8oyVQOXDYh1oxfm6fpNunx3DRRkWbOxTSEjNww1xXGAkD4iI4NyipKhMeLOvfJcL8dYbAhJa0k
 D6EJc1cFbWPlwRqS2rRDglT3QFjeYGZ2aWoDQFESB6snT1JLk/f4UHnD5rhKlqt5oCoPOlWayAi
 9oEcJ2x7hj0CW531t55Cklpq8QBimfLp4ycL5aHpdaZ6LoF/ZNUe7iJYkma/pH3K1rEwdZXq2rX
 sNYxC/htg7ONYKJcMXGN+fgjOb1+2sd6lQrLGi/kgnPNKrlWQsjH4BWA03Lqdc=
X-Proofpoint-ORIG-GUID: BWYM9lKTOjjTsa399sdp02IlIOPUkVt6
X-Proofpoint-GUID: BWYM9lKTOjjTsa399sdp02IlIOPUkVt6
X-Authority-Info-Out: v=2.4 cv=DfEaa/tW c=1 sm=1 tr=0 ts=6a66b105
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iApKCTF-_JrVluo7lTsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10

From: Vincent Cloutier <vincent@cloutier.co>

MAX17055 initialization can fail on register I/O. Propagate the ModelCfg
Refresh command error and retry MAX17055 failures every 10 seconds so a
transient startup error does not become permanent. Report failures for the
other gauges without changing their one-shot behavior.

Notify consumers whenever initialization succeeds, including on the first
attempt. The core registration notification is deferred and can observe
-EAGAIN while asynchronous gauge initialization is still running, so a new
notification is needed when driver-backed properties become available.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 37 +++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 9210bdb4d67e..27d881d4324f 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -62,6 +62,8 @@
 #define MAX17042_RESISTANCE_LSB		1 / 4096 /* Ω */
 #define MAX17042_TEMPERATURE_LSB	1 / 256 /* °C */
 
+#define MAX17055_INIT_RETRY_DELAY_MS	10000
+
 struct max17042_chip {
 	struct device *dev;
 	struct regmap *regmap;
@@ -847,13 +849,13 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
 }
 
-static void max17055_init_chip(struct max17042_chip *chip)
+static int max17055_init_chip(struct max17042_chip *chip)
 {
 	max17042_override_por_values(chip);
 
-	regmap_write_bits(chip->regmap, MAX17055_ModelCfg,
-			  MAX17055_MODELCFG_REFRESH_BIT,
-			  MAX17055_MODELCFG_REFRESH_BIT);
+	return regmap_write_bits(chip->regmap, MAX17055_ModelCfg,
+				 MAX17055_MODELCFG_REFRESH_BIT,
+				 MAX17055_MODELCFG_REFRESH_BIT);
 }
 
 static int max17042_init_chip(struct max17042_chip *chip)
@@ -861,10 +863,13 @@ static int max17042_init_chip(struct max17042_chip *chip)
 	struct regmap *map = chip->regmap;
 	int ret;
 
-	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
-		max17055_init_chip(chip);
-	else
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
+		ret = max17055_init_chip(chip);
+		if (ret)
+			return ret;
+	} else {
 		max17042_override_por_values(chip);
+	}
 
 	/* After Power up, the MAX17042 requires 500mS in order
 	 * to perform signal debouncing and initial SOC reporting
@@ -996,16 +1001,26 @@ static void max17042_init_worker(struct work_struct *work)
 {
 	struct max17042_chip *chip = container_of(to_delayed_work(work),
 				struct max17042_chip, work);
-	int ret;
+	int ret = 0;
 
 	/* Initialize registers according to values from config_data */
-	if (chip->enable_por_init && chip->config_data) {
+	if (chip->enable_por_init && chip->config_data)
 		ret = max17042_init_chip(chip);
-		if (ret)
-			return;
+
+	if (ret) {
+		if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
+			dev_warn_ratelimited(chip->dev,
+				"initialization failed: %d, retrying\n", ret);
+			schedule_delayed_work(&chip->work,
+				msecs_to_jiffies(MAX17055_INIT_RETRY_DELAY_MS));
+		} else {
+			dev_err(chip->dev, "initialization failed: %d\n", ret);
+		}
+		return;
 	}
 
 	WRITE_ONCE(chip->init_complete, true);
+	power_supply_changed(chip->battery);
 }
 
 #ifdef CONFIG_OF
-- 
2.55.0


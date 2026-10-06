Received: from mail.haxxors.com (mail.haxxors.com [85.14.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B7311C36;
	Tue,  6 Oct 2026 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.14.200.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255266; cv=none; b=Z0deq4xN4HMdyxygsPHkN1GASp+VxQ/xzPXPULHRU9x8N89dkuZGpV8I3Cp14S95yimEir+r97s+zykUndHY+FwZtyZk4YsdLZ44euZ8oKg/iH5b5Guz94uvO0Rii2JXz1Lax7hiIF0Y8IeMK+iEMJfMsVwqvXNn117QcHESAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255266; c=relaxed/simple;
	bh=0FklO53WXz7f54itp1hkBvY8/zcxtH4skJdGafJMBT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofzSNPr3YNeq19zD+xHP6Fj3M8Lbc/sMn2yYfeVmqcG4oSuQbgoHwVfGA4bqDKuv5Q1MdUafUMrqeJt9o+RHrDCjc2uXo1AfdmxtCmXYSwZ10HgZZmsCTgcgjRjRWc6mDfUSZV993NDuiBm79DISvzjYvLCSZYCn14zEEJnywPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me; spf=pass smtp.mailfrom=buechner.me; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=mVv0d8ZU; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=oLmqOqXT; arc=none smtp.client-ip=85.14.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buechner.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="mVv0d8ZU";
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="oLmqOqXT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791255262; bh=0FklO53WXz7f54itp1hkBvY8/zcxtH4skJdGafJMBT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVv0d8ZUbZkXgfEHG2oy5CGwlLFXbbpzd2N2l2bNQEupWfTEHAx2lvn0/5/xlkRXn
	 +CcZzQN/vop8y50Hw+BPxUHjbL0/KOue1dsjEyc90wVqcoMv8DsiA/tnhKy5+65Id9
	 rlMiFhFzmdDl3jF1MZTfRjmowPBWab9rz0h5bmzs=
Received: from localhost (localhost [127.0.0.1])
	by mail.haxxors.com (Postfix) with ESMTP id 7B1CD53105;
	Tue, 06 Oct 2026 04:54:22 +0200 (CEST)
X-Virus-Scanned: Debian amavis at mail.haxxors.com
Received: from mail.haxxors.com ([127.0.0.1])
 by localhost (mail.haxxors.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PIj6XKHpFbrk; Tue,  6 Oct 2026 04:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791255260; bh=0FklO53WXz7f54itp1hkBvY8/zcxtH4skJdGafJMBT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLmqOqXTelinS3n35s9bWySXydUzShspuFhfR4+MY+XnSegOn34CeNnod7p6aisro
	 E7uC9khrXaucpgH3qwUWHTr9j6BR1/TOYiXuIt5u0icz8ZOzyUa/VmooyyLeOolNUI
	 3VLKYP3YBvrPeMUiXWkfAoO9mkKZo7LegvV5oJkQ=
Received: from esports.myloc.de (p200300ee8f09a300264bfefffe4ffb4b.dip0.t-ipconnect.de [IPv6:2003:ee:8f09:a300:264b:feff:fe4f:fb4b])
	(Authenticated sender: nils@buechner.me)
	by mail.haxxors.com (Postfix) with ESMTPSA id A680A530C7;
	Tue, 06 Oct 2026 04:54:20 +0200 (CEST)
From: =?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>
Subject: [PATCH 1/2] thermal/drivers/mediatek/auxadc: Register per-sensor thermal zones
Date: Tue,  6 Oct 2026 04:54:09 +0200
Message-ID: <20261006025410.506443-2-nils@buechner.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006025410.506443-1-nils@buechner.me>
References: <20261006025410.506443-1-nils@buechner.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver registers only thermal zone 0, which reports the hottest of
all sensors. The MT8183 devicetree also describes a zone per sensor
(soc, gpu, md1, cpu-little, cpu-big, abb as sensor ids 1-6), and
mtk-svs looks up the "gpu-thermal" zone for its GPU banks. Without it
SVS fails to probe on MT8183:

  SVSB_GPU: cannot get "gpu-thermal" thermal zone
  mtk-svs 1100bc00.svs: error -ENODEV: svs bank resource setup fail

so the SoC never gets its calibrated, lower voltages.

Additionally register every sensor that has a devicetree zone, using
sensor id = sensor number + 1, read from that sensor's own measurement
register. Sensors without a zone are skipped, so SoCs whose devicetrees
only describe zone 0 are unaffected.

Runtime-tested on an Acer Chromebook Spin 311 (MT8183, juniper) with a
7.0-based kernel (the hardware is not set up to boot mainline);
build-tested on mainline with W=1. On the device: all six
sensor zones register and read plausible values (31-34 C idle, close
to the board sensors), and mtk-svs finds gpu-thermal.

The change and this changelog were drafted with an AI coding assistant
during a debugging session on the hardware; they were reviewed and
tested by the submitter.

Assisted-by: Claude Opus 5.5
Signed-off-by: Nils Büchner <nils@buechner.me>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 80 ++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 9ee2e7283..59c8eaf87 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -308,6 +308,13 @@ struct mtk_thermal_bank {
 	int id;
 };
 
+/* A single sensor, exposed as its own thermal zone (DT sensor id = sensor + 1) */
+struct mtk_thermal_sensor {
+	struct mtk_thermal *mt;
+	int bank;
+	int index;
+};
+
 struct mtk_thermal_data {
 	s32 num_banks;
 	s32 num_sensors;
@@ -870,6 +877,77 @@ static const struct thermal_zone_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
+static int mtk_read_sensor_temp(struct thermal_zone_device *tz, int *temperature)
+{
+	struct mtk_thermal_sensor *sensor = thermal_zone_device_priv(tz);
+	struct mtk_thermal *mt = sensor->mt;
+	const struct mtk_thermal_data *conf = mt->conf;
+	struct mtk_thermal_bank *bank = &mt->banks[sensor->bank];
+	int temp;
+	u32 raw;
+
+	mtk_thermal_get_bank(bank);
+	raw = readl(mt->thermal_base + conf->msr[sensor->index]);
+	temp = mt->raw_to_mcelsius(mt, conf->bank_data[sensor->bank].sensors[sensor->index],
+				   raw);
+	mtk_thermal_put_bank(bank);
+
+	if (!mtk_thermal_temp_is_valid(temp))
+		return -EAGAIN;
+
+	*temperature = temp;
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
+	.get_temp = mtk_read_sensor_temp,
+};
+
+/*
+ * Zone 0 reports the hottest sensor. Also register every individual sensor
+ * the devicetree describes (sensor id = sensor number + 1): MT8183 SVS looks
+ * up its GPU bank temperature through the "gpu-thermal" zone and cannot
+ * probe without it. Sensors without a devicetree zone are skipped.
+ */
+static int mtk_thermal_register_sensors(struct mtk_thermal *mt)
+{
+	const struct mtk_thermal_data *conf = mt->conf;
+	struct thermal_zone_device *tzdev;
+	struct mtk_thermal_sensor *sensor;
+	int id, b, i;
+
+	for (id = 1; id <= conf->num_sensors; id++) {
+		sensor = NULL;
+		for (b = 0; b < conf->num_banks && !sensor; b++) {
+			for (i = 0; i < conf->bank_data[b].num_sensors; i++) {
+				if (conf->bank_data[b].sensors[i] != id - 1)
+					continue;
+				sensor = devm_kzalloc(mt->dev, sizeof(*sensor), GFP_KERNEL);
+				if (!sensor)
+					return -ENOMEM;
+				sensor->mt = mt;
+				sensor->bank = b;
+				sensor->index = i;
+				break;
+			}
+		}
+		if (!sensor)
+			continue;
+
+		tzdev = devm_thermal_of_zone_register(mt->dev, id, sensor,
+						      &mtk_thermal_sensor_ops);
+		if (IS_ERR(tzdev)) {
+			if (PTR_ERR(tzdev) == -ENODEV)
+				continue;
+			return dev_err_probe(mt->dev, PTR_ERR(tzdev),
+					     "failed to register sensor %d\n", id);
+		}
+	}
+
+	return 0;
+}
+
 static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 				  u32 apmixed_phys_base, u32 auxadc_phys_base,
 				  int ctrl_id)
@@ -1294,7 +1372,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
 
-	return 0;
+	return mtk_thermal_register_sensors(mt);
 }
 
 static struct platform_driver mtk_thermal_driver = {
-- 
2.53.0


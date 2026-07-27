Received: from outbound.ms.icloud.com (ms-2005f-snip4-11.eps.apple.com [57.103.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164B25A354
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114885; cv=none; b=FC8d8bUrP7jGA5XvxZVbXOphX3Gq87zyNwmEFcYcv8Rnx3uC0wS5f7eSw9KvXC2UdhJ/XrPmIe8GHpm3NbFX08AKtTfFpS2vdEGt6Fh9ABoFNNvydsfAjhmL73CQR4goGaujJ1zraE2KJcS4YoySULZC0G7CIFAhNTmk7BqsKj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114885; c=relaxed/simple;
	bh=vb+ChfhxrZxwoJV1BppbZFGPbh1q+VcvAe9thHPxhRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox1A1zR4wlBDcXiK8UO9brf1mAJOhBqsqP/4oiUZLOrFoYR1wxVAZut6nimWtZGMJXc+RT0nZXdmAUszrrdaPEumpHEvvh+9zoJiDMvEmqzDV380UI4yuWDuaUJ4FXJAuw23BaHqdTnmZCr3VQzFO61qCTwGbSYtQOvZUkmMTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0s63cobU; arc=none smtp.client-ip=57.103.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0s63cobU"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id 3A1091800106;
	Mon, 27 Jul 2026 01:14:37 +0000 (UTC)
X-ICL-RepId: 019fa123-609d-747c-a031-746fad41bbbf
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgFdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114881; x=1787706881; bh=rrWPabv/PiAqbaahZ4xAQxt39tsmPYCm8z+8tsXOcio=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=0s63cobUvgx/w9q3uYckw9T6g3+j4ZDel2nzSwB2VoFhVFscfdudjD8enU/Hlwaui/WkjAvyfg2Sgj3EAM8pmxBAQkHB8V5QEIOzM4jx2cc32eYfo6lOSA2dgq7a9dz6wEVKP++XLCl8PAS0h8ATDK1m5qm29AKpX+F9RLcjQdAXkIEwknO/61Q45Fl7kB0Sv7O9trwUHQJXF6wAIT+DFP2aYjQ/T9bKT1OeQ4Cg4Ki79efdw2Sa4smMIMmY2t/lb7V0hH/pm4JZv5S0CKMB9hxTHmcVfTu8TFJ8GL8vhkt0HShzCO5SEtlaXykGi9nQ1j0kbB0faEVV9OpZjhHFew==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id 939C418000C1;
	Mon, 27 Jul 2026 01:14:33 +0000 (UTC)
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
Subject: [PATCH v4 02/11] power: supply: max17042_battery: Separate MAX17055 initialization
Date: Sun, 26 Jul 2026 21:13:00 -0400
Message-ID: <20260727011319.621794-3-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Oj4ViM0JghTpsZd1bKInxAyRr1DYwyuH
X-Authority-Info-Out: v=2.4 cv=f5FFxeyM c=1 sm=1 tr=0 ts=6a66b0ff
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Gx0_Zz62HskSH6l1XwUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX+ofTaa0+bhiC
 xZmtNjmOLTQ8NDYdhce3MBMfb2xzqgjGMjQV42VrP0cUcj8eDw++KbGM7mmswVh4rLrhnZf4dW8
 FqmK0vrLJC/YtF2lkSzVtyH9TwfHUIWUyCOqR5/UvPpSwiDjZ19xiv9YuRrt0+xoeml6Sb6iA+D
 w/d1nUgYapc7cLl6I2PEkziuDbPowG+6IfhQH+IDye42gr82AE4zEer9tx+BQAeJ2ghXf8Ii39V
 leETGLIIbrJc60HsjvaHiNrmtbbyMAqebIkvZPpiDqYNsn0kLGRD/wftaTH6lgmi/0QcD65kb4j
 1EEgY7LM7xboaI0RmKQfHl9S1RZvVQE/J8LNC2VcILYN2x+BJeeISsi4aQUzuo=
X-Proofpoint-ORIG-GUID: Oj4ViM0JghTpsZd1bKInxAyRr1DYwyuH

From: Vincent Cloutier <vincent@cloutier.co>

MAX17055 uses ModelCfg.Refresh instead of the characterization-data
flow used by the other supported gauges. Move its existing initialization
steps into a dedicated helper without changing behavior. This isolates the
chip-specific path for subsequent EZ Config changes.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index d409d2f0d383..70c5d5ce945d 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -847,18 +847,24 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
 }
 
+static void max17055_init_chip(struct max17042_chip *chip)
+{
+	max17042_override_por_values(chip);
+
+	regmap_write_bits(chip->regmap, MAX17055_ModelCfg,
+			  MAX17055_MODELCFG_REFRESH_BIT,
+			  MAX17055_MODELCFG_REFRESH_BIT);
+}
+
 static int max17042_init_chip(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
 	int ret;
 
-	max17042_override_por_values(chip);
-
-	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
-		regmap_write_bits(map, MAX17055_ModelCfg,
-				  MAX17055_MODELCFG_REFRESH_BIT,
-				  MAX17055_MODELCFG_REFRESH_BIT);
-	}
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
+		max17055_init_chip(chip);
+	else
+		max17042_override_por_values(chip);
 
 	/* After Power up, the MAX17042 requires 500mS in order
 	 * to perform signal debouncing and initial SOC reporting
-- 
2.55.0


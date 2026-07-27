Received: from outbound.ms.icloud.com (ms-2005j-snip4-11.eps.apple.com [57.103.72.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30D27E1A1
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114888; cv=none; b=VHjk1oZI0RxldDaaXU9NpNOGRtsUNXxffe++66570hHL22X3T3cCvPxi4sDOkegZB01bVCRQKbNydqVrYYtTd44g8ZlHW3WdfNz2SuHF8fJYOiEfnvlTRbtkiYx2UMFa0jczKu/rnC/yxyYZLtBgLZNS6QUuxmIL6rCuPg+4qcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114888; c=relaxed/simple;
	bh=mfbkRLOH8HPJTJ9WZ0ZoZaCGB2qhayyzviGQThvN/AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0cd4kczg2qKuxllEstyE0IhZZHfcgd+rfBZb4GY8kdaHcFKtc/OgM0B2AxXGCp0AaDDGanCxHToTPO5HRzDq5IJsYKblkpRVBKdW6v5tAw2CdEvpUBsP7BBBYh5SOcnuKdIX0OO1rnThMOH3Jl+re31mpuEyzpFCHWdm4bNrVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=suXGBHgb; arc=none smtp.client-ip=57.103.72.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="suXGBHgb"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id 627B518000F5;
	Mon, 27 Jul 2026 01:14:42 +0000 (UTC)
X-ICL-RepId: 019fa123-70d5-79c8-aaa4-c8f78156efe3
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgRdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114886; x=1787706886; bh=9KHp6CmaDObAOx5jQscaPIZ3kErwFIbx+Xb8UouCvuk=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=suXGBHgbUD9rhBTga3ckPp4U+0XLWLCDyOyGwBbXg/Q+qTKU54mRLkP5q7b44eff1DyDQx1zmMSNEraUnw/5tlZkcwPsKxjJNpCz1im+T0akJqRtLzsG1CQEaOW2Vjd0ypgz/FpTynMP4r2mZmnEriw+MqgiTS3iXkrMfcTW+NiNefuYiDAvofhyy6v3URVGzJ4uhTdXMotfPani2auqx9SBhi7VXiXY5iD9noAMropp6C7/C9PnrVTYQwtR83MVPsxLATWhMKc6c387sJ6/nNJPB+r8U2UD1OerikablygXB3vHsuxe8fZiRbGhsaUtRHfIlbtj7MPOwoqHQG8xGg==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id 45D0418000ED;
	Mon, 27 Jul 2026 01:14:40 +0000 (UTC)
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
Subject: [PATCH v4 05/11] power: supply: max17042_battery: Propagate status register errors
Date: Sun, 26 Jul 2026 21:13:03 -0400
Message-ID: <20260727011319.621794-6-vincent.cloutier@icloud.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX0xun5junhaF2
 wQKvB6Mx+Btlo5FaZL8dXvIG5ETT3ZPQMFcvK1Z5Gqs3h8XD4Ko4Mrd8oNsFvJiIp8EuiNQU+bQ
 MHgJmeelRr2LfZZjy3zt/+aS4qsvIcgyNnOimLrvxSItHNCpUhVTqCo8U1GweaKcYAMGg4AJ0wC
 B1tjSst9pc5Dt6ixXIkg+yryAI2tAjjFCToeI6wL5raTyTpWOpjm/CIAAYJV7z7gb4bXvcMI/2a
 ZJBIjFHnO+jIykRRG1P05O6EXAHOuUvLThl2BnugFEgun1zB6CTl7XuCYvsBf50cZkUBvs2qTjb
 d5WN0rVyBXhi5IOYfDFxKaHQfCZ6eoQp2BVJmlknj5IYjxum3lhZtjR0OXYcuo=
X-Proofpoint-ORIG-GUID: 7r-Pa42F7wlJGmwDLO23QFPQrVrj_SVM
X-Proofpoint-GUID: 7r-Pa42F7wlJGmwDLO23QFPQrVrj_SVM
X-Authority-Info-Out: v=2.4 cv=bY1mkePB c=1 sm=1 tr=0 ts=6a66b104
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=r7-GddeYStDyDODnpMoA:9

From: Vincent Cloutier <vincent@cloutier.co>

The driver ignores errors from the initial STATUS read and final POR clear.
A failed read can leave the POR decision based on an invalid value, while a
failed clear can report initialization complete with POR still set.

Check the probe-time read and return the POR-clear result from
max17042_init_chip(). Keep this error handling separate from the retry
policy added later.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 38abd3604643..9210bdb4d67e 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -908,8 +908,7 @@ static int max17042_init_chip(struct max17042_chip *chip)
 	}
 
 	/* Init complete, Clear the POR bit */
-	regmap_update_bits(map, MAX17042_STATUS, STATUS_POR_BIT, 0x0);
-	return 0;
+	return regmap_clear_bits(map, MAX17042_STATUS, STATUS_POR_BIT);
 }
 
 static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
@@ -1248,7 +1247,10 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 
 	chip->irq = irq;
 
-	regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	ret = regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read status\n");
+
 	if (val & STATUS_POR_BIT) {
 		ret = devm_delayed_work_autocancel(dev, &chip->work,
 						   max17042_init_worker);
-- 
2.55.0


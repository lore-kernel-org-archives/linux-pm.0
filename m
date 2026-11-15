Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782299;
	b=Q180Xyh8oQPF23NnTLj6xwk+7W7+W8F6wx2+X8ABVywpLw98oYUIBy0d9sjwJH3vI2fK
	 gveC5AF/pmyelq9hCBxw7SHK2DZbgneL+UanbKZO9glqufZAiyedxPQ7hon1N47zfWqMs
	 0K9Q9VkV7PEmRJPpma6vZVn3AYo7kUTBFarpxOV9WDil3QKpR2F/03jQRGnfBluWTGGTW
	 5i0VRTfBnpB29FDZtyRdCtsAMvDTKl1B5kcOMa5V5qtAy2VZP8Ivjw9LFr7gDLaJsBC7k
	 nUNwnMBPwtb9kAG7nD5xa+ZcpdtaRi16Z3kFpsRGnKwxO0nxfkt91mnTHyGCM4XetoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782299;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=cIRRH0DaCFDYPcExE0sOQlYcNb7utp+2evRSM+ZndUA=;
	b=fUBB7Xv33cEI4CLdG4Qq0x+Y1P8YevVYx7oHXdSMFt5UVzOOpm/jLpmvxkM24RTWvexa
	 bFuYsVnSDV6yCYnxGomQ3tbHNaYPVfFG7xqFjfuoTCtLWUvXT3ryeoqlEAr0xTP3P07Ot
	 aruSj2WTG1Yg589pyihRAHmBNoGIrU/eiXsV2Ahryt1mVGBoUJJbk4iQkrUkWTyeEBs1o
	 ZTcjsVaAhiPjPiUe/9QuZAkN/cpySLHCwdz0yXdYEsZ6gajjDRQukU+MuIgAPX7C5lzvV
	 rr55mdseXk7M6AcT0RpC/OEi6cIkfmcx2YNlMwSwhU6O1ZYQv/gOocR54inAseoRl7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRLNTMXg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F8606A330;
	Sun, 15 Nov 2026 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRLNTMXg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA241F000C4;
	Sun, 15 Nov 2026 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794782298;
	bh=cIRRH0DaCFDYPcExE0sOQlYcNb7utp+2evRSM+ZndUA=;
	h=From:Date:Subject:To:Cc;
	b=YRLNTMXgmt2oJMA4V7rIIJZi4gR4X4RMyudzb8/j7pAzcoEQN2tqristf/NKbLrUE
	 65/OTt/Q79jxUe09lwAwMmlK0bzyaQX9d97+mDD0UVnm525SBYP3B1tNWobmCN6mcA
	 zcmm6VZSqzbFW4QmrTO2BKUC0uBTMGVX4IvmwsbwGfDL1+1bi6wqjDZ4mii4LfioY8
	 D2nCwt8FSTPwFNXFMDwu2JsNN/eYftwRNpc1FWYs1/QsNIdjSm9SQcsNdOF25x66vs
	 N5jVPrCRwnws4W4QzWkUTEwoMgnlq7ysnqOcSCGRLOhXT53nyJQe2iZq3s5XuTPDgs
	 YZ2ajevXrV74A==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 15 Nov 2026 23:38:14 +0100
Subject: [PATCH] ASoC: ux500: Drop the VAPE regulator
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
Message-Id: <20261115-ux500-asoc-drop-vape-v1-1-46315e14642d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqEMAwF0KuEvzbQKI7Qqwwugo0z2djSogji3
 QXfAd6FZtWtIdKFaoc3zxsiSUdY/rr9jD0hEvrQf0Rk5P0cQ2BteeFUc+FDi7GsmnQaNEyW0BF
 KtdXPt/3O9/0Afy+ThmYAAAA=
X-Change-ID: 20261115-ux500-asoc-drop-vape-1fada73a07ed
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The MSP devices now describe their VAPE power domain in the device tree.
The platform core attaches and powers on this domain before probing the
driver. Runtime PM remains disabled, keeping the domain powered while
the device is bound.

Remove the obsolete v-ape regulator lookup and stream enable/disable
calls, together with the regulator handle and error cleanup. This avoids
requesting a dummy regulator when the EPOD regulator nodes and supply
properties are removed.

Keep the existing clock sequencing and VAPE OPP constraints unchanged.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
The Ux500 genpd prerequisites have been merged into the powerdomain tree.
Please take this driver conversion through ASoC.

The genpd, binding and DTS prerequisites are kept below the cover letter
and excluded from this submission. These include the MSP power-domain
assignments in "ARM: dts: ux500: Add power domains", which must be present
before the driver stops managing the legacy VAPE regulator.
---
 sound/soc/ux500/ux500_msp_dai.c | 29 +----------------------------
 sound/soc/ux500/ux500_msp_dai.h |  1 -
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index c135a77766ca..df3c9494698e 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #include <sound/soc.h>
@@ -350,21 +349,13 @@ static int ux500_msp_dai_startup(struct snd_pcm_substream *substream,
 	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id,
 		snd_pcm_stream_str(substream));
 
-	/* Enable regulator */
-	ret = regulator_enable(drvdata->reg_vape);
-	if (ret != 0) {
-		dev_err(drvdata->msp->dev,
-			"%s: Failed to enable regulator!\n", __func__);
-		return ret;
-	}
-
 	/* Prepare and enable clocks */
 	dev_dbg(dai->dev, "%s: Enabling MSP-clocks.\n", __func__);
 	ret = clk_prepare_enable(drvdata->pclk);
 	if (ret) {
 		dev_err(drvdata->msp->dev,
 			"%s: Failed to prepare/enable pclk!\n", __func__);
-		goto err_pclk;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(drvdata->clk);
@@ -377,15 +368,12 @@ static int ux500_msp_dai_startup(struct snd_pcm_substream *substream,
 	return ret;
 err_clk:
 	clk_disable_unprepare(drvdata->pclk);
-err_pclk:
-	regulator_disable(drvdata->reg_vape);
 	return ret;
 }
 
 static void ux500_msp_dai_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
-	int ret;
 	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
 	bool is_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	unsigned int configured = is_playback ? PLAYBACK_CONFIGURED :
@@ -408,13 +396,6 @@ static void ux500_msp_dai_shutdown(struct snd_pcm_substream *substream,
 	/* Disable and unprepare clocks */
 	clk_disable_unprepare(drvdata->clk);
 	clk_disable_unprepare(drvdata->pclk);
-
-	/* Disable regulator */
-	ret = regulator_disable(drvdata->reg_vape);
-	if (ret < 0)
-		dev_err(dai->dev,
-			"%s: ERROR: Failed to disable regulator (%d)!\n",
-			__func__, ret);
 }
 
 static int ux500_msp_dai_prepare(struct snd_pcm_substream *substream,
@@ -701,14 +682,6 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
 	drvdata->rx_mask = 0x01;
 	drvdata->slot_width = 16;
 
-	drvdata->reg_vape = devm_regulator_get(&pdev->dev, "v-ape");
-	if (IS_ERR(drvdata->reg_vape)) {
-		ret = PTR_ERR(drvdata->reg_vape);
-		dev_err(&pdev->dev,
-			"%s: ERROR: Failed to get Vape supply (%d)!\n",
-			__func__, ret);
-		return ret;
-	}
 	drvdata->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
 	if (IS_ERR(drvdata->pclk)) {
 		ret = PTR_ERR(drvdata->pclk);
diff --git a/sound/soc/ux500/ux500_msp_dai.h b/sound/soc/ux500/ux500_msp_dai.h
index aae582030d95..7ca7144f5652 100644
--- a/sound/soc/ux500/ux500_msp_dai.h
+++ b/sound/soc/ux500/ux500_msp_dai.h
@@ -34,7 +34,6 @@ enum ux500_msp_clock_id {
 
 struct ux500_msp_i2s_drvdata {
 	struct ux500_msp *msp;
-	struct regulator *reg_vape;
 	unsigned int fmt;
 	unsigned int configured;
 	unsigned int tx_mask;

---
base-commit: 7a98d525145a130fcd86f1519e2b9317a3bad27c
change-id: 20261115-ux500-asoc-drop-vape-1fada73a07ed

Best regards,
--  
Linus Walleij <linusw@kernel.org>


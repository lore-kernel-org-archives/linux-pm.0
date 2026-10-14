Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E76470436
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009177; cv=none; b=iH3b4V1A4nT107TABdhyx/9bHJHiLD5nm+o0bdDZVJOj0Pw2FG3kPUBaEnqzazkufMoXnP2FGw0aJz1YckY2VbHIu04pSJ5BG+DoeTAdhXYtqyCBk4F1cRX04QykfMloOmG1blmGbiNlK2d6PHyhUwWSz0yxswG+OyTyUDluIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009177; c=relaxed/simple;
	bh=xPV0ZTMPLqBdBxIi/G+aYy5reR5nvAnSEi2qcmpISzo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IncuOPCrCZ8Q2dGWo9NEH51QHMOsjn/9BpXtGmlXwgkKhXGcUceIcyBF4JaGbUI/OXYGD63oVhUIkIzWaDzF614bmwX5WD1JSyihGwK1NBgUxRJhVzJ8WmfxTqyOfS3S+x/njPHUndJfD9TDYTDtcaxxiCjDuhZJN4xpS5FOokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AR78wmSa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FK/toMRV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AR78wmSa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FK/toMRV"
Date: Wed, 14 Oct 2026 20:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmvxaH5W8WuBfvQM05+k00V83+oj/tvLFgv9PqhbCVo=;
	b=AR78wmSafCvcC11tGNmrxEvDkVrmq+w9B2Ve9gSW0mJlajqUne52gddIZZyftJgI5CsJmp
	ow6sEg9mjVTWSR7Ri1JhHi3wvJcoMsluPOjk2bJq+upeUvo1e3srF7qVEbIJ0VCrCV7Nvj
	H9QNzxFTiSrxUpfbE1TP07QG11U83Cy+MCnqHzVg2k3dZWs1H3XIapdPAc2eZ02Ai/WZGo
	BEwcncUjg3DayQYooTOUckskXKi5W1eMqSLzKHXtMLHsNY7x6jcfBJEbZrMzZdjHKDTGHw
	wC7flRv3MxHN1lZVtkAy5ot4urN5Uc2vHOopNXTvGr/eBwxMjRGckNoWEbCutw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmvxaH5W8WuBfvQM05+k00V83+oj/tvLFgv9PqhbCVo=;
	b=FK/toMRVTdb5mAscBqLEwk+vNQ00zSS6QyX/vj5YPIMjMz92giO3GAivciPXXpwyhx2K55
	JGSapbqoyp93vpDQ==
From: "thermal-bot for Ronald Claveau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/amlogic: Switch to
 clk_bulk API to support multiple clocks
Cc: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260923-fix-t7-thermal-clock-v2-2-bff7a09eb487@aliel.fr>
References: <20260923-fix-t7-thermal-clock-v2-2-bff7a09eb487@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200917191.2666337.6530911850640835116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     44b39b4fb0f069a3bbe6bfb21a34d2d3730f393a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//44b39b4fb0f069a3bbe6bfb21a34d2d3730f393a
Author:        Ronald Claveau <linux-kernel-dev@aliel.fr>
AuthorDate:    Wed, 23 Sep 2026 16:37:51 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:41 +02:00

thermal/drivers/amlogic: Switch to clk_bulk API to support multiple clocks

The t7-thermal variant now exposes two clocks (bus and core) in its
devicetree binding, but the driver only knows how to get and manage
a single struct clk. Using devm_clk_get() would silently ignore the
second clock, so switch to devm_clk_bulk_get_all() and the matching
clk_bulk_prepare_enable()/clk_bulk_disable_unprepare() calls. This
lets the driver transparently handle however many clocks a given
compatible declares, without needing per-variant clock-handling code,
and keeps working for existing SoCs that only have one.

Fixes: 18d65de8157c ("thermal/drivers/amlogic: Add support for secure monitor=
 calibration readout")
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260923-fix-t7-thermal-clock-v2-2-bff7a09eb48=
7@aliel.fr
---
 drivers/thermal/amlogic_thermal.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_ther=
mal.c
index a0b5306..60728de 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -100,7 +100,8 @@ struct amlogic_thermal {
 	const struct amlogic_thermal_data *data;
 	struct regmap *regmap;
 	struct regmap *sec_ao_map;
-	struct clk *clk;
+	struct clk_bulk_data *clks;
+	int num_clks;
 	struct thermal_zone_device *tzd;
 	u32 trim_info;
 	struct meson_sm_firmware *sm_fw;
@@ -142,7 +143,7 @@ static int amlogic_thermal_enable(struct amlogic_thermal =
*data)
 {
 	int ret;
=20
-	ret =3D clk_prepare_enable(data->clk);
+	ret =3D clk_bulk_prepare_enable(data->num_clks, data->clks);
 	if (ret)
 		return ret;
=20
@@ -156,7 +157,7 @@ static void amlogic_thermal_disable(struct amlogic_therma=
l *data)
 {
 	regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
 			   TSENSOR_CFG_REG1_ENABLE, 0);
-	clk_disable_unprepare(data->clk);
+	clk_bulk_disable_unprepare(data->num_clks, data->clks);
 }
=20
 static int amlogic_thermal_get_temp(struct thermal_zone_device *tz, int *tem=
p)
@@ -323,9 +324,10 @@ static int amlogic_thermal_probe(struct platform_device =
*pdev)
 	if (IS_ERR(pdata->regmap))
 		return PTR_ERR(pdata->regmap);
=20
-	pdata->clk =3D devm_clk_get(dev, NULL);
-	if (IS_ERR(pdata->clk))
-		return dev_err_probe(dev, PTR_ERR(pdata->clk), "failed to get clock\n");
+	ret =3D devm_clk_bulk_get_all(dev, &pdata->clks);
+	if (ret <=3D 0)
+		return dev_err_probe(dev, ret ?: -ENOENT, "failed to get clocks\n");
+	pdata->num_clks =3D ret;
=20
 	if (pdata->data->use_sm)
 		ret =3D amlogic_thermal_probe_sm(pdev, pdata);

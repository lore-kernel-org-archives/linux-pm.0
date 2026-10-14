Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB93470EB4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009186; cv=none; b=todUAOjSrvDeIjRSXyaB5z0O/8sw7nbVw3qvTHVVXvle6NhHtvkSiSiQ1lldHs1ax/wEJwD+CrzFULIiZ32GDFyOi5tx+xTuMU2nlcw9c7ECzx06TrYv/H/Ljaqsy5s386U6P3qBoNPGC/ZQ+hdRnJPlPr3rt0ocE1BYv/VEyjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009186; c=relaxed/simple;
	bh=Ts/MXxErEWWwIO+yXLKwFYOWe98t6wlFhfNT3Zl2ozQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YlqsIA2yABOZGMn04dT13EUjT4pcZbxG1so9hM8dmrSj3xGDPcv0q11iDZ8OfKQXrZ242DXOagP4EGciBVQyL8MNcDX3al7XKJch9w1hmZ6FOf+yhPAkBRbNGCMD7NsHoJonk0UBYbodp0kv9Qh2eDwFmSgw7Bi3HsLWEAJy5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lxs0xWGg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K4QARL4L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lxs0xWGg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K4QARL4L"
Date: Wed, 14 Oct 2026 20:19:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfNTUxl3hTp1Z5v8d4labSeMC/s2STOVeOCM521K0Ls=;
	b=lxs0xWGgebQADYlGcGUalTtXczMM4UO2i8ZEOJQffhLI17DMkopSBYpjf10QO/YX03zC0q
	TbDiojrVgpe8E4UFVOQvryUJJ7YJgslkjabHabzwemh0D7WYBBFrUtEwY2ZQvsJOBj6z1H
	LTcHzGRE5pvbuyvFed/jiHEA6dKIfW2I+H/v+LrMDqisaBE6Izb1JFAtL+fhdfYdCRDxQC
	g7C4NgJMKytozUiWfQCRhX0Rv+AudVaFB6owQ/MtexSlAcZVtTBQyTL1/3U1DCvevWHbr2
	lzo6okB6ktS3h/3xK4NdZJthZUxZYzF5DoeLyJryhIRvsKqQBqNVNEKFfYhWUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfNTUxl3hTp1Z5v8d4labSeMC/s2STOVeOCM521K0Ls=;
	b=K4QARL4LV7xks548X/XsG2rzZ/OOBK3JE+jlcE3xP/E/6zoo98548640PDHFvEPvjFmeD4
	qEn0X7LLzi7smiCw==
From: "thermal-bot for Vitaliy Sochnev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/airoha: Fix AN7583 ADC
 mux field mapping
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260929165209.69669-2-sochnev.v.74@gmail.com>
References: <20260929165209.69669-2-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200918153.2666337.7524874707934819287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     4a0f3193c68eb41882ccf7c298f5cd0b17efb8ab
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//4a0f3193c68eb41882ccf7c298f5cd0b17efb8ab
Author:        Vitaliy Sochnev <sochnev.v.74@gmail.com>
AuthorDate:    Tue, 29 Sep 2026 19:52:06 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:40 +02:00

thermal/drivers/airoha: Fix AN7583 ADC mux field mapping

On AN7583, bits 3:1 of 0x2e4 select the sensor (0 bandgap, 5 GbE, 6 CPU)
and bits 3:2 of 0x2a0 select the diode (0 D0, 1 ZERO, 2 D1). The driver
names them the other way round: MUX_TADC is 0x2e4, MUX_SENSOR is 0x2a0.

v5 of the AN7583 series swapped the airoha_set_thermal_mux() arguments
to match these names. The diode index now goes to the sensor selector,
so the zone reads mux positions 1, 0 and 2 (PAD_AVS, bandgap, core
voltage) instead of the bandgap diodes. On a Nokia XG-040G-MF the result
crosses the critical trip and the board powers off during boot.

Swap the field definitions. MUX_TADC then selects the diode, as on
EN7581, and the existing call order is correct.

Fixes: b20d9782756a ("thermal/drivers/airoha: Add support for AN7583 Thermal =
Sensor")
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260929165209.69669-2-sochnev.v.74@gmail.com
---
 drivers/thermal/airoha_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_therma=
l.c
index ea3e264..1b187c4 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -18,10 +18,10 @@
 #define EN7581_DOUT_TADC			0x2f8
 #define   EN7581_DOUT_TADC_MASK			GENMASK(15, 0)
=20
-#define AN7583_MUX_SENSOR			0x2a0
+#define AN7583_MUX_TADC				0x2a0
 #define   AN7583_LOAD_ADJ			GENMASK(3, 2)
-#define AN7583_MUX_TADC				0x2e4
-#define   AN7583_MUX_TADC_MASK			GENMASK(3, 1)
+#define AN7583_MUX_SENSOR			0x2e4
+#define   AN7583_MUX_SENSOR_MASK		GENMASK(3, 1)
 #define AN7583_DOUT_TADC			0x2f0
=20
 /* PTP_THERMAL regs */
@@ -636,8 +636,8 @@ static const struct thermal_zone_device_ops an7583_tz_ops=
 =3D {
=20
 static const struct reg_field an7583_chip_scu_fields[AIROHA_THERMAL_FIELD_MA=
X] =3D {
 	[AIROHA_THERMAL_DOUT_TADC] =3D REG_FIELD(AN7583_DOUT_TADC, 0, 31),
-	[AIROHA_THERMAL_MUX_TADC] =3D REG_FIELD(AN7583_MUX_TADC, 1, 3),
-	[AIROHA_THERMAL_MUX_SENSOR] =3D REG_FIELD(AN7583_MUX_SENSOR, 2, 3),
+	[AIROHA_THERMAL_MUX_TADC] =3D REG_FIELD(AN7583_MUX_TADC, 2, 3),
+	[AIROHA_THERMAL_MUX_SENSOR] =3D REG_FIELD(AN7583_MUX_SENSOR, 1, 3),
 };
=20
 static int an7583_thermal_probe(struct platform_device *pdev,

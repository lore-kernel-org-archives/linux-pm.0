Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898347F791
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009188; cv=none; b=PH3RGlANe3Shd+Y+kOsUsee1bHLohYd8eD1bFZyr2/cEuzku+BZolne/bHg/5t9JtxHdLL0vaoiYBY6p6qWl3ol/NuPjLe413Ko2RcWFHD00yCMbwi6i9+oX6tSxBmo32/lQqLKaqP1+YM3m7gpoxU9XvmKCvBpS1+Vc5VHzJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009188; c=relaxed/simple;
	bh=qOHpICdACCxKb4w+wX2z6XBY1bivwMG3UZcLQoZ3EOI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TFlShLxgOadegHxzS7NF+qguZkdyEWlgT3ek989EQB/4BaM8BQ4kKW67aa5f4o+milZyBHSbRXf+nEs2V1Qu0UEWFI09B3Xzhtlp1AkvINLOrqIFHiLaXyttvbX89IGXEimYdVFgpmqf8LqBPLxusbQi2P3DW8mVMgXDj/PDowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMeGjPDe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2nyx0uf6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMeGjPDe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2nyx0uf6"
Date: Wed, 14 Oct 2026 20:19:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdH4MOnkCrEtjH5St8ObGepqDqe0XIP95S1smRTR6hU=;
	b=CMeGjPDe+YMynD1ZLE9eh4JG+CMbs56lZlZ7ieGexlYc2INuzn+kbhiJzR06sIG7Veapwd
	Mq5zwuc/ICWciU+rmb40m6/FEO8fgDHoQPY9bqsGzra8q4eQR0p9Ltav5wM7r5dXFnWKvT
	2z/bsng8VmzNDSrAyMCRHgnaX6N/BMXahfAeQ6+zX7gxjfePPiQizYK35lDtILs2EyICrN
	9drYJFpcgCnVyIHne8WpFpv0OGxEZwuAMbNfzo+bGBPL40JKLPLfQ+RcsAIfBgE7vfR2u7
	a/xWx4iwxqo9fkyUIdpLthwReQEBO3FNLbwP3GqysbTdbMlESRRTgP/U1wscbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdH4MOnkCrEtjH5St8ObGepqDqe0XIP95S1smRTR6hU=;
	b=2nyx0uf6avAJASk/BwIrmwbYRKwRwIConGH0JVohjO8HYStsEv+3LmEPRtY3BEdr91Ad7/
	XzWqtYP/Z155UgAw==
From: "thermal-bot for Weigang He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/sprd: validate the
 sensor id from the device tree
Cc: Weigang He <geoffreyhe2@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260926042757.2109927-1-geoffreyhe2@gmail.com>
References: <20260926042757.2109927-1-geoffreyhe2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200918329.2666337.12196991704630712494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     b17d799ce49bfaad68be5ff3df995b3bd021a9d7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//b17d799ce49bfaad68be5ff3df995b3bd021a9d7
Author:        Weigang He <geoffreyhe2@gmail.com>
AuthorDate:    Sat, 26 Sep 2026 14:27:57 +10:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:40 +02:00

thermal/drivers/sprd: validate the sensor id from the device tree

sprd_thm_probe() reads each sensor child node's "reg" property into
sen->id and uses it without validation: to compute the sensor's
register offsets in sprd_thm_sensor_init(), as the thermal zone id, and
finally as an index into thm->sensor[], which has SPRD_THM_MAX_SENSOR
(8) entries:

	ret =3D of_property_read_u32(sen_child, "reg", &sen->id);
	...
	thm->sensor[sen->id] =3D sen;

Only the number of sensor nodes is checked against SPRD_THM_MAX_SENSOR.
A "reg" value of 8 or more, or one that is negative once stored in the
int sen->id, makes the register offsets point outside the sensor range
and the final store land outside thm->sensor[], overwriting the fields
that follow it in struct sprd_thermal_data or other memory.

Reject an out-of-range id right after reading it, before it is used.

This does not address sparse ids, such as a single sensor with id 7:
they leave holes in thm->sensor[] that the later loops over
0..nr_sensors-1 dereference. That needs a separate fix.

Found by static analysis tool CodeQL.

Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
Assisted-by: LLM codeql
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260926042757.2109927-1-geoffreyhe2@gmail.com
---
 drivers/thermal/sprd_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index d683fcb..b57277e 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -396,6 +396,12 @@ static int sprd_thm_probe(struct platform_device *pdev)
 			goto of_put;
 		}
=20
+		if (sen->id < 0 || sen->id >=3D SPRD_THM_MAX_SENSOR) {
+			dev_err(&pdev->dev, "invalid sensor id %d\n", sen->id);
+			ret =3D -EINVAL;
+			goto of_put;
+		}
+
 		ret =3D sprd_thm_sensor_calibration(sen_child, thm, sen);
 		if (ret) {
 			dev_err(&pdev->dev, "efuse cal analysis failed");

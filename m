Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE248EBE4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009211; cv=none; b=cXTmf+ivFYbMSM43M3QsAusAY85rJ5fq/BMZwH8R3/tEJ9y2CvFRED8fJjLP+21waUY6I12K11aroLOTpJ0D2Yhh/pITlbqfN5Wvn7LDkscavSSl6mvSd6Pv5kXQEbt8BVKK+i7j+yuDwaSSXpa0U0HSw47PxSQYTb3vc5VOles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009211; c=relaxed/simple;
	bh=M29GiVzxKavutf2jVUoaBT7wvT0YWduVN2h9sxnooRc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ecFHbKkNlohssUHssDGJB0n7jC9YzBSiHSZkC38/MRe7y9y3TvDlssVxKdCiX9w5RFLVtmBvXtFDI6UYRxXA6Bu04Nu6l9MOS0d/gtIzZpFi8KMpattYcGHPqxB1VsWQgSJT+6pKDliah7XSydp0qmvP8EC8JNwdOGvgxMxCCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4GccQMf/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTq++a/U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4GccQMf/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTq++a/U"
Date: Wed, 14 Oct 2026 20:20:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9IXMbuJXh/Iy9CTHQweQaWuZPzVazkBQAYASErJEts=;
	b=4GccQMf/qn5yXNM6xtjPGn5VLGYOxFFSWCw0AAHbagsK5gcfCi8AhayiAnvfBetgPk6hWo
	zvB0DHkJfF2L2lCri/YsIGv5NZVI4k9o5Hh8f6EPSNrVcYODTXvDEfuIQ1PwvVBJV684Yp
	LFzcTxQzxRr1cntmSJu/NsnZ8Pmag9/bezbsSDmVnDWezAcnzqpQSGAn5P6wGRsRHqRzle
	3ypeekO+HORSBEyMMlZAELuardRsNs2Dj5NJTSwUOqjzM/vN72ktegVbMeBcL8Tcic6w2o
	r+P5K2yaSij+vny8A2gFuXP4pm7juZfsewCKBLC41qUcfYw7usKzOnIFa/vFug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9IXMbuJXh/Iy9CTHQweQaWuZPzVazkBQAYASErJEts=;
	b=bTq++a/UgSw+cBFrwagMKCnht/nn++gdIAOmqROKiz3BKCr1cz/9dA6g6WBcvYzu0b+Ekk
	yDyhpR6xC43PhnBA==
From: "thermal-bot for Ovidiu Panait" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/renesas/rzg3e: Fix race
 between set_trips() and get_temp()
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260916120003.87018-4-ovidiu.panait.rb@renesas.com>
References: <20260916120003.87018-4-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200920721.2666337.6345097985403731141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     acd9bf8f9047b03f023514bceab6a00e037977ca
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//acd9bf8f9047b03f023514bceab6a00e037977ca
Author:        Ovidiu Panait <ovidiu.panait.rb@renesas.com>
AuthorDate:    Wed, 16 Sep 2026 12:00:01=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Mon, 21 Sep 2026 17:48:13 +02:00

thermal/drivers/renesas/rzg3e: Fix race between set_trips() and get_temp()

Datasheet section 7.11.9.2 "Conversion Start Trigger" states that a
conversion must only be started while no other conversion is in
progress:

  "Before making the setting to start conversion by software or an ELC
   trigger, check that the CONV bit of the sensor status register is 0b."

set_trips() starts a conversion at the end of the function and returns
without waiting for it to finish. A get_temp() call arriving right after
that starts a conversion while the CONV bit may still be set, violating
the requirement above.

Fix this by:
 - polling for CONV =3D=3D 0 in get_temp() before starting a conversion
 - not starting a conversion at the end of set_trips() anymore

The conversion started at the end of set_trips() was supposed to check
whether the thresholds have been passed, since the hw cannot raise
interrupts on its own, but only when the temperature is read. However,
the thermal core reads the temperature and computes the trip window from
it just before calling into set_trips(), so reading the temperature again
straight away is useless.

Fixes: dc67521c20b7 ("thermal/drivers/renesas/rzg3e: Fix add thermal driver f=
or the Renesas RZ/G3E SoC")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260916120003.87018-4-ovidiu.panait.rb@renesa=
s.com
---
 drivers/thermal/renesas/rzg3e_thermal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesa=
s/rzg3e_thermal.c
index 45f67b2..58fdcc6 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -225,6 +225,16 @@ static int rzg3e_thermal_get_temp(struct thermal_zone_de=
vice *tz, int *temp)
=20
 	guard(mutex)(&priv->lock);
=20
+	/* Make sure a previous conversion is not in progress */
+	ret =3D readl_poll_timeout(priv->base + TSU_SSR, status,
+				 !(status & TSU_SSR_CONV),
+				 TSU_POLL_DELAY_US,
+				 USEC_PER_MSEC);
+	if (ret) {
+		dev_err(priv->dev, "Timeout waiting for conversion\n");
+		goto out;
+	}
+
 	/* Clear any previous conversion status */
 	writel(TSU_SICR_ADCLR, priv->base + TSU_SICR);
=20
@@ -304,9 +314,8 @@ static int rzg3e_thermal_set_trips(struct thermal_zone_de=
vice *tz,
 	/* Enable comparison with "out of range" mode (CMPCOND=3D0) */
 	writel(TSU_CMSR_CMPEN, priv->base + TSU_CMSR);
=20
-	/* Unmask compare IRQ and start a conversion to evaluate window */
+	/* Unmask compare IRQ */
 	writel(TSU_SIER_CMPIE, priv->base + TSU_SIER);
-	writel(TSU_STRGR_ADST, priv->base + TSU_STRGR);
=20
 	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);

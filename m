Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F149494803
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009213; cv=none; b=DXRJSJNrt/Mdm8chyTvrKeEQ8hICAMsyO64iyuD4qXqY20hoo5XL3ce4fgvhFP7apNP2Z8uH+jQmSPIalNlQu6hj0x+M1cTLxXeXuK0J7ZL7somIdUlWi2i3DYCacTNldofsZUAU+xGkpcCc966eAKx9UgLyfd3H6UkTngIiTuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009213; c=relaxed/simple;
	bh=oy1qD2lz8TSfl0drZ5e2G+XGICDgPCjVtqd8Dth+/WI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XyPpAdmt5lhqRVYL7Wn3FzF6cLfelHo23+QVoYNECdMPFCkxC+heqjpUWSyPXVCmpuGsvkqpJyB8KWhG+p00+X4J1IXlpz4vj4qzWwTIO7NQLXd5SmkS8k9ie10I7GB0Z/EXHhwTq9cl5wF6EOi/ZlIIivvIeqTJn6xlYi7e8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u1sUMJdP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTlibMjE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1sUMJdP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTlibMjE"
Date: Wed, 14 Oct 2026 20:20:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlVKVHyiOdo6RTJRZT46zpGvZhlKOhnwSJ04Au9Xu54=;
	b=u1sUMJdPqTm9H7ptEhWK5ogzndJb/7i4/I6LWKRNq6CmOkBXfUuXJnXFbRFzJSeCHdIRFq
	mg4rJ/C78LhUpdZtp1Ajmcbkejdr6P3iSVNObrH4j0KxJWfV3+iCD+VVS5lYy33aBpUWZR
	meQEBrZZrGCkhrOo5on1u9KgGCePcItJAIgFTtsL7KKySC4gGY2rgqNGdJxILlbw4nVwMf
	eTBfUKB2PTFQ6sbsp9tjeGxibBqAxvHfc3UBA3feO9Y0Vh/N1tSB2aeBZzxgrn1UmvKoAk
	j3+0zBPEEtaBw3ks0pBgmr5yOmxnvqr8UGHNFXBfuxqvw/ZLfR4ssnvq/4Vv9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlVKVHyiOdo6RTJRZT46zpGvZhlKOhnwSJ04Au9Xu54=;
	b=jTlibMjENVwpJnCgFMYOA2KSDTA13hDQjH3TX9h4jvxjqjBoY9Wxb0E6kb+o+qe5OME25c
	h9jH4XWzqG62OgDA==
From: "thermal-bot for Ovidiu Panait" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/renesas/rzg3e: Fix
 runtime PM handling of compare irq
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260916120003.87018-3-ovidiu.panait.rb@renesas.com>
References: <20260916120003.87018-3-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200920863.2666337.4181767795944699804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     aa1bc39e45f29a4f56d7e6be7164e100727df465
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//aa1bc39e45f29a4f56d7e6be7164e100727df465
Author:        Ovidiu Panait <ovidiu.panait.rb@renesas.com>
AuthorDate:    Wed, 16 Sep 2026 12:00:00=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Mon, 21 Sep 2026 17:47:58 +02:00

thermal/drivers/renesas/rzg3e: Fix runtime PM handling of compare irq

The TSU hw is limited in the sense that lower and upper trip points can be
set, but the hw cannot raise interrupts on its own. It can only signal that
the thresholds were passed when the temperature is read, either during
polling or on a manual read. Therefore, the interrupt enable state
configured by set_trips() must remain active for the next read to trigger
an event.

Currently, runtime PM autosuspend puts the chip to sleep and clears the
compare interrupt that was enabled during set_trips(). On power up, the
compare interrupt enable is not restored, which means that it won't ever
fire.

Fix this by caching the contents of the SIER register during runtime power
off and restore it during runtime power on.

Fixes: dc67521c20b7 ("thermal/drivers/renesas/rzg3e: Fix add thermal driver f=
or the Renesas RZ/G3E SoC")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260916120003.87018-3-ovidiu.panait.rb@renesa=
s.com
---
 drivers/thermal/renesas/rzg3e_thermal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesa=
s/rzg3e_thermal.c
index 4acee4e..45f67b2 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -93,6 +93,7 @@ struct rzg3e_thermal_info {
  * @info: chip type specific information
  * @trmval0: calibration value 0 (b)
  * @trmval1: calibration value 1 (c)
+ * @sier: cached interrupt enable register
  * @lock: protects hardware access during conversions
  */
 struct rzg3e_thermal_priv {
@@ -103,6 +104,7 @@ struct rzg3e_thermal_priv {
 	const struct rzg3e_thermal_info *info;
 	u16 trmval0;
 	u16 trmval1;
+	u32 sier;
 	struct mutex lock;
 };
=20
@@ -148,12 +150,16 @@ static int rzg3e_thermal_power_on(struct rzg3e_thermal_=
priv *priv)
 		return ret;
 	}
=20
+	/* Restore interrupt enable state */
+	writel(priv->sier, priv->base + TSU_SIER);
+
 	return 0;
 }
=20
 static void rzg3e_thermal_power_off(struct rzg3e_thermal_priv *priv)
 {
-	/* Disable all interrupts */
+	/* Save and disable all interrupts */
+	priv->sier =3D readl(priv->base + TSU_SIER);
 	writel(0, priv->base + TSU_SIER);
=20
 	/* Clear pending interrupts */

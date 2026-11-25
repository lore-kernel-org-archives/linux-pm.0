Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607975;
	b=Px4mCU0nYMlRnOFYSFdx+Yp9Mkt3FZRVzSNxrrP9mOxoR+b+3O007zXzvS+ijcyzSVcD
	 BhlK7smPi4UTMlaKJ9JCe13whP2WeIB9Jjw/SDUMUM/X5eXTlahJ/qJ61fE1JdbBk71JO
	 s2mqtx9olbmBH8YzOfMxYje1X9YBrrW1RLS8RbfQ498B/x/z/mY3DbFdLEPANxbpPUhE+
	 Azypgog+boIZaAsHr72jJ2FdTOu7V59PGzJQ7UXmeX3tmwQIJVrutTN8z3Yvto7VvmhQ7
	 f+RewrONmpbBqu2LwpaJx2YkvpAiwjnoYfdv/o0KrA19FVmwasNAwBwO4Vg10wGqWvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607975;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=7EohdjwtOAAbWsHs2P1YxbcLbbVDm/qD6B2Tj7NkwZI=;
	b=a9N/9hGvyz7aHYn60MjiH3ZKAwVvwlT/UK8yBCv6wOwmvtaVSSmXlKsG1oaxL2PG0/to
	 b+rrNtTz9nEfZVNvVfUuKq5KXIsTa2QN2Z46EEUZR5VEtlYsDC+xum3wdFIYne/FI73mk
	 pDJFm3Xl8ThoLYj94/mkf9UzJN9+MGn92E2d5H9XL3HzO1luv/oGxOq/ik0VfbG0qztvz
	 cUxVL0Std20xwwUOEQDp5nXFiywhdD1iOgaqksUL8iCVhn30O6DqFaHuUvzRDMqOmzCAK
	 cQdkQB6Y4c10rl+pbSFPmGoUjE/DBtekp0K2HaEp8SBrLKzTY5Ed7pf8MGwgrWTceMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jheeN+lq;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Hl4uJIu2;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FCF606A327
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5FCF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jheeN+lq;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Hl4uJIu2
Date: Wed, 25 Nov 2026 11:59:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EohdjwtOAAbWsHs2P1YxbcLbbVDm/qD6B2Tj7NkwZI=;
	b=jheeN+lq39ugzK1PN3HPwMF285iEK9NId2zraDkQoTQgJxeRMW5wmVyftaKXg5wkegVN25
	64XWmidJPrHefR3RwOghI+TcTLunIH7KaSpffMktc3B2tQRU0z2E5CNSaqixWaUWNs5Wbn
	3Vh9kngwymRPED4ti00todvdXPP8ND6NNzaPVeNRjYSgCXQJO5wAdn7ETrnz7CC4DVHM38
	jZjxRYlaqMmcCqmhDhbz9X5KV/xRd3jYpLzJjeySmicpmpjv6iJOJUSDkoYLXPM+hQwZKc
	fKuP7wBgRDZtcvoCXDb7HKMPqHYN/L2fBFHcLcCgwudYn+Rf8bkZECZU5/X5CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EohdjwtOAAbWsHs2P1YxbcLbbVDm/qD6B2Tj7NkwZI=;
	b=Hl4uJIu2mcAqVzONsnOcVstTRDjOi2HxJ3mIUpjDSVm/lZV8K1P6IgaRfk9gmZimq322LU
	eFGvp0UeIn031TDg==
From: "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/qcom/tsens: Validate
 the sensor count before initialization
Cc: Bjorn Andersson <andersson@kernel.org>,
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261021085749.3786101-2-daniel.lezcano@oss.qualcomm.com>
References: <20261021085749.3786101-2-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560797169.92412.10406920471074534131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     358baf690674d351f2b137d9e82d570d6fea631a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//358baf690674d351f2b137d9e82d570d6fea631a
Author:        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
AuthorDate:    Wed, 21 Oct 2026 10:57:47 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/qcom/tsens: Validate the sensor count before initialization

The #qcom,sensors property can override the platform sensor count without
an upper-bound check. A count exceeding the IP's maximum causes the
driver to access uninitialized regmap fields when handling interrupts.
Platforms with an explicit hardware-ID table can also read beyond that
table, even when the count remains within the IP's hardware limit.

Reject zero counts and counts exceeding the hardware maximum or, when
present, the hardware-ID table length before allocating the private
structure and assigning sensor IDs. Preserve the existing fallback to
the platform default when the property cannot be read, and document
both the fallback and the sensor-count limits.

Fixes: 6d7c70d1cd65 ("thermal: qcom: tsens: Allow number of sensors to come f=
rom DT")
Closes: https://sashiko.dev/#/bug/linux-d0867095-c131-491e-a6aa-a81debfd0df5
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261021085749.3786101-2-daniel.lezcano@oss.qu=
alcomm.com
---
 drivers/thermal/qcom/tsens.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 997a0db..4d4997b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1402,10 +1402,20 @@ static int tsens_probe_common(struct platform_device =
*pdev)
=20
 	num_sensors =3D data->num_sensors;
=20
+	/*
+	 * DT may override the platform sensor count. A missing, empty or too
+	 * short property leaves num_sensors unchanged, retaining the default.
+	 */
 	if (np)
 		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
=20
-	if (num_sensors <=3D 0) {
+	/*
+	 * Require at least one sensor and stay within the IP's hardware limit.
+	 * Platforms with an explicit hardware-ID table also limit the count to
+	 * its number of entries, which may be smaller than the hardware limit.
+	 */
+	if (!num_sensors || num_sensors > data->feat->max_sensors ||
+	    (data->hw_ids && num_sensors > data->num_sensors)) {
 		dev_err(dev, "%s: invalid number of sensors\n", __func__);
 		return -EINVAL;
 	}

Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC93F106E
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009170; cv=none; b=bElRfTtbggDwuuHd28/mGnPbw0pVjdg5LF6TpAvHoR68/6Ts9nH6cfhz7L3Nbbkbz5HOkiv1H8yS3yOvXh77zagRT3xwo9+nLeJscDcmE4RX/KBEcCgYZ5b7iogVGIT1S2U2TBSWPNSWV3X3xLxQsHsRiCX67nw/3nqnqtWcy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009170; c=relaxed/simple;
	bh=hlq9v1xz4I6qAUWjVpb4nNhVa135YD2FakmeLpyxxy4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dX8uJsxZsA5rnKk1Y25d9BlaQzMjcFCC+FrMfpEJTBeXCmq5VJJOeCXlYFRb2QQ7QPlG0xXZ1Tkz2X09NxemHf+3iWQXkpi3CuABMXHsjMt2CH28XxVOVsNVK1pNThGqR8ylpfdQi/Q9xmwdTHqFopUdLZnVwRX7JAwVFG3Olz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IB+HH0TX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x+77NFxO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IB+HH0TX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x+77NFxO"
Date: Wed, 14 Oct 2026 20:19:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ixo7c1Obi9Ci/hl50bwyyoJTrEOzc67zRQY5qbb6fxM=;
	b=IB+HH0TXbf+FY5U2gQFX+Kske6dCNPdAdrCO4bEE5QlEDBBEYk4HFyEBMe+3LGj5wbcM90
	8IlEyoXUkrsQbUUESfrPDuqh/c+Fobn8YHaQr/wpIOFomNJAz2HESzSZuzVqg5OFdXhjBj
	Tof8GOMd9r7fIFTIEM/3XHKyB9vuCuDAoFIbAX+3wcaVmHYiaVsHdVHiqJs74oeIvacqdG
	gIM2TnJlFK8dl60dcjo7JAYCUYNAaQmOr6rjO8w2rG3R/RelhSochgk+Y8/YY+36+fmCu9
	hgr9hh0ZPHxL1Kokcc0M5DkIlCawK2Ktft65xIt0CSOWal3ufznADEwM13Nyfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ixo7c1Obi9Ci/hl50bwyyoJTrEOzc67zRQY5qbb6fxM=;
	b=x+77NFxOmb2Gwy2EPrts1ammIwRnWntYaL95KSktw4v6L58x7FDkiokXMaXPAPXJ95xwrS
	to2PAQAqvdlYCIBA==
From: "thermal-bot for Karl Mehltretter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal: ti-soc-thermal: Fix the return
 value in ti_bandgap_get_sensor_data() kernel-doc
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260912062252.42762-1-kmehltretter@gmail.com>
References: <20260912062252.42762-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200916564.2666337.3986405898798814354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     82bb005cd9cf5a9df4cfe4a52db90346ac5fd17a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//82bb005cd9cf5a9df4cfe4a52db90346ac5fd17a
Author:        Karl Mehltretter <kmehltretter@gmail.com>
AuthorDate:    Sat, 12 Sep 2026 08:22:52 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:41 +02:00

thermal: ti-soc-thermal: Fix the return value in ti_bandgap_get_sensor_data()=
 kernel-doc

ti_bandgap_get_sensor_data() returns an ERR_PTR() if the bandgap
instance or sensor ID is invalid. Otherwise it returns the stored sensor
data, which can be NULL if no data has been set or the stored value has
been cleared.

This mismatch was already present in omap_bandgap_get_sensor_data() when
the driver was introduced in staging.

Document the validation errors while retaining NULL as a possible stored
value.

Fixes: 8feaf0ce1a04 ("staging: OMAP4+: thermal: introduce bandgap temperature=
 sensor")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260912062252.42762-1-kmehltretter@gmail.com
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti=
-soc-thermal/ti-bandgap.c
index 507fe67..815ca07 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -576,7 +576,8 @@ int ti_bandgap_set_sensor_data(struct ti_bandgap *bgp, in=
t id, void *data)
  * @bgp: pointer to bandgap instance
  * @id: sensor id
  *
- * Return: data stored by set function with sensor id on success or NULL
+ * Return: the stored sensor data, which may be %NULL, or an ERR_PTR()
+ * if @bgp or @id is invalid.
  */
 void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id)
 {

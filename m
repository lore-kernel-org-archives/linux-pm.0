Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893764;
	b=QkeW5k3/mzh2erkF94MmKrvggmmHireG5K/X1knbt17UrC/j1sGKgQJpu999qhhHFtqj
	 PgYzOv5NBnYuND2clx81eCRxhFrW3Tmi0hHaWtCMhCmKGUxedFpr58RkeYMWs53aeyWQq
	 qcDlztrAQzGEO0/Dt4H8phvc0MeaZhU3MmeRE6t0psX8soYf3FpIOgNAd520AXwEplsJI
	 118vZtXIDGm6KW0F5m6iCkZ3vdGqDSFCt7grkttxb8tOrWHe0N894sHaVRe9kLW3PS9ve
	 lMumkSrI6Hv1UyjPVxUMlYn1qPCWNvyZNZKcGWbCyAhB8MQ+FuIGjrNl9mxSgGquD8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893764;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=t4+ighO6n7JsA3HWUrWhxJMAbY0P+pSh55zjCpyBjD0=;
	b=XklhAuJ9WEpAoznQLvZtoPGWP+8OvdvptjTXk9/znbl1LO7I5Cc56FOq/KuPEduiEAMz
	 D0LpXXZGrb9LxahpmcsDf+MFwZdIrJxyotXseQNHE7WrMPxz3TWZaipKpyh9PXnH8moIt
	 AgiYO8OCV9yIbd6wfCYTTp1t009FotQkWklFC0EAFWt7oUth8XES/61kwryMu2T6Z0/Qz
	 W1cWJbaXQ8a90nH9VKj82hMxZV6PjNjZgURz/vyXGxESv6FyPcqipvEGGQRo+uPFjzEZf
	 ovQCOLFVQWlYGjcmRUErq2YyOl2ZYfi6SRCvfGlHNh5PSZ4FaiIZNoONJWV6m37TQSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3gm4PzjP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3+Q0qotJ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2A608362F
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF2A608362F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3gm4PzjP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3+Q0qotJ
Date: Thu, 05 Nov 2026 15:49:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4+ighO6n7JsA3HWUrWhxJMAbY0P+pSh55zjCpyBjD0=;
	b=3gm4PzjPgF9QsEWDSyApxpJSJwwz+EWiU6sduN7/NfjGr6hqVZJ8dKXnFvLkMREnr61JNE
	84lT3nXfq+hMBP/bRRRk1rw2wyacZCrY8hunQVZHFZIsLqkYVFtQVlmjy347dxAVhIagYq
	YMBFFTy6FoKm98I86x39qiV/yI7uM761ZHfpcDkVpteuTE6qgOrZoV60iDuk6aMsBTJqfZ
	KeV18kxefc7qjWynKgkh/vTt4BiijLVPtcav0HV3eEfmeRBd5YWU8InAf2FEUv5BEAuBiu
	I6wjWoHv7u/rwFSa+n0IarE65feJ8Mpuv6TTVzbh++l4P2Cv4YylP4MoGUKktw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4+ighO6n7JsA3HWUrWhxJMAbY0P+pSh55zjCpyBjD0=;
	b=3+Q0qotJ8G0eGC1HyPet/KQt6Soe9uk3Z23W9simhRaFx612yqATkD3Z8j/YdOK6nDsPjg
	L1RgIlLMtFRNcxAQ==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Disable regmap locking for MMIO INTPEND reads
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-13-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-13-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389375541.1009794.2469813661450890051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     6eb64c42a31531de51b735a1709ac8b7c24bbb4e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//6eb64c42a31531de51b735a1709ac8b7c24bbb4e
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:30=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:51 +01:00

thermal/drivers/samsung: acpm-tmu: Disable regmap locking for MMIO INTPEND re=
ads

The regmap in acpm-tmu is only used for full-width 32-bit relaxed MMIO
reads of the INTPEND registers, with no read-modify-write operations or
regmap cache. Set .disable_locking =3D true in gs101_regmap_config to
avoid unnecessary regmap lock overhead on every INTPEND register read.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-13-0637431b7268@lin=
aro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index 2324efc..fd491b4 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -127,6 +127,7 @@ static const struct regmap_config gs101_regmap_config =3D=
 {
 	.reg_stride =3D 4,
 	.val_bits =3D 32,
 	.use_relaxed_mmio =3D true,
+	.disable_locking =3D true,
 	.max_register =3D GS101_REG_INTPEND(15),
 };
=20

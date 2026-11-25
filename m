Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607952;
	b=5rA0kQex+xDDDtmM3SVS/R8sJERSbucpyf1cbjBg8gV7eiu416YmFZyN4vaOiLtlst6T
	 sJ58b+9kPIaoKiEoS7y6Db36mKJTLAR/sOuOoJkynBdL/ocmW7jLZp7zqUKqyU3V4xONZ
	 b8JrCcLExsp120/bG7jhD0xJ0MzM05m2IoN012X3kxZ1tbJxKkhTMZVePkMoskXeDifzg
	 s5XfbCpCVPAwaJ2FTlS9HC3zderOtnNkwh+FZufNWZlKdoy35bia+lJry+wVVpMIJDHkb
	 kh7+suB/C2p7oVxNoHhvL+NohkzRvna9FY6gVQhJGmrjEEEpy5hsQ9nA9OziNxgUDzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607952;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=KXttcBGS4dOTRve9wLWETEMDi1XtBKNoKYswRZd3b98=;
	b=Z5GM0omUyOOMe9/2lpWBl3zmwE7Bb+3VM1bBEIAIB8pdyQzgJpLno29p5vsIhladRDmd
	 DB/2tjTuip6FbUn5oHSg3jyBWzZCaWVCv3oxhMz25/8z+T6V4UQ7adbDD06hsHH2/hHWz
	 P1zlzh43VBbN+esa9TYNLpaqNTjsekzqIAWTpYfqdj4c0rWBWatiXE+Ip5XhMaXcSyMbl
	 9hDouFNUBDrblSG+dnmefshRRqCHv7fB3MBq/4cdpk2TsoIDd+5bWsbFyOS01ZTuRN+0I
	 Me3m2UN8JioRn5vxeZtqe/eA46igMHEtsArqorGKARV4rvBSuhGxTqWnEnrE5KIn75w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hd74Ske6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Lr1Qb3Av;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DA606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 439DA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hd74Ske6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Lr1Qb3Av
Date: Wed, 25 Nov 2026 11:59:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXttcBGS4dOTRve9wLWETEMDi1XtBKNoKYswRZd3b98=;
	b=hd74Ske60GeAR1ew+Y/lLQxhHGCcagzxm1utCXHO5RhTkUo75W+v8dxV/E/VhWCn1PFDzZ
	dMR1qvvwgOpeeaaWPFneStSroUSjUgJKUPKJZVHKsE4qs+Fn22OBLsD7g2zuyGqoNkUAOh
	DZUJBYt22CV4sa1eHUkW9Zr1oHHcUPj0PAYdW8P5M0Dk+ugxBaVNqqEgM35K5JzRU7eaoe
	4DhXVYcat2pS0Rq0U9Xd8cIx26f3tVqxF5eBOks8OVtaFw4Wik9yLWfqkvhEc14lsqih7N
	24kRVRVhykREWxuftOenaLZaQ0JQsck6ryJk1YP2YInPJ2++2N0cHCCD8rxwvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXttcBGS4dOTRve9wLWETEMDi1XtBKNoKYswRZd3b98=;
	b=Lr1Qb3AvE8rjRwsBEB6S40ldnmdW70asDsr8xiwsHPImz3SGbjqfbKFNOnKZwdAKeezjje
	at1R76LuXDV4FCBA==
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
Message-ID: <179560794927.92412.13000213052634621929.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     613515c3944b434045c7da3ea7d771d35959fb13
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//613515c3944b434045c7da3ea7d771d35959fb13
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:30=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

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

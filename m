Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4E4A49BB
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009202; cv=none; b=L2D3gslL3NrByJCtvqybrVolFKnU870DbHDQ+c2KLgl91TlXP+bGfl/u9r7erjRqYYogD3hEtgvHkWH8qGRzL/A2E2I+7+08MXnxuEsQQC1n+xN40BvTkLB9JBh5Dyiih5PjLJbb8G2gCuHrVfcmHz41cWZEBVnDib8I/EX3/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009202; c=relaxed/simple;
	bh=R/iodi9SLNyRzeLO6D0/h/YKAEDcj8WMgSziY/XUfeE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CUa/qFYPRdOXS9di3g+LGYsyiOdZfmIIDiZIN8cD4JClj/Qdu83toa4fOjzGWg9ab8G/l221mORuvGTSts95oeqvdcP5vm/8r+Br/aRStB1dpaIcZibX+LY1nDhh5jHsb6XhQ7FZeFEVtOEo5TB55q54OH9jUarA2ySnMyaaUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B7/78thL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7cqlHf4k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B7/78thL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7cqlHf4k"
Date: Wed, 14 Oct 2026 20:19:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2F6ggfoh+7ouwvTOfD61UTmup2o05A4ECWOC94MER5M=;
	b=B7/78thLzYhtQCAq1HP6Kxj/om+zGmJT03i7809FABXj2tigMdJTAZiP6IrnTSe1VoetcK
	/HRivUzKZe7qzDtOUQ5IiI2+6JS7++Lv2bkRszh9QsIxRtWHXyeacEbUM9Ij9SBlUUpfES
	U8bnLYaxvCpOiMj1bJu3WsPIicnPBgIxTAyB2qy8uymGeZlryB+PNqC50YYO1r7WyG/lgP
	MXcdvxAqygEfoxnDNy0ePn1ChYdJ5bt1XI8skugBgHfimrOzi4Af7zD/9NZWxnvmA3ksZl
	wDaH7/CnQfPW5rr711InojjMWsKBsHbLUNOun5jH8Fk4ViLsef7aoN4UVJQLvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2F6ggfoh+7ouwvTOfD61UTmup2o05A4ECWOC94MER5M=;
	b=7cqlHf4kZ/hh/5lKjspB2xlv1Vncp9WVKSRJud6Nijf22FNXVPJ9QG1Eb9gmaWtuwaZj3L
	VX59B0bgvQxxv2BQ==
From: "thermal-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/renesas/rzg3s: Add
 RZ/G3L TSU support
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260925061617.127349-4-biju.das.jz@bp.renesas.com>
References: <20260925061617.127349-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200919784.2666337.5726835277359717362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     e856ca3013b3074fd07cb81c90b1de332f69153c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//e856ca3013b3074fd07cb81c90b1de332f69153c
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Fri, 25 Sep 2026 07:16:01 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Sun, 27 Sep 2026 23:01:26 +02:00

thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support

Add the renesas,r9a08g046-tsu compatible string and its default
(software) calibration constants for RZ/G3L, used when FUSE
calibration values are missing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260925061617.127349-4-biju.das.jz@bp.renesas=
.com
---
 drivers/thermal/renesas/rzg3s_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/renesas/rzg3s_thermal.c b/drivers/thermal/renesa=
s/rzg3s_thermal.c
index 146b73a..a8716da 100644
--- a/drivers/thermal/renesas/rzg3s_thermal.c
+++ b/drivers/thermal/renesas/rzg3s_thermal.c
@@ -265,8 +265,14 @@ static const struct rzg3s_thermal_info rzg3s_info =3D {
 	.calib1 =3D 751,
 };
=20
+static const struct rzg3s_thermal_info rzg3l_info =3D {
+	.calib0 =3D 1322,
+	.calib1 =3D 772,
+};
+
 static const struct of_device_id rzg3s_thermal_dt_ids[] =3D {
 	{ .compatible =3D "renesas,r9a08g045-tsu", .data =3D &rzg3s_info },
+	{ .compatible =3D "renesas,r9a08g046-tsu", .data =3D &rzg3l_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg3s_thermal_dt_ids);

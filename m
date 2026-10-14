Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715B48EBE4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009214; cv=none; b=ba1SlCPW5OUKuJIsqvO0B6fHb/dvcFBTou7cYrBS1Hee03A+6ZtqU9qXV/FgaVpxsthIPvXgahLwTGqjqxp2idYawALK9ZdGVMEmT1C3p7KKCfSOzM5YqXD+u3SFqiJbBrSirkzUh3chODF5kn4tDG+l92da4sYb7VTY0/s7poY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009214; c=relaxed/simple;
	bh=qsNXNGyqk0Ll2TkC2017kBJggJj3RAOnrrUws1vfKBQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dkS+2qNa8nkZq2d/m3S/uBc4xQOJp/FZFK3rBxmt/Ckqii2dCcmM5gizzYTaZVxNuQhuIzZceEn4eYOP3KAMfmFJoWcpwfQlVbTSD4QXmA4DFw8LHIEL0uFl222lbARqbCPcSNeikyQ3smOjTIHx3hLloz04hOhXturZmR5zOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pt1+VsNg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ndh7mOzF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pt1+VsNg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ndh7mOzF"
Date: Wed, 14 Oct 2026 20:20:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n41516cFOSFRoS+0lYF7pXHRIuFozQr68BvoXHjCy3k=;
	b=Pt1+VsNgQScslNSS9IGY1a7oB5F/H1oOOCFCzns1gfemXfyGZnPlkiyF1Yjt8GlcxhZyYT
	rM/ITiX4ko19LrQNy8B0j5baYd87zy9SXLF7PwA5Mu6Ot+A4b85tZqr/6urCO3NHIeEsSp
	r4mBcEboj2iCAe1IWLcP6JBV8W8kjWxGDrXAueXjoQkCiBxF6MT3V6cWbYBth485jE9NCL
	vnh/War7FROZMbuIicOWmaWn3g6E2IkrUR9f48eairHl+Xh2/21FSnIuQsbJeAehaHhxBI
	KLP9giq3/Wh+fjbqhpGeL0DTpQlmy4IJyB5w/6FTyC4pA/Rl6jODMCNYtLU2Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n41516cFOSFRoS+0lYF7pXHRIuFozQr68BvoXHjCy3k=;
	b=ndh7mOzFntoTeFkeBmOoY7MIwIoUcrDtAC9pPstUIQUP8feXGo6A0a0ve98G6dH+q1KLah
	c0lf3IBtiVL58/CA==
From: "thermal-bot for Ovidiu Panait" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] drivers/thermal/renesas/rzg3e: Fix
 signed integer overflow in temp_to_code()
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260916120003.87018-2-ovidiu.panait.rb@renesas.com>
References: <20260916120003.87018-2-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200921019.2666337.9987279161733309716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     84f0e14e6261ef718e6a8583073097ad9ea70e14
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//84f0e14e6261ef718e6a8583073097ad9ea70e14
Author:        Ovidiu Panait <ovidiu.panait.rb@renesas.com>
AuthorDate:    Wed, 16 Sep 2026 11:59:59=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Mon, 21 Sep 2026 17:47:38 +02:00

drivers/thermal/renesas/rzg3e: Fix signed integer overflow in temp_to_code()

The thermal core passes -INT_MAX/INT_MAX as low/high trip points, which
the driver then converts to code values for programming the registers:

numerator =3D (temp_mc - info->temp_d_mc) * (priv->trmval1 - priv->trmval0);

Although 'numerator' is defined as s64, the arithmetic is performed as int.
Because of this, the multiplication overflows for -INT_MAX and, because
temp_d_mc is negative, the subtraction overflows for INT_MAX.

To fix this, cast the temperature to s64, so that the arithmetic is
performed as s64.

Fixes: dc67521c20b7 ("thermal/drivers/renesas/rzg3e: Fix add thermal driver f=
or the Renesas RZ/G3E SoC")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260916120003.87018-2-ovidiu.panait.rb@renesa=
s.com
---
 drivers/thermal/renesas/rzg3e_thermal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesa=
s/rzg3e_thermal.c
index c44f5b8..4acee4e 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -194,7 +194,12 @@ static u16 rzg3e_thermal_temp_to_code(struct rzg3e_therm=
al_priv *priv, int temp_
 	s64 numerator, denominator;
 	s64 code;
=20
-	numerator =3D (temp_mc - info->temp_d_mc) * (priv->trmval1 - priv->trmval0);
+	/*
+	 * Perform the arithmetic in 64 bits so that it cannot overflow for
+	 * -INT_MAX/INT_MAX values passed from the thermal core or when
+	 * userspace writes arbitrary trip point temperatures.
+	 */
+	numerator =3D ((s64)temp_mc - info->temp_d_mc) * (priv->trmval1 - priv->trm=
val0);
 	denominator =3D info->temp_e_mc - info->temp_d_mc;
=20
 	code =3D div64_s64(numerator, denominator) + priv->trmval0;

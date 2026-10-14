Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9503955C7
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009170; cv=none; b=kGc0kFCikaSOvTFS5d7a7lHAXntiqiCPod1AJNDJrRfundvhMlMj0ofb9WxdCk3ZsEvkTEAopCjbln0s/RjpyALIqKSFTu+MTanAE7nbqBOEnxBkwZpSR4lSlpPApTfq+w+2y2Qq4jQcaNiqpULSo8m/z8NMQvPYjquk7wOBDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009170; c=relaxed/simple;
	bh=zeyda70pH1GVehf1TbyHnGEHPRhURVo74bexXA/89Hw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OlZ8WfBLDkQ9pYjY+ZORX6EeGYmB1G85dA/68YeN1zv9sr0EUn7eS+7gMhI+YkliNRPTdWnU1zM3YRBwFHJLsQzfwcjkjAQJ1bK/xR5oak/E5gX/BFNhWmxD8yOgsCgK4iUBjrmsi2/gaZnW/ncrtCghnGX7cd7ksrBcS8ehT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XGy8lWA1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VsDJDdoB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XGy8lWA1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VsDJDdoB"
Date: Wed, 14 Oct 2026 20:19:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009165;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILv9cPWkeh16z/ovSiCxnG8/65gVZAUSQSzN9Fc/ns0=;
	b=XGy8lWA1eM9IAXBC7QCzMPp3dGhLSMrwXxEqM1vGfLhXJJfSOwJpOo9YmHYLN6nLlYtTHd
	XB2UaLddhqjOqOkT5CqiKl7R5IuL/4e2tQNtcVPPq2EjawzIGSMwhLBH45c/k0Bxd74JiI
	KrvqYEnZbS7oBquySs6OLh4slsepqAXoktDtHM9/J9yj+QjfDh4LM6OxmJZbsfMJtBpMs/
	IjZuY3+PRbKOtSDi/5y7zqWaO5T3JR4dKcMz6GgOn+cdaz/3ZotH6HDMJkD7hK3HcXcqWP
	y9TbSwrVpiIkFu+jz+tUyOIMxdMYw7UWY+Yr5kuorZ9lApWzHptzMpJsxylEWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009165;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILv9cPWkeh16z/ovSiCxnG8/65gVZAUSQSzN9Fc/ns0=;
	b=VsDJDdoBn7iHPviOkbI5T4kqZaXKNnM4e2oVaP1bsJLGQhPEaBR/Sfm+OH9eb1/Ue8BA4f
	g40Emp98t/Eek3Aw==
From: "thermal-bot for Pengpeng Hou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/rzg3e: Propagate reset
 assertion failure from suspend
Cc: Pengpeng Hou <hppiscas@163.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20261014031814.7230-1-hppiscas@163.com>
References: <20261014031814.7230-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200916415.2666337.17610219212102196549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     2dc1f296b5754dd2441fc8b6613a362a47f6b98f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//2dc1f296b5754dd2441fc8b6613a362a47f6b98f
Author:        Pengpeng Hou <hppiscas@163.com>
AuthorDate:    Wed, 14 Oct 2026 11:18:14 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:46:07 +02:00

thermal/drivers/rzg3e: Propagate reset assertion failure from suspend

rzg3e_thermal_suspend() powers off an active sensor and then ignores
failure to assert its reset. System sleep can therefore continue without
the clean reset state expected by resume.

Return the reset error and, when the sensor had been active, try to
restore power before failing suspend. This is best-effort recovery:
reset assertion failure may leave partial hardware state, so restoring
power is not guaranteed to succeed. Preserve the original reset error.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: dc67521c20b7 ("thermal/drivers/renesas/rzg3e: Fix add thermal driver f=
or the Renesas RZ/G3E SoC")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20261014031814.7230-1-hppiscas@163.com
---
 drivers/thermal/renesas/rzg3e_thermal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesa=
s/rzg3e_thermal.c
index a1ceff7..e806d13 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -512,15 +512,19 @@ static int rzg3e_thermal_runtime_resume(struct device *=
dev)
 static int rzg3e_thermal_suspend(struct device *dev)
 {
 	struct rzg3e_thermal_priv *priv =3D dev_get_drvdata(dev);
+	bool active =3D pm_runtime_active(dev);
+	int ret;
=20
 	/* If device is active, power it off */
-	if (pm_runtime_active(dev))
+	if (active)
 		rzg3e_thermal_power_off(priv);
=20
 	/* Assert reset to ensure clean state after resume */
-	reset_control_assert(priv->rstc);
+	ret =3D reset_control_assert(priv->rstc);
+	if (ret && active)
+		rzg3e_thermal_power_on(priv);
=20
-	return 0;
+	return ret;
 }
=20
 static int rzg3e_thermal_resume(struct device *dev)

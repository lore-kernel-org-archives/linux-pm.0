Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4076492E26
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009209; cv=none; b=dUxKMGSRlx0eTsD/g/8EoEw3nlC/eMa7pooF52WsDSkJDCWtLeWayW07p+tp/j8+GrlB4CmAidMtda7yl77On2Ci7nppnc9k6cPcEnsBG2YOHQdSxAu0UF0APR8gMFDMF5xaz1NAAGijKVeCPD6AtNuzLKaOinhHrF/RHCapSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009209; c=relaxed/simple;
	bh=XanHk1c24MGkhOzXFhGam2TSlbW1orqn+kkEr1+z5BQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A/Du9DkPk6Wd87VMp8nA4u0CA52nYWvr0gumV5gtWQZdeYSAuD03cBBDP2W592w9e+ZwCDyd371ym1bdzVwsPd3M6MCGWg3s9QIxTOCxg4MwC+Bt6PAMLKf/rkyeHfTlrHDCU81W/i3cXRMk+zo117mCVQiE21wZj8T36NVsp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WDYkrf7b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKBVQqkQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WDYkrf7b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKBVQqkQ"
Date: Wed, 14 Oct 2026 20:20:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H43jgSEFx/948IE5kuFwV3feaGyYV5BumN2X+PEJgX0=;
	b=WDYkrf7bfSBE6vr3+OYr0uTUD652uELX7VREOtVItjykiJc4g2URC+5lWF6nMIOy1OsIyZ
	lmCavEw0GbpoK4zKavjeVo6Dw0mtDAJbeJa7/BdPi5+z2EtrNG1lc+6NJFtlBfKUpdolVC
	o+3dSs3X7Eg7vUHtX+mM46qkHsTFVP3EeyPKSk5PSAVj4lNVFg3SMd6lQ44Zl4R4N5DtkL
	s3KIT9H/FUe6YE0eekThaSO9PyfrX2riiVtNUCwqte0k3/pBlZgfa6vv6gdiXpQqG/iWSN
	CfNC1QOOxcGgcaMnDTBLsgYuvC/fg5xhEXUr8Oy3YVHZjh4KdlJDwSQ9mOlWKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H43jgSEFx/948IE5kuFwV3feaGyYV5BumN2X+PEJgX0=;
	b=wKBVQqkQ7HiyLIj9eSWM3IEFNz+wPi+BOGvcCwBpNrUtfeHCtjiUCe8o2B4C5cwtDmW3Hv
	TGQq4ti17nnQn+CA==
From: "thermal-bot for Ovidiu Panait" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/renesas/rzg3e: Remove
 redundant pm_runtime_mark_last_busy() calls
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260916120003.87018-6-ovidiu.panait.rb@renesas.com>
References: <20260916120003.87018-6-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200920430.2666337.2569616217761938193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     c337b60bdadc819c39f802d8e6418c320c580e0e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//c337b60bdadc819c39f802d8e6418c320c580e0e
Author:        Ovidiu Panait <ovidiu.panait.rb@renesas.com>
AuthorDate:    Wed, 16 Sep 2026 12:00:03=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Sun, 27 Sep 2026 23:00:37 +02:00

thermal/drivers/renesas/rzg3e: Remove redundant pm_runtime_mark_last_busy() c=
alls

pm_runtime_put_autosuspend() already calls pm_runtime_mark_last_busy()
internally, so the explicit calls are not needed. Remove them.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260916120003.87018-6-ovidiu.panait.rb@renesa=
s.com
---
 drivers/thermal/renesas/rzg3e_thermal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesa=
s/rzg3e_thermal.c
index ffe2b87..a1ceff7 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -262,7 +262,6 @@ static int rzg3e_thermal_get_temp(struct thermal_zone_dev=
ice *tz, int *temp)
 		*temp, *temp / 1000, abs(*temp) % 1000, code);
=20
 out:
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 	return ret;
 }
@@ -313,7 +312,6 @@ static int rzg3e_thermal_set_trips(struct thermal_zone_de=
vice *tz,
 	/* Unmask compare IRQ */
 	writel(TSU_SIER_CMPIE, priv->base + TSU_SIER);
=20
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
=20
 	return 0;
@@ -485,7 +483,6 @@ static int rzg3e_thermal_probe(struct platform_device *pd=
ev)
 	if (ret)
 		dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
=20
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
=20
 	dev_info(dev, "RZ/G3E thermal sensor registered\n");

Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952447A881
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009210; cv=none; b=G4hvUptAPwaUl6RyaO12Ix4+FNIZhAN2ctJEkLRzCHNoaAj4+oZpvjKHSh97AXWVVfKvKKRVLsYVOMccbI45wNoPEsopU1EO54b4r2qYZg94HimIcWiOjkHr/w+XpBUBaA2u0T2vtHzzl1Qe//EsnDOrSJXSqzqtxPgkSSmySz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009210; c=relaxed/simple;
	bh=mAvGbWCuJ+d+DjOteTVMIgPmFpgW9L/FnFz4jrtlvDw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TzKQreT0bZ68qI08dBIrQkK92Q0kTCqjGPqdy412UVuQa/ykMsyO1rhawdwag/oiqOrnm2opHVYv1gznpa3f4t9JLZfLHRAxgx0PMZNFVaQ1eO4p+H3R0xD+kOE2rddtPJcYxnBQ+G/vA/ZBhH4193IP0Yz7VTJtoIGcsUaeJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e7wqdJIr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+u6BDMLF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7wqdJIr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+u6BDMLF"
Date: Wed, 14 Oct 2026 20:20:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXokeD5rkJUQiPhcqjZy6RiYhCMR3avhVYSF6bbw9LI=;
	b=e7wqdJIrMLskpSM/ypY2d6AkeNd9IzUrdqHCByCRvZLgDLK5xtWz0ibVpvRNyNv8uStOZX
	X5dUcCW5mmHikCkucFo2/4AjraEJlesGGfdT//8vfTBeIKkKowMpbdfv7nYF1I5SxPtFE4
	4shMli3m7RCo1FlnRr4gKX+6vs7TFvKtWpNfnmWlsDvpfBQmRVCJ3uoG99T5fyFu/bHzow
	U5mDkFwhYtbY5OPORfz7vrqJisnNNDnbWga3SLCY0RlVbSKXeacMbagqdUO3Hzcl5FRyXV
	5wsmd5hoAKdGXYQWMHVeT8T8PNJlV/0rSJMJJIJlxGYo3l+tPRqq07FQqtq75A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXokeD5rkJUQiPhcqjZy6RiYhCMR3avhVYSF6bbw9LI=;
	b=+u6BDMLFOhF4AVcxNXqtx4ccKnSjemif3f1hQBd02eoHhKZo83vwygzFfL8/oNj3XaBJ2a
	8YnC/eMZy2zbcgDA==
From: "thermal-bot for Ovidiu Panait" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/renesas/rzg3e: Remove
 unneeded low/high check in set_trips()
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260916120003.87018-5-ovidiu.panait.rb@renesas.com>
References: <20260916120003.87018-5-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200920580.2666337.6605320325881180633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     a5f1de6d789484f308ff9b571835b3e2e7385444
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//a5f1de6d789484f308ff9b571835b3e2e7385444
Author:        Ovidiu Panait <ovidiu.panait.rb@renesas.com>
AuthorDate:    Wed, 16 Sep 2026 12:00:02=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Mon, 21 Sep 2026 17:48:30 +02:00

thermal/drivers/renesas/rzg3e: Remove unneeded low/high check in set_trips()

The hardware manual doesn't specify that the trip settings must be
strictly low < high, just that when the CMPCOND bit is 0, an interrupt
will be raised when the acquired temperature data is > ULIM or < LLIM.

Also, the thermal core already guarantees low < high.

Remove the redundant check.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260916120003.87018-5-ovidiu.panait.rb@renesa=
s.com
---
 drivers/thermal/renesas/rzg3e_thermal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesa=
s/rzg3e_thermal.c
index 58fdcc6..ffe2b87 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -275,10 +275,6 @@ static int rzg3e_thermal_set_trips(struct thermal_zone_d=
evice *tz,
 	u32 val;
 	int ret;
=20
-	/* Hardware requires low < high */
-	if (low >=3D high)
-		return -EINVAL;
-
 	ret =3D pm_runtime_resume_and_get(priv->dev);
 	if (ret < 0)
 		return ret;

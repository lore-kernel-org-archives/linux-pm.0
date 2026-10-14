Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6F4A2A6D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009192; cv=none; b=SlLH2Vq38xivvBYOxVSO4UMENLPFJ2U3vMbSahmWbSq9Wnsy3S/qyEO8zCcQDCcB8FUQNmAbQ+qZrDrDzNPKDlUrysrJ7jpSowcpHgzgosdXkkyxs0G6fCSoRu3Iz892bMZbrLHG3wdJIMIcM+mRz1yGLi7bB6J/f7qtZ0o43nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009192; c=relaxed/simple;
	bh=p7ET32WSNjPf+gnvnSro2YQl5AOC076r7LdldnCwhCE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PXY9LB4OSxPzlx7Zy9WcA5TJeZfDsfZA4IXus/j8xpYfN06BfvAWOD2OsGA2ewByYIU/2y+Z/wQNLPcoXZ44zoJoYfocBy0Y541E2SsVyTMNMIsTyhxKtqDveT+Zg1oUXzqRb7prvZTp9BnHmepuyeJ3l2r+DkMjHdV7QQdwDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/8GyMM8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H4nHzSni; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/8GyMM8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H4nHzSni"
Date: Wed, 14 Oct 2026 20:19:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6Ls2owmZC6smLsoE8qIVol92O33FUu1nO7CgPeQZr8=;
	b=0/8GyMM81tyQDrbn+Y+j1V9U3qSF51h45uXMf7NfXX4tbKZrPt409d+gk9atdbmxP6TE+u
	PWXke3LLl2e8TASgOxiC4pkm/4G927KQF3HCfr5GjjJ/UjmMgKQTkdCZ+/hB6exCRg0gYU
	hDFFH/ncBryhkV4/JYR6vO4bZdReWax7bmIloNgoMQPBBXds/dzOuQqpFnFOs3jB3lki3f
	0/pEB6TakDxwLM1QQi68/KO/AQpGR52mNYy1IM399rEVKUz2bWRRq5EtHIzwtLj7b5QzhT
	1VqJ1aeygMq0Okg1u6d7vOo+tsQnSfISx6Iby1fWdeXoW4iU0KgwUZjUWAxUiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6Ls2owmZC6smLsoE8qIVol92O33FUu1nO7CgPeQZr8=;
	b=H4nHzSni/RZfykv7dmpwkgc/Lue6WmvF4k5S25BSxPcYENSTu2BofjoeGrXY8ToMVmu4as
	hafCa4FPYBoe2nAg==
From: "thermal-bot for Markus Elfring" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal: gov_power_allocator: Use
 common error handling code in power_allocator_bind()
Cc: Markus Elfring <elfring@users.sourceforge.net>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <a3dc82f0-7333-465d-85b4-8034b1591442@web.de>
References: <a3dc82f0-7333-465d-85b4-8034b1591442@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200918821.2666337.12712371553331435520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     481860eba83b3fe27ca9be6f7f5bb4c8febc6572
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//481860eba83b3fe27ca9be6f7f5bb4c8febc6572
Author:        Markus Elfring <elfring@users.sourceforge.net>
AuthorDate:    Wed, 10 Jun 2026 11:20:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 13 Oct 2026 16:26:37 +02:00

thermal: gov_power_allocator: Use common error handling code in power_allocat=
or_bind()

Adjust labels so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/a3dc82f0-7333-465d-85b4-8034b1591442@web.de
---
 drivers/thermal/gov_power_allocator.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_powe=
r_allocator.c
index 37f2e22..6b9450f 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -707,22 +707,20 @@ static int power_allocator_bind(struct thermal_zone_dev=
ice *tz)
 	ret =3D check_power_actors(tz, params);
 	if (ret < 0) {
 		dev_warn(&tz->device, "power_allocator: binding failed\n");
-		kfree(params);
-		return ret;
+		goto free_params;
 	}
=20
 	ret =3D allocate_actors_buffer(params, ret);
 	if (ret) {
 		dev_warn(&tz->device, "power_allocator: allocation failed\n");
-		kfree(params);
-		return ret;
+		goto free_params;
 	}
=20
 	if (!tz->tzp) {
 		tz->tzp =3D kzalloc_obj(*tz->tzp);
 		if (!tz->tzp) {
 			ret =3D -ENOMEM;
-			goto free_params;
+			goto free_power;
 		}
=20
 		params->allocated_tzp =3D true;
@@ -746,8 +744,9 @@ static int power_allocator_bind(struct thermal_zone_devic=
e *tz)
=20
 	return 0;
=20
-free_params:
+free_power:
 	kfree(params->power);
+free_params:
 	kfree(params);
=20
 	return ret;

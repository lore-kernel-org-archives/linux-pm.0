Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514B4A3F16
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009200; cv=none; b=mjqC3CISkFyFPDjtYmwv7XfEtc0p5roF5roq96bVr+d9BH2EpXIymfdRlvV+Fm0kzJm6A0wUtKWGWqSZmg0o9elYzSoJT0/saUu3dIKGpDcVNAcimmJcUmyMTS+E06EXqnZYtwyLKDz6NsdKI/GgARBesCGiHtMyHHCfN1KjAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009200; c=relaxed/simple;
	bh=E6JLMKGzR3phK46ntwRjReZ/3CPmFt+WLqcUJna95/U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m03oj0X9dxQhVLfDDzl6L0/v6rdiHom3WH45vebjf9LD7ONu2ojVIm64aPOPWZISm7lDHBYoPapLEQmjGVJrVP/oEJv28SLYzkNp7Ds1lCh4cqFcShsx2u20dad0KRf08QRuqaB9S2zQWANVFn6BUDsBRY7pgP+/jqNBFs3dB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VG306zdf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/CvUPnIC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VG306zdf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/CvUPnIC"
Date: Wed, 14 Oct 2026 20:19:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOsTHB5cXdHrX5v/xovnwU9BizxClP8OHHl1Um4oybw=;
	b=VG306zdf9hWIChGJo4WQL8qRE+b2MzHoot3LRHA1bsz89z3I+7n3h5hdy/mOiMYIOqGYMm
	IRbs9ngXje7lGgsLnv5lANWujTlP6mOdIgppCYHP3fhOUZ/fhecYefJbVnKCzm9SujwFCK
	N1iXBDeqNatxDyjEMp2VyOVNzn28kIhQRxtEHrNWk2JQtCmf4/m/CEfJlklAAB/AzN2D7K
	hvs0dpEWyxMYkXq5z/gSAj/QwmcfC09cM4B+x7u1MncbvHbxLTPyz4bpDN6ldyO8PndFe+
	B5Mtp6/odRMINFtEe/fXg6U2iRSlURT0/hUuTWyttC6HX7/TIkP7xu1z8IuyUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOsTHB5cXdHrX5v/xovnwU9BizxClP8OHHl1Um4oybw=;
	b=/CvUPnIC++HA28avuT98eO9mcHCg66WxYp3UQE9h90IL6tYaW9477KA+NiuJMi1vCRFPB1
	kuEIwEGkDXjjOfAw==
From: "thermal-bot for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/linux-next] thermal: of: Match trip property helper types
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260612215009.1884665-1-robh@kernel.org>
References: <20260612215009.1884665-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200919627.2666337.1346270576339984722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     4f6d1a9ea172c22e6c67e2ec06fb0f20e07e7225
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//4f6d1a9ea172c22e6c67e2ec06fb0f20e07e7225
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Fri, 12 Jun 2026 16:50:09 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Mon, 28 Sep 2026 17:54:14 +02:00

thermal: of: Match trip property helper types

The thermal-zone binding defines "temperature" as a signed int32
value and "hysteresis" as an unsigned int32 value. Using helpers with
matching types avoids dt_property_check mismatches and preserves the
signed interpretation needed for trips below zero.

Read "temperature" with the signed helper and keep "hysteresis" on the
unsigned helper using separate typed temporaries before storing them in
the trip structure.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/20260612215009.1884665-1-robh@kernel.org
---
 drivers/thermal/thermal_of.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 0217a49..deaae7a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -63,22 +63,23 @@ static int thermal_of_get_trip_type(struct device_node *n=
p,
 static int thermal_of_populate_trip(struct device_node *np,
 				    struct thermal_trip *trip)
 {
-	int prop;
+	u32 hysteresis;
+	s32 temperature;
 	int ret;
=20
-	ret =3D of_property_read_u32(np, "temperature", &prop);
+	ret =3D of_property_read_s32(np, "temperature", &temperature);
 	if (ret < 0) {
 		pr_err("missing temperature property\n");
 		return ret;
 	}
-	trip->temperature =3D prop;
+	trip->temperature =3D temperature;
=20
-	ret =3D of_property_read_u32(np, "hysteresis", &prop);
+	ret =3D of_property_read_u32(np, "hysteresis", &hysteresis);
 	if (ret < 0) {
 		pr_err("missing hysteresis property\n");
 		return ret;
 	}
-	trip->hysteresis =3D prop;
+	trip->hysteresis =3D hysteresis;
=20
 	ret =3D thermal_of_get_trip_type(np, &trip->type);
 	if (ret < 0) {

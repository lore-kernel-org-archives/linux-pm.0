Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893786;
	b=eJYQcQB0RKT85iAVDGh4XezWDe7x2IF+1nmHkI3lwYVjptjCp5DII+JJ0Paw21v4XTpJ
	 st6+kT3AZB66CX+oI0sYs3aYCdjiNkOHgyre4oOfUS7xdmAC0669jDlIGo+Zd+cdZOi9d
	 4FMZBv9oKJ3hmI0J56d7OJf9I5JBcJYfz1YhV5QDT5nP1DtjIZiEW4XYGzzpKyXRejCpy
	 eWd8pTn1GHxmh9CD3fqhYCIaIPs8DEEgblVe9GqF9IBEGPl4QRAQl5dBSiYIqy0mmEsRy
	 nfslsMvHRY4cgey4Or/+ByWLOmVUzpUJjluBoUSzbXErIFLYlA+7pEpbURtOJoXAt7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893786;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Tz6MipF/FfZqF2uYVNd2ZWwNUi9Ng3hlKh0zUr2itKQ=;
	b=H0k6XtQlKT4DhUGiqoWYtwxMQTFJko9pqSVzGgm4+keGR+icB8dSXxAws0cdr5QIToiB
	 WiNN63jgdCWrdPNmo8H4b+05uFFwoe3s+kt0jCW7s3TnYpAzhatGkH9tGGWxssHkZDku2
	 isJCPTkjgnguAE4B5JCGbel/TXJuCUjUH6xnhda6DD8M6sIz0DfnlMyW3KpM841d+Vu5l
	 89sHr8FIq8Ig2WzvMIJO+adH1RmR4VBSpVX/EdcsJOKKM5WLG6I5ezcdzrbEwG6/X8kIG
	 6o9G5PT7DGGEJuB7LNTxdVALwqR9Q4AKZ4ZVLQp47Fv7DqRewb9TFRY2rZci3ZO4QUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uiVSUV8G;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gpIz1Rfg;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5B606D824
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB5B606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uiVSUV8G;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gpIz1Rfg
Date: Thu, 05 Nov 2026 15:49:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tz6MipF/FfZqF2uYVNd2ZWwNUi9Ng3hlKh0zUr2itKQ=;
	b=uiVSUV8GqesSD2O0czLpnGnbMJ9N4xjhtVETazx7bCMAJ1olLU1YHt2qjBL14vbqEm1gW7
	XtIFbM0lM77/dcwUrDCsB3N4OzQacUAhEmyzCBcMKV/IdLlIPzIY34NNaD3FZ1XmXxc835
	MtX35T6qGeXwJpDxMfv4w3KEN6hRwDIVxcK/Yo55Gbtvu0tRI1fGfU/D8RvhBnyO+rufZ5
	Kp06qM9qnqgKLic4rhmsXUCN+FaM22xJj7EAIPuQpA6ylSWVKHh+mEQOhWv7MjBvrPRUJt
	0khQ8evJlGODYabNbLKt9l/is7uKaYHZcF4+EG+XJ0dmPsdRwv2fvCH0vvPfCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tz6MipF/FfZqF2uYVNd2ZWwNUi9Ng3hlKh0zUr2itKQ=;
	b=gpIz1RfgJEauWFqMXnq1u0Q6Kr5U5vLau8tZgUvQL/H2k5gOK5W6pySn11DVnyExgL6W7p
	+b0HO+kTwxQ6E0BQ==
From: "thermal-bot for laixiangwu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/airoha: Fix device_node
 leak in en7581_thermal_probe()
Cc: laixiangwu <laixiangwu@cmss.chinamobile.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261030040732.1333-1-laixiangwu@cmss.chinamobile.com>
References: <20261030040732.1333-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389378242.1009794.8406307061629074781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     1c566cc82c231705ad8cbdba84b7715d0f6c2895
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//1c566cc82c231705ad8cbdba84b7715d0f6c2895
Author:        laixiangwu <laixiangwu@cmss.chinamobile.com>
AuthorDate:    Fri, 30 Oct 2026 12:07:32 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:47:10 +01:00

thermal/drivers/airoha: Fix device_node leak in en7581_thermal_probe()

en7581_thermal_probe() obtains the "airoha,chip-scu" device node with
of_parse_phandle(), which takes a reference on the node. If the
subsequent syscon_node_to_regmap() call fails, probe() returns the
error without dropping the reference, leaking the device node.

All the other paths in the function already release the node with
of_node_put(chip_scu_np). Do the same on the failing regmap lookup.

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal =
sensor")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261030040732.1333-1-laixiangwu@cmss.chinamob=
ile.com
---
 drivers/thermal/airoha_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_therma=
l.c
index 7c63a1b..b7062b3 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -572,8 +572,10 @@ static int en7581_thermal_probe(struct platform_device *=
pdev,
 		return -EINVAL;
=20
 	priv->chip_scu =3D syscon_node_to_regmap(chip_scu_np);
-	if (IS_ERR(priv->chip_scu))
+	if (IS_ERR(priv->chip_scu)) {
+		of_node_put(chip_scu_np);
 		return PTR_ERR(priv->chip_scu);
+	}
=20
 	for (i =3D 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
 		struct regmap_field *field;

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607978;
	b=ESyK8G3j55Xi5fc0pMj7rWNfkcD+bqS2HtFP5keC3/v32HsGaA3iRZgrZ7A6LzWBcRf4
	 VmTSRky70Kip74vnaKwbIaHgtbzqns6A8lm6xCdz5oGgxBvnQ3ICUN936+aEzcRKfQcaS
	 zHXtjmnnE+Wnx7hOC1+zDt1L+u469F9xu6JQpe+K23N0fdAhFtjPALGuOwvgoQhpWX11O
	 swrjXOi4h3XVUaRg1bHiV6V0g1+naf6wgUGn0IdmVD3nMFv7rR2KdagkBVuTYK0ietbgc
	 57l/gs/WXImZEQZFjyOZZCR67fzdrCeLuzlaJbgNZf/8bWAC/NqLZqXI1drsisiqg/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607978;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=tUDXKEZr3U/WpszAacNXfkNI5EppIQaefq9e2ZA6Iog=;
	b=OaoqzhhLC5KJdJ9G0hdXAqiEL4sEMZEuuZ2yQ+8OKgWWhPAnqr3euox00XlcmzrFDF8d
	 qYQj1r83ov5HP9fuArqj44r6Auuax/RZz34GQ1W6uVsp0eIkqdyMGQehq+9uy+evaPu44
	 FpQNGCXUd1KMD2njls/KfM1Ib5PnYK9MQbOuACd6NNeeWLU7u5BVqtGEBLVvjpfCbbuWk
	 6JM/Xv8tZgO2VNOvwJF+OGyOtcqvOo+MJssycUqgoSNH58BOQxbw7tKqfFGqFeXYPhez6
	 UGqo6IwuTCwVvDQhW6WNzCfvl0I4j4EHS9dr5wgUOYZrRr1Z3qyTAYqaJEhh7FCUlxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Q5Shyyav;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=F8QEQcYC;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E833606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E833606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Q5Shyyav;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=F8QEQcYC
Date: Wed, 25 Nov 2026 11:59:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUDXKEZr3U/WpszAacNXfkNI5EppIQaefq9e2ZA6Iog=;
	b=Q5Shyyav1yo79fyBp9AwBKDNgYfWp02s0s4w2RiW4Y4vc/gzjq3KYIfFIBRQDzNXvToUDL
	DpL5kMe1cW6ii60/Y3B0Cx22SiVmufF5rplW3ZBduor/yUrcWy/lzjYn2kS0szO5v6oDCg
	+4Yt5qb/EXqZ60jZ79lR6AKn6FdmAmYa4Izbqo+dHT/BYZBfrCuO4/f7PSOt/J+hvA+35H
	xuJKd9mlfHtGmjM01psegIjIHcEcK7Cl3UzXw9kNObXUfc/C22IjV+kWI/7Ha+JnUSQ1Ow
	DyOdCWMyF81BPYIxYi+lPmEMI8Wnh7yrbLHOzNzbESy7nDMsVi87lt2cU8X7Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUDXKEZr3U/WpszAacNXfkNI5EppIQaefq9e2ZA6Iog=;
	b=F8QEQcYCJU+kjMXc1vraNfTTKmN+7iZ5ad2043+3sqPNZWNyiJ4dsT42jUFggq6M951oTZ
	N3EPeLh8USPKoBBw==
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
Message-ID: <179560797475.92412.2338513002750950250.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     854481c8dd2002e1bf2afa73ed3facf1997f42fa
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//854481c8dd2002e1bf2afa73ed3facf1997f42fa
Author:        laixiangwu <laixiangwu@cmss.chinamobile.com>
AuthorDate:    Fri, 30 Oct 2026 12:07:32 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

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

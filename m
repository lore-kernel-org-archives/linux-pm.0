Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893762;
	b=FoWzC/oy9MQ/IToqFD1c9CJ+VP10xvjF0kWcsPx9X4YvUm90fTt1P5gg8oOKyuHfNLIi
	 UPpr1cFfq/n0uxH4GOa+xLtoJrvVMqtwVe+t4a3r6xAsQtIm6/HUcJ6Pm0yPPv7ugK33v
	 3ESVO05yG2uZHaRIj7cpfawIQ6MSLuJNhhbjUeJD1zvAJlu7ndMoP5vpOKO8H2q7xR05n
	 eOHrR3gqukRv/U8wNWNbq3vlIjEA6FvegSwHKJEULil0jre+6BF/srM9trNyNLhXNJs6s
	 sNwVpOJHNmBCM+Dsd7siHFMVsQ7TYwoWy75waCGZG9tO6RKnzRteZ7c0pCz9bVFlvOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893762;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=F6RRumhJsMjdxmszVW8PgfCbx61Ge4v/fNb2DhJ+kNo=;
	b=C951MOBWztxh8DaVMgVdUHv4sqokk5B9xyqlDx/aP2dbEl84YuJt/70lgbzAIa1eSAxf
	 SA6WXnfdBhfI6xX1/mDVERpmVczRkx02cpexhK8+eqRvu4Nub0S3HdkSsj1bkfds1PxWm
	 Zu6Huo9De1lBFInWLVpbvwfmnEi9qtYvmR4KbDckbKo7+5CoH16ZHGTEns2WKXo21sQ6x
	 rqeILWv6gg4zPKuO9pzcDyYe/I/ZxcR7T4df9wC+wlDUAS1Ln3bf8Y887Vt8RrhVeUsfZ
	 QOg3ggUUshYrDNVwESp9TIkLjHEvUfIj07BNfHHPuMPybcBoaMLrxj38nuvVs/mVVBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Om44BDrf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="ffIKm/F5";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16766082BFD
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16766082BFD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Om44BDrf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ffIKm/F5
Date: Thu, 05 Nov 2026 15:49:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6RRumhJsMjdxmszVW8PgfCbx61Ge4v/fNb2DhJ+kNo=;
	b=Om44BDrfxCiNUoDX2y0fKxhZ+7/6KtZlfFNUtBVbfc7Wew9cmnSKuBIENuRTeEA/wWo4SV
	Ded4qOhilxQoshufhQUmoHwIEx2PRBpKscjRp1X9YqUNB9M5CGYuUtST1Bq0lYeurwqO8O
	1ieA6pdKFo2VAPNnbZQiaXQTeUddn7XG27oUmY/oa+aoG4EKnF3/ehtBUmHKatMNLcQxxq
	G+zl8oM70YUbk1H4ubaEKk1fXpduBFxeKw77y7h25bJuOBdjBqDWKOnm6QZGboGPuBpvE8
	3f65x0A1QiNeFNJKg7LHQbUJltj99SeQGPItDsrmZQf9jCDkF0mWMkrFTB8Y9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6RRumhJsMjdxmszVW8PgfCbx61Ge4v/fNb2DhJ+kNo=;
	b=ffIKm/F5jglAuH12wmUhBRk/gOYNUlS/+bwibmtjClT6WQgmUg2NnPoNrEWYJ1tqNhHxYM
	7RiTRtUiv6pVXLBQ==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Rename platform driver to "exynos-acpm-tmu"
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-11-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-11-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389375857.1009794.283716939057872036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     ba446bdd27d4a2a6c0cb267f51a6ecc47cf19cf9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//ba446bdd27d4a2a6c0cb267f51a6ecc47cf19cf9
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:28=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:51 +01:00

thermal/drivers/samsung: acpm-tmu: Rename platform driver to "exynos-acpm-tmu"

Rename the platform driver from "gs-tmu" to "exynos-acpm-tmu" to reflect
that the ACPM TMU architecture is shared across Samsung Exynos SoCs
(such as GS101, AutoV920, and Exynos850) rather than being specific to
GS101, matching "exynos-acpm-protocol" in drivers/firmware/samsung/.

Suggested-by: Alexey Klimov <alexey.klimov@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-11-0637431b7268@lin=
aro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index 42b338d..2324efc 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -597,7 +597,7 @@ static const struct dev_pm_ops acpm_tmu_pm_ops =3D {
=20
 static struct platform_driver acpm_tmu_driver =3D {
 	.driver =3D {
-		.name   =3D "gs-tmu",
+		.name   =3D "exynos-acpm-tmu",
 		.pm     =3D pm_ptr(&acpm_tmu_pm_ops),
 		.of_match_table =3D acpm_tmu_match,
 	},

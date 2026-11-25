Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607955;
	b=Rn8a6u9qy30bTn2z39UYkL3eQqW5ljdWJTxj+/XjQ8tCdjsMzxS2XQxJUEM8eJxcCCvd
	 rRt0ySZfzVf0DOtC61/CKVvsf044u+fRftjKjisDBngOJJkILfoZDvZJ47ftQpwpL7AFh
	 C1wQ6oDl4Am+gGJL1m6o/R9umGnknCb7/tcpoWExqI0YJsiMwh8Bp2XyeKepfTIEpMEzN
	 74HY6IOxgX3Y0QojhZYknhBAbZlgp0s1Ux4BTf7UNnznxsIdTmemAsOJ+5XfnAfCH8NBi
	 8GcyMQSlE0nwcEC8QRRyuIXsHuibm9Th99gq5yC4akjuoXCNVp4bnfn/bTC//TZ+E/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607955;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=2Q3Qtx0lfWcBsJTqToEepZb7A4TeLvdHIH7rnz2FZ4k=;
	b=j9AKF/DJqZYyC1ylEbjTRFKsooZF8IblmR0LtclviOc5D75e45Acy6XmoZamDnWZ1gxw
	 tnXjB7saiiX05aeX16+wjc6Gfs7ygPIQEYYvekKbzaX2RgGkujSaRC9alSERu2PD/eLRB
	 +Onct7waC+G/rPuazll9665/Qzke2ngHqi1D+KZJSHvWVI39rcyy5xn3j1BqLPCtwYT6J
	 KMsr7yXG7xhAGsw3Vw3k5jw6tAwXDzi8lzo8VzVKzfsmbC9SyQ9Mhr9bCGnoveW2lhX/8
	 pMxfKSMDk/8bLhPhGiGpSiSHkfxMk69StMQM+oyUbzrBqysETu5dgVMdE22d3+ZCE4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CkBG44XN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jUxQCj5k;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855E606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4855E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CkBG44XN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jUxQCj5k
Date: Wed, 25 Nov 2026 11:59:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607953;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q3Qtx0lfWcBsJTqToEepZb7A4TeLvdHIH7rnz2FZ4k=;
	b=CkBG44XNjBN8jbIURa+yI/8hdDAmNrnEfh8JGlHPq7TOEczwz93eC3VpXRtY1fsbNoCv/G
	p4Rjc9/MMsdmO+3IJaJlQz5F1TEZgvVyMEyOrUvf2ALwCai7406cr/8mxVpcVox1ldiSOk
	BDvKGYur9yNINvdLFT7zVronZkh/eI4MO46Zop19JM7szx4Ui6RQ9ln06hWqTRMUQiunV8
	7kTTCWyuna9H62895YrfYUQy3LePJ9hpmsh02rON3DdejPejhBVmdSSfT7WIg/pH7PXAtl
	rp7gPThFjndpUdiaKfj7fZ6HhkLdVH6VaTOqFZIbhWhsgEL0OE/fufgwcB9bng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607953;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q3Qtx0lfWcBsJTqToEepZb7A4TeLvdHIH7rnz2FZ4k=;
	b=jUxQCj5kqeVSWy86nosiPl8oiW1PnpxIKHsVBqnOia4dSbbvk7QkcWAOJX8qmI+40R5ie7
	H52mxeOwvULsZKDw==
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
Message-ID: <179560795221.92412.10616960826340242462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     a6838907211cfd9507659dfe3fbd77c41ffa52ab
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//a6838907211cfd9507659dfe3fbd77c41ffa52ab
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:28=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

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

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607957;
	b=Tp03Yp2SbI3nke5KBNNAEP3DI0VH4Exk+6YKmH/GHDFdTH/W5Ll777L8w6LDJDUJDsZk
	 U1QqggtlCkWuiRK6oPAQmlRIKhdlgKpdLfHlQa8kv+AeofNr1ww9gBlClhW+TMOKX+orj
	 32XsjeQ+4kuf+hm7k/oq+cDBTiEzcjXl3agpEC1sUSH1/HeWrD297G5eGGIebjWnROlR0
	 pMF50+DqqQ2Y3N5ExqH1y7NmG+u1Pb6cSEkQe8UNpK5fFwkeK+/iJRifL2zx3ZaMTI7sd
	 i3SbYZIZE9cBWOyz0EuoexYgdAq+kULADqHe6aqqz9UMSLT5k69QR7VvyVMU3r4xXjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607957;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=pVIAqnrHVKr96eh8EUEks8U0IRXOrvD+p67dAUpEd7w=;
	b=vkP8sO8laz6lwrTrelOyfYeDyTmHd8CKtffEx50mJrWBc6Qk4XAnIHWLWDgtuTHLLUzM
	 uUmmFoo33c3Pr6GRO+mbhAHJhB0IdzJqxKQPnEtWk1N0PekDkHeKhoU+iAlj7wRpYodMZ
	 AdKPMGVerM3wCnLnf/GPpNljkRIcTUOVDl0iE5uxpBaH4tbpzFySwzFnmLAZ2pBuAT6Tz
	 b27fjSiHHewOrUT74h0TvQqK4KQHHIiU0hXqBuAz7Bm6KKjQaen/8RoAclS3nvDt1MUGl
	 UJhm0EaAo6m7qTI8Qld93+dWr0/n4m7y3kQHumeEn/tTBrIdjo8aFBSwfyHkPc1l3NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YisUEgT6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=am1fgw6m;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F060606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F060606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YisUEgT6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=am1fgw6m
Date: Wed, 25 Nov 2026 11:59:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVIAqnrHVKr96eh8EUEks8U0IRXOrvD+p67dAUpEd7w=;
	b=YisUEgT6yN7utKl/806P4H8Eev4NPWdnU/8D4P6FCSfmfj+T7nhzk3tp0BBHLSW3lEATVs
	JdU2wMx94SxNKYwUxWhfiAmKCU1vssN/veeH0rXjzal5/sAFLaCfoXNUhWUIuwTd2HjvIa
	EmV9t+bDjP6hN/DnnWturf8sm/cPLL+a9G3nu5mCyoexf/BW/oocuepF5yh7iT/nDJ0ezH
	1rPqRPTbiCc7TW/lr5UGKSA85IlQ92F3Gnay5AV2yEY5BSSeGafaFGYm9maQj1jibko7R3
	l5rCZfTm7WASDnsepR97T0RkqeyFQaxH+lPogrsdrElRPCd89nwtpQhoYib2qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVIAqnrHVKr96eh8EUEks8U0IRXOrvD+p67dAUpEd7w=;
	b=am1fgw6mD+a7piahRyanzbei0uQo8uR7dSLnAroNJKGaF5GfiSmjwSr4/iYMvuzKD6kS2X
	YFAAdO/FTo08M4Dw==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] MAINTAINERS: Use linux-pm mailing list
 for Samsung Exynos ACPM thermal driver
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-10-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-10-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560795376.92412.6688855378071794941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     0fa52930ae6ea3f8fe62cc29574bfb3c90c2fc7c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//0fa52930ae6ea3f8fe62cc29574bfb3c90c2fc7c
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:27=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

MAINTAINERS: Use linux-pm mailing list for Samsung Exynos ACPM thermal driver

List the power management and thermal subsystem mailing list
(linux-pm@vger.kernel.org) instead of the general
linux-kernel@vger.kernel.org list under SAMSUNG EXYNOS ACPM THERMAL
DRIVER.

Fixes: 05657c7822f2 ("MAINTAINERS: Add entry for Samsung Exynos ACPM thermal =
driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-10-0637431b7268@lin=
aro.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb3..586ac46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24899,7 +24899,7 @@ F:	include/linux/firmware/samsung/exynos-acpm-protoco=
l.h
=20
 SAMSUNG EXYNOS ACPM THERMAL DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
-L:	linux-kernel@vger.kernel.org
+L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml

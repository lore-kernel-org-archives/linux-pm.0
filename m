Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893764;
	b=KPbjD0PQbcDoJYhPXRmzqRYsaznaeTKvPex/ZAKzl7AWCc1pY4ScLvRXEe+8uCNfxyN8
	 omd63fsa36WzziyVQXJHe/WZDp8PDyr6l0qxcjoXc73kDScO+ezaXRpmFLheLIcKkPC3K
	 kE8nVOCcoDV3jYiJhZmnBd4afMYLtitfONKidMboZZjRQPNGJFgjWqm5ufrscrMuol6gA
	 pyQVvzZX3rG0I2ehRYp8lUM1l9t2s53HjTwa9Vpr8e7pw6tzM50LONV/pnmnXvcA8VENb
	 QBqCmCX9fcsx7zL1ATMg8s1ewfH5Z6CKGM+QaC85oiF4N98hoyfvri7xxuHWV6KgnWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893764;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=poLJOovqUH04lP9lO/vlGqmtWCxlcz9+60OxwUX0s9U=;
	b=dP5mJ7zI60cRRdQ0qS0swOH3GuqrYNJ2zlRXS9daBr1j7WBKz07IG7x3o2ClNCxP8Uis
	 pcaIDUhGHA2ukYlDIzjVokHlUFfLOa5idq8HPvmYnd4v8i5/V6apwI8ECcpsnQzbgDcQi
	 nUNlyaVX+enLVpIKJeuoCUgRbzrIC6Nso9N4qaSt2yrkPHVhyoZ4IHn/YKiWSHFsE0uyW
	 R5WN6OJyBdlRPHiD6RqT3gL/Mv2R1JuG//YoIbQ90dfuh98JPOJ6cAU5UrzAl4ZEARBKk
	 bMZtM56uswHWoH1/hZEuvSC7aUJhYKm7WtuxLGhHhKjdgWpsrgBuraGSIxgcDZpOJyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=S7hTcvVK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kJyv56LW;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0D6083625
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91A0D6083625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=S7hTcvVK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kJyv56LW
Date: Thu, 05 Nov 2026 15:49:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poLJOovqUH04lP9lO/vlGqmtWCxlcz9+60OxwUX0s9U=;
	b=S7hTcvVKBS0v8895dOYFRSogBbmDjOMnOHKcAvuPaB68Cnk/iERundwXmjBvBOR3LI6l+L
	0P3NXbycguB98H9jVbNzyv4cU7UNm4OfV8/FUmykBalr6U24OGB4G6Qw/lMQ2qu2coKmoN
	gqq/d2dfb+WwHKPSSN+oSysbfS1VT8nt1+XBr8pxZS1Ft2+MhCor5ZTtqX/Mp1fl/T1tMX
	39PWg3ob65stxGV1PdThOiAg6KX7RaCzLPc/u+gfNYnd7XKCy3QstKc0jlNxUcoAEPfEzS
	gW6k0fHBq1b3WBlhDF9CxZrufcsS+6ClDWIvS1fBK5t4bKaFfxJbotsxgCTICA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poLJOovqUH04lP9lO/vlGqmtWCxlcz9+60OxwUX0s9U=;
	b=kJyv56LW/M1SMWJHqD1G1rg51MuRPxAKXDGGwGoCMnxoQg0gChudDrH/j0iBmoFhWrb7pr
	OsBAL0uypROCtkAg==
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
Message-ID: <179389376021.1009794.10420346859664767025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     9745df063ef8190d713f90ffd215f39838ad6e83
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//9745df063ef8190d713f90ffd215f39838ad6e83
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:27=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:51 +01:00

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

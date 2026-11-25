Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607954;
	b=CTivO6jHDfwCkAHU4Kq90Ggw76BIhft0N4RzXi7RDVFGBIWLrI7AHbVKMZpnC56JdBRr
	 vudHOh8spxg5Z9xkjNv0hn/eYN/qhbSYuIKZPkoXW5X/IWFdxuPLJAEoBfX3kU17p/hue
	 tY13EOkhuGpYJhqI+AlmL0sXVe45Axzn7taxrHr0h8IPKUGIsJQ7fz2k8oD6cWWwj1ZwX
	 c18Zyq5VIgdJFTaPxjql7v8nPevRZ8KRLKBZBGbA2AuBrSoXIoDQ9ZJ0nqhNjn3OZthJP
	 WdoSvSnC0mcN5fKIQCVU9hysPYVzYMh5RzSPHvU99wEOaF1nZ//lHagpu/UDusYMa0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607954;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=hFSM4R7SXs31YyEHTh3gARJWlp+aSpnnUU5PJPleTtU=;
	b=RW6fRR0oyaKBh3Ll59iOzpdw/H5UMLKHTCvWaewmQ98CWBhZ5htULS7dpyRX+k0rhQ2a
	 /Qchq8QWgIjXWXEZC69jsd+bdSf2+k3MJa6ioytpcIMvFA41YP1GZIjP++LaI+4d4jNFW
	 /x/XUi81STgibS+1s7TZPw0Kb7uotTx/E1UEAtshzsFFJCDeenOHYBfBPx3gxL8LOsft5
	 DwOEFDTlpXDjlWicdqhrIpgDiFChabY3zkno8bkVKaFRrSbCVkAaNXHFr7kPfVSMevHc6
	 gCEepFM2+8B4gpJSHcX6ENliAcV4V2Bi/nbKnmN1Cgtmy3549hvKe5wGRS64TaV2Vhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zbRQchDl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mCVqvX77;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780D606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C780D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zbRQchDl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mCVqvX77
Date: Wed, 25 Nov 2026 11:59:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607952;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFSM4R7SXs31YyEHTh3gARJWlp+aSpnnUU5PJPleTtU=;
	b=zbRQchDl1Fsgm9918HyY0Ufu6PH72ahCSkwWjet6+MNGVsT4XTEoy7n1bQ90WxwffdkNT6
	9zWMMbsLfWSZL3FMZQrcCg9ALSa8yoxKF63YMetFTc1w456+pGYXJRJEF2XMiiisxc3AbO
	kjctI68qM17YHhlrun5lhQ6JNRJ6V+MU7YXdZx1EeMg5PTKObqfFcMSBfgkarF6XKsBm65
	8+Xq/YRcFV32IS78Fh653k9NPNfYhSUqljZRSSBK9lLiSi8r/z0mKQ7mjC6kpkhO0rpsNF
	1AH4CVssTParezxL26jv/ZQAvdTRRsGO0eHkHa4vFsrJH2zngpYqZRE9Hvr0Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607952;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFSM4R7SXs31YyEHTh3gARJWlp+aSpnnUU5PJPleTtU=;
	b=mCVqvX77HqBSBB6c2TQjywCv87Ge5B75DANIm93PecYYgXSzRTF4XVnBIY35J4FwdGSPso
	u71bJ1qcBgkZEgAg==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: Drop redundant
 composite object in Makefile
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-12-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-12-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560795072.92412.13555297404388677256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     e8a44bc190813c1430c3826038e90b31d4eeb4ff
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//e8a44bc190813c1430c3826038e90b31d4eeb4ff
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:29=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/samsung: Drop redundant composite object in Makefile

The Exynos ACPM thermal driver consists of a single source file
(acpm-tmu.c). Build acpm-tmu.o directly under CONFIG_EXYNOS_ACPM_THERMAL
instead of wrapping it in a single-file exynos_acpm_thermal.o composite
object.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-12-0637431b7268@lin=
aro.org
---
 drivers/thermal/samsung/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/Makefile b/drivers/thermal/samsung/Makef=
ile
index daed806..d5b6e9e 100644
--- a/drivers/thermal/samsung/Makefile
+++ b/drivers/thermal/samsung/Makefile
@@ -4,5 +4,4 @@
 #
 obj-$(CONFIG_EXYNOS_THERMAL)			+=3D exynos_thermal.o
 exynos_thermal-y				:=3D exynos_tmu.o
-obj-$(CONFIG_EXYNOS_ACPM_THERMAL)		+=3D exynos_acpm_thermal.o
-exynos_acpm_thermal-y				:=3D acpm-tmu.o
+obj-$(CONFIG_EXYNOS_ACPM_THERMAL)		+=3D acpm-tmu.o

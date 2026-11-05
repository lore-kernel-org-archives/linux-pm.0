Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893767;
	b=RtkwSIT3flOk5r2Cbu0YtvCbtKFWZKXgqQthfGM4weQk6hLqpaZFxp620d8wJPXtV3AH
	 rL3ScmEbsSbkO7L/AVVHGGEGrNSc0c1PjksPFaTYmZQ1wFumYB83+sJfFPwg4lfnqwaoV
	 KuCTRUKwp/39+xoHX1pVLqo/swHqSDY4kd+/G4N2BeoWjd2RmD3OrPtET1MzkwgxiQPnG
	 iNmV5F54UTuCHxIFLizvFx2qkNQ6rCmfXm2ejdcyqTfc5N/Gkc0ZKATlRCvCCakXoqo7/
	 f59sjvHdT+wuzNd17MRTyqf/DC3FhANi6FUlUl+hyEVFAk5UrGlrDRa/XNbbhGXpMkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893767;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=iDXxRF9fIzXLu8hCU/wvpUbj+cFuIa0zpBUgd5O3I+0=;
	b=cl5abp4uK/drAixpxdL2CH3DtWH/92fFf+wqBJerWMZDU2rmfB6DEEL+oZRxjKnzl3RM
	 7Z11hLZIO4FYGrGVciOUbNlqkOkpyslr9zUIPdoTsnki6s3BQ8OSAbC/41H4HgpsZ76Or
	 yXiAEF9imEBBjf1ZFn+9F78Ytkt0tj7yb4eb8xuYC27Zm5zHpMLTETcCnQj4xNHx4txay
	 lXn+4gXP29ZTLMzpTgyP5ALy+Ro5lbDbQhquDBBHjQZdkfwGdEHoUYHjwjoXTByRySVKv
	 NhC+LCCoEg7FcNQXMeCZF/g6iwtX+n50X7X8aU2LgNLt5kFX3IyTzWEkrlAqlVDhFzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Mn+pmWsz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Hg1O37K3;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696A60A2619
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4696A60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Mn+pmWsz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Hg1O37K3
Date: Thu, 05 Nov 2026 15:49:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDXxRF9fIzXLu8hCU/wvpUbj+cFuIa0zpBUgd5O3I+0=;
	b=Mn+pmWszDR/MvFvQNi1GhKtyq+7u3rCvxnfgQQJfS1efVbfmNTUQeLSm3UG3/N70iaEwSE
	DdOUulzIUfNCQVyQkFS3wi2xAgVVfOmMMoAQHZYxN2o2pvQF9xQtd7zW/aX0C+m3tlFkqi
	Vo4kraAZ+D2w2JLzUMzQe75NHCXilNTIUw9K6fKLdKOsi9R7RfjJWw2fLq1o5+oWsFE7n3
	jh9saaemcv8yWEa035vy0RZzq6xC37yOdHClh7b95W1kumyxh4ok25KM+2gaQfdXvIrwoK
	iyJmFi8XkzugN29V3sAaGTbzgFKmEn1s3fGus12RGQXiLQjuLbFaj0zGNwiSDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDXxRF9fIzXLu8hCU/wvpUbj+cFuIa0zpBUgd5O3I+0=;
	b=Hg1O37K3ZR0tiYDvO54ytjFAy+rEbPdkkTbsMHw62bR/Ezx56lOHXm+a8WalgkOK6iuRx9
	hznYgddsEaYv31Ag==
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
Message-ID: <179389375693.1009794.4335222828216732863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     133c6b01f134b6f3da2961099ab2fffe6e9a5f3d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//133c6b01f134b6f3da2961099ab2fffe6e9a5f3d
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:29=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:51 +01:00

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

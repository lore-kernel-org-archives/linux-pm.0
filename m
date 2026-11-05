Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893762;
	b=WfVp09mScSZ0T9fV55kd207xCEZAPjkQkFczkfx1xuajvlilK2X1HRvCPSSc/dPmY/yP
	 rJyvQSOsSqiHkrcpTo3PIKuzhMNxzc2a08mdJWzBunqCOCpMzNUxo0OWs1e3AFRZLlN4P
	 lcjXP1nXEboMnCagNrWWsT3RDgOy4ingUSJXHZRUYnE72d+orpBuvgzVaOyq9b/hHi50u
	 92ub17K6b6P8eonidOZKYgeUbeKqRJ0sAf+erhJA5BYh7AXuWlnUT5JZumXkzEqyG5oQ9
	 +rjW2Ns7qY7eCu0ukY+fmw9vVgEWkCVUF269Q07MZVkBDjfbFKdN4yArx/Zzr+bqM3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893762;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=q6LkNRcOdJKpjwJay2cfaJeZmuOd+rxLVnysyyzhIpE=;
	b=292yI8oO+Aw1Tr+uZHQY4S0JPU/otMwp9+pwLY06YhxYte9K+ZPtOqC+CyCp5ikRkGMK
	 DLpXyYrn1F7FKOIuXwlwouG9p5Ed+1Ygdlh0Vdc3VeOGAiKFtjZic2RwrMxLRlWl1n8aP
	 lyQCYkYmnfsnpftaqUMjIR3T5dsx7xS9n8dhzHROe6+v3GfutNcCwfbdZJAbcQw7TzuKw
	 Dqy3KkC7PloVYPAcV16x+oHXPE1ZqV7NJhaaeBk31t/SwStKqBbcZsXHtX/O4fvZkCgV1
	 k3OSNpxTgfSIogvoFQvxp3KEPE75Q8B4jk4yLC1k8d8btbi+c2J2bywQXal3nd5HPug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jO7qejGe;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="bsb//TGX";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F56082BF8
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C1F56082BF8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jO7qejGe;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=bsb//TGX
Date: Thu, 05 Nov 2026 15:49:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6LkNRcOdJKpjwJay2cfaJeZmuOd+rxLVnysyyzhIpE=;
	b=jO7qejGeeOs3GP81qf5nsM7RzxEOI1+fpBNCI+xKASlXXfeV+diMGfUtgdfCV63X0bfwkB
	RdfcTstih78/pN+R8FFWu0CWh3m0l0FGLtTvV0RZhuPF2Sjr1odSdqLVh3cmntOE2TGp1X
	ebIErwto2eGRSvC/4sQjVSKNSuip37Yn1/K5viXDcPlYdwcbjQCF7RXC+k+dBqP5yzAi5b
	c0iYf2c4z1X8jufJ4g32PAOxLPRIlnn63lfe2xjr5PJ9lI5b0is+cOgmTuVwl+FPyr/1oJ
	YfzruenL8BVF5qu30HipO4c2JGGMC8LZtwDYPOqN/u3SSuSBSEFgaMEKqMsicA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6LkNRcOdJKpjwJay2cfaJeZmuOd+rxLVnysyyzhIpE=;
	b=bsb//TGXCnaLuoF69EswEgy6sYM4Wt1Pm5LLfW5LFoRBebm7PX4Mgz9yMiwWR/1FMDgS1M
	lmfxUlZA6JIXvjAQ==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Simplify pm_runtime_resume_and_get() error checks
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-15-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-15-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389375192.1009794.7537816769913991719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     32cb06b34701827db0ff34244d84fc74e40ca350
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//32cb06b34701827db0ff34244d84fc74e40ca350
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:32=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:51 +01:00

thermal/drivers/samsung: acpm-tmu: Simplify pm_runtime_resume_and_get() error=
 checks

Unlike pm_runtime_get_sync(), pm_runtime_resume_and_get() returns 0 on
success or a negative error code on failure. Check "if (ret)"
consistently across all pm_runtime_resume_and_get() call sites in
acpm-tmu.c.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-15-0637431b7268@lin=
aro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index bce4674..7c30401 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -161,7 +161,7 @@ static int acpm_tmu_control(struct acpm_tmu_priv *priv, b=
ool on)
 	int i, ret, err =3D 0;
=20
 	ret =3D pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
=20
 	for (i =3D 0; i < priv->num_sensors; i++) {
@@ -205,7 +205,7 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *=
tz, int *temp)
 		return -ENODATA;
=20
 	ret =3D pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
=20
 	scoped_guard(mutex, &sensor->lock) {
@@ -463,7 +463,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
=20
 	ret =3D pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to resume device\n");
=20
 	ret =3D acpm_handle->ops->tmu.init(acpm_handle, priv->mbox_chan_id);

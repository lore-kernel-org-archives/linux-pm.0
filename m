Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795122983;
	b=ipxpblsFuL179lJhilVgIVxZgEGphHoBwFn9W8YW2op0eNWf8NvQSXIKBOfSDFCrDEDl
	 quP6/9Rd583osEB3E9DbHRbpb7JwLAZ4IjXIPdZ4xz/WYL9uyGa+ek79zDP5MVWPgyHXg
	 BX+B58W2FUsxFPawE5KitMnFSzCr4ux5KSy4gFTdauZPOYaTC45PVwgvgiK3oqgrJL8vq
	 GL6q3PB5JfBAv0wszRqalc72r9ZZE6G5MMgoN0X3uof5bSl70yOnc9MmpTpb1NRcdStOy
	 6Rf69piT6cjCgKSXUzaOUc3Uk/PuprD880IwzZYVmYeD+zp/9IBU1EDzPyxSmcDUMZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122983;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aupp4QHokLjdwW4ntsE/x/zafUYMMUQHTI33xAd/+K8=;
	b=prO8EI9kEOCCBXgTI8F+3HDxTj89huV7A1QtK9uqXtqnApDVFUVl5FOJqSzYkxfxsO37
	 W67I0lpPPMybFbiO2EVEwWCHH7TYmutFQadvy9AxBTyAwujWGqvG8nv/fOOJRGTPH1bXo
	 aMpUblzRuWin0PnHJYV1Zow2uh4soHtkv4QJMI0r1jiMSnuj8ZL0ao/R+EYqYQYSb5I+k
	 LWOaKNX03rK8sJaHmcV41AzuyWR/GC7yHvDOjSB4E+eqgtJhyca5BCshQ6tfnyRHcD4Nl
	 8pFEl2lWh7xKXZ7UAMEIQtyjnSoImobp1zRHZcO8XxHdBwbDJpxfSD4QhnJpE0U/OyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4b3s0j+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569560A2602;
	Thu, 19 Nov 2026 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4b3s0j+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795122983;
	b=ah8YiNJe7uxW//wOrP1Ks7ZLgDHnKi8NYEVdGQBJlEJ121EO9Q9EiaUtsBpbZ7BmQRoP
	 hu16ipDwOqJDzGPdao2oQm6bvLNFBBRBzgUBkxQXfsztL3s41BjhnwAHQQ7JsNwsU99jx
	 O782DB/G0CU0dNUQ19Dv2okNkHi6BcLGq0DPphfL76LBr1n0RLIVPIL8FZtnS8kqMygnf
	 sb3JUlMw2kog1w4pZGN3FZ5isLls1ppF8V9kPVF1im40Jl55+hxyH9TZy9JzZfDD4IP0Q
	 q1VULtytauu+aYZ1PUUyTND8kFRXTjmm46D5XqZnW+jcGdn6O6bAvQ1f10LOLwZPc7A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795122983;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aupp4QHokLjdwW4ntsE/x/zafUYMMUQHTI33xAd/+K8=;
	b=X3Rv1Jalu9SkUrhWbVIBRJYiaG+HvJ97YJ+giinJdKZUOkl22c5CB8r4tUq2eX2HZfcn
	 TS3Qxj+qsgU+PAfXuRYrUerLYiVImjj2DFIY99+OgJxl+CfkRmIFB+obe7bCJMIEAdxBU
	 ja7oJLjtMYdpMY0CTsKCf37y3EURkgddiE3aNgblhCl6r4Kmg4OP2QxaeVmZx349RbIb8
	 rNyiBE76cyZgGT3mkDs9nBygz9LiKJYDcvUlDOBIjnVFI73wVarKCDG53eO7xqSzjy3M9
	 wWS3zYfx1vuV8qQgpXcTE4wvpbi+Ym0j4A2Au6L0E32F4iRkFuJnFYC5NzvkP5EraNQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9F9901F000C0;
	Thu, 19 Nov 2026 21:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122983;
	bh=aupp4QHokLjdwW4ntsE/x/zafUYMMUQHTI33xAd/+K8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=d4b3s0j+C2u3vFPuMvQWlJaUvRGgxqSitEr2YEsF41Ty4a2M3Kdfn3dWBXdHJpwCQ
	 w/WNqOn6gnx39RXlX3cQaUL4FLTimpv1/1tMB3SZDumrMsyycRKpcSTBhxfmy3w0sF
	 mKAY0hoBS+yw4XRoF+rPK7S/yr5Q7P4MJ5XiSCZMWHep5nHXVHj+dp+gEJbTINixGZ
	 zBzural9FdPPnKc6PdtKqFliVJg+c/pKMh0usD+UNGmGeARgvITioFCqZLPgTPjULT
	 Pz6TFFiMu5x6rnSnX7CIUOF2VXj1x0Oc9TaMdHKXNaI2n9WYygwouyBbJmFkgmgp2C
	 TltEAocNh1sKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1FDB54B429;
	Thu, 19 Nov 2026 21:16:22 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 21:16:22 +0000
Subject: [PATCH v3 1/2] PM / devfreq: Resume at the frequency from before
 suspend
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-devfreq-suspend-sync-v3-1-ef19fbf94d83@gmail.com>
References: <20261119-devfreq-suspend-sync-v3-0-ef19fbf94d83@gmail.com>
In-Reply-To: <20261119-devfreq-suspend-sync-v3-0-ef19fbf94d83@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795122981; l=1549;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=oC9Ygc0eVTfT2xaSEZ90RmzA2OhUbylQMx8o+6M4NjQ=;
 b=a+90IYhYKf1h6Ux+adzDZV+Qjhih4NuCO71zC0xrnOw4fpcJqRNftizSH87J0a4n+enuZBakz
 v0mlh7bMa9CCoNK1l5KuzDvAbuk1TKWCPcL4SD3lNRgupiYCXb2xnfI
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Since commit 62453f1ba5d5 ("PM / devfreq: Use more accurate returned
new_freq as resume_freq"), devfreq_set_target() records the frequency it
sets as resume_freq, so the suspend transition in
devfreq_suspend_device() overwrites it with the suspend frequency. The
device then resumes at its suspend frequency and stays there until the
governor's next update; with runtime PM (e.g. lima on RK3528) that is
after every idle period.

Keep the frequency from before the suspend transition as resume_freq.

Fixes: 62453f1ba5d5 ("PM / devfreq: Use more accurate returned new_freq as resume_freq")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/devfreq/devfreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f25304bca37f..795a01d012ec 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1144,6 +1144,7 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
+	unsigned long resume_freq;
 	int ret;
 
 	if (!devfreq)
@@ -1161,7 +1162,10 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 
 	if (devfreq->suspend_freq) {
 		mutex_lock(&devfreq->lock);
+		/* devfreq_set_target() overwrites resume_freq; keep the pre-suspend one */
+		resume_freq = devfreq->previous_freq;
 		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
+		devfreq->resume_freq = resume_freq;
 		mutex_unlock(&devfreq->lock);
 		if (ret)
 			return ret;

-- 
2.55.0



Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84A3624BC;
	Sat, 12 Sep 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195915; cv=none; b=F3/f+aNJPoz1uh9TGF0djkGAbu7rHImzTQ8bVK/tvby7FJFjae671IbeAhOtUmpKknBKYgRFSdDHxRJfPhvr9vU68OzVTHLXwPsfvNWnCEcU8caB8duKyqUUI+J/r94qLVwv99klqq/tjLwNR3C5tPT5b0YZuIpLzXC3jJwIQiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195915; c=relaxed/simple;
	bh=M4xh6eMrXGc2J2BIeRBFM91FP/hXrXSLQUopRAscVHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sx9NOwSYCJ+XFo51kmUwBBoiKWvS1E0upOz6t7BPUU3HSTZxs6zfLHD2kPGjdYEG1wlloJPBqYmzwzlvuM7I7O/EPUzsJkS4WAF4ClPdkr1dL7AE7KVjldehl5TeQ3qyrLDlWuFJb443ouB2DbS7F5ZRJSxzACRzyFVRN68z1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=KSQh1D94; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dAu0IZl2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="KSQh1D94";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dAu0IZl2"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 916127A009B;
	Sat, 12 Sep 2026 02:51:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 12 Sep 2026 02:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789195912; x=
	1789282312; bh=2VGPOrJwM/1fzfaIuhVbGccUSYx13ajg4aSt3q/c7/Q=; b=K
	SQh1D94RCi6AoYKPYgM+SGXKw8NgAbMNnUuYeZPAVclCHy8y6xSjLcwOVOXoooM2
	zSidZ36PfZnJioXtT+HJRSROjEMYOfQ+2JdJtq0EobKrG/D3eNCeU7G+XMgp4LcC
	BubSqGlxthYsp2CQmMfnJGqJQkZOaWPhYajiTjDH+G9d0CoOQAhuL6/l6vW5ToSw
	BVNf4b9yxnIMXlhPAZLGMZNxvb4b08x8Z1wQStiS6HmoOUAoLN83HRrRGdwIvNq1
	DxrZvMGiHqFc1LFx4MwtvgueWwVgR2PvzeaQLRUidcUnI27umdkQ9TInuahKi75s
	j41IkgNkDwBtp39pK3bQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789195912; x=1789282312; bh=2
	VGPOrJwM/1fzfaIuhVbGccUSYx13ajg4aSt3q/c7/Q=; b=dAu0IZl2TfpoMJ6bT
	SVrGHV6QJVgy2Tyyot/L16AgXtzamldXGP9uEdXFe6r1tYGKiVs/SOMF2MAdXpLW
	HmHuSJiHSQ7GhfUnLJ7QJd9hb56ZDAkt4Pkc3AeoX5nCg/BplHvpcAso0w51mM5s
	A5hSd3J0NGojyiT8dViTg1ziqJ2Xa3CWWXyYnrLzzrbyr8c39qFjh3HimZq9+lMn
	rIb3c4v0k3FRhOZikIr4LnxuHZWI+zJXyan5riUaxN76QYabOjMKmy2meXVuOA+j
	T2760+CXz13LCds3aBlBQAjndnU/XwN1QK37QnHMvbyUrzaxbcTMnFeSb+wp8Jsv
	vw59g==
X-ME-Sender: <xms:iPakat206Xt9PS0QX_c3ntaOd-JXc7pnsCGLiVjGqSP1xeKFnFtV7w>
    <xme:iPakakNwxIqG6gpcLrpE7GYdoOH0Pk_1wqxY6F0AW80i4pf8aN9BKCH7QgE_kVYRb
    Z_YTf2iawYxhOwUiPEtIhE9fEldHzg2-UGp3STMnlmUkw0mE4ilknBwlQ>
X-ME-Received: <xmr:iPakartcGiWlYGupt8wXJlthDRXuSmXsRLbElhzXHCZGVAc56aGi0djlgxovok7mW69zrs6_Og>
X-ME-Proxy-Cause: dmFkZTE+xqYf+UNK3n3/SIVs5BMAkLL9SxSoeEa4aB1fL6sr5qoef0WXj/1D7lk0loNQgA
    4wrb8ygN/2xkG75l4y4Fs8h3bchGJPI+qo1AnRPcGZkXLwTgZeTSmelpSlfpC1UBJUBigI
    1uFUwuHYg71uhjWBx+7gOB0wn6akkmIMJLFlo26eFvuPPeo/6Kal04PCqlAm2Qq1tO2Cfv
    o3w83T+/2Kx2uyay0A4QdFPpF8s9PMsVXY0xB+GdGF9iMqqNE7jnJG1ikE4FT0u5FbUTpq
    2eYTgupwj7OYcoX2KuqqrFT2VA0jtIcYybDBTRddmCPQ7BA12Wvv4mvQuWCvRqXsZSSFtR
    Thh8Nm31j5n/ZrvrcB/CaqN2b+T77rkWnP2lBeJyLWYqXzXEfgoeeidlKdM+gMT4DS8in5
    KxMWJEqW98g6qcFb78ZexlzMtorQJ1IMcHng1m874D6AfZjlylNXJ3sH2QWYt+DKUhb6GH
    71iUa8DPzWdKGcDe28NevzHsKGYIzbWKTJqqVW7dIzXnHPll6xlGl1cJczBFuFcl11xVBB
    O92CEFAbZsI0UN6bVoeXAd1hZwd4Kb7pYQA7kEM0NnojzUS6e0dp4rlLZ2xoDMBOpN5BnN
    lvUEGnnZhBRv5ZBSE/N7QhYQ+hqVhYOFZ1mirjIAltdb3v7ZWHQt742h57Rw
X-ME-Proxy: <xmx:iPakavG84rU0v-757YpHBaDJRUc3TS0yMbzhyMV2G0zqksJEoVlCdw>
    <xmx:iPakauSmkK2MZzQNzEU0_mOT2ANgRVNU_A3QYvCPfqogISkDs7d3Ag>
    <xmx:iPakarjaPR5OJ8ZCfuiPRomgW4PKLRL_937yJAKvkmlXW2RETdDMAg>
    <xmx:iPakaqaW6Yf1WZ319FAwNwusOnW97qcjjR-NOfiVcCbZ9MXCyQsGEg>
    <xmx:iPakaguHBr2XyY1edZ1uLIbxHfiQSqJvy-EW7Kh4XTzIWPfgtp5WXBGH>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:51:44 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v12 04/14] accel/rocket: let the core suspend after a reset
Date: Sat, 12 Sep 2026 18:50:43 +1200
Message-ID: <20260912065053.1519165-5-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912065053.1519165-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_reset() drops the in-flight job's runtime PM reference with
pm_runtime_put_noidle(), a bare decrement that requests nothing. The core
is left at usage_count 0 but still runtime-active with no idle request
pending, so it does not suspend until something else asks, and on a
platform whose power domain does work on power-on that work never happens.

On RK3576 that work is a bus interface reset the domain cycles when it
comes up. Without it the NPU's IOMMU stops answering, and the job after a
timeout returns a surface of the output zero point with rk_iommu reporting
that MMU_DTE_ADDR is not functioning.

Measured on a ROCK 4D in one boot, three runs, one variable between them.
With the bare put the core reads runtime-active with its rail still up
after the reset, the IOMMU reports the failure on the next attach and the
inference returns 0 of 128 channels. With the reference put back through
pm_runtime_put_autosuspend() the core reads suspended with the rail down,
there is no IOMMU message, and the same inference returns 128 of 128. A
third run repeating the first failed the same way.

It also matches the put in the completion path a few lines away, so the
reset path no longer leaves the device in a state the rest of the driver
never produces. The remaining put, on the error path in rocket_job_run(),
is a plain pm_runtime_put() and is left alone here: it unwinds a
pm_runtime_resume_and_get() that never reached the hardware, and changing
it belongs in its own patch.

Igor Paunovic ran the differential on RK3588: 45 induced resets across
three cores, with and without the two preceding patches, and the domain
dropped every single time with no MMU message on either kernel. So this is
not rocket-wide. His conditions cross a healthy block with a lowered
timeout rather than a hung one, which he was careful to say his protocol
cannot settle, but it is what scopes the change to RK3576.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 0be8db391..b588049aa 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -421,12 +421,12 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 
 	/*
 	 * No handler is running now, but we might still have stuck jobs. Let's
-	 * make sure the PM counters stay balanced by manually calling
-	 * pm_runtime_put_noidle().
+	 * make sure the PM counters stay balanced by putting the reference the
+	 * job took, and request idle while doing it so the core can suspend.
 	 */
 	scoped_guard(mutex, &core->job_lock) {
 		if (core->in_flight_job)
-			pm_runtime_put_noidle(core->dev);
+			pm_runtime_put_autosuspend(core->dev);
 
 		iommu_detach_group(NULL, core->iommu_group);
 
-- 
2.43.0


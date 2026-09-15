Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AE48821E;
	Tue, 15 Sep 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469050; cv=none; b=IF/zYimmWT1gZ+rg9Tn3cbRYm4OtfiDeutIIIYm3/y3TXIX6jNXjhCg3Bp8IQHH2PRw62TZO/1R0FiLzskxvb8YX8BiWt4fWKOQ0bMT9p9z2/54pzhSo/SdnKwPkHhCHntphf0DC+haE88nAZpqKRFsXq998qpMV/mq4IXBajy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469050; c=relaxed/simple;
	bh=UNtUWedXOFw6Y84guT0ri0JEMNMiMFLDLbVrN0d1vzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJbde7d8mr7n4puyFTAf7SlJvh33lr/7Y2GrgRKowr+41zDOymIZPEpY3kUY8Pg7OEGYhuQn7oD0as2rkYkMN1Wg9muYGRWluXLbsQx/+1ducVs9TVpUa3bpdradQQ6zGr2+vQOmyQoOxNM0kCplDV5PahIHu+6GKI61/6yQfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=rGrL2iyq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Szew/k5R; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="rGrL2iyq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Szew/k5R"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 07EE2130050A;
	Tue, 15 Sep 2026 06:44:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 15 Sep 2026 06:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469046; x=
	1789476246; bh=v1ElCBSyTnCFYrsQFQwtZaxsgmNkPMyYPZX+ryKcWRc=; b=r
	GrL2iyqQQWO8+8HBmci/t8HWjVRbcseCtQOYKljW6CSG0K8vd6c66UsRSqo6UvJ7
	I7JXug7/5RwewgC6sdVFdvlWqR3TCGK+/I6waHy38xeN7M8pnE/QIGto71iE2TP3
	RtKRkq9yNjreEYnTuQQXOQCg4N30eJYypP5zqcUIipslwimZA71gL+4Z8PaDX7Ca
	Iyv8PegFRnIwqAXy1uail0X6ktfMbf2NXDqrf6g0LjMwOFoiQJRsNyMqqOCTZAH9
	j7EneBr/2PH3QW8iM2VD0DgBd2E99M6d2TTQpSp2ysSvq2QL5wOFpaT5TfVeMdNm
	E5TejJXRwO8EF9FIyxkdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469046; x=1789476246; bh=v
	1ElCBSyTnCFYrsQFQwtZaxsgmNkPMyYPZX+ryKcWRc=; b=Szew/k5RMyQelOvT/
	7vWtqRDYTlZsrya+RycBeZxBdSXcZtvhEXg4Mya/1yJwYrxLSOkBa9yV2zDMhSnN
	enOaNVoqIp9nBbW5qt/sY71flV/4jUrr6GvKcOOPGHswC84kwNKxihN7O5QlmG0n
	K8M3Ao2TCDUiYOZZXFHqx2Vam+YMbv8NOZW0Iid/kUbS/vnOCGveMgX6vxXMGIQq
	wORyaYiYvp+tb1ek6oSbJybOFJNjXn/yypycRe1Xy2RZml4+Ndf461vgwCwf9enB
	6Q9oDE7r6jx6LRLZGlEqSeshE4k9XSsO6YsGzMLsuVOusl4TFqKivuM3uuKFeT8B
	VlFTQ==
X-ME-Sender: <xms:diGpat84YYgS7WZQZySZz_38f2uIqfFNfSGEx0l-yX5L1gUVe-I4Hw>
    <xme:diGpah1xGai6d0LNwAa2QCuVKyoQX_DFNxI1Tg-U4UFQyjk8KZZagDp96DIpj76_7
    kGVpFQUvmSE-OqMP3zuvPSJikacCye_pmV0ZnyBcKGqilqmKodI3_Y>
X-ME-Received: <xmr:diGpao2VB9YAYFXg9W6m5U8784lyoqB-UdAgh9BG_Fsee4GGqQeVmVzKT9mKOWu1gs0PxOf4NQ>
X-ME-Proxy-Cause: dmFkZTEJ7lsNMc5MXcmK0yAby6zAyahnp/o+BLQRTsAUuD6zUFYE1mfayW4ARlNvxFxbHL
    RViSXklp2Mvqoh7nMl9WcpZxcA5zX09aM17WbnSDD1mVdJoa+dDoRGgFZ+ZZgzctt5mn//
    Fi1Mt6BzxdDiSZyXddMkKr5ZuKnhcJKMT/Ww41HfwQaAux+0BU99FP+g6srkBweq+0Pyu4
    FpApM0KD75gdC3rQ4X6qbPGbs1ABgnV9cF7lajdZo5Ix2shyw0qolijI7Y4mlyGIz0nhlc
    sJGrQ0glbm4LA0H4VdiK+uhUvmoFkp3adh0VEvVmG9UeMUF3kO5gMGvK351yi5uht+G8HJ
    9VIQDdOShQh0XpTD2S2lGQbN+p0sfwZyLoHdudE5j8rPF0gisWveIjbPVJ2de4yTnbnZRb
    yhKAkObkGu9cCJKGyUZ/ogRYYyw65d8zdgDZf7yNUl315cvni+3qPAOgqxwWeK3+uklvg/
    VeZsYBwOcZLbKU89lu2goMk8FJdXZWg96ZmXXhJI+yHUzWVe/UnWGOVQvuUL7MpfjiDubX
    4d1PM9xRi1VbQGC0W4xwRNiug/af2YtVXaRe4KfNB6Odx+5bA+Tq93vcBagC8gKkWwuoEX
    65YeQwDhMUgv5ohAfgua27G3SIbLrcWlmtJvbzKypmfH/0u2VQKkBK5XruDQ
X-ME-Proxy: <xmx:diGpaluaiKlliWY0DHjx_fLeBzspCbHGfQ9lvtXFanrrZZmRn_IR-w>
    <xmx:diGpagYp1XnBZNsNrYGZ3soqxFrb8ZhLpM8yKS0pEyTAYYiNWskP4Q>
    <xmx:diGpajLPqxdE9pTINXfBVqxFnHll6ouA1hrFm4XSuz-iqrAQp7iiXw>
    <xmx:diGpaphK2LFXrH04cWFKceQV0dQivl3h5iLprqp4cAHkat28pzO8VQ>
    <xmx:diGpapAAKkDWJQ0E6DOKWGOj6UQhdWljFn2OsJ1osnP2fl1dwF_O_jXc>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:43:58 -0400 (EDT)
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
Subject: [PATCH v13 02/14] accel/rocket: take the completion register writes under job_lock
Date: Tue, 15 Sep 2026 22:43:16 +1200
Message-ID: <20260915104328.45901-3-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_job_handle_irq() writes OPERATION_ENABLE and INTERRUPT_CLEAR before
taking job_lock, while rocket_job_hw_submit() writes OPERATION_ENABLE from
inside it. The two can therefore race: a completion being handled on one
core can write its zero after a submit on the same core has written its
one, and stop a task that has only just started.

Nothing in tree hits this often, because the interrupt is the only
completion path and it does not overlap its own submit, but the ordering is
wrong on its own terms.

To be exact about what the lock does and does not buy: a mutex gives mutual
exclusion, not ordering, so it does not by itself stop a zero from landing
after a one. What keeps the ordinary path safe is that the handler signals
the job's done fence before the scheduler can issue the next one. The
reason the writes belong inside the guard is that stopping the block and
deciding what to start next have to be one step, which they were not.

Move both writes inside the existing scoped_guard() rather than adding a
second critical section, so stopping the block and deciding what to start
next are one atomic step.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index f40435505..575945015 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -345,10 +345,15 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
 
-	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
-	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+	scoped_guard(mutex, &core->job_lock) {
+		/*
+		 * Stopping the block belongs under the lock. hw_submit() writes
+		 * OPERATION_ENABLE too, and outside the lock this zero can land
+		 * after that one and stop a task that has only just started.
+		 */
+		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
+		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-	scoped_guard(mutex, &core->job_lock)
 		if (core->in_flight_job) {
 			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
 				rocket_job_hw_submit(core, core->in_flight_job);
@@ -360,6 +365,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
 		}
+	}
 }
 
 static void
-- 
2.43.0


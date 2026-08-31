Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCF3DB96B;
	Mon, 31 Aug 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164458; cv=none; b=sMWLqXS3seZvGTUafKXawNq9xwDCV+yPs1DInG6Zzla835fnDFUDuddNV0J4y4rRB0cqb+Py7IrizhOi3K3c8KNwzqiYLn4CZSAZF70402Pql2awQfq/5AfOT6jbndhhf+RRWMmCU8HPVfC+8DQcdfBAMGYezkA/Ke4yV0SdjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164458; c=relaxed/simple;
	bh=SRHQE8bCG1hZarDfuj2dLy5ZE4gG7sSEuLmBWXWIfB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOiJV5kpxt3TBP2W5esyD70XhzmlchPrkFhM1HOfTZdFz0895MO7ZzyAPRrQdDb1e4EnChwUtswgoH0gY2/EZ/VLkW6OMCwA/nSGuRyVT2l7bXG20V+0na6fMvmXkKyo/+I+y8RcMKuCUR26T9mcm+pv8JnxzCja5Xu+f7suTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=Fwwx/Wd7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EW/WL4KX; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Fwwx/Wd7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EW/WL4KX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 73BB113800E9;
	Mon, 31 Aug 2026 04:20:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 04:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788164456; x=
	1788171656; bh=hIs4JGkCZbe1hIfuDPjKMzbKJ3jJLbxC1l4hzdrLCRw=; b=F
	wwx/Wd7DfSW5KwV1i0PS2+qyAzZ2F9GvdUIsJk50qWErbHET0LDSC9TldcRYUp5v
	OZCBIzAI+nWE948A3++nxZkeA9vdGsbdY9InLklsm5CUpzZJLQO0a4oxLRLSn9gs
	0TKhUg1XkHBQGzCJAeGPC7VQVt0g0SHuH/o0ik47NQlC7d7fCFmky2e1ay3C4GTi
	IsUacoSywDuR4Z28yMOEwkVErjoHgA/yiec6wsIoLr/Duo0rA/MmbHNcLMtn+XmI
	Eagy6xPPi9M6gE6FcCn0vzH7xcqJsYWmYscsnK4AJuDZJMmFzm30EKXPVsh5O71y
	kcfxPpb+24d2ATZmzIgzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788164456; x=1788171656; bh=h
	Is4JGkCZbe1hIfuDPjKMzbKJ3jJLbxC1l4hzdrLCRw=; b=EW/WL4KXxK2rs/WO4
	NvOHQhYLmkY139g/cAE84dq4uJw7vmZtkPya3NDZC8nBY+b/h/i5AvMd8tMgQXTp
	RWucNaTffvPxMnkDMU8etkFSh2u0acNprZY6WN2g3uKcmGOzNiH5L5Oyn2dbnJAg
	SDLbyAUU4Z4YnWCdzpwbfJdTB8t5nNgs2A5mBfOPFZrV29KgQYiyhzEjR1XVmkqt
	0YzG8RpKG1Lsx6NJf32/7r7TTHgidAhiJCRd9DZxByNWZaNiZxESAMarIZp4k4BA
	dLCgwoLqLD+RaImuo8cYWaE/3DumnS5pgrdAP63Ec1sgmn/EEiuR8lhUslRcUHiv
	HH4/g==
X-ME-Sender: <xms:aDmVakmoNe8DCueFNCCZbU2H5rLLDWbW5Yz09y1QW_N7FMjcr1OYpA>
    <xme:aDmVavVDLtfS5lP7wHvb4qQMasvX8OOu9Mi6AS8rLDQJhNu8yyhMF3vgcSzMK1KZz
    5oPxRswO653KmDaPZKyj4UypsWz8KmpxSm1QOxQ0em3ZO_9VcJWF-g>
X-ME-Received: <xmr:aDmVaorETTMgFGsKe-u1wg7g7wpjj20IFzAat4vHiWmMMB7khA1Gt4dKcqfqtq1rowjTBAKPBQ>
X-ME-Proxy-Cause: dmFkZTGYrYQ2jbMIxuQQCTBrQEZV+2IeEJvNcIZdcE9k2+nonI+MXWeL+Fq1FR2QwCrGvg
    gGSdLycSMfgfbE1kxPSllUMxTP/iJF0lzsn6HivhDL3LXGwnti4ujyK/i8Q7drADO1i81K
    M3noTNzJzt5qFNP+YDvtmt4fDPa9SsdmVpmUjZRssqd/d2WIk0TSez88y0itYx7VRZu9p5
    hyBi/gwTU3HsYOw0HnQy3iy84WTZdJBZDEJUN+mIXpXclmSEQ9RkG9+4o9+kafPrg479JT
    lNLt9nPHiC8q9WThD5Zm2cxB8DqJUzOHOFBcRpz3xfx4ph80NuZX6vZFgzhR+6ENZvUJGO
    FrePjJEJbnA2bUwY0CCh4e4f4ARti5hvrFJGiKgGTEXt1zfMaDZjglPR+n6A/rzkP+6RDM
    R0dFN3fuEhBX6/EeEboQ9DFWad5VJFFv3p1fonh4nGMdYHyo2h8tNLAToBHt68MenAon2a
    hNb5sumWlFwSvHkhesnazqDpWe9h5RnZlrX8kG/snk0jvi0Z2NHPKWtUa9+5mK1+lLljXt
    RwEU1vAQfCqpCziYEcZRlcCjPghrRanypXiEJ1KE96B0x3Lo0lQUjbINEN6WOBHgS2mfzs
    IBZ0oHeu3FqmxPXb5loFD+zG6EbylmiXYeDWm1sSEk16h8O2D97GUkM589EA
X-ME-Proxy: <xmx:aDmVauV_cMj2CwQEwQIi0Rw5Hbb2drXs9yxSHuzGAXZ3uuPYDx_JNA>
    <xmx:aDmVaoB4xDq3uT2wKJoYZbJfJOEbZfURxn8hGh_pY12O0yEe8ojWEA>
    <xmx:aDmVaiUKO76lIOk0aRaOP1GoFPXSxJGhZw63pHtq7hbl2Qh6oiGpEg>
    <xmx:aDmVam8ooeSeoT6Y0xBTxc1tZpaO9O6HS3DhzBrnBFWCF8MyOVJXZg>
    <xmx:aDmVauQX3AhUJhR_6m2Lz9-HH9pnBylqa9P6IlM-qdaue3wyoQ5kteza>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:20:49 -0400 (EDT)
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
Subject: [PATCH v11 05/14] accel/rocket: factor the completion tail out of the IRQ handler
Date: Mon, 31 Aug 2026 20:19:47 +1200
Message-ID: <20260831081956.84871-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831081956.84871-1-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_job_handle_irq() stops the block and then either starts the job's
next task or retires the job. The second half is a step of its own and
reads better with a name, now that taking the register writes under
job_lock has moved it a level deeper inside the scoped guard.

Move it to rocket_job_next_locked(). The early return that used to leave
the handler now leaves the helper, which is the same thing here: the
scoped guard drops job_lock either way and nothing follows it.

Doing it as its own patch keeps the locking fix at the head of the
series minimal, so a bisect that stops before this one gets that fix and
nothing else. There is one caller, and no functional change.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index a89ab49e1..69e29f40f 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -341,6 +341,25 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return ERR_PTR(ret);
 }
 
+/* Start the job's next task, or retire it. Caller holds job_lock. */
+static void rocket_job_next_locked(struct rocket_core *core)
+{
+	lockdep_assert_held(&core->job_lock);
+
+	if (!core->in_flight_job)
+		return;
+
+	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
+		rocket_job_hw_submit(core, core->in_flight_job);
+		return;
+	}
+
+	iommu_detach_group(NULL, iommu_group_get(core->dev));
+	dma_fence_signal(core->in_flight_job->done_fence);
+	pm_runtime_put_autosuspend(core->dev);
+	core->in_flight_job = NULL;
+}
+
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
@@ -354,17 +373,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-		if (core->in_flight_job) {
-			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
-				rocket_job_hw_submit(core, core->in_flight_job);
-				return;
-			}
-
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
-			dma_fence_signal(core->in_flight_job->done_fence);
-			pm_runtime_put_autosuspend(core->dev);
-			core->in_flight_job = NULL;
-		}
+		rocket_job_next_locked(core);
 	}
 }
 
-- 
2.43.0


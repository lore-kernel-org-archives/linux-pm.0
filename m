Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC340926C;
	Mon, 24 Aug 2026 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569800; cv=none; b=RahemU0L0UlYZHA/79gvxSpYKOlLVLjwICR2LrNmmZlvGCK4HhmeeUaGBNmgqH/1rmOQWXznc7u5warcKJlik6PZbACTTQE1i1IHuyWto5MwvamHYi2JEg6ry0uxbzCFqC/S8WV7sqdw87lIRivw4mSDQCmOpWImsdYL4ejtfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569800; c=relaxed/simple;
	bh=SRHQE8bCG1hZarDfuj2dLy5ZE4gG7sSEuLmBWXWIfB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRJ9fdR5fnHci1cTUWctSq0vOuZjUQCHTmCneE64uM62BFGG6+hDGInf3ORUtLmMcOSahcnW2bC7vOYa3vQBEeL0UPEFQ1vIW8LF7xLDvOElNLLOAivfmqjC2m04NU9/dcwK861zvdgn4qRbegPP6r57XZJMWTIwcFlRq3JmxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=Nm0AxSaQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WAYbjAfj; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Nm0AxSaQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAYbjAfj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 0CE781300124;
	Mon, 24 Aug 2026 07:09:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 24 Aug 2026 07:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569797; x=
	1787573397; bh=hIs4JGkCZbe1hIfuDPjKMzbKJ3jJLbxC1l4hzdrLCRw=; b=N
	m0AxSaQdVAR5t/IE9UNljz+/HDgO7A/txsHhD5N7WRrY8jEcG0JmEJr7eBMqRsuy
	FzVmoQNRMpu7yT3uRBo7oCviC47TlAM6+8mp820Z2oz+55KL4ISdsO348vtnJJ5b
	BcdRrT+iki8tq2nQviXa8tozFu1+IL3iL6lGmQCS3ZfRe1RSdc2lu1cHewzQf92F
	hnSprEw6E0gcobBhLEYlx2kaa8o8VC4rpDC69d2ftcPlDi91P1NkzbhiFwe8EEe/
	ZZ5V8DXShht8JWutmQoJw4c74h0Weeo0jIdDXw6esv4siV8XVDSdWJ2R8Du2EjW8
	viBHF7Io8zRGWnJZRF+eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569797; x=1787573397; bh=h
	Is4JGkCZbe1hIfuDPjKMzbKJ3jJLbxC1l4hzdrLCRw=; b=WAYbjAfjgdl0Bx3lr
	bssNeGTKRBLStJyuV3rd/mjxY8k9CMAuOqnaOdOQGJMzA/+EqiFqihw5IFYoo8yu
	FvCPf9+5C4UzgsexqwkNebjsm4ynq+hDx+azbktGS/92secoDJXL3iKqE8tPho4u
	jOyBsI18vJnXHLiLEctMDj+S63aRbazW3N96NWhxUk94fPizH0jatwFeHhUnNk1R
	bEjjrfB/rV/M9iYnv+1qOPSbRS0oH+hvS8FEip5dx4sYo0FKF5kv+SMQfvXeTZzc
	12PJVr9LNx+xBMl+aVaIaMUCofXAq03bSo0kHUr4o7Zu0SfEWPSg0+hn7WLRzbMK
	L5Dug==
X-ME-Sender: <xms:hSaMal9K4pqV1OEL8MnTCMKz-gawl2UUt-H-xoUAg16MaXXTCmxX9A>
    <xme:hSaMapmDoVOBUp2rHVDpQEyQzOmHh34xhc6XsXKypzRAEwLmfLrDOUtfppMRn1QUO
    UTL6PCH27SZZrMJVKHhvobvtSYUI_x1_Rvjn8DV_pFXrwOn_0lg-m2V>
X-ME-Received: <xmr:hSaMagWF5A25bDSx14mapbaiP8nxRv35Poob8fls_Mb8Y-tajPIZKCGYY3EPBivI4wjGw22xdw>
X-ME-Proxy-Cause: dmFkZTFZCbpsgW1YFD8tkPvHCNfxYRvTZ4blFH/NRV/HzygHIZO36nEMOhE1d730qpXJvh
    mj3vwdyckgY6cjcLbWoO+E+Y3xnZHjj3a4qFKPUp4C1ItOyypDc5v9ubc43QMrvknpo3YV
    t254bBqkhHFILTMaiaOskey67wujVC060Hg7shRsjYN75EBvtRkSi+gTwzTAT9QI5uwF5a
    jKY8X+yRsMvgEojvqKUbS+n33ebqC8Mk85kgoigVyIrVFWYfmyd/lA/A6ULdG/inFBXWp7
    ziuYhhyF6f7lNHjxbQ4kgWN86q7p7VmrRBdAb8OqXw1LSsz5kDP4W0+4ny2SVIkbn/odGN
    XXQIbzmB/vcLF1NlXS+kM2UIUaMF5Cqm9KOuiSdlbWEUDKfHso/+J57OohIKreHXTg+BxZ
    8sHl3bGdMIwg0h+ro1NqYo85skD7QF+zT83v+ttuT4mfno7zwuo11ScZcwElamMqO0DkvP
    ZJnyU0KxFbHDHolO7OapXFq4k7hhW5zLmCjVi4XuJrm01Yk0OozeY4Cub80lZWvK/TqKfp
    nwX6Imjv2xArvLbG8iXYCgqao5DyRYJv8ZLcODTGnfO2twC1vZl660wcbL+K5lvimqVx4m
    rKI5ZgSpyQrToA9yHwyrI7HgY1Ek24Zsd7jmGHx2TWYb7qx0g7e1dLaEp1wQ
X-ME-Proxy: <xmx:hSaMalrYGxiVPXgaIeiKh_NFsN3OpYFkVekfKYBI80w0RDNycBrraQ>
    <xmx:hSaManXPu_3UdDjB22Ht1edrpOiMsukVWMxSuQF-nUWRd7EyBmUFKQ>
    <xmx:hSaMatC4EM4Zmdq_kVXGpcW8NXVrh6dVYvozbjjkt9DILrrkf1fllA>
    <xmx:hSaMajVMOqGDyp2PbBD-mygbs-bUgbnTKjQDj1hic-QAXhdygxc8PQ>
    <xmx:hSaMav0t_dzFiV_Zy68weuYw4hnY_pisrcsygNF3wCM8zWcrorbdylNm>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:09:49 -0400 (EDT)
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
Subject: [PATCH v9 04/13] accel/rocket: factor the completion tail out of the IRQ handler
Date: Mon, 24 Aug 2026 23:08:53 +1200
Message-ID: <4ce8b384a2f0c2ba389e4ac070c1f91d9802fe8b.1787568944.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
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


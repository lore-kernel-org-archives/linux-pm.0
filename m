Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DAC3B4E9B;
	Mon, 31 Aug 2026 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149342; cv=none; b=GGrQxxDcr7SZ4d9KH/a7ygPogBW7tWcE9MX1/NQOWHAdD29IR3eHrTUoECwHG3h6nOqpiEzlOIqNkzZUPiP4Ww86upDMYWRmrWuXRMGKJpFI6hcnfFeWR6oAAEA04pms/hYEof9soBfJbAT8YBE4FsZb7H60JsMwHTpTb0R5L5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149342; c=relaxed/simple;
	bh=SRHQE8bCG1hZarDfuj2dLy5ZE4gG7sSEuLmBWXWIfB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WExKOtIFyEj3jB9+O0c1w3jEsDSq5RRxkmsNjnj/hekgIdDrVBSW2s1JHuCxn2MfwXZz+jzj/OueLbNofdiLTJJFxZ0bUqlqOM1FvPB0DgPxeWtbMd8i3z2u7EqtxPuzHNGHdOkXAy/Z4JSqbP3FVtzqtYpuZiwpPQbCc2DZcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=E8pZHUcV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhsAaFmL; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="E8pZHUcV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhsAaFmL"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 0257B1D000E2;
	Mon, 31 Aug 2026 00:08:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 31 Aug 2026 00:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788149337; x=
	1788235737; bh=hIs4JGkCZbe1hIfuDPjKMzbKJ3jJLbxC1l4hzdrLCRw=; b=E
	8pZHUcVLQvAb9Kgjubjwm/Ld0np+aGC3ErcEQxRDLT2HKAm/TmlMPKNMMv243BTi
	T420BLre0i6eyYxPz8ITnTw0c6LFHySmNGSbm80O74z2u9EmDo+jZ+67/v0g2BuJ
	5Udvwvmfz2R2bt4tVVyWJRAH0V/jEGDeMNbCnZSfc8udSRASie1xdMb35ytfx5uy
	ny2wfeHWXx/IcbMBWaj6dKPEMFWaHiC0WzzpVpy5jYjSucQ7pIa3mBUUg0ZFLuke
	Cz/eguGr9QV2qXFsCqt81R9ZZeWmq2gS2XYGcL6Ey6FXIQC8sigSMfIbhAzTHXAm
	6GDAD9pjGPXoRL3MEpmuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788149337; x=1788235737; bh=h
	Is4JGkCZbe1hIfuDPjKMzbKJ3jJLbxC1l4hzdrLCRw=; b=bhsAaFmL1Wp+dzjqo
	npS282jlOpW20qL+xudgXs2azhnv28dJy2jGLYESsJsrDMz7qzpZJQ4SKYVaZC3d
	eNvO2UwokvVpa7kE86QEwKsPZBgmSF58wORzF52mHbcu3sClIV9uHN/BIi1BDjPs
	7/v1MrikSnmsYJe7EXUsdEMAbBRYvNVM9Sh/b6V4D6YIBAP0WXlLAIPcFnby3gwq
	b9//L1M44JrYoTB2s/14yRNA6F8Iqf4AfX0GCfeMYrWgGwOY/MuYEcATI2bjdhvG
	r1ISJvQVKjwNnWiFnD0hSODOJxBTp86zIw7zDau5EKlO6SjynHicIeYN9tAMb8Yz
	hyuiQ==
X-ME-Sender: <xms:Wf6Uaq2gOgj7i7PL58hqcCOFDKMaM6Iq1PdPTCaQd8hxj62tYi8Y0Q>
    <xme:Wf6Uas9WsHNm5dvhOvcf_6jwJBj8R2hlZGYSwaX8OLSrc6JDw-wWIB3-Hy5JtgFnB
    6MXR33HGxkX-nYwmBcJ58nOX-HnJX8HUmKNW2nkpgM4XXxyZ5n52NEh>
X-ME-Received: <xmr:Wf6UagP3vo8NhjRBt_3ZdMwAk0oorpL8euwrXFixgSN5rIpl_JkQH5_X8RQWhjYaMbJBC4-wxg>
X-ME-Proxy-Cause: dmFkZTGgZgR+VcPfe+PhAzOLd0oIFeQYFsXhiZHiqFEfJLX+Zh5ZMdMCmp7DSb14qyqV39
    jp/P4WoX1+fWMg7xKNkg19erm52kJxQUcTYbC3fhf7J3kTCWp177f4eiTLGImcgm9FlW/K
    919HsGQiniAe1IB7e9jl0y2Y9dxEodpqsZNpi/Wh8/Y0aGqz1kZ0NysbtBSq+wCn4J8DOp
    NMVeqNR7AEscaSespCcNi1Tsf5l8QtvZS5D7uic9GEJ8sDuUqjUvTw65giXWj5Lizkd8mk
    k6Wvf2Wg5sOErrVa3i9eyoCaEv0ghglB6LbcQ07PYZ4WQgjzQYOd+k7ebFmJtNV5tyGOHS
    zTJJZx80ECWdSg9j5XiBIbNOlMZg9QwpKpxsCOFk32pvKKdsLoMSJOE7c9JVQsoUpu/28e
    +vrvdprSsbE13gthPaFucmO0+rmPbyv2EuyNyUqociW/jap1JKUinQXv4sUQFfauRTsFta
    Z0jJE1Cm0LNL+lkZ9HITGHm5YASNOz/PPzKcM7k0tbvwEXKBTFeNm691AuIafCTPm3X5Li
    hhXbTqG3k+gScBTPxD6CQyjbDCApuZdaAkj5Rso7Vx5lngWtTs8x2/aFfA9QdYra4lpEYw
    eyqr55AST8M8YddVoXATxMoHjCS8E0aIqzd2vf2y03UDMB/88rpGQ/gGUQOg
X-ME-Proxy: <xmx:Wf6UaoCVsP65DeZ-XJnUYQV3lwCgVtSvzk1YkxIQijBi65qCIuJNEw>
    <xmx:Wf6UaqN8CCDy1VcxRSv4Z_M9nVAsqZy1QE56ohewEYN01oWdE9qnAQ>
    <xmx:Wf6UambJtdaW3LaiEwD6m8tfI-uQ9KhbnQfjfFsdJAivqMQTdQYY_g>
    <xmx:Wf6UahMgsfoNV1WQEN6rPZNSLH30JqZ5JbEP1Leu62c8QfkShugZrQ>
    <xmx:Wf6Uahcj-crIppvml_D_YcnZb7zrnpT2X3sbUIFjjgWhVcjPuju4GtpN>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:08:50 -0400 (EDT)
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
Subject: [PATCH v10 04/13] accel/rocket: factor the completion tail out of the IRQ handler
Date: Mon, 31 Aug 2026 16:07:55 +1200
Message-ID: <20260831040804.24111-5-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
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


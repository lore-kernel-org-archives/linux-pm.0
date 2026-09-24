Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A5471CFE;
	Thu, 24 Sep 2026 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245350; cv=none; b=miBNyd5a/RfxurGhNWSbyyq2dXVn7MdTWgHuxJhODPrRxecAU29NN2m/HN0zK/mvdBK05EUEF7zP4381krG2uX1L+bLG7/T612nYGCf1AmLbK73JhyCil3FnycOR2lPrPDuXo6nRMdoaFIRRQp7yGos0+Uwbyx5gm5067JZGbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245350; c=relaxed/simple;
	bh=S7VJI8rNqqoTZtXfNnT82b4wv6KgWc73yuntbX1kjqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXJw7n94/KA2Io5pSUjg5BT0on5y+zLxke9WGhEReKEN/3Itmjgi1XaRGgR1GcQs7TIGZcWxCc9FO0SvJnpF7V9sfES+iHTw7Szyige+RgErK0NJMVglgAAgaNVLYX+VOH6j4x4lyPoWuW5kt5RSPYbSFboeBg3LQCt7NO6Ojhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=RIxqB2HR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SaZvD3D5; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="RIxqB2HR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SaZvD3D5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 43DF17A0050;
	Thu, 24 Sep 2026 06:22:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 06:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790245346; x=
	1790331746; bh=49B2LH0OEjwjigLeB2EyzGpXNjuF1qmoGFk9qR05DBA=; b=R
	IxqB2HR3GiVIENBla1T4u5F0EDFAI6jyjNVcDjhgCQ3KrlCbAZ3v/fUd+Od04P2U
	jeKXjLNiunNgFeZRhw7m6tXlYfWLpRpIxy/dE0+mZFWn5VeKTrr+JIumlMtOIa56
	lOEMxpcO5oaa8Vu2BDA8TzzNY27wmeSYYliJ06iyPtjlNF7Srkal1cwt61Du7pS+
	dvEZFEnFmbI9xCr44w4kCeJTzYf2j6UAA93vCiyDL/VOKQT+rhbIetK84zg4R7TG
	5CrleGKZuXdEvOYJ0EWIMFPRRLVzL9xsytuZiNB2xmL3UCZRpRRKCIhhXytjLNqb
	RWZrBTlJscOF4cp0Amw2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790245346; x=1790331746; bh=4
	9B2LH0OEjwjigLeB2EyzGpXNjuF1qmoGFk9qR05DBA=; b=SaZvD3D5h9s+YQ8m7
	cTVflLlo0Q8os5V5HAlPEWNyBKLZ0UIO2VhR24tiwxWPbg3u379fPvPxQ2XGFds+
	ryuS/sq92DcZA5f8bzqyl9q1dkmdLvhPCsQBt9DTirZKgLXCeuaALkCAE8uaXj27
	ir1L6A1homfvb8crgmCX3rMn+M4rQfIO+Tf59REqgsXtSpzmeqJaHkWe7r2Q1f1S
	vFORJBKEgqPVGnJKTExvioi+5oGy6Pg5a7G6sI09pNmIUQEa5IBUFqjPdB5BFf80
	ogC0VKIEWh9iikHZI4aBB1+rPJ02Wrj6vHoBPi5nmyHNO0JlzvK/sHCOYQv2KTtN
	1rL1A==
X-ME-Sender: <xms:4vm0at2fqAiEjF_voPWkxQqKHGMNrQ-5K4eD_Emgqg4aa027C0RDkQ>
    <xme:4vm0ak39_i9yBd5UuLGnRAY0WLeHeEqGqyRS_n6QykIUxSb4RlCTQ_Vr9d_1zodYK
    BYKWOYp7mc5YJyOvf6cDCKn7jg46B2_MVYTHCdIMG0ZLU0YCrbuFVE>
X-ME-Received: <xmr:4vm0ahtHFmT8H91ERJyV6DXBTnS4z8fx4ZtmsB_Xa5cgPO8wQWfUzHmYw25h_Xw0wvS9IOPjyw>
X-ME-Proxy-Cause: dmFkZTFPKKwhcsF2tVcf6J1tdoJzHIGivu3GiCcgJWp0Pt/Z9Gazphq9uGNO64qgWXMd+/
    r0Y/QC+GxAQC2Q0ieU8CUeap8kK2TKuEf79EXK3nmOyezz75bao1uY7ZOtIqBBuPshRXdM
    IOJk66Q73oMH4TFALUk5Kcv9/tV+8zmUjNu4znwNLW6QCtNjM5T8lbyMLgXah+SwAfjMDC
    rCr4sv174gNvDyZRPPY9GCenUHIgd5s2D05F8pDWC2YXojrrAeUc6Y5eDqXskNa/85NpzE
    OHpcem/V6xXRehfddSOwZh22araaf502XMhjJIeZwed46ATd8n5B6uoJ2HCgVahU0f6UNP
    1TkXNgqCi1AbBpPcJwLHekqpsHW/kLvonsHOYrxJM9r/Y5Ihp+Uwed6Cj5GKQlaNpiaNpG
    ezXitG6vTbIPVIEahEl2r7H837aVhl9/5FepLbRyUEaEPx7T4LCVHFrnkYJEaDr79b5DEb
    4R9+tNdQqZITD1qZMOH+zZQQiSyAew7HW2koDUhex5nTrk9ZbwJWdQ1ThUA3D5jzvkUOJv
    URIoCxLsig/RG1sqG792Lz3HjxyeBZCekuA59ezj7LpeVXVSvKg+owZ+33odVg4QLMiEJB
    2gJ5oMDatDmy1Fx6ww6+Tsx/RyJQITfV5/uimj2B9qAJsZ24B2/TkORKBvVQ
X-ME-Proxy: <xmx:4vm0asY2XPKFFZvngEEuYz3SJjZL-5QopCI8W0JqZyKk7qtZmqAqeA>
    <xmx:4vm0avIph-zRblkfHV7fYcONjF8i0bJAZKcYsq-HHejM2BEbt_A5vA>
    <xmx:4vm0alhuxo-tOyHMW66DZJJRnun-G7bdQkEjfl1xZ5LWrQ0-RIqapA>
    <xmx:4vm0ag8NU4HuFvjWcgKlQK09OaGNMumXEB55ITcbkQxrq_qCHOjkiw>
    <xmx:4vm0avW_f4-tmwVY6H5Aqypm7sKmvEIGzKnK3THAi9JevaCWgc9DwVTZ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:22:17 -0400 (EDT)
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
Subject: [PATCH v14 03/15] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Thu, 24 Sep 2026 22:21:23 +1200
Message-ID: <20260924102135.92217-4-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_stop() does not wait for a threaded handler that is already
running. Call synchronize_irq() after it, outside job_lock, which the
handler takes.

Before the sync, mask the block's interrupt and clear its raw status, so
that an active core cannot signal a completion after it. Do that under
job_lock, since rocket_job_hw_submit() arms the same mask under that lock,
and only when pm_runtime_get_if_active() returns a positive count: the
reset holds no runtime PM reference, and with the domain down a register
access takes an async SError.

Igor Paunovic's induced-reset runs on RK3588, including a two-task job that
puts hw_submit() on the IRQ thread, found no fault; as he put it, "this
does not show the race is closed".

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Link: https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com/
Link: https://lore.kernel.org/all/20260912113717.6819-1-royalnet026@gmail.com/
Link: https://lore.kernel.org/all/20260916132824.13527-1-royalnet026@gmail.com/
Link: https://lore.kernel.org/all/20260919103422.148834-1-royalnet026@gmail.com/
Suggested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 71 +++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 575945015..bcafa89ba 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -377,9 +377,74 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 	drm_sched_stop(&core->sched, bad);
 
 	/*
-	 * Remaining interrupts have been handled, but we might still have
-	 * stuck jobs. Let's make sure the PM counters stay balanced by
-	 * manually calling pm_runtime_put_noidle().
+	 * Mask the block before waiting. hw_submit() arms INTERRUPT_MASK on
+	 * every submit and only the hardirq clears it, so on an ordinary
+	 * timeout it is still live and a completion can arrive after the sync
+	 * returns. The next submit re-arms it, so nothing is lost here.
+	 *
+	 * Only when the device is already awake, though. This function holds no
+	 * runtime PM reference of its own: the only one in the window belongs to
+	 * in_flight_job, and the completion path may have put it and cleared the
+	 * pointer before the timeout worker got here. drm_sched_stop() above can
+	 * block for a long time, and it drops every pending job's credits, so
+	 * rocket_job_is_idle() is true and nothing keeps the core resumed. On
+	 * this hardware a register access with the domain down takes an async
+	 * SError, so a reset must not be the thing that causes one.
+	 *
+	 * Only a positive answer will do. pm_runtime_get_if_active() tests
+	 * power.disable_depth before power.runtime_status, so -EINVAL MASKS a
+	 * suspended device rather than excluding one: pm_runtime_force_suspend(),
+	 * which is this driver's own system suspend callback, disables runtime PM
+	 * first and turns the clocks off second, and rocket_core_fini() suspends
+	 * the core and disables before it cancels the timeout worker. Both leave
+	 * the domain down with -EINVAL on offer.
+	 *
+	 * The cost is the other half of that ambiguity. A core that is still up
+	 * with runtime PM disabled (pm_runtime_force_suspend() before its
+	 * callback has run, or CONFIG_PM=n under COMPILE_TEST) is left unmasked,
+	 * because writing to it would mean writing to the half that is down as
+	 * well.
+	 *
+	 * Clear the raw status along with the mask, the way the completion path
+	 * does. Masking alone leaves the DPU bit latched until
+	 * rocket_core_reset(), and the hardirq decides on raw status alone, so a
+	 * fault from the IOMMU that shares this line would wake the thread again
+	 * and what the comment below asserts would stop being true.
+	 *
+	 * UNDER job_lock, because rocket_job_hw_submit() arms this same
+	 * register and always runs under that lock. reset.pending is set here
+	 * without the lock and read there with it, so a submit that has already
+	 * passed its check can re-arm the mask after this clears it, and then
+	 * the synchronize_irq() below fences a handler that is no longer the
+	 * one that matters: the block is left running a task with its
+	 * interrupt live. rocket_job_handle_irq() avoids the same race on
+	 * OPERATION_ENABLE by making its completion writes under this lock.
+	 *
+	 * pm_runtime_get_if_active() does not invoke a callback -- it only
+	 * takes a reference on an already-active device -- and
+	 * pm_runtime_put_autosuspend() is asynchronous, so neither can re-enter
+	 * this driver's runtime PM callbacks while the lock is held.
+	 */
+	scoped_guard(mutex, &core->job_lock) {
+		if (pm_runtime_get_if_active(core->dev) > 0) {
+			rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
+			rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+			pm_runtime_put_autosuspend(core->dev);
+		}
+	}
+
+	/*
+	 * drm_sched_stop() returns without waiting for a threaded handler that
+	 * is already running, so wait for one here. This has to stay outside
+	 * job_lock: the handler takes that lock, so waiting for it while
+	 * holding it would deadlock instead of fencing anything.
+	 */
+	synchronize_irq(core->irq);
+
+	/*
+	 * No handler is running now, but we might still have stuck jobs. Let's
+	 * make sure the PM counters stay balanced by manually calling
+	 * pm_runtime_put_noidle().
 	 */
 	scoped_guard(mutex, &core->job_lock) {
 		if (core->in_flight_job)
-- 
2.43.0


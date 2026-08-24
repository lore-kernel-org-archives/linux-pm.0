Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F43EEAC4;
	Mon, 24 Aug 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569779; cv=none; b=KiIx80tDpid6/akd/1t/VVOTCnGZt/aK4Gyy266f4rO8F7PBh4JPIoZJVwddPYq26t3Ki9u1qss69CvV3KqjhCVRxJlXp0hJ7coWfaTwCHH/do3GbkEGIZYzoMMvlJ9znG7oWS71jvoMZQnaUUwhBwkz+h3bfkqvvIOH6lX7k40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569779; c=relaxed/simple;
	bh=I/chgQ78WSXqBGxB32+GzcocmUhkizzjLGgj1KKVc/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN5wycBnfDQAO9BFQetnmzqri+oUN29TGDrd8lLSOFbuBPq5uSRA6aPSmWHcwPMPSaYCVgYKaxMPN11K7YZQpwo6YSYaKr/JJJ9cgS35eRy07H4ByGpwRV84eQ+H2nLQ33cRUYSd/4A9yoJz1RrBUSY+CSRp7r7LpWndqVntCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=eZeitwYv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=en9tf1M3; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="eZeitwYv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="en9tf1M3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id BB1371300113;
	Mon, 24 Aug 2026 07:09:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 24 Aug 2026 07:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569775; x=
	1787573375; bh=V+XEVBgCvZMzkvcS8JqtCrOs86+ciHD+ApINKtqS/tU=; b=e
	ZeitwYvELpJMLXxaPB3Nmzrr4jP+W6WPOaZfhNZV7hprY0IFmolMahkS/CmBmLdX
	nM972seu/+KgPBgwC8gBgq5vUcD5QYmNypMEVBLSK7D5XvgQl/7aDUKBBLWRR+TN
	NaDLe+uQKhcVVZ5XcJYQ7tWgNNmkpSnp0G0YTCLLVWlrtT4O6Kc3ymqgzlz2ToGL
	VNz0fsiNnxtNVI8NZAAvr9QquogHBZyLWXF8d6pyirxQiHqRdaQpH6u0Xrdo9+He
	3YGjrFs7/hpn/Bqs1NaAGQ0rE4SHb2cD40BibmhSyv/tRpcv1W8q57K1o1ik7KmH
	PnFScJblJr0kzXa6UbpVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569775; x=1787573375; bh=V
	+XEVBgCvZMzkvcS8JqtCrOs86+ciHD+ApINKtqS/tU=; b=en9tf1M3YLGgvAloU
	k0b5fVDrWsIlF6HuOTfGVwz51kW5RyAK1CyLPtrcIYcnq0YSHgyBctp9NppRl+9n
	ypUA7iEtIOL6k2o9dv60c1Lyp3kgHU+lfDPqlDZk5GRVRONiELJsFF+FWGDnTUVf
	v+iY6KXwjkG8Cd7xkFJYkwWO1McFIWdTOCDoiHwJBRU5GAo/362L6gSjo9KpVY7S
	0ki4Giy0+QFWNJEResL9mo0t7dqcnKoj/UID5SYiFg4/r4qyziXWvnhlFQk2qW3l
	Dg4WOWdUoSZcC+uriqhJanZeBrKTjGRNN9sAZKneyDWdDLCBi+Of0LvucSbRSbCb
	8ItMA==
X-ME-Sender: <xms:biaManiPCGU4hPczD490OSTztT7TX5FiJ-NDBTNUNpab0g6QDYhfuA>
    <xme:biaMaj5lDSlGwdsTIoe2qqsx064qGIKCWXRMKcks8KLBe3LCKL4aXdhJXRd6Yn9jC
    nW2E3Rg5Ng98wQ7KUdjt7T0HGc-Ru3YL-58kSApbZM3nFwGVPa6ZV9X>
X-ME-Received: <xmr:biaMakbWqfMU_fxR_C9v-eOMucnhpAHUdGNbr9nBvrsPKRPoT0av9d_AWTCAQyWxniNr3D2zyQ>
X-ME-Proxy-Cause: dmFkZTFZCbpsgW1YFD8tkPvHCNfxYRvTZ4blFH/NRV/HzygHIZO36nEMOhE1d730qpXJvh
    mj3vwdyckgY6cjcLbWoO+E+Y3xnZHjj3a4qFKPUp4C1ItOyypDc5v9ubc43QMrvknpo3YV
    t254bBqkhHFILTMaiaOskey67wujVC060Hg7shRsjYN75EBvtRkSi+gTwzTAT9QI5uwF5a
    jKY8X+yRsMvgEojvqKUbS+n33ebqC8Mk85kgoigVyIrVFWYfmyd/lA/A6ULdG/inFBXWp7
    ziuYhhyF6f7lNHjxbQ4kgWN86q7p7VmrRBdAb8OqXw1LSsz5kDP4W0+4ny2SVIkbn/odsx
    vrKBOQ6BYummaCU2PerSeK2g66yMf+oRL/ot5eifh82dWleVKjzIw2AiCPHDtotakglBL9
    cHHV0LMbOHJD5UwBsvkPEPlK6CnzMj9KTbDi8K/5zTe8uL58j11nmszhLskXBer1sR1Fba
    veBoxR9IBEv6Me3yYYVWoTyU5ax4mGu8Ll6mVbrM3QsNpMRpZRJaLXpNGtV1TXDU6n4CEj
    4brkOiH2nddvwb1X3YjHOwfaMOfmhgqXj7UUHqu0wXBiAa8QoLsHNslwKuqJBZMN1oJVHt
    6UNorgxzUhqi8HRkMFk1+1ox+MyLDk15vax+u23LV5LaXL049HnpsusjOEPA
X-ME-Proxy: <xmx:biaMagfXC3rHgp8sdZcmihkmjOhcgW9-h6-ZmhTCgToLIoGkhv2rEQ>
    <xmx:biaMah6tNh2WT4YqY-69_dws-fYryIYLA8SjGo2KrXfQk2QZADu9HA>
    <xmx:biaMasXvUn4HHeY9Ft95iqPBKPwYtyd2BKO4PBbByyJPCzg_QMk6tQ>
    <xmx:biaMaobQp0qvohddh2O1E60JD2MOrISF1ljxoLXk-WsueJfDoW7xPQ>
    <xmx:byaMauYLjwU-Dku1NTmoXg4l_xRdoNo9zyS2CQ0Qpukpp-AzaY997Wzl>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:09:27 -0400 (EDT)
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
Subject: [PATCH v9 02/13] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Mon, 24 Aug 2026 23:08:51 +1200
Message-ID: <7d47bbef8b629eb287fdfa3e8d6c62b95de6b61d.1787568944.git.gahing@gahingwoo.com>
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

rocket_reset() calls drm_sched_stop(), which stops the scheduler and
returns. It does not wait for a threaded handler that is already
running, so the comment that follows, "Remaining interrupts have been
handled", states an assumption rather than something the code arranges.

Call synchronize_irq(core->irq) after drm_sched_stop() and reword the
comment to say what holds afterwards.

It has to go before the scoped_guard(mutex, &core->job_lock) rather than
inside it. rocket_job_handle_irq() takes job_lock, so waiting for the
handler while holding that lock would be waiting for a handler that is
waiting for us. Nothing is held at that point, and both callers,
rocket_job_timedout() and rocket_reset_work(), run in process context,
so sleeping there is allowed.

This does not stop a handler that has already read in_flight_job from
finishing its work on the job the reset is about to drop. That window
needs the check and the register writes to be one step under the lock,
which is what the previous patch does; the two are complementary.

Mask the block before the sync as well. INTERRUPT_MASK is armed by
hw_submit() on every submit and cleared only by the hardirq, so on an
ordinary timeout it is still live and a completion can arrive after
synchronize_irq() returns. Nothing is lost by clearing it, since the next
submit arms it again.

That write is the first register access this function has ever made, and
it is guarded, because the function holds no runtime PM reference of its
own. The only reference in the window belongs to in_flight_job, and the
completion path can have put it and cleared the pointer before the
timeout worker arrives: drm_sched_stop() sits in between and can block on
cancel_work_sync() and on a dma_fence_wait(), and it subtracts every
pending job's credits, so rocket_job_is_idle() is true and
rocket_device_runtime_suspend() will not refuse. With the autosuspend
delay elapsed the clocks are off and both NPU domains are down. A
register access in that state takes an async SError on this hardware,
which is the failure two later patches in this series describe from the
power-on side.

pm_runtime_get_if_active() resumes nothing and allocates nothing; if the
core is already down there is no live interrupt to mask and the following
synchronize_irq() is all that is needed. Igor Paunovic asked the general
form of this on v8 -- whether rocket_reset() should hold a reference --
and it was deferred then because nothing in the path touched a register.
This patch is what makes it matter.

The deadlock this placement avoids would not have been reported. The wait
is on desc->wait_for_threads rather than on a lock, so lockdep does not
model it and it would have hung silently.

Suggested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_job.c | 34 ++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 5f0f9682e..3c0ed4605 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -377,9 +377,37 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
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
+	 */
+	if (pm_runtime_get_if_active(core->dev) > 0) {
+		rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
+		pm_runtime_put_autosuspend(core->dev);
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


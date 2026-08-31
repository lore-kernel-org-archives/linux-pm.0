Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB513AFCF2;
	Mon, 31 Aug 2026 04:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149321; cv=none; b=nuWgylbd9eCjDT2y+Tjb1ON4YoTtXuOx7IfeXXh1pXvuvgMFk08DQIuyylGomU65UbtM7DHk53jqy7q+dW1282OIFLP4vshWy31/FLNcZKJni10kfq1pFXpbRXGXBXG7LRmYeARIWlrjjeIZwH26I+q5TXaTKHvcdtkLtVcnfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149321; c=relaxed/simple;
	bh=mLKiP59LoXJVXWQoRWVwvz6rmlSIz6KcbchWojiNylA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM9Cm2RjSd4LZH6j6dxMvvjPeDwrnSOPeO2EAawCEoQoeSGhleGZejzf3KDwXQifvvC3gtUYHENGT3et4TWZZpWv9NHbIEWRFhGtVFozNZdHDcC83aMR40o09/4guH+euMeJiL7/aI7sqamHrSgkpK6OnK4zV3ih9eNk/2dSOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=pDvzYU+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PpEZBxfT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="pDvzYU+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PpEZBxfT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1512D1D000E2;
	Mon, 31 Aug 2026 00:08:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 31 Aug 2026 00:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788149317; x=
	1788235717; bh=AsPhvud3azvo0r2BrkdCIsXDLM/tUzAdsviQlX0O/e8=; b=p
	DvzYU+8vFmOgwXnSsxeBYWcEvTXEjYziLRmq5PyYxkh8O9ob4o0iQXY+BfpnTJDc
	3PP7BCj1462PF5cMc9ZkBUFlTy6lEv/0M1q2mIEBjPpXsnoVa8f6g+rNisWGEimj
	MRZlH97RlH79R9f9ktTxSqNiBepzv6kxwKtf3qUgk+2MSBoir6bzilqycED3g65n
	i6WbrhtKOwh2QWg6waQvGPkzB3zxorO3dIQaUpE4KgGoOPECWPKG2TSS5HhVxEK+
	uoUqMJjY+HNknLwIzlFaSG96ixC+L0MI3qlVx1NSrkYslati2E6zsvuP8y+1pALo
	fozdl0AIMRnCVOBj8Alpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788149317; x=1788235717; bh=A
	sPhvud3azvo0r2BrkdCIsXDLM/tUzAdsviQlX0O/e8=; b=PpEZBxfTlqaBWh0q5
	ymSiuiT/GoELu69YPhtk6ff7e/NfmjZkzczBBfffzpIXaETSjG8WOcphOEAx8qpH
	Rt2Vorp5aW9gggb+7Y1C4/MKmX25sBybnTpyGLKML4v2i6BanKY6poPf+lNxuTt1
	S8sVgT1qJcbmBevd1xQVQINFfJ0wQSW7cOpB0RdgkTCUMUVw9kR408cW/nRRWFmo
	84SzW/maMxsw54Lb+o1UhGwSpmm4D3d0q5ObIFB0jEzGlmxQyLAiPnFaktuo57sH
	EbX4Tahl7/nunHlJ7bkX5WPuCH4YLP6lrT7QQXOpK3FFmDBBYCrj5HDBsa0mMw1q
	E0cPg==
X-ME-Sender: <xms:Rf6UasHb30aIEJfiXNJpyB06vE5wnsUHCVnSIrsqQssetbMFNDWvRw>
    <xme:Rf6UalN2jmH9NYYWqNJh4RhkH3dEfyHdwysscnqp2f2WXXVAwFckiDCr1rw-iUVSS
    f9hxI5blNLawWnD6oQDaXWy3HlLAyn9_O9kWJlxaX6hoVlUjoT5sCky>
X-ME-Received: <xmr:Rf6Uajf6Uu1zrTVH6mmTsZVh0e2cXftXqKNh8TLeZ5OhWzxPQ87EPvoh6vbGmJnrfvqbcsyZAw>
X-ME-Proxy-Cause: dmFkZTGgZgR+VcPfe+PhAzOLd0oIFeQYFsXhiZHiqFEfJLX+Zh5ZMdMCmp7DSb14qyqV39
    jp/P4WoX1+fWMg7xKNkg19erm52kJxQUcTYbC3fhf7J3kTCWp177f4eiTLGImcgm9FlW/K
    919HsGQiniAe1IB7e9jl0y2Y9dxEodpqsZNpi/Wh8/Y0aGqz1kZ0NysbtBSq+wCn4J8DOp
    NMVeqNR7AEscaSespCcNi1Tsf5l8QtvZS5D7uic9GEJ8sDuUqjUvTw65giXWj5Lizkd8mk
    k6Wvf2Wg5sOErrVa3i9eyoCaEv0ghglB6LbcQ07PYZ4WQgjzQYOd+k7ebFmJtNV5tyGOnJ
    DKEccPdDjj87nuGb509043j9Ys3EJiUNJ62UAn6owyBBBtbnpZrPEgt3sk8NHpwM0w9JuS
    GNx728Smhf6o27kmbq7HcSP7LxpN23sJehOkZy2SaguJ/c6iemlLCIfukB+3jLjrJE2+TH
    PpyCC3gOmdndigvRJ6mHEkX394xOMoXHvW+/KvyjrheMZ3bt8dYsTFGaSxbMvBVeBdiL/c
    Z3o23yOXMJs/kERa7x3H+HbrOyIDFtzWqzmUtUEWVmn76ILrIgpqJUEluJSmaN4klYO1uH
    4By6ln9y/UP2FMSoaBN3eq45x8pZ5S6quVamQcagIQW28lFvo3CNeTq2/1Tg
X-ME-Proxy: <xmx:Rf6UaqSqht1bC6SDGJlYhjl3JCYxMw9nhHxZM0csV5ovD4XyQ2-CQA>
    <xmx:Rf6UavfUXQ1L6bBSyRg179t79u4vtTWkU7gHvlklRMJMXragCqVZfw>
    <xmx:Rf6Uaird19bE42qg6_UeymDJ1Qb4bT4nIPVlgCoXbONxNpDLl4FMHw>
    <xmx:Rf6UaoeipdcSQYOzwAMPgg9Km2vGSq-EJmRWKGqMItlNN0CvZru7Lw>
    <xmx:Rf6Ual1Jf57HI7lXOCHxMUGt1IbJNPzupTP8bTO8bA8h-Dq5R3XX76JJ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:08:30 -0400 (EDT)
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
Subject: [PATCH v10 02/13] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Mon, 31 Aug 2026 16:07:53 +1200
Message-ID: <20260831040804.24111-3-gahing@gahingwoo.com>
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
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, differential base, JOB_TIMEOUT_MS=2
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


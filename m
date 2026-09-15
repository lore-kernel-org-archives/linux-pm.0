Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668EC48CD60;
	Tue, 15 Sep 2026 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469061; cv=none; b=eHRwyFPMQLhtcZdFUh4UeMcEnkQZLmNrlCwwZgiI2hxoWR/7smV+BQeNdFK0IQaNumvgyvUvCGags2qtW8Mxgl/clehayyLiaTq7dWHHXbiYlzn9Hfu5WQYCtNbOq7gYzuSCXDTBUTgmrUGeqM+weMhUtuneOSN9a8+u2VPq7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469061; c=relaxed/simple;
	bh=oxhxGUx2HMNqsz0n/0zSX+4g/cPJMS8th5puphONEyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c16TxrtKgD15Z8C+DtHeHIyr4L+RD4kPJe1UIQ0Vl9Km8JAF9YjSyGs3TPJ5ksLI4AgnB+6kAN899LzNQ+v42x2WTKxPuH7ha9LOj64iAq0XSJh/SiMb9twkkwRxY/N0yreuqwB0TsSAyz5CpTZ2oQ36pCDfyJIroaZuAro/9Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=reF3IplS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VuQio1mk; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="reF3IplS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VuQio1mk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 11558130050A;
	Tue, 15 Sep 2026 06:44:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 15 Sep 2026 06:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469057; x=
	1789476257; bh=I6ioBW7ScYUdG/oTToYCNPrLN7Q7315lvgvDhvoEbok=; b=r
	eF3IplSZl/1fOwjtHMfcDCZFXsMAAmY328L9vvhLZjQktqT3A+pmPl6AW7GSCEdh
	Jup0Nm7mI5YSbwwBhAdxXn+5HfQqkl047nX6bHvwOp69IOCP5em8k9SO3d3t8sAB
	ThQzQjb0sMybLTpiH8esM8UzLnj5XGW9fpphVJJv1vEfRNJaKTYe6Tzp+hDfo1wD
	mhfu/FoKMJp3EfvMigkI/bno5T/Xx3LfuDile4/0+67t9nAQWxIHYl8QVeexcBRt
	+L0f1NW2eGZp5UZuggcg0bKFAoRu+ufkldQnpZ/ScpUA2TBmZQ+zSh5WE5ZhvL1X
	umy15VeNIQ+Run/Wt+EVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469057; x=1789476257; bh=I
	6ioBW7ScYUdG/oTToYCNPrLN7Q7315lvgvDhvoEbok=; b=VuQio1mkFpj6GJwvF
	AQZb96Jc733eoM3pOP1rFTkc+iEYVmR0QvQ76GiWSwANnbvwY1FNFtDdGBrxEMVF
	oygKw9Emoo2EGbTepEMIn95grJoY39DK4t1GkdX49aUVsSIak2lXjDxNTpBv8ggH
	dRVBeMMQoO5GqR53uunIa1A3xwnQFEhPb/A2UaoZOHUpSWdlIPSIOnN0jWuqqOQe
	KDuyKJlTzDGcSwqlCj+rlAm5mFUK3CFEZkzumz42bKHNKx/O9wMLaRIhDPWJMxuT
	gjIGd6noT7LQre7xzhe+pjKXhWliING5h3aNgeQHuCdMDs4ZtNIqxLwcS4JjAIyt
	2qzNg==
X-ME-Sender: <xms:gSGpat5go6NmcVXIKYvp1jo6E1G_4RdvcsNmnBSWWa7Cili5G57X-A>
    <xme:gSGparoQFkGAoLJ04EW_uXBe0DaFLqNOb-l2O8tF2fMNzCPB7F4RylViT1GPQ6C02
    Hwo0-wgfGRz_F3oipX_8eoCGr0dcEET6XKOhi1q_8fU8bQY1msJ6a5b>
X-ME-Received: <xmr:gSGpaoR62dTCI5jibtGcCFGtop1htP_jiwmxECbEZyGGEKtFOpPVz5tF65p-d8RT9Ilm--yVdA>
X-ME-Proxy-Cause: dmFkZTE+OOtKqCgoTSrVlWQquKDyDOihaRAkbxrETzU46WPYI4xRZhEiyJhifUIK7wOXWw
    wVB9SQ/RAi7MrJDFDtBnx7Pb+n0YwQkRdmArbygP/oxZoxHW8LIKLQIL2L7jzJ+dDFOc0i
    zgJzZNFATjdf2+j0asWJSTUnqqtG7PFp8Vs3eFHmviT3HEJrjWQLemcS9TcZGgU54P+FV5
    4Pm9j2o7pLtOaGphBt5Uxmdvehz8zGy65174LdzdOvWQ05shZHdK5O0prBfSV/v5pCB4Ev
    utsMlLRk0S0Gt2QFQEaEqPdSBGLc8kXC99b8ea4ToJp+YO5u/c8PUKkTZ3pOeCnaAxuGfw
    HX+v75BTfd2sEB2EeANuHPDGM9vTWcdK4k/4guAv2h1+Sb8iwf86wlb7GGDMvZonjflT/6
    QScWCcnQqRWBApSuoYoKU4tojI75MAb8Hcwevrh+u+i+fUJxRGW4+rTAaSQqVOtkVUfVu6
    ju6c9PmbLB5pCYUzbWRTqHz4Tll/QWYUDqEIvk3yep9rYumZ0MUi9CoztUZoRhtpQE2jjp
    J12frvnHksQ1TRyyxB/jf5e5KWaTQLwEbaLGjj4eFnRycXK7vvVpg5Dx+gsHJQVurR4szb
    bF3lnsV6ZjfjnaqSRR6Ikwjddz9sDZKnH5RgOdufgDEdiXaWfKPCp4/AQdAA
X-ME-Proxy: <xmx:gSGpantwdchz0zWfy41AeZd6eBcikaYcaJ16_m1D92gnUEUu8sEESw>
    <xmx:gSGpagNa-efwWscT-oV2BDpGDDZswW6YsVMhmKDu4F8u5a6oJF9ttQ>
    <xmx:gSGpapUrQES6x9ZtSSYmIHg5aoUD-6Mk36jpiNqMewDGW5ucJA5R6g>
    <xmx:gSGpaghuaRP1RJgf9GAeYMXU0rJaNHRSgUacyog10AoMJO7G6NAYKg>
    <xmx:gSGpamNzQTwNxsaEgjrSIpZOqAUnUZ-x6tscfuilNiONbcHQ9NcawuwI>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:44:09 -0400 (EDT)
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
Subject: [PATCH v13 03/14] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Tue, 15 Sep 2026 22:43:17 +1200
Message-ID: <20260915104328.45901-4-gahing@gahingwoo.com>
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

rocket_reset() calls drm_sched_stop(), which stops the scheduler and
returns. It does not wait for a threaded handler that is already running,
so the comment that follows, "Remaining interrupts have been handled",
states an assumption rather than something the code arranges.

Call synchronize_irq(core->irq) after drm_sched_stop() and reword the
comment to say what holds afterwards.

It has to go before the scoped_guard(mutex, &core->job_lock) rather than
inside it. rocket_job_handle_irq() takes job_lock, so waiting for the
handler while holding that lock would be waiting for a handler that is
waiting for us. Nothing is held at that point: drm_sched_job_timedout()
drops job_list_lock before calling ->timedout_job(), and the only live
caller, rocket_job_timedout(), runs in process context, so sleeping there
is allowed.

This does not stop a handler that has already read in_flight_job from
finishing its work on the job the reset is about to drop. That window needs
the check and the register writes to be one step under the lock, which is
what the previous patch does; the two are complementary.

Mask the block before the sync as well. INTERRUPT_MASK is armed by
hw_submit() on every submit and cleared only by the hardirq, so on an
ordinary timeout it is still live and a completion can arrive after
synchronize_irq() returns. Nothing is lost by clearing it, since the next
submit arms it again.

That mask write goes UNDER job_lock, though the sync does not.
rocket_job_hw_submit() arms the same register and always runs under that
lock, while reset.pending is set here without it and read there with it, so
a submit that has already passed its check can re-arm the mask after this
clears it. The block is then left running a task with its interrupt live
while synchronize_irq() fences a handler that has already finished, which
is the same shape of race the previous patch closes for OPERATION_ENABLE.
pm_runtime_get_if_active() takes a reference on an already-active device
without invoking a callback, and pm_runtime_put_autosuspend() is
asynchronous, so holding job_lock across them cannot re-enter this driver's
runtime PM callbacks.

That write is the first register access this function has ever made, and it
is guarded, because the function holds no runtime PM reference of its own.
The only reference in the window belongs to in_flight_job, and the
completion path can have put it and cleared the pointer before the timeout
worker arrives: drm_sched_stop() sits in between and can block on
cancel_work_sync() and on a dma_fence_wait(), and it subtracts every
pending job's credits, so rocket_job_is_idle() is true and
rocket_device_runtime_suspend() will not refuse. With the autosuspend delay
elapsed the clocks are off and both NPU domains are down. A register access
in that state takes an async SError on this hardware, which is the failure
two later patches in this series describe from the power-on side.

pm_runtime_get_if_active() resumes nothing and allocates nothing; if the
core is already down there is no live interrupt to mask and the following
synchronize_irq() is all that is needed. Only a POSITIVE answer says the
device is active, and that distinction is not cosmetic: the helper tests
power.disable_depth before power.runtime_status, so -EINVAL masks a
suspended device rather than excluding one. pm_runtime_force_suspend(),
which is this driver's own system sleep callback, disables runtime PM first
and turns the clocks off second; rocket_core_fini() suspends the core and
disables before cancelling the timeout worker. Both offer -EINVAL with the
domain down, which is the SError this patch exists to avoid causing.

The mask is written with a clear of the raw status, paired the way the
completion path writes them. Masking alone leaves the DPU bit latched until
rocket_core_reset(), and the hardirq decides on raw status alone, so a
fault from the IOMMU sharing this core's line would wake the thread again
and the guarantee this patch is about would stop holding partway through
the function. Igor Paunovic asked the general form of this on v8 -- whether
rocket_reset() should hold a reference -- and it was deferred then because
nothing in the path touched a register. This patch is what makes it matter.

The deadlock this placement avoids would not have been reported. The wait
is on desc->wait_for_threads rather than on a lock, so lockdep does not
model it and it would have hung silently.

Igor Paunovic ran an induced-reset protocol on RK3588. On 19 and 25 August he
ran it with this patch and the previous one removed as well as applied, so what
those sessions show bounds the pair rather than either one of them; the
12 September session ran two patched arms and no unpatched one, so it re-tests
nothing differential. His own summary, which aggregates all three after he
re-ran the protocol on v12 as posted and corrected his earlier reports:

  45 induced resets on 19 August, 102 on 25 August and 74 on 12 September,
  every reset recovered, no MMU faults, no lockdep report from rocket or the
  scheduler in the runs where lockdep was still armed, and of the 420
  inferences scored, 384 matched the CPU reference within 1 on all 48 output
  channels while 36 returned the all-0x80 buffer of a job the reset had
  cancelled. The protocol bounds; it does not prove.

The all-0x80 buffer is not a differential signal. rocket_reset() calls
drm_sched_stop(), drm_sched_start() then completes the detached jobs with
-ECANCELED, and PREP_BO drops the fence error, so that buffer is what a
cancelled job looks like from userspace whatever made it miss its deadline.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Link: https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com/
Link: https://lore.kernel.org/all/20260912113717.6819-1-royalnet026@gmail.com/

Suggested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 65 +++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 575945015..dfe9135d8 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -377,9 +377,68 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
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
+	 * interrupt live. That is the same race the previous patch took the
+	 * completion writes under this lock to close, on the other register.
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


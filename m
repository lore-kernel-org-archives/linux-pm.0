Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123137417B;
	Sat, 12 Sep 2026 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195904; cv=none; b=ZaZAwQui12Uxyb71NtJMZWUFEzyfc5DygyTJNrPDWbXNZzBVmHQbrMRbw/2dKX6EDXzaqs5w0YsVQjgaG1HC16/mvNeoHlHsIqYmkc28oOo2syk9LjuGR2RS2KuYtnqiutjDSMHF6svM3E2g0JOOdoPmXVpvfh5thwJ9rtaXYOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195904; c=relaxed/simple;
	bh=i5DiVlINgwnNhtS3vi9Pt2BdawjxGHAj3w84ic0jIXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bi39I6+AjZPZomQAYQymdXt40hUr0M24c3Z1gxSkqhJVLY35YhSCmnpIXJrhuwQAJ08q151BSvDtkBBa4Gy/4WyeUbFwV2BPu9RTnjCDXKG//jZteucUPXzRuIPgW9Wh5RgeAPahsKKW8wbRJQXToqyXA+6ajV+saxsbHvKtXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=Yndc+8yt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v0/m8Ix9; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Yndc+8yt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v0/m8Ix9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06CED7A009B;
	Sat, 12 Sep 2026 02:51:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 12 Sep 2026 02:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789195900; x=
	1789282300; bh=dy/rZbJ8lujt892CZ6J3W3qCbtMy0BQKpDj3DzkhqMM=; b=Y
	ndc+8ytc9phVCsDpEJ5d1VIL8FnnEKgeFb0OifEaYmXrE+XpzOuvI0qogp3vXL3X
	w13tCTLBUN8+JHujZpmvwveKg8l4H1BDvPaQwjNXsVsx2WB1AMA330pd/HmYi5Dg
	nHGOTyIeHWwr7hb01iUXjzOlM1svQ9UUMB4dJXvT2XX9xuBgZaVRlj/dICANZbwp
	DD6t0FVJNLu6CowuIkIrWOxm9xU0BcKfqonVbqBdJKTaC7sU2jJIpcMeKc8QccGm
	HDNlzYXlNjxIaYyxoR4e7ipu6EH87bTA6n65iY+LbD695R6Z/PkH33ew06+AYK+T
	Tw2onIOOLy46HG+Pgn2Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789195900; x=1789282300; bh=d
	y/rZbJ8lujt892CZ6J3W3qCbtMy0BQKpDj3DzkhqMM=; b=v0/m8Ix9gyOqyS9Fl
	YBUfUL77Gd+87V/1v6dNXl7Qkr4/wKJSH8CPAhECqhNKyVNIjDnwblJ1FPGSYrtX
	eiIdZy6+aWD14iy+r2ONoaDM7D029QKsBVCy0gJitiXtBYsfokQt2ClHVYQ8SuqO
	/pbSNZgzyI7JaMHJzRGcwijKstIbI5sGwfwKu9tVtqb0gIXW5pFZiVe7N034ObIc
	F9ODJ2JHc20f1DvPirN/tLlW8ST6JTph7NTsJQPq2kX5YO6RY1IeC4FCZMh5GcnT
	7sP4TUrSMAdfqX/QNJMHZJTtJlhR3gj7BGqD9cyNrq0GWuVviMXaJO6TBcVdigMC
	cu5bw==
X-ME-Sender: <xms:fPakav646I7TbLFNzO7S4dI5zlJ7oGLR-Bf42Nc9mGz8jmYzI2vpdA>
    <xme:fPakalDYeivmhYrxgllTE71x7g0mmcQgUiyH2-75ggsNWvdlv9YdXvCUF9SiI7gTE
    If7YLdTAMmcNCzoRMo2ICLIgKc3dIeVVGpkG1fcbFIYr2Verek5mUg>
X-ME-Received: <xmr:fPakakRYPKaCeGHqXwNuLpN96i3pyhKWN8D5XDdruTa1oVcbAjQ__Va7vDIqzXyljZS21Yd52g>
X-ME-Proxy-Cause: dmFkZTE+xqYf+UNK3n3/SIVs5BMAkLL9SxSoeEa4aB1fL6sr5qoef0WXj/1D7lk0loNQgA
    4wrb8ygN/2xkG75l4y4Fs8h3bchGJPI+qo1AnRPcGZkXLwTgZeTSmelpSlfpC1UBJUBigI
    1uFUwuHYg71uhjWBx+7gOB0wn6akkmIMJLFlo26eFvuPPeo/6Kal04PCqlAm2Qq1tO2Cfv
    o3w83T+/2Kx2uyay0A4QdFPpF8s9PMsVXY0xB+GdGF9iMqqNE7jnJG1ikE4FT0u5FbUTpq
    2eYTgupwj7OYcoX2KuqqrFT2VA0jtIcYybDBTRddmCPQ7BA12Wvv4mvQuWCvRqXsZSSFTA
    CJonMka8MMkBSjNQSjLHwBZeQ1p+OUy6IaRFfV23oAjaU2/SOWWLib+hJI2hn6vfeyG+LM
    Nt2RyX6L7vfu+pyDUASDDnfn/DUzUlroYPKJtlgqfXSkTQ7mO8NOPJCkyK18EJLXkMWKzp
    l0gMxDlR5lbQUEq4SBJTTpCecJHPO5CdKVez3Hgs2YYyEMVq9qectO2kJzaJKa0T8zDw3F
    T5hxc9NpyBQf8H1DyFF5zB7kG+RmNomJAkg8AtVD4/YsLUgAV+YEmhRoNNohbf8mo13fgm
    f1yCBXJ6aYqfXkimGFGvgFh/MHrEZxue9ARckpm4DNOcDAguzsbpurteQG3A
X-ME-Proxy: <xmx:fPakakbso-mNQvbc12JRgKGGFiPVi1VN1BgB0b6ggY4WQxItl9Yltg>
    <xmx:fPakahUstJ9N4FZ4IX-bHu2jPq7NWQ-uhwRwKv-lIRAmetz42R-39w>
    <xmx:fPakapWWM2hMMlnlJ98ZPqckysA1eF6sFQHYk6k2nCoLsn2oQk6CSQ>
    <xmx:fPakar8hD6KzHJHzSiijgO-xuR0nXn8JVGIsg1QBfw_maKZa-bKpqg>
    <xmx:fPakasDFdROhMKWiurrRLCOGJgd8XAhIPgiaitMtQkj4-QW9wxzScJmh>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:51:31 -0400 (EDT)
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
Subject: [PATCH v12 03/14] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Sat, 12 Sep 2026 18:50:42 +1200
Message-ID: <20260912065053.1519165-4-gahing@gahingwoo.com>
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

Igor also ran a differential on RK3588 with this patch and the previous one
removed together, so what it shows bounds the pair rather than either one
of them. On 19 August, 45 induced resets across both arms: no
manifestation, oracle 48/48 throughout. On 25 August, the same protocol on
v9 as posted, one of five runs on the arm without the two patches returned
all 48 output channels at 0x80 from an inference that reported success,
with nothing in dmesg, in lockdep or on the serial console, out of 102
resets across nine runs.

His own bound on it is the right one: one event in 53 differential resets
against zero in 49 with the patches, timing-dependent, and his protocol
cannot tell a genuinely hung block from a lost completion. It bounds; it
does not prove.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Link: https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com/

Suggested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, differential base, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 49 +++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 575945015..0be8db391 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -377,9 +377,52 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
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
+	 */
+	if (pm_runtime_get_if_active(core->dev) > 0) {
+		rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
+		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
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


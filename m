Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1A3D412B;
	Mon, 31 Aug 2026 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164440; cv=none; b=hAXAn/NWzgAMznwH8izlso9VYtPvJAQIlLu76iJhm4rEfmAbSkCtDgl2H7xPUp1zn1/nuQGz5JUg/lMkqO3K8rOq77wyh8tpYLqy6KhGyPk/c0nNP/AdZ1YqhkVFTQecn3qQGFqym+3TJ6n6FUtHA6ZvagdgRrQBDisVlFkOAtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164440; c=relaxed/simple;
	bh=mLKiP59LoXJVXWQoRWVwvz6rmlSIz6KcbchWojiNylA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErVCcqb9DjAeiY0CbE4DS7zi8pDjOfgmR0ySIsOY4ZlKNowB/nz3nId+/zHFDzUpU/f8YJmMhAVNdF2TfOUyLpUTQXV/1gVEAbkbAnSc2Mbj9iLKnT4nm+oJT/DpFTw9pseMp9nvVw7W3qv9EaC+U7xiC+WxZqX1Acddxyw90EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=f7H7XXRw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c19MCD0x; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="f7H7XXRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c19MCD0x"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 7240E1380074;
	Mon, 31 Aug 2026 04:20:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 31 Aug 2026 04:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788164437; x=
	1788171637; bh=AsPhvud3azvo0r2BrkdCIsXDLM/tUzAdsviQlX0O/e8=; b=f
	7H7XXRw2WskfLXnNQQjlE0X/A8JbiuMdh5Sb24A0nQoqHes1rZQ5ssNSoWZS9t/b
	50HB7m6jVyKS9wFSkRTqU6jh7gdriWO7xIDZ7ujPjuRCuuop3rFnV5QDWUpBiO0v
	n7BAhNNHJQIR68v0vtY++neYGaMLwl5sq3US/MHsq3qDm9TKs/HGuF0QOwt0U/ub
	cSw6b71Rd/ikwvVKl/wMfM+V6ZB3dRn3RFCKXkQDR2uJ6ICP/NmqEC9mmi9J0PKN
	p3PsTJ26aZ4rtOUsWQ9kSF4msCvEajkL1XfMjrgCWJjq/m3DsxBlumLZ2M5Jzoim
	acItKbHejyyseivD/49ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788164437; x=1788171637; bh=A
	sPhvud3azvo0r2BrkdCIsXDLM/tUzAdsviQlX0O/e8=; b=c19MCD0xNppLdqjSo
	8UMZaMV9pHgM3SgXS+9AgAoVVD1l3WqvIe6PrAls/sXKPYAfI/xeghxioyDYDX+U
	vkmKYRi7IxYmXx2XeozDHo5N6qHuua0eKPJoctlVDC7bXo5E/nBwHIFJdhehyMes
	wHUu0f6ahrP4LDSfcVK3Gzm8eamGMGO4DAUM7M8OeeI8FlhVjd0eODg1ik6teDiE
	RG0CO4Hnxz2jduC1N995yur26RxDr0CYA444xoJhxwmvUK6FH+JwYSv+i1euhA1z
	iAUkXAeExVYPb4IKDy+rS8qRjLEWKq+DnbQ9z4TEfBse5wEGo+pSzhwMzs9Kvzdb
	gECIg==
X-ME-Sender: <xms:VDmVahZtXj5apsH-ttGZOQEHFRxMQWDAa5auR8rWG8XVF8ORHdMfaQ>
    <xme:VDmVaoS1YCk-MKH9C7p8Ce8s_QTql71yJ_hfeuYR42TDqKO7NSHc0QDCKMl1ZKvoQ
    4I-kEqJanQ7ZVrTIcrwJVK3ddVC63XR_cPBr-gUy81p99tEyrMiybU>
X-ME-Received: <xmr:VDmVahToyaVO7tcLsgbUabnuiYPXOzLXu9eZ_ELcFeEY7uWInO0jr7NU9oy7nCdUhtAN2qcnvw>
X-ME-Proxy-Cause: dmFkZTGIFgHn697QN77LvkxTVd0HUgqc7dtgfWAXvrJnzjyYk/1E0GgI5UhaHEirT/WT1x
    b+qszzNdMAzVFopaNRs2dxhnDg09r1jPoC9MEUtixnInykmU3Pw0l3hwtCEJ1ad3c93Xay
    bd+l5sHxlTS6v/5iZXzAZK/4u27Ei0nAwXdeaVFF7kRMXjXXfW3iRGTZonBhmmpTvqhV+z
    V8Wknu+rEOyAMoGvxP8cZTL5kJKYkaLJxiSkeTXi9Trr4J2M5YjykmqP7kv72jWCs8a19h
    BukMvHNfzyzCVsSYvDh2T5LUAPpVgmVJhTbdZLaOSzh+ILq3lNXn5p+T2rNKefe0YsrRTV
    GXWCy4Nc6Xg5c2VMDpArm7CB7Jqsiy342MSwQWT5trhAiWCV8fd4ssQLpHBERMjS/r/glS
    tRymfWbA3D3Yt5lxoQ5UaT2AV0P28HX+apnpEw55tFUre7Tt+fGkBMVrtfXBoodKUEWMjI
    XuUtixBqv45vv8lvC2OufSPVaM/B5A9Uqx7UnYGUsFjnrZPzvENdV4bak+YnxayLUEO0K1
    DAar6K7DjAS88jNJmUPbRA0I4ePZk6y1yTKI3C+K+uOZXdCB/uWLrnW+ffqtCNUVs7e9se
    50HHvYlzHgomOP2xboIJ6k5N7368PMaMav6EX1v0PDmFfFxbt66E6scp7FDg
X-ME-Proxy: <xmx:VDmVar1_mi-RIIdLoQTHhnMVg-IH5gyZvocUq0dCFH6kKyi_lRCSSQ>
    <xmx:VDmVapwGUPIvrKJDz7vCncUY0ums_nLImfqlRzGJxr5GVDslW2sVug>
    <xmx:VDmVams-rcTd1IUxOvI9GYY0equBPAK9QxMIRLEZWo6dhYwWVlY_LA>
    <xmx:VDmVajRxzNb1ztgdZdt8EOnvZNtO1dA3k5ZF86XQDvKesisSyhM2MQ>
    <xmx:VTmVatexhp4WoEhUgP5fljTk2HU0_i6Agl7OClrY7gdjswjzkmfXgVEB>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:20:29 -0400 (EDT)
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
Subject: [PATCH v11 03/14] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Mon, 31 Aug 2026 20:19:45 +1200
Message-ID: <20260831081956.84871-4-gahing@gahingwoo.com>
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


Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF39481AB7;
	Tue, 15 Sep 2026 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469084; cv=none; b=CJaregUpc2YO1eS1ChbKd/QoEVNmQu8U06AO58uBsZHlTnDQ4uOYOU6YCFir62WnlDqDtQK9BRIpV8n55P3MEv69XWxoUg3FtM3aphdGO3IgdwqG2kgTo4SP9RaCFfMH99ctDHp9kQTUxEV05/EXsn4SIbIN+i07ZuR2I8/E8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469084; c=relaxed/simple;
	bh=VY+jAzc2LpYZrHfjHkhavBoH4rrL0d63DJB6mvv2fk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEDgvkaxxQ1U79szrrWjeBkn3v8IcF44cnXpnDO6BdFLJGoJUNzviefVE6oj/J/Xd5B37iebhzIOlEYEVUKqTRS8sasQg1Yw+q6GgivFtWlOW3aF7WlEE8qYxmkr+i6YRcnfeRteqMqSsOgtr/EQtigbcr2OJCS/+eIvtsOJdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=aj/kfVAU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSS5GWOT; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="aj/kfVAU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSS5GWOT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 30071130050E;
	Tue, 15 Sep 2026 06:44:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Sep 2026 06:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469081; x=
	1789476281; bh=lQdZ0GHKydOrKI+dUcKiWk5+c+F2epU+605XobNgMDI=; b=a
	j/kfVAULkQ7Zl+5CTq4oWRIGyK+jSYdSb+kceBSWxB5CwZpF2H14siu6rd7FPUPK
	tULObl6PDTehISiwCcyM1dT45XXzKORzQPy3Wk0h7vbcNfyiqmAgz9uoupH7r5Pz
	xL91HkGsi/FNvHQ7wWESYKwTs4+L65iqfHdhcD9CjQmsDfh44XgH+w+KezgHftHz
	1LSdC0KDQPo+2fLE2S3cv8e5gC2irXXfotCDYK9zTo4GEwwnQjuXYGOkRkoOM5zP
	TaoOy/p7jMIfpQVd3lzgQIYLVufvLvF6le0p/RcTLomtUft37LgKJKoFvcee+Vv2
	E90qnbUBlNhtGvwr3hgoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469081; x=1789476281; bh=l
	QdZ0GHKydOrKI+dUcKiWk5+c+F2epU+605XobNgMDI=; b=NSS5GWOTn39hXlrjh
	2tynGo4wuL6qi8Uutjv9s1wC/6C3JGTixQ9RcDynsquvj0a2yu3vRBDa6xn5xTNv
	PGAjeKG6r7WbdteYWg/sRwnbpn1aJZROpUo5MWB+4s687zZ6MwmzJPVsMQuTLSXJ
	VFYrXUy4GebYjpW0oMBAiHkEgXEbDTyG4fDrS2e7cr9d03ajtgEWvV1DZEDFKj7D
	uVm4q/WMPwt9kXANMZIcegfjGamCMwtwywU8F1k0SYaTNWEkcQJWnt1x71qa6/di
	PbSYUZsw6FmPs+2KJWXCU6ux1qZlJ1HLEVVeDUI8xsBu4Zr0Y/oBzikVwZfk7QLU
	Xm9uw==
X-ME-Sender: <xms:mCGpaulfFjI7ChMxdRQGtMQZ5KRCZsdj4UAMAqA_nB_oE7yEVqbnRA>
    <xme:mCGpal8MhlQ3cZLcEnLGMLQ2TNi7BZMc58Il3SRZYf6umdd7zzZNs49Y0WDK3uan2
    _toQHp1YYxblSuuuuDD9u5AUD3cwk2JnoY0dzxbINxVvlKKZOmkiYc>
X-ME-Received: <xmr:mCGpaqf8mjAiYH05QaZQ-F8w81ck0dQA4Y2sRfBgF9fS4QrgKXTxIcyuqd9gD4gcey4p_zALrA>
X-ME-Proxy-Cause: dmFkZTEJ7lsNMc5MXcmK0yAby6zAyahnp/o+BLQRTsAUuD6zUFYE1mfayW4ARlNvxFxbHL
    RViSXklp2Mvqoh7nMl9WcpZxcA5zX09aM17WbnSDD1mVdJoa+dDoRGgFZ+ZZgzctt5mn//
    Fi1Mt6BzxdDiSZyXddMkKr5ZuKnhcJKMT/Ww41HfwQaAux+0BU99FP+g6srkBweq+0Pyu4
    FpApM0KD75gdC3rQ4X6qbPGbs1ABgnV9cF7lajdZo5Ix2shyw0qolijI7Y4mlyGIz0nhlc
    sJGrQ0glbm4LA0H4VdiK+uhUvmoFkp3adh0VEvVmG9UeMUF3kO5gMGvK351yi5uht+G8Y6
    Qn4mGh9p2Xp3teJ7lrtCnrs4DdEl2OlXx9GRcKrLB9ltkK7+THqkrBW73sBwUIHNGSQ33T
    t1jiSbJMzpBY0x54Agj03p0KNE9PU/CBjhMk4rkAqh17Ocw2+BegO5gj4Is1+nmY/Hr4Ud
    4es7cuCAO7MwuMjnKHCkWXetZkXS760OVgVfVVBxFrnofhsZa9oIEDunDHREs2Lgald8I0
    SQPER3rKqOKGJcscVf2nyPIosWdeo6M/ItD1XXQJqRWmfNTgaG8R4SrD8rGd7DrdQjUjzR
    m6bKc0yRBgXKgVwqjX9KAhf8HV14wdHyfrq02KY8hpjbMsVrColr2Vd2Minw
X-ME-Proxy: <xmx:mCGpam3c5EA3z8LrqMi1g3EQTmeW40wRRWtnJjBB4uZGszSyIQJotg>
    <xmx:mCGparB2EVT0lQmJ6tQdfG3oPmYBkuJAFODE3eifreIfnp9ohe405w>
    <xmx:mCGpapSc1zXEWjNwHd6G7DyVeq6RZq6ClH-wiBAQSpv8QXQWvgm9gQ>
    <xmx:mCGpalLJXDeY3fdFYcM4wRi5kIZwPHQqXHmuiYXtv6x-tyAgRYQLUw>
    <xmx:mSGpakKLisGSJz2wemHICUK6KjKAeHZ6Vr2wzb1a3apsOjwfnchHHEKH>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:44:32 -0400 (EDT)
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
Subject: [PATCH v13 05/14] accel/rocket: factor the completion tail out of the IRQ handler
Date: Tue, 15 Sep 2026 22:43:19 +1200
Message-ID: <20260915104328.45901-6-gahing@gahingwoo.com>
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

rocket_job_handle_irq() stops the block and then either starts the job's
next task or retires the job. The second half is a step of its own and
reads better with a name, now that taking the register writes under
job_lock has moved it a level deeper inside the scoped guard.

Move it to rocket_job_next_locked(). The early return that used to leave
the handler now leaves the helper, which is the same thing here: the scoped
guard drops job_lock either way and nothing follows it.

Doing it as its own patch keeps the locking fix at the head of the series
minimal, so a bisect that stops before this one gets that fix and nothing
else. There is one caller, and no functional change.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 2a0b8af6f..54f9c299d 100644
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


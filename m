Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4D403E9C;
	Mon, 24 Aug 2026 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569767; cv=none; b=B+ZnELwtAg0+N2HpAqXGiGCJiFhi6WS9Tv5ZySdK2hTJcujY65zNcGOWp3fTr3Ez9DblODdeWpwNDKCT3Up2f1x3E/0xLcT8OL4v7Nrz5MFniIKs5lB8ONnkQ/KFbyU1um0eW93vXUc84BHBP+S/X1adL42l8fowPdDXTPS48LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569767; c=relaxed/simple;
	bh=tlg1zGjylBLNUM0UO5lGTdVugx9lVmieiDA+AM9me9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crjKrBh0bhGQOJtENTNmNy9jQ5UgG7UUUFAPIG/axgjfTi5UUgpwxXDhpweAqMrIIPeFfn3LCWisrrhErKp/C9eBCCOS+MjokP3BXqXovxctWUdMVl8CRf2QkbifKskEn9a7XgrkjK8dduoMnIgkYISFUPCuBYnq4umUS86EeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=Lbe4zwGs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=en05nMgQ; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Lbe4zwGs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="en05nMgQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 299D61300124;
	Mon, 24 Aug 2026 07:09:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 07:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569764; x=
	1787573364; bh=FTYy85YaRXU7jvCVYmoRlG7bSU2LigxqGLsoOU4vW4o=; b=L
	be4zwGsBEurRouuitmk4pBuOHGxqotRdq/QlTu0FbmU8PIqGtH1iZzLP5gDszZ8L
	5lrexUqrlSR5j/4DuWr9X7cOmIpATuYquOs7Sn00LM46iKfZI57FFjx8WI48bavS
	hsS2y+IacDltwocxxJhjfmabH4YBQFHSoTJA0EqvWmgNM6aNitB/AnbWREzSrQwb
	NALXjBg6c5dxeEHVz6jOnGo23VzIiuuGYpTejGaCrx5X4+ZMQKz5mysYo1Jpms7I
	sLCDE9mb4oohumRxiPt/ANI4yuWvRTHmnq2Iv0+cHp0TDQVvi0kI17PNs+Zi7ed6
	Zi18OvEcCOvA95hXE2KgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569764; x=1787573364; bh=F
	TYy85YaRXU7jvCVYmoRlG7bSU2LigxqGLsoOU4vW4o=; b=en05nMgQI8/DYhZvp
	h4JckhU8+s6VFm9V6gw4gxKULrFjVSqU+4ld0MDfGdGonqXJ6z51HrfC1diCpnco
	4ltwi+QgpjEBkE59DWGyjjwto1QdE1al5kcPC4idiHBa5ci2KYQcFtG5QJ0JgWSa
	QMUv+CYMgxPwbeeozJ1yK6M39ByNhKI27gkkEYyIvg9dwKR3t6ycITDPPQXtLmCZ
	cGcm4A694Ev2n+bA/ykgNhebKnpRjC4T79biCOhsbJeuR8RQwDgQujnotu8ByFLd
	YPiz4pv3ib5ZH0M191OsLqBbTDSuncQBxmJaEJM4GC5tyuBlgPQBUCqFllR9feg1
	C/A+A==
X-ME-Sender: <xms:YyaMat92suaHnqAFzm-BQxHq1tjeuVe3tv_wtZogz4iMp5Tf8msEHQ>
    <xme:YyaMahl2P6mLhuWUuULfUWTk21PyzKnoaZHq_r5SfCJw8cE2TjLaunuckNBFzf0Vl
    1cDflTXDF6phyo1Ig94am4ALhMn5yseI-g6e6Ykj6ZwoL2MiQY9ysw>
X-ME-Received: <xmr:YyaMaoXFA_hj1GRRb9BsOlh4njtwiugeNKSbfM-4TDrpARXW8HwaKMUJlAJhwv_LPsCUb1UU4Q>
X-ME-Proxy-Cause: dmFkZTFZCbpsgW1YFD8tkPvHCNfxYRvTZ4blFH/NRV/HzygHIZO36nEMOhE1d730qpXJvh
    mj3vwdyckgY6cjcLbWoO+E+Y3xnZHjj3a4qFKPUp4C1ItOyypDc5v9ubc43QMrvknpo3YV
    t254bBqkhHFILTMaiaOskey67wujVC060Hg7shRsjYN75EBvtRkSi+gTwzTAT9QI5uwF5a
    jKY8X+yRsMvgEojvqKUbS+n33ebqC8Mk85kgoigVyIrVFWYfmyd/lA/A6ULdG/inFBXWp7
    ziuYhhyF6f7lNHjxbQ4kgWN86q7p7VmrRBdAb8OqXw1LSsz5kDP4W0+4ny2SVIkbn/oddh
    +njcyhOooUEeYlxso39Ruv5OzuUgnOOiLqyWUs6Pbv/SycCTUX9Sfn5QfHpLBy92hhcD7m
    lYossoEFBC+I8hXEZ9Gu6JmLsJkpFW4ZA3TxD+oldH/Ed2QLGG1izPgyxWm3thrL2B4URJ
    UF7Jv9nmy3T4Pi7HOuWWS8pYo3k2dIhhL6i2c05l52dJSnSU7pTSnStj/x4/kTBQYAaLML
    73DqzZ2rD1a00CT/PSEt2i/nETJ4sMR6vpQsj8hawp1fIRb0UPW4i4aDBW3xPGTOYcbGTL
    2UuX8l5ZqI8vFrSTJNy0t9BzioJ8hGmW6zBAqGxm72yCFbY0MUIAu1ru5CjQ
X-ME-Proxy: <xmx:YyaMatpOXVHUj8nNW7pT5a0fH0koWzrtb8S_hcpZgq-AZf_XWhEo_A>
    <xmx:YyaMavVDEm3tpuHaxsJpiRP6mDfzrOStDhBaJ_ATkAs8K0FyjMdPTA>
    <xmx:YyaMalBTi0g-5Zsrs_M6CrHFpbGfvClYeCJQmx0bsTYVURohJRSVwA>
    <xmx:YyaMarUUPVxSAeqU8AeHmfpIxdrJncHBb5XZRVr5CeF-nscGAVwQzw>
    <xmx:YyaMaoHjRiHPa99CkSqHUWME-fWl4GnJnzHWsFnv68KLjO000-hs_O3Q>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:09:17 -0400 (EDT)
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
Subject: [PATCH v9 01/13] accel/rocket: take the completion register writes under job_lock
Date: Mon, 24 Aug 2026 23:08:50 +1200
Message-ID: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787568658.git.gahing@gahingwoo.com>
References: <cover.1787568658.git.gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_job_handle_irq() writes OPERATION_ENABLE and INTERRUPT_CLEAR before
taking job_lock, while rocket_job_hw_submit() writes OPERATION_ENABLE from
inside it. The two can therefore race: a completion being handled on one core
can write its zero after a submit on the same core has written its one, and
stop a task that has only just started.

Nothing in tree hits this often, because the interrupt is the only completion
path and it does not overlap its own submit, but the ordering is wrong on its
own terms.

Move both writes inside the existing scoped_guard() rather than adding a second
critical section, so stopping the block and deciding what to start next are one
atomic step.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 3141f210f..5f0f9682e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -345,10 +345,15 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
 
-	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
-	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+	scoped_guard(mutex, &core->job_lock) {
+		/*
+		 * Stopping the block belongs under the lock. hw_submit() writes
+		 * OPERATION_ENABLE too, and outside the lock this zero can land
+		 * after that one and stop a task that has only just started.
+		 */
+		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
+		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-	scoped_guard(mutex, &core->job_lock)
 		if (core->in_flight_job) {
 			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
 				rocket_job_hw_submit(core, core->in_flight_job);
@@ -360,6 +365,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
 		}
+	}
 }
 
 static void

base-commit: d589af98928d20eb39b04ecce3eecbe7ec802222
-- 
2.43.0


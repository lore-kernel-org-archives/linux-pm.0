Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC33403156;
	Mon, 17 Aug 2026 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966588; cv=none; b=bYyrAQN1yb6lZ+qq0JvQsZxMrwcc4WCge7P114ERammPXhp8vFrlUB5TGhvBQAaC5gchiG7MTkzOqegC7zz94zD5Uhfcv6xw8KuUZ8eT6P0f8q5bG+bLbyu1ckGIFRaP919h+wR7EW6YDX0zYYq10RH90utZGcdEO5SP5NsErbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966588; c=relaxed/simple;
	bh=vprsrG8sAYEblGk2j6cjGM8odDdLxA4Y92VQQpSkgYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsRmynJND7UD9LV9U0Enqr7cy70pzZH1Wg7O2gn9HsL2Mmxc5FSAvXIrJKm+kJcuYT0daxK8qjdTkMuG0u82asT9IPQdTrnNVBUi/vYGIDXxxre2L4faCjLcA+cktpESvPSXquV53TgHN1INtvLJOUixCGgVZA+M9flYDoXAz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=cWIRyH/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OBjFFmaQ; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="cWIRyH/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OBjFFmaQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id D5E7E138014E;
	Mon, 17 Aug 2026 07:36:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 17 Aug 2026 07:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786966585; x=
	1786970185; bh=kOD0qgmgpDkG6VHfvGiR3DFrto+S5r/nxaFB/JMutG8=; b=c
	WIRyH/hX5KptnbsHPD7kI9kK8yHDQs4b+Z0xVbfWjVTB32U94rOmoJWQYZ4OoG7y
	iram5RHoRnKXMWin+0w9oXPE53uyYqqzYxg+8EHlEkuWDfx1fomVgCLG1gCh6DP1
	Hd6sbgJBbHxgS7gDm8srxA3B1z4Pxu8crIVhC7zlcsJe6EzhoXqj7apHCex8gH4X
	pT/RrldwQQsQ+jDsEkcDMvxqkPHn+L3F4NUr0uQcHvNJHEPyYAn101qH+pcfRUax
	cjiJwyGZuWP4pdnSCCS0QQkSSvoyujDaiePj0AVQi9tl8kMR6fqn3OaGvqf+GJ7T
	pl0/5oc2ytrUjEzXaSyUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786966585; x=1786970185; bh=k
	OD0qgmgpDkG6VHfvGiR3DFrto+S5r/nxaFB/JMutG8=; b=OBjFFmaQUnvahu8Cl
	CZGHdl945d/bgj7fX4pcw+mgCh74W7CNF0p+61arXd2Km+DPX4NB5D0zfJdgfo0E
	iQZvyFz227N1s4vUlLlrHqsXW2RIwzO8bYayTYtNQTPXbBae3njN19foPU5bU4vu
	RDx5KqUgEa6eibKwxOW71uu7oqwTJUgp3DgXs0yobPd5bLBtlu0FnKWLyF9dZ6qa
	+U0uYP+DnH/HaVbrte/3RcCz+imJaxnpEzUfoPBYsWXDXh2sjXajHIei/2slA5Lh
	NwQI84Who2WaaFmnfAfYBM2ALv1sDn46+NM8QDump/s72HeW+8+YSA+yxaGPTNdt
	nGn/w==
X-ME-Sender: <xms:OfKCal53jtdUG3QAdo5rOjGlWTZHMSbnOgcE54s6B0rTMVgwKDZmzQ>
    <xme:OfKCavB1Ma7fn9Jxop7EZlkpSpxhzl7o83PojSNrrpNxL20zNx3ssP60J9MdWYHmB
    Hw0mCsPbTxDwQLGY02HCFxc4__waeALgHYWsX0WOnl_LgZDUq7nJLR3>
X-ME-Received: <xmr:OfKCaoQjj5zQ7tzJXrBTsidfeERrz-HNZ03tzuUGW5xvUXEMq_-cRMEGrUZKdSqlzf5QhtHknw>
X-ME-Proxy-Cause: dmFkZTFJpbjkSDT6AcryrIHhgbEVj8SvkD3tgmT76I8WU6lQDo3YUCdtzXxAeg/zKqpB+E
    Srz/I8ZJc3N7HCrgkTkwyaBZdvHNOdURxqLv8+rxKpfV73gGv9LWiSebktKgvlTsmvhDvl
    7z8e7P5tVZXD1XfHmjG3x7RlOqfrClYofT98201dsDsGzeGalaNI/cy87SBMyHKVxLpD1H
    cf8c4VtlmLV27PNqhGPBVow9iGRSY0ganIZ7M7ursi5UKI38krV8lOdP4K1YQOgw9wIEpu
    SQtDihQpP3WqB+Si6LCioT5pFEw0karkUBJswAF2S4IqKtJUmYgRgB9BVHgg2tCz+ac+Ah
    lKkMoiVooZn13gF2ewwzJ/R/TGfLWaf5J6ZQND4Vxhr8M4MjHFIDUOy/vfNPhvAaBdfhoZ
    UAm+IprfSmqFHoEwJiObU8GWy4HQw1+FXmhNlqKH7v+a5eeyjI/jMrqQx6ZUqT7FsP2Wec
    lNZROYvySo5ahIC350kReexBYGlRtYqql2+7STa8FJTwmwufrZoZCB1I0fC+seyaYCxOse
    9lUg/xwfRQX3Mcgab74K7kn0XWpWdMDrm3ijn8wGBCCQP9KjQ28qUzEcbkcrMZPnkfkrFY
    Nfc0tQY+18DghcECJRV9JLYOm+DyIwIEgaCxAWiF7BVAzdqiVmf0idUPSz1Q
X-ME-Proxy: <xmx:OfKCandS5wvpbxOjVILjEScihOjPfq-UMBQgIayq_coZ3E7f7iQFjw>
    <xmx:OfKCapS3Rxro6Zo-TIh-OPhD0kstFC7xIqRSQauxmgrmDIL-RnEVCw>
    <xmx:OfKCar0XV41mkGCNDICWzMFIB-qIlldu5ZlxWkWTt8QfUM2jhuVSoQ>
    <xmx:OfKCan5GETroU1GmWwA_XT9puH-ge5jPG0MX_OkbkQgOvqzlXa1LAQ>
    <xmx:OfKCaosLTwSPWAZrmGIOF_ApOrpc8Q0MnLSmAeBYM81KdXcYkutf2jdf>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:36:19 -0400 (EDT)
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
Subject: [PATCH v8 01/12] accel/rocket: take the completion register writes under job_lock
Date: Mon, 17 Aug 2026 23:35:52 +1200
Message-ID: <20260817113603.1436067-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
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
-- 
2.43.0


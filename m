Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1192D29C8;
	Mon, 31 Aug 2026 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149310; cv=none; b=eu8hi4ONGlHE8fveInPoZq7vk0h7FqN1JN/aj94zcVBmUR2CwGhCAAexEY0v++jBo+A+nybhm9GDJPHGUifWCuOBxq3jgHm6mcIyW1N59hnV5w7DMDpiSkEv8//CBFMOCW4IK5+eUYrFPN63L713o6mKpefBPBN2tRAzwtliRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149310; c=relaxed/simple;
	bh=vprsrG8sAYEblGk2j6cjGM8odDdLxA4Y92VQQpSkgYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHzQbvWEHe3bhK65o1XVDAUBDSr4is6fCSPKKXKyRmQR5NmNDh6lo5vYe83ZKcip04fG3BvR3kvdeDk022MsVvOyzUIOAxcflW28/eFpzipHNtxdXx9kPMHAdv3SCYQ4jDaJVc5mC5c93z8ncur1PzFOqAq3akGCSJE1XgwQCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=kCH+GKQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TmRCWxTC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="kCH+GKQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TmRCWxTC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F2897A00E7;
	Mon, 31 Aug 2026 00:08:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 00:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788149307; x=
	1788235707; bh=kOD0qgmgpDkG6VHfvGiR3DFrto+S5r/nxaFB/JMutG8=; b=k
	CH+GKQ1iT5k7IKpP+V58dELV0XVYsUOZ4VKMVQVezOLGjVgDllNK0mmyflp4tIBT
	S6mHPrOcXpWnPwnCWaV9AfIUsxWmC4rmE3j55o3KWq2LRadA5uzS7MlSE16+TeF+
	UH7dvXu2B/ZcoRML0CBEXHC14VbXkaCoplZDezKQKJVEuHOFaifYw+DcspBH41Cy
	0dj0Y/8s4vzQumt7zxaHyRJVATI6cLHUqGaSIZx7HrzuZQf5TSl/9VjPKUcEMCIb
	8HgEKkrkuHUZB2U+zqsa+KJLfUU5bkqEr4H3aTlrm79jMMp3iCtgz6Lr7LHVaNHJ
	WvGG9ig4JmtTmVAwsqnlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788149307; x=1788235707; bh=k
	OD0qgmgpDkG6VHfvGiR3DFrto+S5r/nxaFB/JMutG8=; b=TmRCWxTCi8PVMksGd
	ea0GuQzePDsQKkF81RyGPHq2CXgTgzY4IKqO0J54RVEZ27OQwoBVeoQxg+uODQ90
	ddJqIKFXaPvTGcKjGjDFkacbj0N2GR8CAA6XEjVqtGo39vH95On5HwJqrx1s76DO
	El5OC+Qr4hhPihGbhQsrb/OTRVZxdhy2NeQIFguA6NIThOHpfroS02n4+SHbwL+I
	QZxuz929Ww09ud9Ey64WwhO2ekrZoz4p5LU+jo1gIwVZu7448DAyrokJ4T3R968e
	RLQoTh9P5MGrXHT04GqePa7YfYk7sQudSGcj1Y929M+jhCktFV1W4KHo44hcHdVf
	8glwQ==
X-ME-Sender: <xms:Ov6Uala1Shw1ubDgysDt4_l5k8iz200IEUVJIYNlXXZsts1T9kKI1A>
    <xme:Ov6UasT45ArOSKJVVWGUdA1retBKbY32i2bv-JIGnfI6Ta2ZjOkrIt9y5qwBWqPgj
    ez3ojrfD5BjcDP85arGfkrPVvMR-Yl3sXh5bu50XmF_kmS_ZQT01Rc>
X-ME-Received: <xmr:Ov6UalQKhv5FdZJ8RBdKOhpXLMP7iT0U5iexkG4Aq6p-bHeha-mO8Z-de4j7aPWpIwLUPwbxvg>
X-ME-Proxy-Cause: dmFkZTGgZgR+VcPfe+PhAzOLd0oIFeQYFsXhiZHiqFEfJLX+Zh5ZMdMCmp7DSb14qyqV39
    jp/P4WoX1+fWMg7xKNkg19erm52kJxQUcTYbC3fhf7J3kTCWp177f4eiTLGImcgm9FlW/K
    919HsGQiniAe1IB7e9jl0y2Y9dxEodpqsZNpi/Wh8/Y0aGqz1kZ0NysbtBSq+wCn4J8DOp
    NMVeqNR7AEscaSespCcNi1Tsf5l8QtvZS5D7uic9GEJ8sDuUqjUvTw65giXWj5Lizkd8mk
    k6Wvf2Wg5sOErrVa3i9eyoCaEv0ghglB6LbcQ07PYZ4WQgjzQYOd+k7ebFmJtNV5tyGOFc
    UAC7YPPpqcHGS0xfNMZggo31BVuyuLFl6z5ep22yBZShtfEQnChcWYd1qHMt+qllbvRATt
    DgtqBHejXRvbYY0teo3bE6FcXYVDb1HGXA+YmyueBRZyopCZ50k/4LRfXGuEFNJqcg/aKM
    b6Va+EXDODvjava3OcB8/CH9miSaOyW3RGGlkZDE1WjzyGr9WN4x8cYXd1fvcfnhC3kjM7
    JPmb0Un4Dq22nep5ghGsn/E4IOhUn0BkMh18+B7xXigHeXCJ0Ekqw1CRmKYu26CxCgBZEH
    4f2hjopjdyzZjZTxMyaf7TG8h2aYnU8KDZ0cVQKwSNH7XVI1q4cGAt+FL8oQ
X-ME-Proxy: <xmx:Ov6Uav2UehE5yI-QLoG_FDf9EC5cyc5gVRkyQu8Spp9FFqbcmCAwVw>
    <xmx:Ov6UatyS0IiIW8Xp-ma8aTdpVpmWjEODpbxnP1JU_p6HCANhrDXEew>
    <xmx:Ov6Uaqt1aiLUBAfsiGbb6NYfWRnV1ggyCSANJwBhgZWB3ez1oTBrLQ>
    <xmx:Ov6UanR3AC_9B26SDC-ConSh30VZH5qhJ48n7L33rIWVfH5HktWmgA>
    <xmx:O_6UapyeocTvlUozgG_uP304WcfJNPSRcI2FCL5c6l-nt91a5ABkwBWE>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:08:19 -0400 (EDT)
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
Subject: [PATCH v10 01/13] accel/rocket: take the completion register writes under job_lock
Date: Mon, 31 Aug 2026 16:07:52 +1200
Message-ID: <20260831040804.24111-2-gahing@gahingwoo.com>
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


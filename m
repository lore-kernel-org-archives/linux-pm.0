Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B973F4DD1;
	Mon, 31 Aug 2026 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164429; cv=none; b=QzEX5hLj8ivQWGYES+VLv/mRZcVIApVOsfIx2hl3LfimMnOkKtdIdWoJekrsMTl3RRovVYAcuTOq9+bHYR751eiRQX6T9K3x6ak1QjYlx/ATLtz2jzRJ4fVJJBX5ufzn0xbM019W9GTRgq/UX8lV1koRdkTapdVIer62el9nbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164429; c=relaxed/simple;
	bh=vprsrG8sAYEblGk2j6cjGM8odDdLxA4Y92VQQpSkgYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjH5buh+gKgdf5EYCgkekWLyAzeUdvt0uj4g4YdCrSZjR3V35XAoJxy3n3jc5akGSG/b4PxCUdL5dUjzrCECQQVWmkBwoZLbbf9PqiaZEeIPNBrgJw8EX9gKW8lup2O8mbJB2rHqy97bQvNgT1w1Lu2pGNcQ4ifXykPqrQEChIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=qdJuzmgk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNWh8OPK; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="qdJuzmgk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNWh8OPK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id ADDF41380074;
	Mon, 31 Aug 2026 04:20:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 04:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788164427; x=
	1788171627; bh=kOD0qgmgpDkG6VHfvGiR3DFrto+S5r/nxaFB/JMutG8=; b=q
	dJuzmgkWhpdba45E/IZDNrBexfCuFwyqPV3K5bvm08CfPMOPSEjC0Z/oWcBNmLSW
	r3wtDilk0H3rd1Eofg0ZvuqrCVTehqSZENRO6xfS06Xx/ioz3tlsqtB+El0VJ/yK
	ihhbg0b/DJ+vNSeaU9qSfHAMFGjrXBr92kNUpcvRiA4JQRdUN2BkLcHm7cSnUhQ3
	MeDUK43aQ2LVbsULph0iD45j+1uzYkosZRmSQlzdGATM+/u5AQQGmZjHh5VwdwZK
	clqCRiGjSHjGhu1V5I6CVWQi2cD9k3j/1i6Vme+pEcxqh+VpJYvqq7qgU48KcRut
	43xhbi2NIR6yrmrVnv0wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788164427; x=1788171627; bh=k
	OD0qgmgpDkG6VHfvGiR3DFrto+S5r/nxaFB/JMutG8=; b=fNWh8OPK62oA66hAc
	8XgWQ9cgdPkz8WXhjdFRWI04WpuNTOTsUvU8hmqiZkRLfNxiRo3KJACoaU5RgOWk
	ncggU63aQynXSuss2Eoe1UUCHpVPjN+TrCaH+0C7iKp8a3TIlmYVe9BEWUzRxjnL
	gcjqKgDx112aRGbVzBnk85lrOoadjnoCaRlzhYmZGtUFycLJUtmpNwGecZ7074Oe
	TdarY/Is1h8bXdcPpVE1qMps5y9L9iPI6Rg/EXo0hJKWcU3Q5TpvJ7Z5x0+RXiIg
	IoAIwU6y0Nw0G9D4A2VFP5N3kLrZNggCWaIewSe6qut9sP2EV1DFN2GU/kyUcdG7
	HwRPQ==
X-ME-Sender: <xms:SzmVaoxK20fkWYDvz05vdIASyOb03KdIFXrA3I9-F1uB1KKGOSf92Q>
    <xme:SzmVasIES98xKYRXeQ-DE8BwW90giM3DzZCvI_aaaWMDDbqoSAp1CKHJ9-Erv7KPd
    zzucaDUXGFI0IDx2ulVRplPNlhWvwS3-OfQr794IuMbrEAO63P2Cr4>
X-ME-Received: <xmr:SzmVanpZ527m5Tf3HYk4GttLr3hDA7uTiNjO847CWhXFvVkVgGNmRy1mft5A7v5Ip9uas7PcoA>
X-ME-Proxy-Cause: dmFkZTGIFgHn697QN77LvkxTVd0HUgqc7dtgfWAXvrJnzjyYk/1E0GgI5UhaHEirT/WT1x
    b+qszzNdMAzVFopaNRs2dxhnDg09r1jPoC9MEUtixnInykmU3Pw0l3hwtCEJ1ad3c93Xay
    bd+l5sHxlTS6v/5iZXzAZK/4u27Ei0nAwXdeaVFF7kRMXjXXfW3iRGTZonBhmmpTvqhV+z
    V8Wknu+rEOyAMoGvxP8cZTL5kJKYkaLJxiSkeTXi9Trr4J2M5YjykmqP7kv72jWCs8a19h
    BukMvHNfzyzCVsSYvDh2T5LUAPpVgmVJhTbdZLaOSzh+ILq3lNXn5p+T2rNKefe0YsrRS2
    nK19gDxbE2YJhY+vL2jbro3X9j/dRTbv5TdGtGhNPNSRS7uLUQ81Z0NnrcRq6QYtOzq69n
    owSQget5go3lW6V919x9l3Yh4n9dbXkPEmi8kSVCux4cIDm8l9IMm7hmlSm8FNq5kP4gQw
    sJGmGlW2GRNrGjgw9QXG3fx7n5P9FFCPJHKERaqPJY2W1uEmSOgrpJQMfVxhz1NEuvu/VL
    SOreMBdz6XnyaS1JwnFxK6n/aCkF+2HS4FzELxYp7/Xd0V2M1whCR43sgVjDJQLqvr6kO/
    5jMc7wdEk/gOegV10ylNRly2WSHBAw0eKpvubGW/ADSTRnFVDeHCabJrztDA
X-ME-Proxy: <xmx:SzmVaitsDUMI8DgsYSs-j79ZJkEqzWa33Cr-apEWxhKhNo5DYPHurg>
    <xmx:SzmVanKFEdTZxcInqpOQZ3V3RXDZUJYmP72Fp3kVE_CoDp_Vbt4Ehw>
    <xmx:SzmVaomDTD1KCWV5Vp_3-PRwtwoaSG5IMLIzvHi0GxX6tpOr93M0fg>
    <xmx:SzmVavrSXQZEyUYEqk1tAEsZudkESfJECe3YX4AdnGcildEaDBWpWg>
    <xmx:SzmVaiuyA5mIDO7DS-Jgp1Uz0QYQU7QrUsYWG-qnKtATddWoNTz72fnL>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:20:20 -0400 (EDT)
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
Subject: [PATCH v11 02/14] accel/rocket: take the completion register writes under job_lock
Date: Mon, 31 Aug 2026 20:19:44 +1200
Message-ID: <20260831081956.84871-3-gahing@gahingwoo.com>
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


Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542D3EEAC4;
	Mon, 24 Aug 2026 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569789; cv=none; b=RPPnk/rr/BZ7rMgR8kVGCv1ELzFDwtWWZtdMgMFUyA4zXAaaQZD+LFddCjFLPBWQoF8uf6ZwoWEhyIs8QrTVJoZoiZH8u4bvgisTxK+iVHxQ662K4o1U4Ojw97GEdApQByncFyNHZgsgmFt/fm2DwzbeXUcM+VTGF2pgW0r5Eqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569789; c=relaxed/simple;
	bh=mBrZ3+T6z6IExNX+T9PKsCfamLVnRR2s2H918NWqsfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFXKmRnu2oyE5nBYE5Rus29NfIX3kunxJkb5chxFS+eVl68CQ/lRuUCFBzg4cqhXZpAqI02jRlVC1QehNnY2sOYTa+mdZeZNQhrbhFUgI+VYHRhHtMAStawcrEzes2Dok86DnZ5MRQ3aeJ+IeZGyriEjFxo/Gs1vvlmyvsLswm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=TZch7FSE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QgJ5OLHW; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="TZch7FSE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QgJ5OLHW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id D376B1300113;
	Mon, 24 Aug 2026 07:09:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 24 Aug 2026 07:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569786; x=
	1787573386; bh=nY4LfjNBMQybI5V+J3EnjM2yuNte8+TGmXXkWp15KSE=; b=T
	Zch7FSEQwJ7IkYtp104PfD8y0p29rl4R+5W5uJ4uWZ31R6vZsWjzC54WVfZLQ+7G
	+eXKg2lQSlMaYdpQ+cj2SpdH3Bq3V82xGU7jahuvLncPGEF/7+wCkl6h4xFzwx/B
	qtOwLIRptnlGCMypmxv67NhTMJeZTL8FL/G2ntOe38lWyDd11mnaYFWgafopgjTp
	RrgLeghWUlJW15HMWJ470XdamvszKlTqWomqvLtr9oHiq+7aRvv5xm5P4COwr4Xa
	IDfDzoQmf4qkUbEzhzDEBMdXBYIe3kSAbslDgxqVqIObExLrz9jVSxJukU0x/wEi
	ULo/5Mi9svW57dEQNF/Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569786; x=1787573386; bh=n
	Y4LfjNBMQybI5V+J3EnjM2yuNte8+TGmXXkWp15KSE=; b=QgJ5OLHW1Iud41CFH
	IkXexp340iH0BJFbEVW2b5LOr1dOUh/rWK17hXTSrTXPkoWunzTwkAgBGgT5IRQZ
	O9k+yZ7kEabIMcbpm9gaxd4BmIMYNd5lKEcd+W2/wfAysPfNKDG4QFPWPRkAUj0X
	8Z5UsCTpTY0bKPyKqUfDn9lvaoCK4yTolGbod37dRN0cNfwBOp1C9WxD7g0pHLLi
	rnoi8bkeMC7BruEFKrAD+QBtnQ20/A1LGbPpBxccde1zfsSyM0yTQVQnJB72T/kU
	wARy8CdIQ7y5jkYCURHcuuwZI2XZJ5DmyfVwrNd1EHm5LtM82MBl5pWLimI1iVlZ
	nNlnw==
X-ME-Sender: <xms:eiaMaqAifhYkfoVfGQZQMKumT7ROMBR9ER0gRUi0PmJSG3al8aiKiA>
    <xme:eiaMakb9MrPguJbiUeOVVC3j2222Q0pD1_xkovSn9vjFk34cxqR5jNxdjgzGqP7bU
    bKdbGvZzCPkUKrDUxIKNFKjOodV4Rm3CnmUVLVZlWQpq6kDERmAO1I>
X-ME-Received: <xmr:eiaMaq7BoqNNYhEsr-JUSJNOSQjZueFUwLqwbc1mWgODoRdMES5t6hpab9_GJCCBisRJ5edOjw>
X-ME-Proxy-Cause: dmFkZTENgThD1X3/5nJWj+xsWnd4M7t08ZtE3fcEUcWKzIQHoSpuCMd4ibrvhmmRYkAmQc
    R21t62WIK9jz+jJKfoGJIKU/gB9hST1KVQTN18Z2JYV/V4mWhmgdQYRDwjisbmVPJKCb0S
    WaL5VtXOzW4WjlCfoWSlM0gkIfJXD9LL/VAiHQu+bagM7ALxmX2ZNTk8N/7Am4ar5Nxlzw
    +1m1AplaxdMOy81WUtomlFP5vliIFcyga5Zku9qjdltNj27kHtIrcJXZLDtCx+exZbAzbZ
    qx377ynl8ObD8c//EmPs3KqsKnDXLECPRroeb1CKieV9RqwD6dA84Bls/txHXgfCMRf6HM
    6nvvuTN2Yyz7f4Ymi+PNH6Eq+etJW6j+hCYHGOhzqwVTtQ9pPdgANRSebLlfTiVOXdkFtf
    O35EI+neLRXs7oUEYUmrfKDtcJdobyfFBCKsNRiHeMcMxeSIYKwvzGY8ODI58m3bnMZClC
    h/f3GAx4u23NcxBSzyD7+kXqEkIZ0AUMIv66DOiZn2JNDhZaUNWE13PgvpcSN7P20TITsB
    CwdosOwccvP5EIHWsbo/VHqCBUtitxxO0RaxlZ/UCkS7O3slEIXlnPJEveIslPkT1P+70J
    B4bpJ8NnAoRoGXHSlySH+mQlA3kjbUc+ac06bm4r0kbz6zBkjcmg+xKoXOxw
X-ME-Proxy: <xmx:eiaMak-CZz6UWrEum5IwyuMvDcHQ19PvHeR7NMEJiqL2txnXx8h1eA>
    <xmx:eiaMasZKgWoOApphkdW5rWVALs298wCd3eqSoVxJk8M41Fkpu9xmvQ>
    <xmx:eiaMak0AnXfi3tQUNYrFlhB2uB_g4CU6vOhw3siRKtOAe7kPliXjyQ>
    <xmx:eiaMam4KaycVQeozlWbxxbyL10E7ipW_h-TAeFzrXm8436LxSDSJMA>
    <xmx:eiaMao4DXL48F7X2NMocFqN2XgX3fSf8YehsHRmXF2yS2ac2KeqFVZra>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:09:38 -0400 (EDT)
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
Subject: [PATCH v9 03/13] accel/rocket: let the core suspend after a reset
Date: Mon, 24 Aug 2026 23:08:52 +1200
Message-ID: <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com>
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

rocket_reset() drops the in-flight job's runtime PM reference with
pm_runtime_put_noidle(), a bare decrement that requests nothing. The core
is left at usage_count 0 but still runtime-active with no idle request
pending, so it does not suspend until something else asks, and on a
platform whose power domain does work on power-on that work never happens.

On RK3576 that work is a bus interface reset the domain cycles when it
comes up. Without it the NPU's IOMMU stops answering, and the job after a
timeout returns a surface of the output zero point with rk_iommu reporting
that MMU_DTE_ADDR is not functioning.

Measured on a ROCK 4D in one boot, three runs, one variable between them.
With the bare put the core reads runtime-active with its rail still up
after the reset, the IOMMU reports the failure on the next attach and the
inference returns 0 of 128 channels. With the reference put back through
pm_runtime_put_autosuspend() the core reads suspended with the rail down,
there is no IOMMU message, and the same inference returns 128 of 128. A
third run repeating the first failed the same way.

It also matches the put in the completion path a few lines away, so the
reset path no longer leaves the device in a state the rest of the driver
never produces. The remaining put, on the error path in rocket_job_run(),
is a plain pm_runtime_put() and is left alone here: it unwinds a
get_sync() that never reached the hardware, and changing it belongs in
its own patch.

Igor Paunovic ran the differential on RK3588: 45 induced resets across
three cores, with and without the two preceding patches, and the domain
dropped every single time with no MMU message on either kernel. So this
is not rocket-wide. His conditions cross a healthy block with a lowered
timeout rather than a hung one, which he was careful to say his protocol
cannot settle, but it is what scopes the change to RK3576.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_job.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 3c0ed4605..a89ab49e1 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -406,12 +406,12 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 
 	/*
 	 * No handler is running now, but we might still have stuck jobs. Let's
-	 * make sure the PM counters stay balanced by manually calling
-	 * pm_runtime_put_noidle().
+	 * make sure the PM counters stay balanced by putting the reference the
+	 * job took, and request idle while doing it so the core can suspend.
 	 */
 	scoped_guard(mutex, &core->job_lock) {
 		if (core->in_flight_job)
-			pm_runtime_put_noidle(core->dev);
+			pm_runtime_put_autosuspend(core->dev);
 
 		iommu_detach_group(NULL, core->iommu_group);
 
-- 
2.43.0


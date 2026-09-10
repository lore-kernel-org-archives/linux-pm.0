Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3314A012D
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050794; cv=none; b=OKrCwQpooYJh0QnHn5sqyRUhQlNje/qqycLOFDcC0S3FLvD24Lm5WaFo+Jbo/LY6VSwb6Mjpf+j54EXv3EusThqwCvwwQNXoQOSVn9WPn+7wsagRBV1nWz444q10JJkdIY0ssn09EOQeXxnWXHsGcTHrn3DzuBMZSNnwQvp+3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050794; c=relaxed/simple;
	bh=uu+2lcKvfJGi/5CNbofvvGBfTiVgP3doGLL1WgijQqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C25ewB7iQQ1dKkfEe7wzcMycc0A3zfumRM+w2zzX885+h24g54Lw8/ntIv+Z6V6rijcwKhG+wPxa3oodoPx+yHP69NwH1sla4r2QMyCxSMOzONE28hucE5JK6eli4iGBSWAK1+m/iBua4P9qjbWakUXJWZO2U2xiKIEAn+5YgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=EZDZbhOI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="EZDZbhOI"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so57623305e9.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1789050790; x=1789655590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATWBzXgtximDnM1arJgBep/Ega/TVarG2T9lOXViDEw=;
        b=EZDZbhOI6HPqHxGLh0hchaszlfqg4SGnoLXnZn7ylmRSclUipqACGsx1+fPhITOslB
         sz+VF/IFmsupjDZaA+FzMDMF1KVhNvk3HpsWUNXBF37tItZf4mzc4bawBmxJ24yLoH2d
         q4kXjHNIOqQ+n51quafHglm5R2HT58uLDPMK8ix+nZxt4xBMTQewGVsRGg4mz5G0dkeM
         qmgGy+dDiwL1k0RVJb5fm97r4zC+korYZZnuUkYDdSXyFE1eikXvGWXEl3fN3dolUheE
         t+NB+mgtqITg7/dw332nSBs2VLf1gQqCaIqV8mRKijSQapuMuz4VC+qGCSqcXIOGNTNq
         4YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050790; x=1789655590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATWBzXgtximDnM1arJgBep/Ega/TVarG2T9lOXViDEw=;
        b=ooxww3iDsH4Xtt5EFLnIXnXIiR2vwqIBBiMVohBERflymqdWsVMVRoP8UjFgNpU/ow
         kCFUds17MrrGIzCeOoPh9ad5ayq8WGPPFrbOJ9PioKRs5hlQekrIxZyNEuykIoAYzm2m
         jqPFuIBTrVlXpsQnKTatJYZSCKekJ8HIvZT+FNDDQq+HI0ah+OkNIn42ACQ74hz+dmQn
         370ew1Z8rbHyervd1baSJDbwcFOs4x2/kXX5Bt1+ETjyaWX2QgGRqxr8v3wxEsWaSNJA
         9iPORIVe/YV3C3AeP4AXllkfipnHCrkcP8EVmwQKHT1ElQTUIBaEbiOxOm8jS/WLwveC
         7aPA==
X-Forwarded-Encrypted: i=1; AKwUvBzniD0bQpImQj0Pb0hbWAK4jzZfwUolbXY/rscldYaySsWvJIpMDvvq1Ux1XxM62snMcSoIUtdnWw==@vger.kernel.org
X-Gm-Message-State: AFuF++nI3SFdJWfFUhCaNihOlHeDUDfdUN0UFBhDrlj+KSHC9P0v4uRq
	nM6xJknOD8QDniux796l3lJKoeRvJDYAENXQslhbcwjof7t0xIWZXCjwUZl79+oZ0F8kDGdByra
	SrWNA/5A=
X-Gm-Gg: AYBFou37ww+ckWKDO6EPQTJTCi/j1qiPE1wEMT5nlcDukbYxp6CEeo2C/BYSwxshuXz
	tUbS3pz1Qy1yxTEblsqBe/GvIoEfG4mFVDukkSEB6nhMv2c+N38V5uE9XpWMese7s0l4VZbj1SN
	ib6GpYX/oiLib24YPSifHHZuA7NaODsDn+ccj4shhbgC60mJSK840skkHJJEKaCUUZf9ZuPTAHK
	ZLwXYStzEKl2Izs5LXqaYBkoOQ+XXfVyzwHD9xkSOtocHGs5Z/mz8q0tQbmHx5jtlKHC45ELAKX
	MwXQwWlMvBOryBFwW4jlwasGwxwOj+oAn+rekC3J5bXgfFAOhI1lUC/AVjZn0XJYqFW1EaLWzqI
	EY6XGoy8SiCTWIZeUtpJ6tXpG87wjFlnTBWY0cguJreKnSYKQo9vzL999y6pxn1cZvBBI/zzpex
	V88WKD5te8eozzgUwQNgMFMMm1lXQUZX7Jq/NVP8KCsUiD7ADmupGVa4HOGvL41T/C8tvsdHT7o
	4KmQmtkhaNdRNHOhh5wZ6RrhBdj0ZofC20or+/KRS0GDku8clKc
X-Received: by 2002:a05:600d:8446:20b0:49c:fc7a:22d5 with SMTP id 5b1f17b1804b1-49cfc7a2342mr292687845e9.4.1789050790421;
        Thu, 10 Sep 2026 07:33:10 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5fbda49asm12537135e9.3.2026.09.10.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:33:10 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 10 Sep 2026 18:32:58 +0400
Subject: [PATCH v3 1/3] power: supply: core: prevent unregistering a power
 supply while a callback runs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bq257xx-init-v3-1-4e219a1a04a5@flipper.net>
References: <20260910-bq257xx-init-v3-0-4e219a1a04a5@flipper.net>
In-Reply-To: <20260910-bq257xx-init-v3-0-4e219a1a04a5@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7060; i=alchark@flipper.net;
 h=from:subject:message-id; bh=uu+2lcKvfJGi/5CNbofvvGBfTiVgP3doGLL1WgijQqw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQt2j+nuaJK/3DU95CZrx/P2/hdcNezl2VTcq6EdmSus
 tg09+qboI6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx1jHiIGLUwCmet1URobj1RdPT7rd4VtZPm2u1bp1B7bcMO3l3KxkFpMYdHRKwRo/RoYnXFe
 vX8uOyOEpvb5/2vQgx5aNKy89W6Yjc+Gw3MRVEqwMAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Once a power supply is registered, its callbacks can immediately start
firing from other contexts, such as external_power_changed() triggered by
the TCPM stack. If a power supply is unregistered while the callback is
still running, the driver data can already be freed when the callback
tries to access it, leading to a use-after-free.

This happens e.g. when the hardware bus carrying the power supply device
malfunctions (e.g. I2C is hogged down by another malfunctioning device)
immediately after the power supply is registered, and thus the core is
still processing the callbacks which were queued up when the driver
starts the removal, leading in some cases to a kernel crash, e.g.:

[   11.645942] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000005
[   11.646751] Mem abort info:
[   11.647006]   ESR = 0x0000000096000004
[   11.647338]   EC = 0x25: DABT (current EL), IL = 32 bits
[   11.647806]   SET = 0, FnV = 0
[   11.648077]   EA = 0, S1PTW = 0
[   11.648356]   FSC = 0x04: level 0 translation fault
[   11.648785] Data abort info:
[   11.649041]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   11.649524]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   11.649981]   GCS = 0, Overlay = 0, DirtyBit = 0
[   11.650390] [0000000000000005] user address but active_mm is swapper
[   11.650955] Internal error: Oops: 0000000096000004 [#1]  SMP
[   11.651460] Modules linked in:
[   11.651742] CPU: 1 UID: 0 PID: 144 Comm: kworker/1:2 Not tainted 7.2.0-rc6-g62a9297af2cd #1 PREEMPT
[   11.652553] Hardware name: Flipper One rev. F0B1C2 (DT)
[   11.653024] Workqueue: events power_supply_changed_work
[   11.653511] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   11.654135] pc : __power_supply_is_supplied_by+0x18/0x100
[   11.654624] lr : __power_supply_am_i_supplied+0x40/0xb8
[   11.655098] sp : ffff80008192bb30
[   11.655399] x29: ffff80008192bb30 x28: 0000000000000000 x27: 0000000000000000
[   11.656049] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   11.656695] x23: ffff0000c19f4200 x22: ffffdb2232ba4ea8 x21: ffff80008192bc28
[   11.657344] x20: ffff0000c1eef000 x19: ffff80008192bc18 x18: 00000000a0886e62
[   11.657991] x17: 000000040044ffff x16: 04500072b5503510 x15: 0000000000000000
[   11.658639] x14: 0000000000000000 x13: 0000000000000220 x12: 0000000000000000
[   11.659286] x11: 0000000000000000 x10: ffff0000c1fdb2b0 x9 : ffffdb2232ba5590
[   11.659934] x8 : 00000000e5b906e6 x7 : ffff0000c2502778 x6 : ffffdb22339793d0
[   11.660581] x5 : ffff80008192bc18 x4 : ffff0000c19cbca0 x3 : 0000000000000000
[   11.661228] x2 : ffff0000c1fdaf40 x1 : ffffffffffffffed x0 : ffff0000c1eef000
[   11.661878] Call trace:
[   11.662103]  __power_supply_is_supplied_by+0x18/0x100 (P)
[   11.662596]  __power_supply_am_i_supplied+0x40/0xb8
[   11.663040]  psy_for_each_psy_cb+0x20/0x40
[   11.663416]  class_for_each_device+0x110/0x150
[   11.663825]  power_supply_am_i_supplied+0x68/0x100
[   11.664262]  bq257xx_external_power_changed+0x58/0x140
[   11.664733]  __power_supply_changed_work+0x60/0x80
[   11.665170]  psy_for_each_psy_cb+0x20/0x40
[   11.665545]  class_for_each_device+0x110/0x150
[   11.665953]  power_supply_changed_work+0x98/0x1b8
[   11.666382]  process_one_work+0x164/0x4c0
[   11.666758]  worker_thread+0x19c/0x320
[   11.667104]  kthread+0x138/0x150
[   11.667408]  ret_from_fork+0x10/0x20
[   11.667744] Code: d503233f a9bd7bfd 910003fd a90153f3 (f9400c34)
[   11.668294] ---[ end trace 0000000000000000 ]---

Add a read-write semaphore between external_power_changed() and
power_supply_unregister() to prevent the latter from returning (and thus
the driver from freeing its data) while the callback is still running.

Fixes: bc1540561c9e ("power_supply: Add API for safe access of power supply function attrs")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/power_supply_core.c | 26 +++++++++++++++++++++++++-
 include/linux/power_supply.h             | 10 ++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 47e307709e5e..1279785645fb 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1530,6 +1530,19 @@ void power_supply_external_power_changed(struct power_supply *psy)
 			!psy->desc->external_power_changed)
 		return;
 
+	/*
+	 * Keep power_supply_unregister() from returning, and thus from letting
+	 * the driver's data be freed, while the callback is running. The
+	 * ->removing check has to happen under the lock: on its own, just like
+	 * the use_cnt check above, it only tells us the supply was still there
+	 * when we looked, not that it still is by the time the callback
+	 * dereferences its driver data.
+	 */
+	guard(rwsem_read)(&psy->epc_sem);
+
+	if (psy->removing)
+		return;
+
 	psy->desc->external_power_changed(psy);
 }
 EXPORT_SYMBOL_GPL(power_supply_external_power_changed);
@@ -1774,6 +1787,7 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
+	init_rwsem(&psy->epc_sem);
 	init_rwsem(&psy->extensions_sem);
 	INIT_LIST_HEAD(&psy->extensions);
 
@@ -1914,7 +1928,17 @@ EXPORT_SYMBOL_GPL(devm_power_supply_register);
 void power_supply_unregister(struct power_supply *psy)
 {
 	WARN_ON(atomic_dec_return(&psy->use_cnt));
-	psy->removing = true;
+
+	/*
+	 * Publish ->removing so that no new ->external_power_changed() call can
+	 * start, and wait via semaphore for one that is already running: it may
+	 * be a supplier's changed_work, which cancel_work_sync() below does not
+	 * cover, and it may still dereference driver data that the caller is
+	 * about to free.
+	 */
+	scoped_guard(rwsem_write, &psy->epc_sem)
+		psy->removing = true;
+
 	cancel_work_sync(&psy->changed_work);
 	cancel_delayed_work_sync(&psy->deferred_register_work);
 	sysfs_remove_link(&psy->dev.kobj, "powers");
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e749d2189335..131cafded72f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -351,6 +351,16 @@ struct power_supply {
 	bool removing;
 	atomic_t use_cnt;
 	struct power_supply_battery_info *battery_info;
+	/*
+	 * Held for read while ->external_power_changed() runs, and for write by
+	 * power_supply_unregister() when it publishes @removing, so that it
+	 * waits for an in-flight callback to finish. Without this a driver's
+	 * data, typically devm-allocated on its own device, can be freed while
+	 * the callback is still using it.
+	 * Must not be shared with extensions_sem: callbacks may read their own
+	 * properties, which takes that one for read.
+	 */
+	struct rw_semaphore epc_sem;
 	struct rw_semaphore extensions_sem; /* protects "extensions" */
 	struct list_head extensions;
 #ifdef CONFIG_THERMAL

-- 
2.55.0


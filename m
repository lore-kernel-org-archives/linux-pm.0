Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287C4FDE5B
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793317; cv=none; b=h2YFFreIrIOpkdAGKel/gtHmbb4pPFdGUZQooxeaUitpNyHkLKdVLIK789+4NBKgkSCfdQKIWtaw5Tor2cZ+tx8a0A1tz5BN9Ss4qQbIPZxhctEhBtRPTd9g4Zz7OvczILLLWFaGihibtwOZdQJghcjcHxHYjI7MwK7CAJrbJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793317; c=relaxed/simple;
	bh=fFBFontuCqoa+Ns1VZvMEqJqM1VnbRtNd5ndmJogdRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjcXPNNtLEBH6AsUOkO+7sdPyaBAq+VdwT01Nvbwd2LEUmoWX0MpPhkCNyNB2Tvo5wR5ihu208YgotJMqmJST4Ch+7MMDM3wJfaMbcny/vFQxLDkCDcyi2wf7v3xRn3BRwUklV5Aol1xGCEbsXKgLGCOL/lgVLGQUYsgV1vRHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=qQn4oRbo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="qQn4oRbo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so17092535e9.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788793313; x=1789398113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4PGZ09ulVNgaF1vpoTSJtIuCw22RVQMsrEgCaeTkLjE=;
        b=qQn4oRboYesYOvz3J4E1FFV4dFk8s0uZfn5uh79aQTxELllqkvSood3gJ0gQFXBwq2
         eiA4GwFbVkPSzxj239uPmaKHmLCs3fxNUeF9tje2u4410zFUpaeB12ui2o7cko/vdERO
         fZZ0CLXOPYyW3YLebtnLysAxLetzqyykZLl05IoaTIb16pYCajxL9s80f1SEodxZe+gN
         Ym3ROHRv8j9CvTFxw9ZPsXEWjCUWS2DVYaUbpqaXGJ4OnTy2RHRD617Rb3xi02DDZ165
         baIzUOzkhJ3TvRH/DSLCzbpBcaXS/1NG8qwxfWA6vluZxxdYag0C8um3CnnkgN6+XPx7
         XyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793313; x=1789398113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4PGZ09ulVNgaF1vpoTSJtIuCw22RVQMsrEgCaeTkLjE=;
        b=NyguRLiqXhRxN7/UC93Wx4NtTOn7yVvGEqZrEM7GArNPlP3mDsAeTPp+irKPiOKq9N
         aZe2LDgCd3MuzQcnShEkNfWwv7IyDC8D5LpN/QqLJpsJEs8QSiV3NAs7jadLJm6PlEq7
         gzmIt3bNVwEOJpUFgR4U0rNPFeajNcLNh5YRbcBk2InKM5MXaQ9CGOSFDS8dEet2Nd74
         d6E6iSVPoF5I+gJAFQEpsIQNAt844/8lJGRiWinNqkASswfCw0fPiVlWcmxqCwdIuVaz
         cMqhOanEA3YG+2MS5vWgw0aa74Nc1/oWvFJK8bRsqjW7RLBsie5TQ99oLe1Cekc0TeKl
         ZGuA==
X-Forwarded-Encrypted: i=1; AKwUvBzHLH70CbvdUanw8wYrvZEKq/4FMuDW0u46aALVar8+HjDtXK04y/rbGsMVVGrD4RddDdhk07/f+w==@vger.kernel.org
X-Gm-Message-State: AFuF++kV0v8yYOVTV55sCU4TsGsl+iLYzAHtzDliuvK9CvhAa76bYTRm
	4dYqpD3kgEi1eZL234TDoN/svSvzcUbYp9cM9YFD1w+dSMm5jtlb6k60sFwAQWqoBB0=
X-Gm-Gg: AYBFou00zA+79d9yCJjC9rQqiHROMOBwp1N3ziI1mQOaN9QR5QTxOJtratGmCBhXNGc
	PSaV9NOH1COiLRhvhOIs+VnBmgqDBGnIILS+V77BMIaaxsXcEh4Ch09AS7jSsy7z4073I0ILn3H
	Ir621fJP/ZV44ItPaulqyECp8YxDzZhXvWeN16bKNX1xCqx21aKkcR+Xbuj1DR9yQdc7ddE24cY
	QsqjzNHKg96Ebqx/6NFC1RQGA4rC6URD2h45CO3lYSE3tzlHhVRbLQKWw+vkFzVZPFTIoFwos1C
	s5lSWNyxA3RToG+TcnitDPY/z1s3PCOFVS6mW9fCP2j6HPpxgoxExz88hhhhZFQHXFt0YyWo4oN
	P3HkJTPFQXYmtkjEcS05St9XCOy77UuKzU9Y3T5UjFiu9onX+kbH7p0VP/ZhuVCMwB0GmIYHv4G
	UWlpbgIZU7u0geLYcOa1E7bDnaPOGDCIjxjuJrzVjsqxTRl5aGJxSOpmUG3y/teaZNJ4IH7sH1k
	kAl4r9fy4mh7XHLv2H4nYZFwvLMGGG+0g+fMUWI
X-Received: by 2002:a05:600c:3495:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49cf8244bc5mr230429545e9.7.1788793313278;
        Mon, 07 Sep 2026 08:01:53 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm262992705e9.14.2026.09.07.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:01:53 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 07 Sep 2026 19:01:41 +0400
Subject: [PATCH 1/5] power: supply: core: prevent unregistering a power
 supply while a callback runs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bq257xx-init-v1-1-1a08b29e1a68@flipper.net>
References: <20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net>
In-Reply-To: <20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7016; i=alchark@flipper.net;
 h=from:subject:message-id; bh=fFBFontuCqoa+Ns1VZvMEqJqM1VnbRtNd5ndmJogdRc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNu3jng3XwjD2LDMx/ZTTHrOC3nPd+mZ7WwzqNli1xa
 +psfv5W6JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqV9cyMqxv5dp6b2Xthl+SOfdmeOgpp+7erXrMgluna+/pV563d+1n+Ke8MmF
 CsNn+QtapDH7GXzdmd+ZE1j7ccyXPcZ+90Kabb1gA
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
 drivers/power/supply/power_supply_core.c | 26 ++++++++++++++++++++++++--
 include/linux/power_supply.h             |  9 +++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 00d8bc98d588..83769fc33575 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1526,8 +1526,19 @@ int power_supply_property_is_writeable(struct power_supply *psy,
 
 void power_supply_external_power_changed(struct power_supply *psy)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 ||
-			!psy->desc->external_power_changed)
+	if (!psy->desc->external_power_changed)
+		return;
+
+	/*
+	 * Keep power_supply_unregister() from returning, and thus from letting
+	 * the driver's data be freed, while the callback is running. The
+	 * use_cnt check has to happen under the lock as well: on its own it
+	 * only tells us the supply was registered when we looked, not that it
+	 * still is by the time the callback dereferences its driver data.
+	 */
+	guard(rwsem_read)(&psy->epc_sem);
+
+	if (atomic_read(&psy->use_cnt) <= 0)
 		return;
 
 	psy->desc->external_power_changed(psy);
@@ -1774,6 +1785,7 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
+	init_rwsem(&psy->epc_sem);
 	init_rwsem(&psy->extensions_sem);
 	INIT_LIST_HEAD(&psy->extensions);
 
@@ -1915,6 +1927,16 @@ void power_supply_unregister(struct power_supply *psy)
 {
 	WARN_ON(atomic_dec_return(&psy->use_cnt));
 	psy->removing = true;
+
+	/*
+	 * use_cnt is now zero, so no new ->external_power_changed() call can
+	 * start. Wait for one that is already running: it may be a *supplier's*
+	 * changed_work, which cancel_work_sync() below does not cover, and it
+	 * may still dereference driver data that the caller is about to free.
+	 */
+	down_write(&psy->epc_sem);
+	up_write(&psy->epc_sem);
+
 	cancel_work_sync(&psy->changed_work);
 	cancel_delayed_work_sync(&psy->deferred_register_work);
 	sysfs_remove_link(&psy->dev.kobj, "powers");
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e749d2189335..6a8c4b140a9c 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -351,6 +351,15 @@ struct power_supply {
 	bool removing;
 	atomic_t use_cnt;
 	struct power_supply_battery_info *battery_info;
+	/*
+	 * Held for read while ->external_power_changed() runs, and for write by
+	 * power_supply_unregister() so that it waits for an in-flight callback
+	 * to finish. Without this a driver's data, typically devm-allocated on
+	 * its own device, can be freed while the callback is still using it.
+	 * Must not be shared with extensions_sem: callbacks may read their own
+	 * properties, which takes that one for read.
+	 */
+	struct rw_semaphore epc_sem;
 	struct rw_semaphore extensions_sem; /* protects "extensions" */
 	struct list_head extensions;
 #ifdef CONFIG_THERMAL

-- 
2.54.0


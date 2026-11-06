Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942493;
	b=ZYt4FaUO7dVqREkx+A77QYWqJfKcpa+u4xXM8Mbp7mjWwuQ0l/CTbYhfpbnIGDHTbg+l
	 zvu9u09BSgQ9N5ZJc+AmCPHp3GVNqSlJ/s3tPMHMIFyUBmLQupddxjyHna7+RmY9gxvIx
	 4TewEfisKNtsAGoAslrfQnS6W9+A2XtTjAtMxlMvZQVxKeAaDK5HS8spieBEfNsLlcOAm
	 4UWUobSNxZmi0vrFsw5YQ5og/drp83/y0rQhtqBKUmcKRwKTSPkGySuKPgVx3YlUrdENS
	 l9KkiYp2KndNiU2DjS3Q+9lL86pLRxOHvrO8ahmer75KNBoBUIrxUyp9OeZkSrFaaSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N1u821A4KIwQB9OeDGNSa874HBrPBVuuOBBXo5yucbQ=;
	b=YRoRz1oAhLYBRNRo9thPjqIcpgeqGnX7noYc4SyFXkHsyBlgpEk1PgsyBrC5E1I8rTId
	 iYKx2R6o5UahBvTG+fbKsQf/T2tAl9hDRl5Aj68YkG3GkD8h2OPFvWMYbqGUhPT6Ui8f3
	 MwVgDI26appUfmk1wSAqPqXWh6iOSnoFBDpYbal2TgkVhJ7ZBVkuIyBACAt9mzZup1Co5
	 drCVvINet3oEcPKxoQ2EyiJdBMrKOdmRyLbW3n2kPlZuMA7FLDuP39qBQtGXTnfGUcTew
	 vvBzze332xWkruXTmgpPXtBQDCfsj6TgvZN6PU3DbBZocvvufzuG3szBJ3tnn3wX6Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xbxPQuVI;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0C606A31B
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 05:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B0C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xbxPQuVI
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-19305bcb72cso262079c88.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 21:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793942492; x=1794547292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N1u821A4KIwQB9OeDGNSa874HBrPBVuuOBBXo5yucbQ=;
        b=xbxPQuVITKyj+xCm+P8jesjnI8ewU78j9O+4nQWHT51csxaEf+db0YTOTFJVH1zLme
         tm/+21qmLBTvhvso+bJYM7g3c2ljXeV38agRiWC+fVChqYXWveQD8a75z97oHDAbQZmq
         bOr6OFX6rRF1bM+Skl5cMLxrTFd1H9D7eBd4m0wP1Fx9711QG1GItQOoPEd37iwpT7X/
         AzdQUjiSGSRyEc5/iu+An+lhOG/vflQzBSf7CDeo/hTSdUDpr48bn5ueSzfviX3yXpRP
         VJVM2CkSjBA5/Vtivh05p+R/YBlkGcW94mEwqB6B68G4tAiLo1t8lqK3oCYw5djK9zPN
         jfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793942492; x=1794547292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1u821A4KIwQB9OeDGNSa874HBrPBVuuOBBXo5yucbQ=;
        b=QXv64l6SJ9YPJCnQIhzfYz8CnIGhd0n+QaV57XX0dF8M1503lYlRkD21Jihy4c1F5P
         5d6eSAahMHDC3vqxwVgH56GERzatXZiZlQimINvDQHoz26OlYfcr8ni2UPBTNIHC0qvy
         ZjpjjrNRdpVdvVDraqsuamHvt9Udf9kAOw2ftvAzPqXQf1AH6J4dYZFvZGFCLoB00csr
         cTeDboCzRvqbFQ8z0j9/apcQxtiZ7WP6grjdJ5JCRfAhXes2u5tsQNRBr9tXqSVbH/KF
         eIURIRLPY9pSYPut5xtq0w+46uSB2+wF0sxz6jb87hrRfelzq7Ak2/8qIcT2SiXe3vB/
         hW8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzGE22tfxZ39nnUMAnOU8CxNSt3xL3GSJm8HbQduqhJcXW+WKwBhxGbTBckR8TNU5vcu+mpsS/1Nw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/n0ewjLYgKsJ2uWWOmHxIRxGvgJOBXzXHiUSxr0veV9mqm6Qib
	wLOug0YwND4QqJhXmgGQA0BG/KhRJhLupKlo1Ot90Dr+KfXZMS1lPFFde4ebM2tT4sHvRA==
X-Gm-Gg: AYBFou04XXJPWAdZWhnDdIijJeZ3AqlgKYBskkR79NUe4H2i6FZfkk1VoqjlB3sgsQl
	ffTQTnBK71/j0uggmnTa62TUtFHb47Jr9seM/lZLnmzq3OI9DxYjbjbeKCb10mArM+cqKD5qEMF
	ZjtgAgOUv2urgIxhleJsvI0CWMM0uOdpMVoqQA9Q/nF99ZXaS2xfEMXUIxLCDvtlT4lLmaBoWWX
	kEpYMWY/B4Z8PfY+n01Wo0vUURfE2vxZwC+l3wKjRYKkqDzwAdB3eg76cH/GCN7iDTRIOcH8+3q
	8tr34X6Fw5VOYkWWVpWzRr9m07vW6l/lmg7Gcv/Rg22knU0t0pdbKhHjf5jwnezlIFPrq0rx5ZI
	RnvwLhPs5m6XAPHW/QObJqwYgHLi8wONN4RMWRmpVyWwc4L1NzlragEVkYy6NGcivIWNDcXobjr
	gTfUGbzxQwhPgrWmdSJO/OEdoz3qhrFZ+mLFwSmpPFD7h6p9PXeuOelqCIMFXOniJxYfaUk33wg
	MMMrnVHrazOpTq5yPGrdZ8CM+4fHPjz5hgv0V6dMugvzhIbxG5A390OOv3yXtgOHWX9F2qtnLcL
	yb5mUhRjfs2g+Xf0wBfb2ClPxj+a9eEeiM0D14730bbMjL53/DpjoWL0VDh4kCuLo33bnvXa7S6
	s+4MbUhGDCFLKD+oHlRFJsrecog40Pcmpt4MjgfVNiVUFIiXC4uRqpEkbtBD8pRQLXTTL
X-Received: by 2002:a05:701b:2719:b0:136:b50c:c0e9 with SMTP id a92af1059eb24-1b25d309c43mr1672095c88.21.1793942492079;
        Thu, 05 Nov 2026 21:21:32 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:1602:ecff:fe49:38a8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e261962sm3495639c88.0.2026.11.05.21.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:21:31 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: sre@kernel.org
Cc: hansg@kernel.org,
	marex@denx.de,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] power: supply: bq25890: cancel the pump work before the supply is unregistered
Date: Fri,  6 Nov 2026 13:21:00 +0800
Message-Id: <20261106052100.1203225-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bq25890_pump_express_work() ends with power_supply_changed(bq->charger).
The work is initialized in probe and its only cancellation is a devres
action registered before devm_power_supply_register().  Devres actions
run in reverse order, so on driver detach the power supply is
unregistered and freed first and the work is cancelled afterwards.  A
work item that is still running at that point calls
power_supply_changed() on the freed supply.

Switch to devm_delayed_work_autocancel(), which initializes the work and
registers its cancellation, and keep both early in probe.  Because the
action is registered before devm_power_supply_register(), it runs after
the power supply has been unregistered.  At that point the power supply
core has set ->removing under epc_sem and serialized with in-flight
external_power_changed() callbacks, so no new work can be queued and the
cancellation is final.

Cancelling the work twice is not enough by itself: a supplier callback
can queue it again between the first cancellation and the power supply
unregistration, and if the teardown then takes longer than the five
second work delay, the work starts before the supply is gone and
finishes after it has been freed.  Add a teardown fence that serializes
the queueing decision with stopping:

- bq25890_stop_pump_work() sets pump_stopping under pump_lock and then
  calls cancel_delayed_work_sync().  A supplier callback holds the same
  lock around its check and queue_delayed_work(), so it either queues
  before the flag is set (and is caught by the cancellation) or sees
  the flag and does not queue at all.
- bq25890_remove() calls the stop function before devres, draining a
  work that is already running while the supply is still registered.
- A devres action registered after the power supply covers probe
  failures, which do not run bq25890_remove().

Initializing the work before the supply is registered also prevents a
supplier-change callback from queueing an uninitialized work.

The explicit cancellation in bq25890_non_devm_cleanup() is removed; the
managed action and the fence replace it.

This issue was investigated and the fix was developed with AI
assistance (ZCode/GLM-4).

Testing with QEMU and KASAN (lockdep and CONFIG_DEBUG_ATOMIC_SLEEP
enabled in the test kernel), using a simulated I2C device, the real
driver and a fake DCP supplier:

- Unmodified driver, pump work running when the device is unregistered:
  46 slab-use-after-free reports per run in power_supply_changed()
  called from bq25890_pump_express_work().
- Normal unload after the work has finished: no report.
- Work running at unload: bq25890_remove() drains it before devres; the
  work's power_supply_changed() completes while the supply is still
  registered and the teardown reports nothing.
- Probe failure after the supply was registered: the supplier storm
  queues the work 160 times during a widened window before the failing
  IRQ request; the devres stop action cancels it before the supply is
  unregistered, and no report appears after the five second delay.
- Requeue window with a six second (longer than the five second work
  delay) teardown: the fence is set before power_supply_unregister()
  and the supplier storm queues the work zero times.  Without the fence
  the same run queues the work and produces 14 slab-use-after-free
  reports in the running work after the supply is freed.  With the
  fence, no report appears after waiting six seconds.

Fixes: a7aaa80098d5b7608 ("power: supply: bq25890: Ensure pump_express_work is cancelled on remove")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Changes since v1:
- Use devm_delayed_work_autocancel() as suggested by Sebastian Reichel.
- Remove the explicit INIT_DELAYED_WORK(); the helper initializes the
  work.
- Register a teardown stop action after power_supply registration so it
  runs before power_supply teardown, and call the same stop function
  from bq25890_remove().
- Serialize the supplier callback's queueing decision with the stop flag
  under a spinlock, so work requeued before unregistration is either
  cancelled or never queued.  A delayed work that is already running is
  drained before the supply is unregistered.
- Drop the cancellation from bq25890_non_devm_cleanup().
- Revalidate normal removal, running work, probe failure and a six
  second requeue window with KASAN, lockdep and
  CONFIG_DEBUG_ATOMIC_SLEEP.
v1: https://lore.kernel.org/r/179378565123.72475.2497991563887142080@gmail.com/
---
 drivers/power/supply/bq25890_charger.c | 73 +++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f7510ada6b734..f6ed7c137125b 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/usb/phy.h>
 
 #include <linux/acpi.h>
@@ -117,6 +118,8 @@ struct bq25890_device {
 	struct notifier_block usb_nb;
 	struct work_struct usb_work;
 	struct delayed_work pump_express_work;
+	spinlock_t pump_lock; /* serializes pump_stopping with work queueing */
+	bool pump_stopping;
 	unsigned long usb_event;
 
 	struct regmap *rmap;
@@ -760,9 +763,14 @@ static void bq25890_charger_external_power_changed(struct power_supply *psy)
 	case POWER_SUPPLY_USB_TYPE_DCP:
 		input_current_limit = bq25890_charger_get_scaled_iinlim_regval(bq, 2000000);
 		if (bq->pump_express_vbus_max) {
-			queue_delayed_work(system_power_efficient_wq,
-					   &bq->pump_express_work,
-					   PUMP_EXPRESS_START_DELAY);
+			unsigned long flags;
+
+			spin_lock_irqsave(&bq->pump_lock, flags);
+			if (!bq->pump_stopping)
+				queue_delayed_work(system_power_efficient_wq,
+						   &bq->pump_express_work,
+						   PUMP_EXPRESS_START_DELAY);
+			spin_unlock_irqrestore(&bq->pump_lock, flags);
 		}
 		break;
 	case POWER_SUPPLY_USB_TYPE_CDP:
@@ -1446,11 +1454,27 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 	return 0;
 }
 
-static void bq25890_non_devm_cleanup(void *data)
+static void bq25890_stop_pump_work(void *data)
 {
 	struct bq25890_device *bq = data;
+	unsigned long flags;
+
+	/*
+	 * Publish the stop state under the same lock that protects the
+	 * queueing decision, so a supplier callback either queues before
+	 * the flag is set (and is caught by the cancellation below) or
+	 * observes the flag and does not queue at all.
+	 */
+	spin_lock_irqsave(&bq->pump_lock, flags);
+	bq->pump_stopping = true;
+	spin_unlock_irqrestore(&bq->pump_lock, flags);
 
 	cancel_delayed_work_sync(&bq->pump_express_work);
+}
+
+static void bq25890_non_devm_cleanup(void *data)
+{
+	struct bq25890_device *bq = data;
 
 	if (bq->id >= 0) {
 		mutex_lock(&bq25890_id_mutex);
@@ -1474,7 +1498,22 @@ static int bq25890_probe(struct i2c_client *client)
 	bq->id = -1;
 
 	mutex_init(&bq->lock);
-	INIT_DELAYED_WORK(&bq->pump_express_work, bq25890_pump_express_work);
+	spin_lock_init(&bq->pump_lock);
+
+	/*
+	 * Initialize the work and register its cancellation before the
+	 * power supply is registered: an external_power_changed()
+	 * callback could otherwise queue an uninitialized work.  The
+	 * devres action is registered before devm_power_supply_register(),
+	 * so it runs after the supply has been unregistered.  By then
+	 * power_supply_unregister() has set ->removing under epc_sem and
+	 * serialized with in-flight external_power_changed() callbacks,
+	 * so no new work can be queued and this cancellation is final.
+	 */
+	ret = devm_delayed_work_autocancel(dev, &bq->pump_express_work,
+					   bq25890_pump_express_work);
+	if (ret)
+		return ret;
 
 	bq->rmap = devm_regmap_init_i2c(client, &bq25890_regmap_config);
 	if (IS_ERR(bq->rmap))
@@ -1517,7 +1556,10 @@ static int bq25890_probe(struct i2c_client *client)
 
 	/*
 	 * This must be before bq25890_power_supply_init(), so that it runs
-	 * after devm unregisters the power_supply.
+	 * after devm unregisters the power_supply.  The delayed work is
+	 * stopped by the teardown fence registered below and by
+	 * bq25890_remove(); the managed action registered above is the
+	 * final cleanup.
 	 */
 	ret = devm_add_action_or_reset(dev, bq25890_non_devm_cleanup, bq);
 	if (ret)
@@ -1531,6 +1573,16 @@ static int bq25890_probe(struct i2c_client *client)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "registering power supply\n");
 
+	/*
+	 * Register the teardown fence after the supply: this action runs
+	 * before devm unregisters the power supply, on normal removal and
+	 * on probe failure, so supplier callbacks cannot queue the work
+	 * once the supply is being torn down.
+	 */
+	ret = devm_add_action_or_reset(dev, bq25890_stop_pump_work, bq);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					bq25890_irq_handler_thread,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
@@ -1551,6 +1603,15 @@ static void bq25890_remove(struct i2c_client *client)
 {
 	struct bq25890_device *bq = i2c_get_clientdata(client);
 
+	/*
+	 * devres runs after this callback returns, so a pump work that is
+	 * still running when power_supply_unregister() executes would call
+	 * power_supply_changed() on the freed supply.  Stop and drain it
+	 * while the supply is still registered; the fence also prevents
+	 * supplier callbacks from queueing it again.
+	 */
+	bq25890_stop_pump_work(bq);
+
 	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
 		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
 		cancel_work_sync(&bq->usb_work);
-- 
2.34.1


Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924845516F
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170811; cv=none; b=WR/wC9/fzNu0YVFO1pDMnKsxeKqp7cEcPaxMKD/rNZ8eRtlHKd+HiSl6hui7k5HFtOIFtzbgJgEbdUb8jynNXwOnb3Q4kf8Hz6EIron4OIZiTxliiwv4yon7NFpOC51CeZj+hmmKpkmz4bbUq3O+voKvb5Ss4JakEo5G9eEn1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170811; c=relaxed/simple;
	bh=/1AnwZpesUmA5f3rZ2CmDEtDQnHai+DH/01B5wkGwtA=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:MIME-Version; b=PO2CwlL8nsO4i77XiuxP49XbfasZOw1H8XbY60UaAXPrRBlKIvgvWUqe4HDoIlxKjPnw4uOczXTJduY3Rts71s/W34bSBfp93Rx9evecuxmfdFlTzgoJgqULlp0iTAuvJudCh1oSpstvkywXTjJvolE/iBr1T1//jQJWQwuCiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FmKtJ9qL; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FmKtJ9qL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792170801; bh=sqrhZZRSmVjw6I7M464sWr481/rGqdA68BXL2BDi380=;
	h=From:To:Cc:Subject;
	b=FmKtJ9qLwH6VLVYSLaQMVVdvy5lVmDjZGYTsmDjSbqrcpYQW/RPL4GToQoNtmCEHN
	 9UOGmqloyXjAPPZXoto4EYcUq1dpgBunKaGqrdwcbWRMUSzRu/3p/Bzz7vw6xpUVfB
	 gLP/cdWIEe9ozKkS+CO129qbp4PMRP+QvMJWPp3M=
Received: from [127.0.0.1] ([2409:8d5c:c30:3b3:3535:7b1a:7bbe:6767])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 3538E6C0; Sat, 17 Oct 2026 01:13:19 +0800
X-QQ-mid: xmsmtpt1792170799tbbdb0nmk
Message-ID: <tencent_8258FA5B59F3058B3D0A31E1D31A92CB9706@qq.com>
X-QQ-XMAILINFO: NBMltDMjH0L11Ub2EGreqARhqakqaqDQgfBs+BUC2CX07ixmzgwYodX+vQXHaw
	 qofovjz+trwsGGdvduTXcPK5J7F67BDrcat1Fgu0OrMNGmtZPbhT1pHhFZLOhBxMgjZNkhFhQY3C
	 mqfiNYooYPirzajV60zYoj9mCXZDvyGfXmUkSKthiY7L/drMQkxQjGhaFKwVzqWB33BLRr9yRiXz
	 zAyerP6sMRgiT6yrldKEySxNakyzqA4eH2gpPz8Zf8FahZrh3Qiy+KPBeYiPBesD0Czc6qklQ9xE
	 1H+OmncZuGCIMeY+ne3Z9aKAy7fNG2NbXDWIDw4DLPXGltNFQzBEaWCYZeRd8zvMrnnSxEoON8hR
	 mzfda6e9bCN+vZ4kL7bOuFEaqvADIphKoB4LxJdMHpKpmFqQ78vae/xeh0JORNBAOdZa9IdRGI7g
	 y3BMWahEGb33erG1aMqCADXnaHeks1vKLMG9sq9dIXD5kc/ld1cKhbnamtsLw9f8WP945slIoo2H
	 igNc/bjFhUHMWL/pMPXsOlR+DwYQ7xq8cVRPldFjEjQASpiASsF6twbQ3WfZ3+uM5acx7hGETEyT
	 NEzEnl/ImQBGbOrNwAZNdiTwJZDgnx5co+FkvP3WUAHqTZeoktyV5ZQJvG4aW580HI2Ov65HgJ0V
	 Cyp7jRDEDKYFNohpjTg7ML+z1eMydFw55KiHhoc24DGdjmvObARK60oxAOzLaL2EuyqMOcjXBPWK
	 HX61PClj7tW0l/PfkW1eDzwGoMzz0QcEHC11uhipfLp/uDqfW8aGz9jWOQcWXHEYNbEtDx65zTqU
	 dCw+bD2dvg2eVe98nZZ2QKf0TVN8wWFRhM4fgQRMUT7mvUeowj8dCWqXkmtAb1pUrfqKghc8IK0g
	 2XyOAbA/kGy+33taebHVJSIaoLzh+Wfsyb+ZBXHbuIMNESvF4oTOZPEztDcN+YBFDNEX4TCV+lGV
	 0fDk7VX7Ad8hbP3V8Z5f4uk/WY4wcOz3fI77JmsIpYhRdQCPv8NEFovEha2nus744yVA1ReYjFNS
	 yZs2D3hJTKo6HwLRPDcqn+pDQm882eGIXly0FN7uJ2eaCKM/an8IrLR0+DYvstsa1JL+N2AglHjS
	 bTCC8dfe124vmnox7+E5omJ6X7gRX+/5n2/lmU6ba54YMcHvJlX9gyo25WypyNrAvxDrvNhH049X
	 aUYqc=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Hang Nan <2122295973@qq.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org
Subject: [PATCH] power_supply: serialize property access with unregister
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: bulk
X-Mailer: git send-email style plain-text report

power_supply: check ->removing under ->epc_sem on the property paths

This report was produced with the help of AI tooling, so per
Documentation/process/security-bugs.rst I am reporting it publicly; the
reproducer is not attached and is available on request.

1. Affected version
   Mainline, i.e. after 5b4bd13e055 ("power: supply: core: prevent
   unregistering a power supply while a callback runs", 2026-09-10) made
   power_supply_external_power_changed() take ->epc_sem for read and check
   ->removing.  __power_supply_get_property() and
   __power_supply_set_property() still only test atomic_read(&psy->use_cnt).
   Verified again on the current tip 90201351a86 (2026-10-16): ->epc_sem is
   only taken in external_power_changed()/init/unregister, and the file is
   byte-identical to v7.3-rc7.

2. The problem
   As the comment that was added to power_supply_external_power_changed()
   says, the use_cnt check "only tells us the supply was still there when we
   looked, not that it still is by the time the callback dereferences its
   driver data".  That is equally true for the property accessors: they never
   look at ->removing, so an access that starts just before
   power_supply_unregister() runs still reaches the driver after
   device_unregister() released the supply (the supply itself is kfree()d in
   power_supply_dev_release(), reached through device_unregister()).

   Measured with a small out-of-tree module on v7.3-rc7: the module registers a
   supply whose ->get_property caches its drv_data pointer and then sleeps
   300 ms, while the module's main thread calls power_supply_unregister() and
   then kfree()s that drv_data.

       unpatched:  unregister() returns after       78 us
                   callback then reads drv_data   0x6b6b6b6b  (slub poison)
                   => the driver callback read freed memory

       patched:    unregister() returns after   302549 us  (the 300 ms callback)
                   callback then reads drv_data   0x12345678  (intact)
                   => power_supply_unregister() waits for the in-flight callback

   A second harness (take an extra reference with power_supply_get_by_name() so
   the object survives unregister(), then call the exported entry points) shows
   that after unregister() the non-_direct entry points no longer dispatch into
   the driver:

       power_supply_get_property()           -19 (-ENODEV), callback not entered
       power_supply_set_property()           -19 (-ENODEV), callback not entered
       power_supply_get_property_direct()      0           (dispatches, by design)

   A KASAN kernel reports the same window with the access stack inside
   power_supply_core.c:

       BUG: KASAN: slab-use-after-free in __power_supply_get_property
       Freed by ... kfree / power_supply_dev_release / device_unregister /
       power_supply_unregister

3. Triggering conditions and scope
   - needs a caller that reads a supply's properties concurrently with its
     removal.  Such callers exist in-tree and they go through
     power_supply_get_property_from_supplier() ->
     __power_supply_get_supplier_property() -> power_supply_get_property()
     (core.c): e.g. bq24190_input_current_limit_work()
     (drivers/power/supply/bq24190_charger.c:1429/1437), and likewise
     bq257xx_charger.c, max17040_battery.c, rt5033_battery.c.  The context
     matters: when the read happens inside the supplier's own changed_work
     (bq25890_charger_external_power_changed(), bq25890_charger.c:744/753),
     power_supply_unregister() already covers it with
     cancel_work_sync(&psy->changed_work) - both with and without this patch
     that path serializes.  The unprotected case is a reader in the consumer's
     own work/IRQ/notifier context, which cancel_work_sync() cannot see;
   - measured on v7.3-rc7 with a two-supply harness (a supplier and a consumer
     supply that reads the supplier's property through exactly the API chain
     above, from the consumer's own work):
       unpatched: power_supply_unregister() of the supplier returned after
                  112 ms, while the property callback (300 ms) was still
                  running; the callback then read 0x6b6b6b6b from the freed
                  driver data (slub_debug=FZPU poison), i.e. the data was freed
                  while the callback was still using it;
       patched:   power_supply_unregister() returned after 304.8 ms, i.e. only
                  after the callback had finished, and the callback read
                  intact data;
   - the harness is an out-of-tree module (the in-tree timing was not
     reproduced on real hardware), so I am reporting the API contract bug with
     an in-tree caller path plus a measured window, not an end-to-end exploit.

4. Reproducer
   Available on request (the module plus the two harnesses described above).

5. Proposed fix
   Take ->epc_sem for read across the whole dispatch in the two exported
   wrappers, against the write side power_supply_unregister() already takes
   while publishing ->removing, and refuse the access once ->removing is set.
   The lock must be taken in the wrappers and not in the __ helpers: guard()
   is scoped to its enclosing block and the ->desc->get_property() call sits
   after the extensions block.  The _direct() variants stay lockless
   intentionally, for the same reason they avoid ->extensions_sem.


--- git format-patch output ---
(format-patch 信封的 From/Date 行已删去；下方即为补丁正文：提交信息 + diff)
Subject: [PATCH] power_supply: serialize property access with unregister

__power_supply_get_property() and __power_supply_set_property() only test
atomic_read(&psy->use_cnt) before they dispatch into the driver.  As the
comment of the ->external_power_changed() fix puts it, that check only
tells us that the supply was still there when we looked, not that it still
is by the time the callback dereferences its driver data; ->removing is
never consulted on these two paths, so an access that starts just before
power_supply_unregister() runs can still reach the driver after
device_unregister() released the supply:

  BUG: KASAN: slab-use-after-free in __power_supply_get_property
  Read of size 4 at addr fff888002ddf3a8 by task ...:
  Freed by task ...:
   kfree
   power_supply_dev_release
   device_unregister
   power_supply_unregister
  Call Trace:
   __power_supply_get_property
   power_supply_get_property

The check-then-use shape comes from power_supply_get_property() and
power_supply_set_property() as added in bc1540561c9e, whose message says
that the API "along with atomic usage counter adds a safe way of accessing
a power supply from another driver" when it is unregistered concurrently,
and that a follow-up ownership change was "still needed to fully fix race
conditions in accessing freed power supply".  That follow-up, 297d716f6260
("power_supply: Change ownership from driver to core"), is what made
power_supply_unregister() release the supply through device_unregister(),
so these two paths have relied on the use_cnt check alone ever since.

Extend the lock that was introduced for ->external_power_changed(): hold
->epc_sem for read across the whole dispatch in the two exported entry
points, against the write side that power_supply_unregister() already
takes while it publishes ->removing, and refuse the access once ->removing
is set.

The lock is taken in power_supply_get_property() and
power_supply_set_property(), not in the __ helpers, so that the _direct()
variants stay lockless for the same reason they avoid ->extensions_sem: a
caller that has to read its own supply from within a callback uses those,
and rwsem read locking is not recursive once a writer is waiting.

Tested on v7.3-rc7 with two out-of-tree harnesses: with the patch applied
power_supply_unregister() waits for an in-flight ->get_property() to finish
(302 ms instead of 78 us for a callback that sleeps 300 ms), and the driver
callback then reads intact driver data instead of the freed object; after
unregister() the two non-_direct entry points return -ENODEV without
reaching the driver.

Fixes: bc1540561c9e ("power_supply: Add API for safe access of power supply function attrs")
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 drivers/power/supply/power_supply_core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 127978564..17cb40959 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1422,6 +1422,24 @@ static int __power_supply_get_property(struct power_supply *psy, enum power_supp
 int power_supply_get_property(struct power_supply *psy, enum power_supply_property psp,
 			      union power_supply_propval *val)
 {
+	/*
+	 * Keep power_supply_unregister() from returning, and thus from letting
+	 * the driver's data be freed, while the callback runs.  The ->removing
+	 * check has to happen under the lock: on its own, just like the
+	 * use_cnt check in the helper, it only tells us the supply was still
+	 * there when we looked, not that it still is by the time the callback
+	 * dereferences its driver data.
+	 *
+	 * Taken in the wrappers rather than in the helper so that the _direct()
+	 * variants stay lockless: a caller that has to read its own supply from
+	 * within a callback uses those, and rwsem read locking is not recursive
+	 * once a writer is waiting.
+	 */
+	guard(rwsem_read)(&psy->epc_sem);
+
+	if (psy->removing)
+		return -ENODEV;
+
 	return __power_supply_get_property(psy, psp, val, true);
 }
 EXPORT_SYMBOL_GPL(power_supply_get_property);
@@ -1479,6 +1497,12 @@ static int __power_supply_set_property(struct power_supply *psy, enum power_supp
 int power_supply_set_property(struct power_supply *psy, enum power_supply_property psp,
 			      const union power_supply_propval *val)
 {
+	/* Same reasoning as in power_supply_get_property() above. */
+	guard(rwsem_read)(&psy->epc_sem);
+
+	if (psy->removing)
+		return -ENODEV;
+
 	return __power_supply_set_property(psy, psp, val, true);
 }
 EXPORT_SYMBOL_GPL(power_supply_set_property);
-- 
2.47.3


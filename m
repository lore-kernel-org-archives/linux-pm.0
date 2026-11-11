Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361952;
	b=1Vn+N3InYcHH9vyRmcl8UQBQUY7Ub+IEH+Il4V4alrqrgDIGZtZZOFSfdoMTwCqAh7+x
	 A8ORms74PXzbdFzaesOG/dAKvOU41oXplEa3S6wrylUQCWSsXkjof4cZkVoX/zakFOS6i
	 DletTSlVOcPwnuLfqSOwH0dH6i+OJf/6hIB77Xx44JjM2ohl/zNiEWr0njfQA5YZtYnVY
	 h1DzHtP6exsknhvl+myk9nTWzSIhCpGIwEnpvTRkpWI78Fy2ydXD1Ivg+A78oQ+Rk55LN
	 h5iw2feyy8p1ZnM5sMMxh+TE9Yh2n19JxkKifmgu0SDf44n6WqtHkmNofMat9KwqLPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=FrE2nxcQRZH8WQUmYcabDKCJom3Cf8QMuXcnvRuyIOE=;
	b=dZUn/tkU9xRUjDeZ43x0gJON8uR6Ta3YkjFkPd2FP9Fc9N10DwPhd75jcIKvg5UI6sL1
	 itsft+qDQqlIS0emPsPbTfcg16fLCGqYD3Vh1Vvzcj4uB76+CDxt0XPG+EjsOyun6wnez
	 ElJLztW10sZ8++UzJC+SsZZonA4KzixaSbmEUW+/ccdJRZOZlktWwK8BIFsrt8EfJPEWf
	 v/04Z+qdiRcj64MjY60S1CWaHl3QzfT97uh4FqMFz1B9OdP2kvK96ecoYftF1FSC0eJP3
	 BDGORbgDbx4GRFwVLBINwQqC0vpwJG1r5gGlUbHoOaHZ82td5P4CAEOB9QiO6crQs9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WswQo9xR;
	arc=none smtp.remote-ip=74.125.231.138
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C71606A320
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 01:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C71606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WswQo9xR
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-85ef6c584b0so1253951a34.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 17:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794361951; x=1794966751; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FrE2nxcQRZH8WQUmYcabDKCJom3Cf8QMuXcnvRuyIOE=;
        b=WswQo9xR6Ay2Ig8PLllXM3nUQg0nuun37Ftz4VjBmkMxrlCeSnOT1Lv/dcBP9mFeKV
         UobcWGLxINwKhMBNJbZRY+CBz4li8gx1oIqkPn2ddyL9d5OcMqjvV8iAEIh1dtsHB2im
         zCNrnG+2BbDgXXMh0B5ASSx16qUjJZoCkP7f0Yb9ZwCbAa599l0d0fXlZMvUkYNK1LVm
         xrVsG8MZAG+7NmkSIwBkjJ5jx9G7+BWqukTjvLnbDaK+L9FhOyxggaPDhfIzHkBsleWg
         KcxYxnV4zgwvpaCrdP2+3xAIsMzsd8OvuYa8BB0v5XxNlTThHpd/FTViGWU7QvPdnqBT
         rAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794361951; x=1794966751;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FrE2nxcQRZH8WQUmYcabDKCJom3Cf8QMuXcnvRuyIOE=;
        b=lwVXRPy1x7/qMV+JppW8imdjmN2D4vuXDDlFkYfojiQ570R5NdYnWCuZXOmw2EOYHf
         M6bPdGBQccyvtxMyRDmjIoKCqoNXUWc3EWTLaF6gef50ZxZMEPpfmCGjowTMPB/gAF2D
         INnd0So1r/4MVwa6LwEa+MWOZc7qvlYBGHSif+IRFS7yEzdOc0BWEQawM0A45XmwkKzb
         LjY96TfbjJd9zJX20w9YWSjGddzC0NHSCL2MMqKMih1xPYvwPcGM9WYDWSqzjCNk/E9E
         eedFQ+2tzqvyEQS3oRJ7rzSMPxRSaam8ufQwraLwksCSl0i0sP/dkq2LvAl4+93I4tRi
         DlKA==
X-Gm-Message-State: APuU4Z/0oDy1n2fVPKZQNf/zSm5LYikffV7uRwT9GViD5ClZ4Al17sRi
	GpqWpE5Mggj7AtpQKFC403ZRap1no21f8L1hdcJwT4UrueP9I+z+Y/jr
X-Gm-Gg: AYBFou2XnAJOH7+F7EHmEAgQhPPooY1gOg21clFjxl9FvjE52fWbKySk6hIZe9hctrJ
	Lel8103QnLX9uKJr4p7Sc3463ZpBhxyWkhWPVu39vnBzX5TxdkayCZHy2vBMTc0tGPOrFA+vy48
	cpB3wQnE8L/Qyy/pOzOk8ErNZP79U/WwHNT1q7lh1UK3hpIGdSyJYWgtLJTJyOutqMmJ6SIn9oB
	QHNymB0h2+8rrHbis9IEW8Gag7aERu3Sk0APOI3tPPxUbpiRdic/x58IRvi1m03GrUukuar3idX
	RBzcFvipmSNJO0+/HWYt2/T5DJ/W5kM7/gs6TAVV5gJ611gxxMBZToMEVkay92D7z8hA3Fh234y
	1B2YFCcubH2je8y/XsJW9G9UyLYWt6TYBY6lER7Qpe3nfrvWaMVSOtYSOlH74pAfv7elpP2CAUO
	gbKN1gpjxZHSglpZRIJPa+sb7913Q848NGD35i2Mm04gorsLNZaP/zcHmhulLWHdf5HSdg3tna/
	eIxP64/SuasmxzdHjUIU1ILxkK69W487hkrKCTXDiTmYn93ld4bUJ1zm7P46tF+npBXDpFwFY62
	TYUbnKBh/h+YH1x7iqN0o1Wh
X-Received: by 2002:a05:6808:124d:b0:568:8130:9c79 with SMTP id 5614622812f47-56b972f7271mr773993b6e.27.1794361951415;
        Tue, 10 Nov 2026 17:52:31 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56906036028sm4008565b6e.11.2026.11.10.17.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:52:30 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 10 Nov 2026 19:52:25 -0600
Subject: [PATCH] power: supply: core: give each supply's epc_sem its own
 lockdep class
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-power-supply-epc-lockdep-key-v1-1-39bd0a237a6c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MUQqDMAwA0KuEfBtoOxTsVcSPEuMWFBtaNifi3
 QXfAd6JVYpKxQgnFvlp1bxhBN8A8idtbyGdMAIGFzrv3Yss71Kofs3Wg8SY1szLJEaLHBTS7Nr
 k+5aZsQG0IrP+n34Yr+sGMGr6W24AAAA=
X-Change-ID: 20261103-power-supply-epc-lockdep-key-2af05a195ccc
To: Sebastian Reichel <sre@kernel.org>, Hang Nan <2122295973@qq.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794361948; l=3715;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=YmCqJjTCZNRzJZ4cgvXeQI2hyXoDjvK2f+9IDcUZq3M=;
 b=DjaOTZWy+pWszEcbPAaGnJQzUHxc4B6gb1op23Bv2YL8XC4xqUX77TV3BcInTxD3mAGSm2xmg
 1EvIRISuGlbDRRCupgVn89LIc7MeYJ8Pdcgk0/KmqdI0aHyER/QaAk8
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

Since commit 9f7f7a859451 ("power_supply: serialize property access with
unregister"), power_supply_get_property() takes the target supply's
epc_sem for read. Every supply's epc_sem is initialised at the same site,
so they all share one lockdep class.

A driver that reads another supply while holding a lock that its
get_property() callback also takes is then reported as a circular
dependency, even though the two semaphores belong to different supplies.
sc27xx_fgu_get_property() does this with data->lock and the charger, and
a fuel gauge driver in preparation did the same with its charger:

  WARNING: possible circular locking dependency detected
  kworker/2:1/60 is trying to acquire lock:
   (mutex_#2){+.+.}-{4:4}, at: mt6397_battery_get_property+0x50/0x23c
  but task is already holding lock:
   (&psy->epc_sem){.+.+}-{4:4}, at: power_supply_get_property+0x34/0x80

Lockdep then turns itself off for the rest of the boot.

Register a lockdep key for each supply, so that only a supply's own epc_sem
is ordered against its own locks.

Fixes: 9f7f7a859451 ("power_supply: serialize property access with unregister")
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Since v7.4-rc1 power_supply_get_property() takes the target supply's
epc_sem, and every supply's epc_sem shares one lockdep class. A driver
that reads another supply under a lock its own get_property() takes is
then reported as a circular dependency, and lockdep switches itself off.

Tested on an MT8173 tablet (Amazon Fire HD 10, 2017) with PROVE_LOCKING:
the report came at boot with a fuel gauge that reads its charger under
its own mutex, and doesn't come with this patch (debug_locks stays 1).
---
 drivers/power/supply/power_supply_core.c | 3 +++
 include/linux/power_supply.h             | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index de15314ef954..76bbe8772143 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1662,6 +1662,7 @@ static void power_supply_dev_release(struct device *dev)
 	struct power_supply *psy = to_power_supply(dev);
 
 	dev_dbg(dev, "%s\n", __func__);
+	lockdep_unregister_key(&psy->epc_key);
 	kfree(psy);
 }
 
@@ -1765,6 +1766,7 @@ __power_supply_register(struct device *parent,
 	if (!psy)
 		return ERR_PTR(-ENOMEM);
 
+	lockdep_register_key(&psy->epc_key);
 	dev = &psy->dev;
 
 	device_initialize(dev);
@@ -1810,6 +1812,7 @@ __power_supply_register(struct device *parent,
 
 	spin_lock_init(&psy->changed_lock);
 	init_rwsem(&psy->epc_sem);
+	lockdep_set_class(&psy->epc_sem, &psy->epc_key);
 	init_rwsem(&psy->extensions_sem);
 	INIT_LIST_HEAD(&psy->extensions);
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index cce61137aef4..3cfe2520862e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -371,8 +371,11 @@ struct power_supply {
 	 * the callback is still using it.
 	 * Must not be shared with extensions_sem: callbacks may read their own
 	 * properties, which takes that one for read.
+	 * Each supply has its own lockdep class: a driver may read another
+	 * supply's properties while holding a lock its own callbacks take.
 	 */
 	struct rw_semaphore epc_sem;
+	struct lock_class_key epc_key;
 	struct rw_semaphore extensions_sem; /* protects "extensions" */
 	struct list_head extensions;
 #ifdef CONFIG_THERMAL

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-power-supply-epc-lockdep-key-2af05a195ccc

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649021;
	b=iMBQRHu+9ncouHIaIgxWtq6nxGPqBoS6Jbe1ZPWnLz5O2lG7cA5wKZtZFATPT4KrQXjh
	 aA9oy+VMZbRfWTGtsuxIuf4eE8x5uRqvrjaReugwIApLvae6DTgYxe2lrVygQwJIWJMWa
	 ThltDRIzCBt0ksmjhg+YZ4FELhTjkhM69IhvpADmdCS1SdpWbE678HxeNyfsapv5bn6iL
	 6nBSCe0evKqJhnO4GefHGMU6n2cXd4B2JraVSJ828eeTTRYmkS1fts8sRRwEVnfNH6CJC
	 gsz0HPW/avIKbqLBxygWBm05picuJrxySCdkRt3MWyW/vYoYOLgYSNMcR3H0CVXKRng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=RwepV34j5nNPfrfrTOoxO68UcVdQ4nwsTdHGe5ShZEI=;
	b=qDFX7wB6MCQ6Gv8Mo8FwYT2yGfTOpKF4rXcMoBBnIErPgCdUGicVsRsSzasw7WuOZEGS
	 yDho3ScEACurOYyFag6ih8+hO7xdS43ICddhrzzM0Z+nreu81bZM1+KnOuTnY6on4jVq3
	 jRQwv0eOs95DGLwrQ8Hb7Nb1ZU+APvI0qvYqWToEsrngkrUtd0LfyyKYwwRFA0MWKQtHF
	 tAHNkSClLuXHt/7tL4qoM/b2/7mpN3cmSeaCPgd0keeGP79InVe/+Kjd4FZ1w6b4Rn4Y+
	 sDY6dJGm4ZITYYEkPLJJZDmi1H9BLsGzsk9DWYflE4X1NQva5vo9RCJepcfuGdsaiJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4TtAVd0;
	arc=none smtp.remote-ip=74.125.231.203
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86AA606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 23:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86AA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4TtAVd0
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-56820670d00so2154094b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649020; x=1796253820; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RwepV34j5nNPfrfrTOoxO68UcVdQ4nwsTdHGe5ShZEI=;
        b=k4TtAVd0Q5yeT53kuCv2tVlWnh7TyZgeD7vMYoZbEGHgEFe5HK2S7Hl9ez0W15w8ep
         eCOF/X4FRwK3lEeGPWNf6OE1jFA9Z6tpfG71FHX+++Ckk5ihwMtGuf4z3h4LzDxRgUdB
         Mh5RbVda0NnYuq188GEAtRtOREIEcUBZ9Z/jvLFE7ame7Lno4ARV2MjM69lUj69NM5Br
         oxsNe3eYjdFmGEF5uupC+JtWg11BOfqYLk2zqHhobq34DvNUyoyD8oK+/IZjF+ycHGXu
         qDDo4A+xa2JiEqKsMPambU8FHltgC557iziezI0LIsaviEqu7TG1JuxigEx5GSx2HkVH
         qriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649020; x=1796253820;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RwepV34j5nNPfrfrTOoxO68UcVdQ4nwsTdHGe5ShZEI=;
        b=Yx86Pc6IitDlV0DO8dika9c4nQ2OYgn11IUqyuTcZJ5XnkydwYpZYo1BAodcR8j1Yu
         Rupvx1hv2p7CLKKRmxvN372is77pIde6mCw6LtZL7xDBG6kqG5FmkumcHh3oKaj/4zkE
         41c004ByXkze7ssjzzNRl+xUiZhIDvattm24+Bi5bNy2pXXgZMY9s8tXsqt+gptlg3YK
         e5oQGtyGQWOH4wWkLKiXTQxDC4/GIX7I7Ym7KR6Jtd5K1bnNndZ6o7Kzom9cvqx2SAvQ
         EueQDGh+Bxvgm23dIkRO4X8ABz7p0XD12GLrOZtHSDCo1DXwPDOGZ416mPcJD8RE8mLj
         NXCg==
X-Gm-Message-State: APuU4Z8lxi2sS+k22fV5g0Buwyk4/B5AwhuGrS4pQGL5wzICiseMwuqV
	ploEDx9CsbLWRxr3gnjlbTYPUSlD6nSQusCvVThKoffLcBO9vNwiwX7krSo1uZXYGn77nw==
X-Gm-Gg: AZFdTZetmeocQktaW5gsyKsSQougHHU0iBomcWJ62cKP3Gppecxly4/EpInseHFhjhW
	+YEDYCGoKubDYVingm8PjjB0h0fzN9rypX7BfAvFjyZK+gk8atimHFrl8+whsKAi57ii3we3RF1
	Uk9wetG4i0q695OfjZcGW6kRfDVoA0z4zmCE/hQ436zkq/Zw/JJ+lX6DJCD1F62IwC/S/Cveda0
	4OWYEjQJzwrnuwFpyybBhgfWGxE+66bvAGgpjbJ52vFY4zBJzbvarhacMFnHSrvXt02zfobCcdk
	Pc6ZU/JlMtV6nytMw+4PXPEvMjEzqfQ/AA17vFk5lqURHxG+zzYbW2WNK3rK9kJ+ZDp4VdaESd0
	c4sR1E8MLUFAKX9OCnMNvmFagZZkZyrxeUHzcwayMhLDW82Zf1sGwV9yu++PaLuaXaPgpWZbA+b
	2s/WOH4tgan31htj/Co1FOz8UvcqW0DcZIuH7oBqRda9qMvw4KmKepzA+ZyO0bI8ASe4ZTFKR0G
	6BJe9VSo7NdMq/8dmlfCrqJ/gkvGf05w/cDO4tyZGLborn3LvimvsniVeKx8snLK1uYazM0d5VB
	hIoJLo2TxgNKR/SEA4J5DxdGrtbl0T5+Cj4=
X-Received: by 2002:a05:6808:c2bd:b0:571:a186:d6a8 with SMTP id 5614622812f47-57a0a20acc0mr18248900b6e.17.1795649019601;
        Wed, 25 Nov 2026 15:23:39 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35c5ac5dsm15369084b6e.15.2026.11.25.15.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:23:38 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 17:23:22 -0600
Subject: [PATCH RESEND] power: supply: core: give each supply's epc_sem its
 own lockdep class
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
Message-Id: <20261125-power-supply-epc-lockdep-key-v1-1-c8a41b8a4470@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/33NvQ6CMBRA4Vdp7sw1vRAwMDnI6qCjYajlAg0/b
 VpFCeHdTXB3Psn5VgjsDQcoxAqeZxOMnaAQFAnQnZpaRlNDISCWcUYkE3T2zR7Dy7lhQXYaB6v
 7mh32vGCsGpkqylOtNUQCnOfGfPb9Ha7lrbycoYoEdCY8rV92daa9/gCS/4GZkDDJH7VUcXJUm
 T61ozLDQdsRqm3bvkglgnzQAAAA
X-Change-ID: 20261103-power-supply-epc-lockdep-key-2af05a195ccc
To: Sebastian Reichel <sre@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Hang Nan <2122295973@qq.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795649016; l=4188;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=aHS9VlhwbSd4ISaj/nw4cXUIJavrqEgLKdMBe+KGpqo=;
 b=FPlfiH8acOc2+ZC4ConFbGPH/aAReeCpfEAjvRtDpj6DPYrQcOW0W3sBWd1/pZUKK69/r6NZ9
 hVTL0a/0vM/AgTCmKrhODIS5imfYu5uImchQTzMtfiT6hPvC/hzWNYw
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

This is a resend of the 11-10 patch, now also to Sebastian's Collabora
address, which I left off the first time. The code is unchanged, and it
still applies to v7.4-rc4 and to the power-supply for-next branch.

This patch was developed with the help of an LLM coding assistant.
---
Changes in RESEND:
- Added Sebastian's Collabora address; no code change.
- Link to v1: https://lore.kernel.org/r/20261110-power-supply-epc-lockdep-key-v1-1-39bd0a237a6c@gmail.com
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


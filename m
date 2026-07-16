Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A33DA5D1
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195448; cv=pass; b=iAwuNj3cRFLBezM8ueDBc/yNanmBE25r0z6Zm/RoJLa3hCq0OBUoG9Etz+AsbUlhyL39/kULB6JLFf/G9OwENMEN/vivupP+zRDMfZ2zGJ1jk2AVrca1R429Qbkql2vJ6FTHn25AR7uAKL6lgpn9UMIJGU558dxZK8reiOpf5/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195448; c=relaxed/simple;
	bh=4PHDdxADWcJXcHELSsybkbYwxBBaZNxU4xqJtB2mqtY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RQeSL4nZDZM7RdFTe1mV7EwszuKoyXBMk0lAvl8YOt3iKbKX7/ZpzTMRzf/fcHdCSbPDnq/+cE6U/iAvoz31xHJepLnTQdvfb0BLItM8dQJqTRDRnrHLEZc/y2BfiHSVXyLRdZHgVRDfr5Yxt7QqTUuuQ7ASoiebuxUDsqAS29Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mechasystems.com; spf=pass smtp.mailfrom=mechasystems.com; dkim=pass (2048-bit key) header.d=mechasystems.com header.i=@mechasystems.com header.b=jc6YljRp; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mechasystems.com header.i=@mechasystems.com header.b="jc6YljRp"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383adaa461fso2246538a91.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 02:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784195446; cv=none;
        d=google.com; s=arc-20260327;
        b=AxrGXjgP2Y9jCLdbggPbjQpdm5/bdZucYGmOBEv6Ji9CNDbJ9kGF1JbRUInL5dBnh9
         vSAejXDghQEy+lQDmh1brNd/0LY/9Vg3LkTdSCoB5aptYdIWH3iFKhZgdJjwPMgHrY94
         8Rlwbw0D1B7IeTX6VRK6PORJHdoH849Se1xJq5etc1VQjIPF/mw2stcHGkAxDbF/3hu3
         SrX4rsQL8vAQNYsuZtTPY4wQF3HmK384LFdPQOnXHk2/j5Xz8eCygqQsTo7DREDjE51x
         O9I+UrTgMt5km4vMQr7e5H2aW+E7ajzizR62arriL+44viGV+vTFKvzfuC2P0BdG9IwN
         B/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7BnpV4VIJWWIXN3EfRYg7aDjYvj13ejddTvZNuKOsQM=;
        fh=ukEMP+ZEBqqzFNLXVYKiS/LfuNTCMBdbU1TlxB6b9dU=;
        b=XXhD1XgqjEvAFult6nGentZoJqDHgsbv7Xx/uU4TmaePWxBkuccXszPCKuolxpCWFC
         1m5ETaseIZCTGNg4G2DY0KX1LFSDMdbbOvsWtlxy1kp1yiNUEmzJTVYt3qvFlxdhkIkt
         I57WpxCHE1H4g3c27LFXtwDOPUDxZKvLowW9pcniLQOVIz/4FrX07ZTuUW3NN20tv/D1
         62eREbTrPnokrHR/IzR5QLlV0oBQ9EKtIGGHB2clGU61bcBj1uyYgdwoqZO4UPIkJ1Z+
         g0K1ipSw1NEfwVjUGcFQLsjooFGf9+6U5aVkePdf8f8sD8icg7MaSOtdcNDEOJG0K0Sv
         cH4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechasystems.com; s=google; t=1784195446; x=1784800246; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7BnpV4VIJWWIXN3EfRYg7aDjYvj13ejddTvZNuKOsQM=;
        b=jc6YljRpihhinGwjESyROadIBljlKhUGqrIyGX+JCcnTTtykAVWK8zSpLZ/un1EAcY
         hct3IFHN+HylULRsbh6hl5mjWAMUJOU1lYpz8uPIto1Dxt2Kd/YAB8HEKTYdFhcd2dxV
         tcbESNGYaLIzcn0HO3xYm3Lr7LCf+QhxTsd3aw65+YQotqW1qzkf/aIMfhIWazfIeKv9
         FVAYvbN0nglztF/bIas2bxwh2fTDMjsd773Tgh1QdjYUfdl9YSOdQdQRnVqDY7Zsbjf6
         N+s/QPI5BKDkLQhCwwr734p3q7GpxKBjGrUC5cHoJxz5vwjkxDY3sDaAi7X7b6vkmLrM
         BpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784195446; x=1784800246;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7BnpV4VIJWWIXN3EfRYg7aDjYvj13ejddTvZNuKOsQM=;
        b=iyttPb84T4Sr2uAvSm6xXGQqPwVJIZEbLh+I5Dqa/Fc1zVVuDlLazkfQTwk64H8YkH
         5pgzZEB5GZzRm+2E7fKgfiPotoBNOtYWYM+8OFaWqCQbSHaNbAWbs/4ZwW7JnhOApSHx
         CiLaFELnrmM3jm9qpW78AcJzqDLIRPdRRPfGzQut+kgmFH3iq3BJ8hyhNkhJuBWzdXWy
         QJyvb/HeoSuNUUmxOJMXCUuxiFtavcSRiQwglQiQNh/ReKG7VWAp1U6LCx62zR4OhHYf
         LyYdti3e6f3oKF+TD7wRjngTLH3ea8w3Puv7v8hfRC6J60jiVfiFxX6gHoRCRFsxJ1aP
         3TCw==
X-Gm-Message-State: AOJu0Yzg5Svhr4GSFyygtdCHghwDGqC3R+ctUVKUpbIiUxyOlMLz6bxL
	6LugJQcPYyGWiwsIIsExPgsEJbBmvaY+P1TtJxTII17vCKhlgcnMsSDgLG6FmsPm8B83u3YnTwS
	w+1x/5zLXP8AX6yVqCRM7mEpZkkxQqhMqGiYHHpFQ5q5bxEVfJyhwSN4=
X-Gm-Gg: AfdE7cnCkvgFGIu27lL5bhytSOyim0ypCbMCVIuMjSlKxniX2thWJah/9ApS3CmuTxn
	GALUQjah2aBpN8pVzDEKcmPzmqaWUjCsAXVmft4ASQJk1cWsukRYD5MNR4hdZBkydfQ6VdZVcHX
	oT6rNQpmUCdN0Xm5QXP2UpNQ1p98zk542XAfZyQvUaCm7D1BgTXc4sNMSoK7hhYtjedc2bdO66I
	CjJY1OBLwXK3CYGhSNnTL/X5BifpSRpbOlIuBuReXASbUHzj6W7GnzITu6h
X-Received: by 2002:a05:6a20:c989:b0:3c3:94bb:ceb4 with SMTP id
 adf61e73a8af0-3c394bbd078mr1152070637.70.1784195446147; Thu, 16 Jul 2026
 02:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Advait Dhamorikar <advaitd@mechasystems.com>
Date: Thu, 16 Jul 2026 15:20:33 +0530
X-Gm-Features: AUfX_mxWjVGz1D1bqa6lo_mj3pKzEhFiBc4uYqQMLANU_mgqiNhYY5CmMp3yH84
Message-ID: <CAAPs2HTo=4+AEw1+vcU6c9vt_O2BfF+gv3FFvx9G3KLLzCOsHw@mail.gmail.com>
Subject: pmdomain: imx8m[p]-blk-ctrl: resume hangs when waking from suspended state
To: linux-pm@vger.kernel.org, imx@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, ulfh@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	bhushan.shah@machinesoul.in
Content-Type: text/plain; charset="UTF-8"

Hello all,

I'm debugging a suspend/resume issue on an i.MX8MP board, where my board
suspends itself just fine but it gets stuck when I try to resume it using the
SNVS powerkey.

```
[  127.955231] imx-pgc imx-pgc-domain.6: PM: calling
genpd_resume_noirq @ 963, parent: 303a0000.gpc
[  127.966055] imx-pgc imx-pgc-domain.6: PM: genpd_resume_noirq
returned 0 after 3 usecs
[  127.975922] etnaviv-gpu 38008000.gpu: PM: calling
genpd_resume_noirq @ 963, parent: soc@0
[  127.986183] etnaviv-gpu 38008000.gpu: PM: genpd_resume_noirq
returned 0 after 44 usecs
[  127.996201] imx-mipi-csis 32e40000.csi: PM: calling
genpd_resume_noirq @ 963, parent: 32c00000.bus
```

I added some logs inside `imx8m_blk_ctrl_power_on()` in `imx8m-blk-ctrl.c`
as well as in `imx_pgc_power_up` in `gpcv2.c` and have observed that the
problem appears to occur during the first MMIO access to the Media BLK CTRL
during resume.

```
[   65.145718] MMIO: writel complete
[   65.149030] MMIO: reg_write returned
[   65.152617] PGC[gpu2d]: clear PCR -> 0
[   65.156369] PGC[gpu2d]: deassert reset
[   65.160124] PGC[gpu2d]: clk_bulk_disable_unprepare()
[   65.165096] PGC[gpu2d]: ===== power_up success =====
[   65.170067] etnaviv-gpu 38008000.gpu: PM: genpd_resume_noirq
returned 0 after 137496 usecs
[   65.178348] imx-mipi-csis 32e40000.csi: PM: calling
genpd_resume_noirq @ 652, parent: 32c00000.bus
[   65.187316] BLKCTRL[mediablk-mipi-csi2-1]: ===== power_on begin =====
[   65.193762] BLKCTRL[mediablk-mipi-csi2-1]: pm_runtime_get_sync(bus)
[   65.200034] BLKCTRL[mediablk-mipi-csi2-1]: pm_runtime_get_sync(bus) -> 1
[   65.206740] BLKCTRL[mediablk-mipi-csi2-1]: asserting reset
rst_mask=0xc phy_rst=0x10000
[   65.214760] clear BLK_SFT_RSTN begin
[   65.218340] MMIO: readl begin reg=0x0
```

No further messages are printed. The CPU never returns from the
first readl() performed by regmap_clear_bits().

Has anyone observed this behaviour before?

Here are the full suspend/wake logs with PM debug enabled:
https://paste.debian.net/hidden/5b4133dd

Same logs with more verbose info:
https://paste.debian.net/hidden/9f544ae7

Any suggestions on what to investigate next would be greatly appreciated.

Best Regards,
Advait

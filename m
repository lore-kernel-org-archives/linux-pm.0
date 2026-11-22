Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795354682;
	b=3293Hs0DYklOJnOKE/+K11egeW9UG0H6/zfZE348npmUYXw0e8H4JOFUidur3JWg/PcQ
	 OMm8firQqbL4qMdVWf7O6EuIvlNNYlmikTBkVD7dLWX84L5hxWkCIHojQlrFkS4qzmUXD
	 CFYNXJ/HS3jRrmfCLjfZljav+Gffmrl6s0BTp/b6knCkpzfv46AW0eLaby6O6K6DVM2nl
	 8yqmlksDuasnjEAd6Kh7vdLNBpD3wDRAvY+4vl7hfVFq7dmVfbBerPfmE1U5EB8UV4Btn
	 GEy2qrdQFdDmG1qxC9w/zi7mY+seFANsKXD1ViDbD+X4LWcbDM5uLjykuTTPakTpXJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795354682;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=MaLZ/5e/yperaGiOGWV6z+zK2FhbvcWBhbuuohCNTlQ=;
	b=tBtDWLTkBL0x3JZuWedUa2otLJuqE7UyS98tP9J0WLoZu/CVvjd8RA7q4GMfaBX9u0ig
	 KOVCeumgj1btaUHkDkHguSSll0iW0gAHkMrYXBelZBf32EICRBtegMg6BjxXMDsOtBDYb
	 TFKhewx9oJqdEAAl9INeP3Y8dsnfjAkT5L1gTR6AkgaVgP7ODyMmv9qrPn1u+jwOh3p+a
	 FBMvvST+/YMwBJ2vYmmKi/AT7NSIaAs41xAl/7rp1hgEIMFAGcRDtX3wLnSwzCXNXplgk
	 vhY3hAyLcFLHmzq3OD1/+IQK33xiqzB53ySalE8mEUNi5nyjJBeBXB1SJ5f8WAovAfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OTAiH7yl;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40F606A320
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 13:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A40F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OTAiH7yl
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1DBB61A178A;
	Sun, 22 Nov 2026 13:37:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D86E560512;
	Sun, 22 Nov 2026 13:37:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 834F5102F0DBA;
	Sun, 22 Nov 2026 14:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795354673; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=MaLZ/5e/yperaGiOGWV6z+zK2FhbvcWBhbuuohCNTlQ=;
	b=OTAiH7ylWvXXaSMCBYUk3oXEHf74GJpwwQtyHazm4tDKGVHo10dbTK5TvQus76lRYafMRS
	a2CW0F4Hk+WGDNNPjzGCf4l6fPWDDAEtFP0xHap3JrwoAFKXO2qXBPkqzKZbvOE1IrbilP
	uAbIgAKtSG7MO3IuzvMNePc/WdPBsPVbWnQQ1ikX5WwApjEVd1mdHdlr6cjPfJVhhcUIJX
	xhTbJaP/kmapXYZaS54LbyZXn4/ZuMl1GuNn6puJc8q4WpY8w8taX7DCkMrurdqWbRKxO3
	wtkxjnaw2udj1NFl1H5YUfKfBjDZjaVu2P6HKrBkvJx7xXnUjTOvqiZjjzTLmg==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Sun, 22 Nov 2026 14:37:40 +0100
Subject: [PATCH] pmdomain: rockchip: fix warning when deferring probe
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-rockchip-pm-defer-v1-1-5b41635e3410@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0auEWXfAScCFV5EuTDLRUaph0kpBv
 HtTXb7F/wcUVuECnTlAeZci21pBDwNhGtaRUWI12Ma2RNaibmEJk2TML4ycWHGI3jlHLhE1ULu
 snOR7Pfvn7fLxM4f3fwTn+QP6EtXCdQAAAA==
X-Change-ID: 20261122-rockchip-pm-defer-adb33313f110
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

When the PMU probe fails because a clock can't be acquired, the
pm-domains driver raises a warning in kernel logs:

  [...] power-domain: failed to get clk at index 0: -517
  ------------[ cut here ]------------
  WARNING: drivers/clk/clk.c:4831 at __clk_put+0xf8/0x130, CPU#0: swapper/0/1
  Modules linked in:
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.5-00004-g552d0d1e09f2 #103 PREEMPT
  Hardware name: FriendlyElec NanoPi Zero2 (DT)
  pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : __clk_put+0xf8/0x130
  lr : clk_put+0x10/0x20
  sp : ffff80008192b750
  x29: ffff80008192b750 x28: ffff80008147aee0 x27: ffff8000813400bc
  x26: 0000000000000000 x25: ffff800080e5d5c0 x24: ffff00000074f280
  x23: ffff00007fbe6bc8 x22: 0000000000000000 x21: 0000000000000000
  x20: ffff0000004f78b0 x19: fffffffffffffdfb x18: 0000000000000006
  x17: 70203a72656c6c6f x16: 72746e6f632d7265 x15: 0720075207450746
  x14: 07450744075f0745 x13: 0720075207450746 x12: ffff8000816ee830
  x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000816ee830
  x8 : 000000000000005d x7 : 3ffffffffffff000 x6 : ffff800081746830
  x5 : 0000000000017fe8 x4 : 0000000000000000 x3 : ffff0000004f78b0
  x2 : 0000000000000010 x1 : ffff0000004f78c0 x0 : fffffffffffffdfb
  Call trace:
   __clk_put+0xf8/0x130 (P)
   clk_put+0x10/0x20
   clk_bulk_put+0x3c/0x60
   rockchip_pm_add_one_domain+0x298/0x4a0
   rockchip_pm_domain_probe+0xd4/0x310
   platform_probe+0x5c/0xb0
   really_probe+0xc0/0x3e0
   __driver_probe_device+0x164/0x1d0
   driver_probe_device+0xb4/0x120
   __device_attach_driver+0xbc/0x190
   bus_for_each_drv+0x88/0xf0
   __device_attach+0xa0/0x1e0
   device_initial_probe+0x50/0x70
   __bus_probe_device+0x38/0xb0
   bus_probe_device+0x10/0x20
   device_add+0x604/0x850
   of_device_add+0x44/0x60
   of_platform_device_create_pdata+0x94/0x160
   of_platform_bus_create+0x198/0x520
   of_platform_bus_create+0x1f8/0x520
   of_platform_bus_create+0x1f8/0x520
   of_platform_populate+0x58/0x170
   of_platform_default_populate_init+0xe8/0x100
   do_one_initcall+0x60/0x1d0
   kernel_init_freeable+0x204/0x288
   kernel_init+0x2c/0x130
   ret_from_fork+0x10/0x20
  ---[ end trace 0000000000000000 ]---

The warning is due to rockchip_pm_add_one_domain passing pd->num_clks to
clk_bulk_put, but pd->num_clks does not reflect correctly how many
clocks are correctly acquired (it is systematically set to the _known_
number of clocks, before attempting to get them).

Only pass the number of retrieved clocks to clk_bulk_put by setting
pd->num_clks to the number of correctly processed clocks. The value will
be dropped anyway in case of failed probe.

Fixes: d8b384777066 ("pmdomain: rockchip: fix clock leak on domain probe failure")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index e193f978d5f3..adc3bebcd928 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -854,6 +854,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			dev_err(pmu->dev,
 				"%pOFn: failed to get clk at index %d: %d\n",
 				node, i, error);
+			pd->num_clks = i;
 			goto err_put_clocks;
 		}
 	}

---
base-commit: 988117cc1bb17338c586a4e21ade88b5397eac33
change-id: 20261122-rockchip-pm-defer-adb33313f110

Best regards,
--  
Alexis Lothoré <alexis.lothore@bootlin.com>


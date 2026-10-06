Received: from mail.haxxors.com (mail.haxxors.com [85.14.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBC244687;
	Tue,  6 Oct 2026 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.14.200.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255230; cv=none; b=LAYbXhXEu00GlEe5XgT+R3mFznbzRs4TO3USI7LArozDlm4Jtp+SVUcOhYB26qJOIGj7ODPliS6CVAD01PxRMDUkbugWggPdML/WoGteb8Ss8VXijZxNQyL5OiMDqCbPis3zWRoC/s1P5vnubUgP0hb8nOcr+ts24XyyyaBnpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255230; c=relaxed/simple;
	bh=n6BEXt7OYkjTFNdfwFEm8H3uUmWyU4uREug1p7Xp2Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HDQFQ81XNRZJ3P6rATTbfF5BSqQrxA9xvYuKHEwMj2F54mm6b9jPHuZZGz2gbxc1UyC4/t4bAywtwUonY5CpGeqT5WZ0VksmCAVxglG5Dhh8oKIGyul0lfku3AAy/3ohx+dLiBmsMMRjFMHtcUPL1l/gwhgEDNzt1fBraDCnzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me; spf=pass smtp.mailfrom=buechner.me; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=IpbGy6nT; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=Lh7MOB+D; arc=none smtp.client-ip=85.14.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buechner.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="IpbGy6nT";
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="Lh7MOB+D"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791255225; bh=n6BEXt7OYkjTFNdfwFEm8H3uUmWyU4uREug1p7Xp2Ig=;
	h=From:To:Cc:Subject:Date:From;
	b=IpbGy6nT9XalwC+s4hIvwnobAp+w3EdPb4RYSf8pVolG/uQ3Y4h1BEQGBeEE5i2hT
	 KVJUkNJagXZMYOz76g3NPi40FZItps/P1Xbd2Evh0DCZCQEy+STqopbsY8ebU7jSVh
	 H7jjoP7/sYeZF1Iw389C76T/LfdTxr/Il6X6j3SM=
Received: from localhost (localhost [127.0.0.1])
	by mail.haxxors.com (Postfix) with ESMTP id 37FF953061;
	Tue, 06 Oct 2026 04:53:45 +0200 (CEST)
X-Virus-Scanned: Debian amavis at mail.haxxors.com
Received: from mail.haxxors.com ([127.0.0.1])
 by localhost (mail.haxxors.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4vRzOVYAH2xc; Tue,  6 Oct 2026 04:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791255223; bh=n6BEXt7OYkjTFNdfwFEm8H3uUmWyU4uREug1p7Xp2Ig=;
	h=From:To:Cc:Subject:Date:From;
	b=Lh7MOB+DA/gLdxJT+fsE/Tpoh0SiKYi3MW+Oz+rxHNh0/JQpsmAAmRb3hrxqI7/JE
	 GHpydLHOFqIoyhiiW8BsUcPggeNhqJlc4YcljDds4X5rLQwM/qaq5DzWKcxtm1+g2u
	 PWzOqcKcT7IVgVOeRCaSgbzaEa9kuIy+cisFpFgQ=
Received: from esports.myloc.de (p200300ee8f09a300264bfefffe4ffb4b.dip0.t-ipconnect.de [IPv6:2003:ee:8f09:a300:264b:feff:fe4f:fb4b])
	(Authenticated sender: nils@buechner.me)
	by mail.haxxors.com (Postfix) with ESMTPSA id 3C5A0530B1;
	Tue, 06 Oct 2026 04:53:43 +0200 (CEST)
From: =?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>
To: Ulf Hansson <ulfh@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>
Subject: [PATCH] pmdomain: mediatek: Don't power off default-off domains in probe cleanup
Date: Tue,  6 Oct 2026 04:53:18 +0200
Message-ID: <20261006025318.503422-1-nils@buechner.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

scpsys_remove_one_domain() runs the power-off sequence for every domain
that reads back as on. Domains with MTK_SCPD_KEEP_DEFAULT_OFF are
registered with genpd as off and are never powered on by the driver
before the provider is added, so their clocks are not enabled. When the
bootloader left such a domain on and scpsys_probe() fails (typically
-EPROBE_DEFER) after it was added, the cleanup disables those clocks
anyway, triggering "already disabled"/"already unprepared" warnings from
the clock core.

Seen on MT8183 Juniper once the audio domain is KEEP_DEFAULT_OFF: six
clk_core_disable/unprepare WARNs with backtraces on every boot.

Skip the power-off sequence for these domains; only drop the clock
references.

Runtime-tested on an Acer Chromebook Spin 311 (MT8183, juniper) with a
7.0-based kernel (the hardware is not set up to boot mainline);
build-tested on mainline with W=1. On the device with the audio
domain marked MTK_SCPD_KEEP_DEFAULT_OFF: the six clk core warnings on
the deferred first probe are gone and audio still works.

The change and this changelog were drafted with an AI coding assistant
during a debugging session on the hardware; they were reviewed and
tested by the submitter.

Fixes: c1f3163d8ff3 ("soc: mediatek: pm-domains: Add default power off flag")
Assisted-by: Claude Opus 5.5
Signed-off-by: Nils Büchner <nils@buechner.me>
---

This is a follow-up to "pmdomain: mediatek: mt8183: Fix silent audio
from premature sync_state" (sent 2026-10-05), which marks the MT8183
audio domain MTK_SCPD_KEEP_DEFAULT_OFF. With that applied, the firmware
leaves the audio domain on at boot, so a deferred first probe of
scpsys runs into this cleanup path on every boot. The fix itself is
independent and applies on its own.

 drivers/pmdomain/mediatek/mtk-pm-domains.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index f0fa79e01..2b41bb8ed 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -1100,6 +1100,16 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 			"failed to remove domain '%s' : %d - state may be inconsistent\n",
 			pd->genpd.name, ret);
 
+	/*
+	 * Domains with MTK_SCPD_KEEP_DEFAULT_OFF are registered as off and were
+	 * never powered on by this driver (nothing can use them before the
+	 * provider is added), so their clocks were never enabled. If the
+	 * bootloader left one on, running the power-off sequence here would
+	 * disable clocks that are not enabled.
+	 */
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
+		goto put_clocks;
+
 	if (scpsys->soc_data->type == SCPSYS_MTCMOS_TYPE_HW_VOTER) {
 		if (scpsys_hwv_domain_is_enable_done(pd))
 			scpsys_hwv_power_off_internal(pd);
@@ -1108,6 +1118,7 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 			scpsys_power_off_internal(pd);
 	}
 
+put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 }
-- 
2.53.0


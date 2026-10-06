Received: from mail.haxxors.com (mail.haxxors.com [85.14.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976C30D40C;
	Tue,  6 Oct 2026 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.14.200.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255269; cv=none; b=snZDsMFWdcnSB4e+43IW5ZlfCYdGg5WHGtQAXr2dM3pOp+BGQg1EBujUQEumwD7ioQvuVUD1Xc4qoXgRbs/3cdCBvvJy6AwKAHb+msaFIwRE3wF4IcirSXobHMXCw3izRReuyKcR48J54NIzTBd5D/GDesruvUFXexBYv82lXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255269; c=relaxed/simple;
	bh=IN1+YcOwY+FTqBiIa+Re4S3jHnglM2aBHQuLytSJ6rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWLHh5iNmQmJFBTJI8w14NvOy/5qWRbrAoaVBMn7zLaYbv5YIrBqfAXhMlAahHWBW9UTXly0vV3/tJZCP6KKMdOS5RJ+E8DtEG9Lac92Vj4nE+/YQSTcG2RFpPN5E4lGwzX6xDu1YcGxJeBcEqJQvC8+CzSsuVsIZtwH9UkqXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me; spf=pass smtp.mailfrom=buechner.me; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=C40ZPFY+; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=D3jcTAtV; arc=none smtp.client-ip=85.14.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buechner.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="C40ZPFY+";
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="D3jcTAtV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791255265; bh=IN1+YcOwY+FTqBiIa+Re4S3jHnglM2aBHQuLytSJ6rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C40ZPFY+/sjT8W69RY+eIig37QPy4WDZXCjAPfUyuYi/Ll6+YQw7NN54J5wu6/vVq
	 xMWBNWN7mLoib2rGPIEQ5ol9TjfHKdUx4gDPqQ2EhH3CKKxzviZ3sAmCkz8fZEG/Fd
	 t/TEscoT5sftYG9SWnVunry0tV0LdVoSseq3O6Vg=
Received: from localhost (localhost [127.0.0.1])
	by mail.haxxors.com (Postfix) with ESMTP id B522653113;
	Tue, 06 Oct 2026 04:54:25 +0200 (CEST)
X-Virus-Scanned: Debian amavis at mail.haxxors.com
Received: from mail.haxxors.com ([127.0.0.1])
 by localhost (mail.haxxors.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c61zZGrjNMzN; Tue,  6 Oct 2026 04:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791255264; bh=IN1+YcOwY+FTqBiIa+Re4S3jHnglM2aBHQuLytSJ6rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3jcTAtV1os3sypZ8DPwjWfzkHKq5eOj2vBvckGVFCJ/hc28fKqS0kCol7nHPrEOI
	 zEgQuoPZzGU0Utr9O2jy72HhB4scVdzEJCsftB+Bua7XQjoLwXiaqvYtkfZe9CoxGq
	 gW2r/H/195/6qUwHWaMHPMkoWpy9lySKNoQo22Nk=
Received: from esports.myloc.de (p200300ee8f09a300264bfefffe4ffb4b.dip0.t-ipconnect.de [IPv6:2003:ee:8f09:a300:264b:feff:fe4f:fb4b])
	(Authenticated sender: nils@buechner.me)
	by mail.haxxors.com (Postfix) with ESMTPSA id E85C95310C;
	Tue, 06 Oct 2026 04:54:23 +0200 (CEST)
From: =?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>
Subject: [PATCH 2/2] soc: mediatek: mtk-svs: Don't fail init01 on a bank whose buck is not at vboot yet
Date: Tue,  6 Oct 2026 04:54:10 +0200
Message-ID: <20261006025410.506443-3-nils@buechner.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006025410.506443-1-nils@buechner.me>
References: <20261006025410.506443-1-nils@buechner.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

svs_init01() moves every bank to its vboot OPP and then immediately
requires the bank's buck to read back exactly vboot. For the MT8183 GPU
banks the buck follows panfrost devfreq, which has not necessarily acted
on the OPP change yet (an idle GPU stays at its lowest OPP), so the
check fails and the whole SVS probe aborts with -EPERM, leaving the CPU
and CCI banks uncalibrated as well:

  SVSB_GPU: buck voltage: 700000uV, expected vboot: 800000uV
  mtk-svs 1100bc00.svs: error -EPERM: svs start fail

Poll the buck for up to 500ms before giving up. If it still is not at
vboot, skip only that bank: restore its default OPP voltages, disable it,
and calibrate the others.

On Acer Chromebook Spin 311 (MT8183) the GPU buck reaches vboot within
the poll window and all four banks complete init01/init02.

Runtime-tested on an Acer Chromebook Spin 311 (MT8183, juniper) with a
7.0-based kernel (the hardware is not set up to boot mainline);
build-tested on mainline with W=1. On the device together with
the auxadc_thermal per-sensor zone change: all four banks complete
init01/init02 at boot (CPU little 1.99 GHz 1050 -> 1000 mV), stable
under 60 s of full load on all cores at maximum frequency.

The change and this changelog were drafted with an AI coding assistant
during a debugging session on the hardware; they were reviewed and
tested by the submitter.

Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
Assisted-by: Claude Opus 5.5
Signed-off-by: Nils Büchner <nils@buechner.me>
---
 drivers/soc/mediatek/mtk-svs.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 99edecb20..2598a1ccb 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
@@ -1439,6 +1440,7 @@ static int svs_init01(struct svs_platform *svsp)
 	bool search_done;
 	int ret = 0, r;
 	u32 opp_freq, opp_vboot, buck_volt, idx, i;
+	unsigned long skipped = 0;
 
 	if (!svs_mode_available(svsp, SVSB_MODE_INIT01))
 		return 0;
@@ -1542,13 +1544,20 @@ static int svs_init01(struct svs_platform *svsp)
 						      bdata->volt_step,
 						      bdata->volt_base);
 
-		buck_volt = regulator_get_voltage(svsb->buck);
-		if (buck_volt != opp_vboot) {
-			dev_err(svsb->dev,
-				"buck voltage: %uuV, expected vboot: %uuV\n",
-				buck_volt, opp_vboot);
-			ret = -EPERM;
-			goto svs_init01_finish;
+		/*
+		 * The consumer's DVFS (e.g. GPU devfreq while the GPU is idle)
+		 * may not have moved to the vboot OPP yet. Give it a moment,
+		 * then calibrate the remaining banks without this one instead
+		 * of failing the whole SVS probe.
+		 */
+		if (read_poll_timeout(regulator_get_voltage, buck_volt,
+				      buck_volt == opp_vboot, 10000, 500000,
+				      false, svsb->buck)) {
+			dev_warn(svsb->dev,
+				 "buck voltage: %uuV, expected vboot: %uuV, skipping bank\n",
+				 buck_volt, opp_vboot);
+			__set_bit(idx, &skipped);
+			continue;
 		}
 
 		spin_lock_irqsave(&svs_lock, flags);
@@ -1578,6 +1587,14 @@ static int svs_init01(struct svs_platform *svsp)
 			if (r)
 				dev_err(svsb->dev, "opp %uHz enable fail: %d\n",
 					svsb->opp_dfreq[i], r);
+
+			/* A skipped bank keeps its default OPP voltages */
+			if (test_bit(idx, &skipped))
+				dev_pm_opp_adjust_voltage(svsb->opp_dev,
+							  svsb->opp_dfreq[i],
+							  svsb->opp_dvolt[i],
+							  svsb->opp_dvolt[i],
+							  svsb->opp_dvolt[i]);
 		}
 
 		if (svsb->volt_flags & SVSB_INIT01_PD_REQ) {
@@ -1599,6 +1616,9 @@ static int svs_init01(struct svs_platform *svsp)
 		if (r)
 			dev_err(svsb->dev, "%s disable fail: %d\n",
 				bdata->buck_name, r);
+
+		if (test_bit(idx, &skipped))
+			svsb->mode_support = SVSB_MODE_ALL_DISABLE;
 	}
 
 svs_init01_resume_cpuidle:
-- 
2.53.0


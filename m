Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854A331EB0
	for <linux-pm@vger.kernel.org>; Sat, 25 Jul 2026 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964348; cv=none; b=bce7GYGLxW80dqTKOL+ccaOUFfoDWS12HFpfAr5RObC8oJNxAe7R0b4H9U8Jz+eFNELjWRmM3e3TgTmqjihf2imEevxm++q8iJza07Kw+4a7eQ35Pn8iYGcXePgXFDITxxK6CKRgA2pwqIKyO6NTO9MdteFbQQOS8mG2aCdTdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964348; c=relaxed/simple;
	bh=DCI7rjRmM93lutxj7+bxqQZ86jwK5qGWszKWi9ztQ4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tQPI+xoYJAlTF0oDb5PJ2UAGTfwdnU1pkqK7tq6o2QjZapq7ECBxiBbLyGU3YQgtgEowZXXHw2f1FnSmiX5LOnVQFgXc5Dmtnst+CHTjh3oi9ovpwDDBZCln52JnyqX/RsG8WNptXwdfIkIzBH2nzTPWolydNoAWbQsgLiS6m+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWqDM5mQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWqDM5mQ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so1183074a91.3
        for <linux-pm@vger.kernel.org>; Sat, 25 Jul 2026 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784964346; x=1785569146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxN16LlGLH2WwnDJmdIskymBeU5WPj7iW8e+rfqR+5c=;
        b=TWqDM5mQ0LvbGO3xv90snOwBtokbv7LCbbDftiCg3HVPneK7e/7MuYwuqEiv4nLr8y
         FFIPec+LxtPLG+0JlJ8CqAfkQ4GdIky2EsW1WHsCsja1XJgCQ5n/clfJw542JfarLKsc
         2JVNh1/X83sOBWllROG0a1dggH+TraGt0H9Zp5D34SVLIUQSS4hnCSRpzcXt4AHy4XMS
         2LXYloOjGXl1v2Rk5qC0qc2j7u2XDtPlL44k8r0rZzdRnPDTvJfe0EGMIo6Kw8DT+dmC
         2A/+qfVO16dOxgpbRwTc31NwPv3Wys5UUSNWT/nWPsiLz8cugpLWoo9FazMuc5nX1pt3
         ubCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784964346; x=1785569146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxN16LlGLH2WwnDJmdIskymBeU5WPj7iW8e+rfqR+5c=;
        b=LdRW6WfoHeV1x+I1p2Hqt/Lp6cFyxpN34DNgK7gZgGQcgQT6JubgOJEiIvqP1Bxcp9
         Vd1zT3v5g6eUzGpgPV9AxWcfr7ruex8xFdJ5eVY0D0fq9QTWfMt55eXC1J5BKzbwJFVz
         7pnBFLQg1FsSdKth645unxONjvIqJQTtCk/NZVv9E69niDuCmbAeXz38Xgk6keShbIim
         TLxy29xWf1UiJDjGqjVlVG5dcS7a3dRyP0bygtNw5jGYqZJkv90TJuu9oHAW2+vu0uwt
         lEjF3pzKTYFjQ3vi6ruhjHmf86Pai7TVxq21LFZuibqlLKhIxtA3PnZlU8MPsel5VzUa
         bDxA==
X-Gm-Message-State: AOJu0YzHKxaAu2ckifrSc7gBm7kiHHUDkqoIm6tzmsC5Tc4ZXh5Q+k1M
	KFEuRIUnhymR4TH97JMh3ulH70wqXZmcfdjhI59SFncSUKgVTsgH/gMp
X-Gm-Gg: AR+sD12+S//+ILKzkVccES2eOJVstCOby3mN/SjUWcCGqsmqN9rOt8D2VUhHpP3Do4B
	tgQJKTGUWElkPw6wDf7lMVm9QoVk2s9ArsmN7wgcWy9TLLDRI7Rzf6i3/uAQExPygUafrmSFJYP
	qHn9BFXmdVsf9dYvtakUdMR8QZ3xUx1HXgDTYHBgUax+QaAZJYrUPFQDmgUV+tTzMiQpk4b+lSC
	HHg35+LgFOkL61q++Shaoo2h+Ub8oom202kAckkhSAPH76MAIvGKGWRJR3rysn3NAe49I8L2PLI
	Ewn6J/1yWE3FRT3gBJ5m3K0vMZmfbilFLRvLbJWS7GVsTnPpGuRq0LVMW/VLdoFNZslCiwpQHaD
	2l5rMsVLSzrWl7goowzVKdTHxNg54VwZgz159SeLv3di82NVfkKA3qv2apyNVq6AXrmDrlJnT/p
	iWYgt0w2gwz43vwrvuRzbdgqgKdbXEbMD2XBf/2Q==
X-Received: by 2002:a17:90b:3f0c:b0:387:e0bb:57f1 with SMTP id 98e67ed59e1d1-38f2975d581mr1657727a91.34.1784964346221;
        Sat, 25 Jul 2026 00:25:46 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13014d27sm33921944c88.4.2026.07.25.00.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 00:25:45 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH] power: supply: twl4030_charger: cancel workers via devm
Date: Sat, 25 Jul 2026 15:25:40 +0800
Message-Id: <20260725072540.3092504-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bci is devm-allocated. Two workers (bci->work and bci->current_worker)
dereference it. twl4030_bci_remove() disables charging and masks
interrupts. It cancels neither worker. A worker pending at remove() can
run after devm frees bci.

The USB transceiver comes from devm_usb_get_phy_by_node(). devm
unregisters its notifier only after remove() returns. A cancel_work_sync()
in remove() can then race a notifier reschedule. devm_work_autocancel()
and devm_delayed_work_autocancel() avoid that. They cancel the workers
during devm release, before bci is freed.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Fixes: d6ccc442b1210 ("twl4030_charger: Make the driver atomic notifier safe")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260702172128.2001753-1-maoyixie.tju@gmail.com
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/power/supply/twl4030_charger.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 04216b2bfb6c3..d8bae2daac23d 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/twl.h>
 #include <linux/power_supply.h>
@@ -1002,8 +1003,18 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bci);
 
-	INIT_WORK(&bci->work, twl4030_bci_usb_work);
-	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
+	/* Register current_worker first: devm cancels in reverse order, and
+	 * bci->work can reschedule current_worker.
+	 */
+	ret = devm_delayed_work_autocancel(&pdev->dev, &bci->current_worker,
+					   twl4030_current_worker);
+	if (ret)
+		return ret;
+
+	ret = devm_work_autocancel(&pdev->dev, &bci->work,
+				   twl4030_bci_usb_work);
+	if (ret)
+		return ret;
 
 	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
 	if (IS_ERR(bci->channel_vac)) {
-- 
2.34.1


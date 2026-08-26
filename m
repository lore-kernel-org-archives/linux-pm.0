Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255444A3F8
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779373; cv=none; b=sj+4jnDTwrh2wL27/GOJjMBcu8FToYwPGYaZAeH6gSmDHvK19ZXMgmZzEbwdgddtRXNr/8oEecqARCN6+1ZuwnhunFvxtewSGzj5BSdyXH+28Ui1Hxvs9Gy0cNwO6/lMcWMwhwEX/eHfsS24sLHs2pPHFEPokWlnSjGU2MXl69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779373; c=relaxed/simple;
	bh=X7jtbksA3CZPJmBAGM4XuJ8n1h4BDQWRewnDoQ44Gas=;
	h=Content-Type:From:Date:To:Message-Id:Cc:Subject:Mime-Version; b=ZPqZ16IMVBVSzXRYkiU7uicoqlWNMStN1AJG0rMLB6UkoaIxGDcuAw4h8hmTN/de7rZsL951WCYBlGrM+N6WHyTjUVVLfM5jO8PJ9Ffu0o27XQSN1Q5XxFMSqEvuY/XL1yRMsAFwSR5eWThe+P3Xde9TIydERUseuRNLQrjVA8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=zI+QHNNi; arc=none smtp.client-ip=71.18.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="zI+QHNNi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787779354; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=W9vZu2zKGaMGtvu0O3flOjnu9HCBU0WdS+0u+R/OMwA=;
 b=zI+QHNNi+QJTN2oAebXmuwvrU3YqPYW/1HdB2MH5s//UeTCJGTzZfqv8i6b+bly2XE0zsN
 uj6o9uId6fKLbsKujksDgO2xHHcUvyqPy7O4nr8P7yh1DECZeQbBvDmHHUquHWdkdg7rVN
 2rl/i0jB/Tsc07wFuAf0J1OkHgKp1dLAvCzokyJguvnTaFM8837iMp/760SeWRTyfyIHsM
 n+HirKqV41LJDTcwjJLfd7YS0Q+kc7dD1iTVG6a3KxMKKiJ7LDVuVXYEqnmuOQHDYF3lTv
 h03PowKF15uLSf758i70VFI8W/N06vgqiTUzqcjxV9aV9acpvflRbQb/RxYpGQ==
Content-Type: text/plain; charset=UTF-8
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Thu, 27 Aug 2026 05:22:29 +0800
Received: from [192.168.9.107] ([111.42.148.146]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 05:22:31 +0800
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a8f5918+8d0954+vger.kernel.org+me@cherr.cc>
X-Change-Id: 20260827-bq27xxx-suspend-cancel-sync-7c60fc384041
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	"Sebastian Reichel" <sre@kernel.org>, "Hans de Goede" <hansg@kernel.org>, 
	"Marek Vasut" <marex@denx.de>
Message-Id: <20260827-bq27xxx-suspend-cancel-sync-v1-1-77a67711cbc3@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIABRZj2oC/yXMwQ6CMAwA0F8hPdtkTMKIv2I8QClaQiquYmYI/ +6E47u8FYyjsMGlWCHyR0yemlGeCqBHq3dG6bPBO1+7xgfsXj6klNAWm1l7pFaJJ7SvEgaq3UD npnJVCXmYIw+S9v16O2xLNzK9/yVs2w/SGAcsfwAAAA==
Cc: "Sebastian Reichel" <sebastian.reichel@collabora.com>, 
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH] power: supply: bq27xxx: synchronize work cancellation on suspend
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: b4 0.16.0

The poll work requeues itself via mod_delayed_work() while the device
is not removed. cancel_delayed_work() does not wait for a callback
that is already running, so a poll racing with suspend can keep
issuing I2C transfers after suspend returns and requeue itself into
early resume.

Use cancel_delayed_work_sync() to quiesce polling before suspend
completes, as the teardown path already does.

Fixes: dfcb264a01a9 ("power: supply: bq27xxx: Stop and start delayed work in suspend and resume")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
Same class as 86a3a8a926aa ("power: supply: max17040: synchronize
work cancellation on suspend"): suspend is the only remaining site
using the non-synchronous cancel, the teardown path already uses
cancel_delayed_work_sync().
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 01c9ec1116fa..4d4809a70b62 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2291,7 +2291,7 @@ static int bq27xxx_battery_suspend(struct device *dev)
 {
 	struct bq27xxx_device_info *di = dev_get_drvdata(dev);
 
-	cancel_delayed_work(&di->work);
+	cancel_delayed_work_sync(&di->work);
 	return 0;
 }
 

---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20260827-bq27xxx-suspend-cancel-sync-7c60fc384041

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>

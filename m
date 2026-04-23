Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD426F47C
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776921378; cv=none; b=XpNfKo2BefKGxKhW7MklYQodu+gXgqUYBLXQMjy4J+3YZ1qZ1Jzb5Ww8xQiS72cBXZpol7HBtpiDnhlWkCoMySpgYxf37Ac15QXSv4GRe97Zdrhx/8qBc17/3MOB82grCJqgmjwO/b1bZCYG1E2+gX3Hima9eUnNnrq0wWnAbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776921378; c=relaxed/simple;
	bh=vVmUc6BHhzs+fV8O2rHNsLH+X7k/U7RbLkyQO4qhSZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSfneWa2X7Sg/K2e85pW4nrzmQUq/LFaCJ7OGZWcO8N4f+5e99A+pN0Dzxm8Whm5CHuwLxMPBPx3pE1wctpjOC1dBk26paEBKnmw4E/hRMm4Mz/rlbQSE7siAwlinyvVBVZ9rX53C03LXJgUy7JIEpR6d/djTYDl9zYhKEmqSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSt8DCzG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSt8DCzG"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso4391991b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776921377; x=1777526177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmd0+i3zyfUooe2qBex0I9Uy4jA43VCAP6YM0wisfD4=;
        b=VSt8DCzGmGUep8OI6ug+V0T+RHqjQ+6reg95e5SO9FHFe2TJ3fsJ7iVm7TmEz+CEEG
         kZicP6FXfylZisJurLicBs3NcbzIrV8kaxcELmA/Jlrmrc98n4p4S0LFnFnlgBwv/5JI
         CmanjdANw4cP5sJ0KeNKUWEfplg+atKXN1yXy30+cq2y7l1QNUgkVe1/07SAOonVbat1
         lcl4fOXzzBCLd8s8iuVpzmdWHDqROPjjWyGC37FwV3sQ1GvXYRTbd5JAKRF00dy5L7Tz
         kYbEHk2s+FlBmdNipflOO/SuEzqqL3stVA0SIr48yeOZ8iapYHXPU8UwtxFtKr2Cb0kw
         wzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776921377; x=1777526177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmd0+i3zyfUooe2qBex0I9Uy4jA43VCAP6YM0wisfD4=;
        b=iVmGpm2HWCnj3BjgBq9u4W/Xoahgr69Ph8DB+ISQBuNx1LNvpbmi9wlm/62zijmJmP
         9NKrBqVdRK8t+beGzs4DkmJ/41bbHtWB2PMNmoKydzHwPX+BkfqrFTwB+m42Vt7F92ri
         vIMl7SMW7zJFqu/m0PRdlPWiZoRmYWb/j4HPi+/nAqIdyCkS00TwqPFMkyQ497IUyZQB
         7JoyOPNNcJ/wegZLBDwmH77aJt7OpqttQguI7lH13EI7SGjSPzoPSAA7vdwwwkJexBjJ
         N3NC+QQNmtVrDuwWgBK7owVNvS7pPJU4uVeb7IgQe3KFqFo/Z9+QyzNAJUzgX+DJ3cMh
         0htA==
X-Gm-Message-State: AOJu0Yx4TgI87Rhn3RAmu3WV+Cg0x5XLuRYvXHnVR+FQk/yVshqYw2at
	2QNxoTvFWz+fAeT5doF8h3IosWrsM+Cg7jLXFGsvr6/5+Tk4egkW1+h1/nKy+MyO
X-Gm-Gg: AeBDieur5m87H1VCh61CiU0SySXA9jiHxc8DZ7G2GHwRSvrRUyoFqek1TjZx2mcZHov
	aNEk6dsufDvDpH99XYKaJrpez0v2ZOZfdavUOYve3L3e7hdkKbJdj14Iob0HkHri5htalLSQ3KW
	WuZBNruN6qWllF/oTjkU2VT2QEzFB5MWHA4MvFpBSlEAmJRcH4a1yo0faA/NFr9HI15u28vu0tl
	qxynujm36ZVp6XB94ir83faXY/jNc+FRPCHyPTS6LXrKIkaP/DVzCTbPsQZP7cMsLS2wd4/qhSn
	hPLvogcj3mxGF/jVL0k+kPHCri2aVQAJ9AZrDVvqb6+lLWt0Ukb4DdFdPlVm4z5dsi2sFfiGPZw
	8/NbYE4pKGMdCyaLpxSwvkCeBmTXJADOb0mM/4lAieAKjpoZV7EGg6s0UvecmoDwH0tCmdeiLen
	yDvdhdm+JkW5TOGfmZxBLSXFRJy2PpHA/93wB+AN2A8Gc87aymJ5hBD7uG1rxcYr9mfQs6UPTpK
	PDfSArolD1j2nhMkJzY1kcTtdYder9UuHec
X-Received: by 2002:a05:6a00:4094:b0:82f:6e9:d1ba with SMTP id d2e1a72fcca58-82f8c90b253mr29372382b3a.37.1776921377084;
        Wed, 22 Apr 2026 22:16:17 -0700 (PDT)
Received: from DESKTOP-87O68R1.hsd1.or.comcast.net (c-67-189-53-77.hsd1.or.comcast.net. [67.189.53.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec037e1sm22517658b3a.54.2026.04.22.22.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 22:16:16 -0700 (PDT)
From: Nikhil Nagarkar <nikhilnagarkar97@gmail.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: ltc2952: remove global ltc2952_data structure
Date: Wed, 22 Apr 2026 22:16:01 -0700
Message-Id: <20260423051601.250932-1-nikhilnagarkar97@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently uses a global pointer (ltc2952_data) to store its
entire state structure just to access the gpio_kill descriptor during
the power-off sequence.

Refactor the driver to use a specific static gpio_desc pointer for
the kill signal. This addresses the existing TODO in the function.

Signed-off-by: Nikhil Nagarkar <nikhilnagarkar97@gmail.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 90c664d344d0..f07283d38cbd 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -77,12 +77,7 @@ struct ltc2952_poweroff {
 
 #define to_ltc2952(p, m) container_of(p, struct ltc2952_poweroff, m)
 
-/*
- * This global variable is only needed for pm_power_off. We should
- * remove it entirely once we don't need the global state anymore.
- */
-static struct ltc2952_poweroff *ltc2952_data;
-
+static struct gpio_desc *ltc2952_poweroff_gpio_kill;
 /**
  * ltc2952_poweroff_timer_wde - Timer callback
  * Toggles the watchdog reset signal each wde_interval
@@ -154,7 +149,7 @@ static irqreturn_t ltc2952_poweroff_handler(int irq, void *dev_id)
 
 static void ltc2952_poweroff_kill(void)
 {
-	gpiod_set_value(ltc2952_data->gpio_kill, 1);
+	gpiod_set_value(ltc2952_poweroff_gpio_kill, 1);
 }
 
 static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
@@ -274,8 +269,7 @@ static int ltc2952_poweroff_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* TODO: remove ltc2952_data */
-	ltc2952_data = data;
+	ltc2952_poweroff_gpio_kill = data->gpio_kill;
 	pm_power_off = ltc2952_poweroff_kill;
 
 	data->panic_notifier.notifier_call = ltc2952_poweroff_notify_panic;
-- 
2.34.1


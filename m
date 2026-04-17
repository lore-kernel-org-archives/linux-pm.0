Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C043AB297
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776424435; cv=none; b=bxNBhNALQQJLhhg0YS0HoYyt3JnZmiJMsQoMPWi7jcyye6d1IZfJ7Ic5+9FmH9iGaYejwzuJKaDCOrAirtj1awyl/OdVGNGvconXy9+OTAZtL5p56MAJnmEWplfRt+JNQI3uo+hxUaEMsPD5YrGTZnxBgDQPvqgFaAfaWYOhE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776424435; c=relaxed/simple;
	bh=ZFA0J21UavqemBdX61tkeeGyEAB0nt+X9PKTYKjXLbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQd5BtzXh5DrGICBFYiAlJFs1Rq3ZOXkkAr8aou1TIhbhdzYDJB8JktLYH+JFyFqlE1JI/F9VAauJ++aZAtIX11MVkBnOdTcmt5HwE30akWbEY9rkEUDpy0SXBMjnyeUrsAcXldpVPUyxR3Fp726Y/lFpCu8UiRPr/e42O/5Oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/l9SPQ8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/l9SPQ8"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e7d983f50so6062841fa.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776424432; x=1777029232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bH6jMbcTJb5ej+R0a9MCxG7qrcx/3nMs2OEMFRxEA/Y=;
        b=Z/l9SPQ8kJdhqWcAzMFMcxoerc3yTGtrOIoqCNeEW9iQnZYnGHk7RpipjltxaNApst
         a+HACIh9BidMH0Smrn/TedVd36B2Agkh449OOeeeTIeXa3ka1f1jGB2gb1haJLJjXuWt
         fu7uxOxm3WU6iizqX9LNCBS2iEyDC1IzVgO98yW96o0pulSe7fxJCPV3iegVEJwBW2Mx
         TSo2hBR2qpi4OlpQGehkdYMwX7bzCopWuTp5NQ2OaOGyqklYMUYJHwVgtcNghyAsBMjr
         iinFGDD4Z6PjT4yn2xef3q95X4waMB7f8GsvG+y2yIsbh0BegkQe5hk3DbQDo/QbIt4Z
         x2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776424432; x=1777029232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH6jMbcTJb5ej+R0a9MCxG7qrcx/3nMs2OEMFRxEA/Y=;
        b=lF64ToqIpkAevOe4qYhKm8Wg9PE1icyxzsv6N3cGHrCbdgr5dLYcnXR8kZTns/BGVv
         ZCvdaFBRzSc2a3OtSmEAWbGiG/lYyFOvKdejWRGMe7kCncT1bvbQ0C8DUDCB9o5t1/2H
         EQ17SwAuwM2JdKH3wzRGlP0KNfWdnLT+hcawhqX9XabVbMPzcHKhNZ4L2PNJHNZDTNA6
         w8CVgMJmDvNj5ruJI8VijUG9Fs+9V6/G6nhvUnCgnSMOkM4+6WqdN98vddpPPTiq0yde
         Jp4sdO0N1Q48FfaI7mqTUjxFbwOa9wVrx3DRSoRWDJs0QRXBkujkgN+I7B0QL6dUfdgX
         Ew6A==
X-Forwarded-Encrypted: i=1; AFNElJ9bncQkCqczkQH06msEJEWC9drhODTBIiJxdAz50sFgMRkU9kHjm5FXVDTLrihlfp4/9VdWh2D82g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzolHXD2Eon5I9BVbnMvcp+cU6UClx+1rasqdfDwHlcnj2Emb3T
	PlVLRFrHWUYFDY/sjz5weQ5L3pm9yoiA5NX5+ArhxB1C7hKwGHgYs8o3L8sGXKUje/E=
X-Gm-Gg: AeBDieu5fl/PH1uWR6AMXn6eb/g27VpdCCSW7CbSDvAoBN+CmFXt/+HU9tg6pXTf7uj
	4S5B3FO/5PzHe5NmZ2cGWo1Yb/lx6WzUMXnaQq1byFk4vt0GeMJR9oIs+oIh7KnrRhDdcwKagwH
	jn+j26QJaLVxCF5ifn+q8HNkZHBvsTZgbFFJcqczM8nSpDv2oRLMFanDLBd+3W+tHihuwyvFMHW
	WMIqqRJ5ZFGrmyz20FZMV+Mi3+GXF5IDFWByngJbTvzPswvxHpE3dskbBJsC2gWU+2iTiSm3MU+
	hOn8rM63SYDMKAr0YcOMHEm0rsAyLmnBjAO+m7ddDWo4sPbKnT1bgJJnapon3272j2kV8gZ5EYm
	9w2v9I+zWqHAb21rLGGEbKof7XMtTve57/q7dDeLShslPbDPloT8yS3hB5oajUfDuPNQMiIj3Hj
	4+59sl6C9Pm+Ye/VnjultwCkHhuYl88whWiXp/F+H32lIVqBFafcuRYHtmmKSoMZ4nLeXxhyiUu
	NOa8+7CJ8Q=
X-Received: by 2002:a2e:bc26:0:b0:38e:58f1:99f7 with SMTP id 38308e7fff4ca-38ec7b61afcmr6554131fa.33.1776424432285;
        Fri, 17 Apr 2026 04:13:52 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb733847sm3086691fa.34.2026.04.17.04.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:13:51 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Marek Vasut <marek.vasut@mailbox.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] pmdomain: core: Fix detach procedure for virtual devices in genpd
Date: Fri, 17 Apr 2026 13:13:31 +0200
Message-ID: <20260417111331.158190-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a device is attached to a PM domain through genpd_dev_pm_attach_by_id(),
genpd calls pm_runtime_enable() for the corresponding virtual device that
it registers. While this avoids boilerplate code in drivers, there is no
corresponding call to pm_runtime_disable() in genpd_dev_pm_detach().

This means these virtual devices are typically detached from its genpd,
while runtime PM remains enabled for them, which is not how things are
designed to work. In worst cases it may lead to critical errors, like a
NULL pointer dereference bug in genpd_runtime_suspend(), which was recently
reported. For another case, we may end up keeping an unnecessary vote for a
performance state for the device.

To fix these problems, let's add this missing call to pm_runtime_disable()
in genpd_dev_pm_detach().

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com/
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4d32fc676aaf..71e930e80178 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3089,6 +3089,7 @@ static const struct bus_type genpd_bus_type = {
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	bool is_virt_dev;
 	unsigned int i;
 	int ret = 0;
 
@@ -3098,6 +3099,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
+	/* Check if the device was created by genpd at attach. */
+	is_virt_dev = dev->bus == &genpd_bus_type;
+
+	/* Disable runtime PM if we enabled it at attach. */
+	if (is_virt_dev)
+		pm_runtime_disable(dev);
+
 	/* Drop the default performance state */
 	if (dev_gpd_data(dev)->default_pstate) {
 		dev_pm_genpd_set_performance_state(dev, 0);
@@ -3123,7 +3131,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 
 	/* Unregister the device if it was created by genpd. */
-	if (dev->bus == &genpd_bus_type)
+	if (is_virt_dev)
 		device_unregister(dev);
 }
 
-- 
2.43.0


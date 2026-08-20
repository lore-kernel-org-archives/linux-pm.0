Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67730D405
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787210804; cv=none; b=dBT6AUtnv40rdln89HpuC5lAshCuG0A1OzEKF751ebjXK7/gIZWg3XBGx7c/RQoQ1k0bG8l/sgR2aaE0BTrWs/2UCpXEUvNaU4Gox3aL+Xi7XfpAPDJVbCdnUGhKxOKJBeDP0iyjXyNLx2f9m4iYDu/tNhmlUAZQOjnxYYt+5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787210804; c=relaxed/simple;
	bh=syjUuMyE1FVCHZoraDkCPBZ1qJTc86g+j3kAqZUyDFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovYZb7XoqAcaq3qKTKyZk/jWZbAwH/5m/3Us2KjA4FeneuBLkJjpgrp4PW5hdFMoGtq22G9xh/kqgC2bPeHCsTjAQztgku5u5/EWjpowbSEqXF5B5eRrPJhhpgdd+6NHzO4QeGAGUF+D2wWYfy+1y9YkN8yJKhHxKur+o8qLgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqtJYWab; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqtJYWab"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a652535dcso1130807b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 00:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787210802; x=1787815602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8FpAmuQv/0D1SendrGr4xs5zcx8uXf/Ui4UAqXK6/V0=;
        b=iqtJYWabjNNyXuqRlbKRlfp5SOYxV50Mic7t/1tA3m5j2X8X4ck824iaC36wY2nHi+
         ICrPszKsPLxzdVSZNYsO1DQRZvPwYEm4dhlk0/u6FfzZAWlTc3koWxmZ8oTcAs9qjm8X
         q41ebM3vsO7BmTPunR0CZ+87eYqspQa6Y57L3i2VkWnbWudbfn9EgcjjHGEEEiyGRoiG
         P/KevDnJ7wHMV93cRDiTC1sTATabIbDk+GxT5BSO0JZDE99XmXwYpjkFGod2w01nghZW
         0TJjUCOlw4ho23CpnR3tibtCEK90gkd/DQBlcH6K9GqxefWDBicS4cCn5pVUpTvbNZba
         oWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787210802; x=1787815602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FpAmuQv/0D1SendrGr4xs5zcx8uXf/Ui4UAqXK6/V0=;
        b=N4mFZxlS9/d1hUmxje9VrgvW0/1fmd7IQxM+0r0JCIUzIggi+8cvwJrMIOGoV7trug
         43TplcHKewSBjWibgcU3GZF3I+wxTMJAOfeEnrNhPxOHSFm4QYGuujsvtIxN7d0qS6f/
         o0df4GaZkQ1kbgp/tZcgflmuUaMVE1DbGrPp0ovR+0x6JNL4Wtm6h/O6ivQOFOwGV89H
         D93uMzySU+U8R3vPP9nj9zrgiRXYO8d/3gYMXJjTBWihGRkfk6AyIZdVkuTWOe37VjRa
         b6VV5cGukjniP4o8h0VnOmev7wKRohud4B9ehjEsCF3VSUeeItwhboRr1gTbESGPDAO5
         TZnA==
X-Forwarded-Encrypted: i=1; AHgh+RrjIbMa/A5o4okez4eGX4Je0tKbFgMBKyKB3qNWzE6YlzLve43tJJ7vwMaPAV/fwzeW+Fl5VOhF1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf11AZj3hylW1aU/s/xCQA0LLGPjoWkD85wnBi+/7t4TQbdWYS
	6pKec4K8P76S9l4hi31GX0jHaUZTOCv/KzxJbBjvAXa7krPxaSLBqg0/7pOVJ8Q=
X-Gm-Gg: AR+sD10nCoLiyJ/gl/2wVOZX8lUp0JiVOHKdEXbIP4YmU0mVmk2vOl+1EXaCKWLenbO
	h1+B7u4v/m25HxdPNSVqwtAayjWZwI3SGUFbb3dwtbAJYJn0EgL7+JXUvbiDmab2/t3l5G3wjis
	UPhisKOIHgzHKiCkxlPRbEokZv8TE2Fw3gl9lcySW9XM6hIlXuJKQYCLnJ9+bSCeJxqLbH72KmX
	jvoWqHFjwi8rsmFM54GMHptewDJkHgS8UqOh9rmgP/wEsO9hruYAqAKo2A0qN3m9jkFmA2TGOxM
	ueFArAoYqIssGb6LSe/uwrUlDLIz1ImNw+pFSJQvI3u/8GnHDsES8QrjRTtOofY23B00WvLMhE6
	10xJ+Rk7hLub5aodPZTnPqfcegTv0bDAM+4VChJzoLSMGrUNWp3I8sDMbuLYQWC8ApgE9k7HHFx
	okEwSCIOqDrz0VXN40M1qSANpGnTC/Euii8mlMd4ahSouwu9k2qp+S8kk+RHEP12qm06vIQZz60
	fQuH6av0/Dw
X-Received: by 2002:a05:6a00:c81:b0:851:b007:2fe0 with SMTP id d2e1a72fcca58-851d3820363mr17061044b3a.1.1787210802084;
        Thu, 20 Aug 2026 00:26:42 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d33b4135sm1360621b3a.27.2026.08.20.00.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 00:26:41 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: myungjoo.ham@samsung.com
Cc: kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] PM / devfreq: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 14:26:36 +0700
Message-ID: <20260820072636.2049617-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/devfreq/rk3399_dmc.c     | 8 ++++----
 drivers/devfreq/sun8i-a33-mbus.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index dbdce7636ca5..3ebc817fa608 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -243,7 +243,7 @@ static int rk3399_dmcfreq_get_cur_freq(struct device *dev, unsigned long *freq)
 	return 0;
 }
 
-static __maybe_unused int rk3399_dmcfreq_suspend(struct device *dev)
+static int rk3399_dmcfreq_suspend(struct device *dev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(dev);
 	int ret = 0;
@@ -263,7 +263,7 @@ static __maybe_unused int rk3399_dmcfreq_suspend(struct device *dev)
 	return 0;
 }
 
-static __maybe_unused int rk3399_dmcfreq_resume(struct device *dev)
+static int rk3399_dmcfreq_resume(struct device *dev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(dev);
 	int ret = 0;
@@ -282,7 +282,7 @@ static __maybe_unused int rk3399_dmcfreq_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(rk3399_dmcfreq_pm, rk3399_dmcfreq_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(rk3399_dmcfreq_pm, rk3399_dmcfreq_suspend,
 			 rk3399_dmcfreq_resume);
 
 static int rk3399_dmcfreq_of_props(struct rk3399_dmcfreq *data,
@@ -477,7 +477,7 @@ static struct platform_driver rk3399_dmcfreq_driver = {
 	.remove = rk3399_dmcfreq_remove,
 	.driver = {
 		.name	= "rk3399-dmc-freq",
-		.pm	= &rk3399_dmcfreq_pm,
+		.pm	= pm_sleep_ptr(&rk3399_dmcfreq_pm),
 		.of_match_table = rk3399dmc_devfreq_of_match,
 	},
 };
diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index 4bd5657558d6..1636501c753e 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -312,7 +312,7 @@ static int sun8i_a33_mbus_hw_init(struct device *dev,
 	return 0;
 }
 
-static int __maybe_unused sun8i_a33_mbus_suspend(struct device *dev)
+static int sun8i_a33_mbus_suspend(struct device *dev)
 {
 	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
 
@@ -321,7 +321,7 @@ static int __maybe_unused sun8i_a33_mbus_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused sun8i_a33_mbus_resume(struct device *dev)
+static int sun8i_a33_mbus_resume(struct device *dev)
 {
 	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
 
@@ -470,7 +470,7 @@ static const struct of_device_id sun8i_a33_mbus_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sun8i_a33_mbus_of_match);
 
-static SIMPLE_DEV_PM_OPS(sun8i_a33_mbus_pm_ops,
+static DEFINE_SIMPLE_DEV_PM_OPS(sun8i_a33_mbus_pm_ops,
 			 sun8i_a33_mbus_suspend, sun8i_a33_mbus_resume);
 
 static struct platform_driver sun8i_a33_mbus_driver = {
@@ -479,7 +479,7 @@ static struct platform_driver sun8i_a33_mbus_driver = {
 	.driver	= {
 		.name		= "sun8i-a33-mbus",
 		.of_match_table	= sun8i_a33_mbus_of_match,
-		.pm		= pm_ptr(&sun8i_a33_mbus_pm_ops),
+		.pm		= pm_sleep_ptr(&sun8i_a33_mbus_pm_ops),
 	},
 };
 module_platform_driver(sun8i_a33_mbus_driver);
-- 
2.53.0


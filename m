Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7C33F5BF
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306183; cv=none; b=mZ3lAjEUkAf+1/E9ETnhCZ0mQqAJKU6Lc/r1N0ebN2PsHZzJt+mcxezPC+3TnDrl+w9DlIuPnhVG2BIIjG9ZfkdSNood3Ph2KkaqyvLeS7JFP2kqE6myppp72VaLbfpGmd4+udRLtIGhhliptvcNBX3OF/fKVsaYx9XK1gh53+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306183; c=relaxed/simple;
	bh=kQUjd2Nr/ZmFSNCyyYEmJ1U7nO+nmqD2qxm41xOlNvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmaU8v7m1h1tvcLuc1IToiyDe4aThXmCaNGIGr2s72eJKnSeif7H2X8XHoeVuaJ9jQ5d0qJlbz8Yd8E/XK8akN6aTmESSCKUlX1SqdaBrG4drovGEFjaT0fDBwQ3YN5rrEf6rXZxP15Ax6+fw8EmlvM+kvFzz0LqGV/fZWb6D2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmGBFfrx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmGBFfrx"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84275887a3fso1841376b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781306181; x=1781910981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQeqMrR7LVhilVEaUk2CBoXP3LxmpSJ6nJ8KAubQS2A=;
        b=rmGBFfrxpdmkWKgYKbfwiAtgPCh5017AWcWCDlE9gldUBvMWOJZhqolt7EV3DR/BNt
         9WlrbJr6t16O1UTGMID/73cc0/ZUtno09+5toGiWJ9FvSri9MDNRJuaFdOcXtfALWSXs
         TJtbI6TC2dzrJr1JP0JHBOmh9MrjgZs3IDwCXv4LxqRPIuZjZnFv+NCf6R3xIYXSfw2L
         fQjCyYCEam+Tr7wJbDUThJl+o/Gi/a1pi475Sll7/096ibs9vDA4x5+jWuNI8P9/jwK0
         PvJd2RpnxVZt97xF1eLy9aTR0CTkrUnC0aVRrP0ySJrKHHcELvK4cC9p4tvwsx8qTHqi
         W4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781306181; x=1781910981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQeqMrR7LVhilVEaUk2CBoXP3LxmpSJ6nJ8KAubQS2A=;
        b=Vsargc3wnXu+sTzMW8w53AjhP0rO0NV3xLYRuk/RjuscaTvfjYPBFC18gXMIhNl8gw
         +mZHFG3UmwFQil1g9dw1agBm+Gp4fC05DAWx/Bur5fP5/RqMZl0fW3XOPnTMWgj/YnEy
         hLQljcXljp+/++CJZJHU/ywyWvtlISVTtOk93Ck7cS2lbC115sS9Nh4OY5p6ttkE+lD9
         dUouSBpm9s6P77krYSxX3J2VlWk8A/eelK5HNtyuzgx6MR5Nj7oH9UnNrYe35V6HNL8Z
         x35MnQULoZs+l5qszEjl8iU375Rk7ZZQ9flefuNk0w8x5CKOKaGVm0kA7tn7jYFAMETc
         vcDQ==
X-Gm-Message-State: AOJu0YyuoXUumrTQR9hVfy6Qy1hRy9YgtqHvzBU19pZm4xKEfnp3pE+V
	+oSHO7b5snWxazfBSuGANjUwiM4/snTKc5nyZgpqcvsQ3ErBpl5o/+OD
X-Gm-Gg: Acq92OGv15MGlyQW146P20yKANWldIVzIdHLDu+lfzBWXxYHzmYpaOa74+aYcLSvijV
	hX/DUZFMCKwHLWLnsotlfhWqOoitEEPfzjurnpPsE7s8bx/Dny1PC8PaySfAPmq/5zJh2Fem1DD
	O/8AW8PxCsqQmVFML3OHcKcZf6LJbeDFAvPGBH13AjYaAUjNt1ABHWOTyAvyWZm+JUWe84nRNxX
	54S57eiGMnH5jT7xJFMg8msLWzFqoaDQAKpBVVSBu5w2RsE+nOSDtk7MSQT2+2uEG3LYsyYIFXy
	+rqtb/uyY4Er9j8Eb2lbI6FiTWKAuUhWCb+5BgV2OcaJg6OceK/rLPE27AJAfL1o26tgsIU15hf
	EqIdkjji6tbZnH8BtuLPivGovYhTLkq0RJgOllCKz+AG8LHD142awpJ5KNFCk5bQTIN4mXW3ekW
	teQlaGb9vqQQ7UzF1FnKKDzdgpsnP8vAdLIei8eTsegAI0uvVGnkNKdZJ6kTzt2JIpJt9WFsNPR
	OZO5JDSCno5aEwLo5fkGA==
X-Received: by 2002:a05:6a21:1343:b0:3b3:9f77:2e45 with SMTP id adf61e73a8af0-3b7855fd72bmr4320685637.1.1781306180696;
        Fri, 12 Jun 2026 16:16:20 -0700 (PDT)
Received: from bloom (S010680dac2bce256.cg.shawcable.net. [174.0.186.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8665186828sm2688072a12.21.2026.06.12.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 16:16:20 -0700 (PDT)
From: Jack Lee <skunkolee@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Lee <skunkolee@gmail.com>
Subject: [PATCH] cpufreq: powernow-k6: replace symbolic permissions with octal
Date: Fri, 12 Jun 2026 17:16:12 -0600
Message-ID: <20260612231612.206356-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Symbolic permissions S_IRUGO are deprecated in favor of octal
permissions. Replace S_IRUGO with 0444.

Signed-off-by: Jack Lee <skunkolee@gmail.com>
---
 drivers/cpufreq/powernow-k6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index 99d2244e03b0..764907b04c04 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -29,10 +29,10 @@ static unsigned int                     max_multiplier;
 static unsigned int			param_busfreq = 0;
 static unsigned int			param_max_multiplier = 0;
 
-module_param_named(max_multiplier, param_max_multiplier, uint, S_IRUGO);
+module_param_named(max_multiplier, param_max_multiplier, uint, 0444);
 MODULE_PARM_DESC(max_multiplier, "Maximum multiplier (allowed values: 20 30 35 40 45 50 55 60)");
 
-module_param_named(bus_frequency, param_busfreq, uint, S_IRUGO);
+module_param_named(bus_frequency, param_busfreq, uint, 0444);
 MODULE_PARM_DESC(bus_frequency, "Bus frequency in kHz");
 
 /* Clock ratio multiplied by 10 - see table 27 in AMD#23446 */
-- 
2.54.0


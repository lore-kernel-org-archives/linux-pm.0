Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB72741B6
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781370979; cv=none; b=URdf8GD/SV+BD5WNf90XSLdfIX94cCC6X58nUMfy/G0bfpglUjLwVDDgwaVLnDRE7AqnOuuIlStYTIyXk926P6KrHvVXnI+upoHtQtYvWvwAhRbSjqnMnJDiYZMoJ24kf55sKRtK11G4CFtT2S40Woclyl0YeQ2NjXV4nE8uI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781370979; c=relaxed/simple;
	bh=11UNlnIIJRXDoCKTM+VHTBTqUB7BwG8U2LkeOEZp7qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl9SiUWfE6hGVX7JLBeBIXaQ9NiGOGKkbevD3BJTiJCLqIg761RBD1Jn4vBP/sFdS2vB1QCeSc9Rpn1pgJpq/W6OIfT36dIyOsELK0qZFrldynpHwdzOA4PUj1ZHJzMWxiwZdx/Sed3nDo4fPflYOGvr0hCGsjB9so3o2c/GLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ0atN32; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ0atN32"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so1274991a91.3
        for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781370978; x=1781975778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHnjrYe71b0/9xawuiMitiqCxEUiRYNpMNNAG+kyN10=;
        b=gZ0atN321OLsQN96RyfZOO8gCwUaIwBhjtPwV3TbVSEk3leDmdr9F/YAaOvEl7Perv
         Eqr5N8KY4aqSQjwMs6UfVIbEEF4MX+2lGwiJqNJewkCr3f8v/zigF9puQuXOS07Uj78N
         DTsFEoN0doKvd2gIisW+bmyA6zNcFK5nCnj3nnLYjMFI5Qt6KZioAlYAcIch3GWL5cyo
         hyjU5PagTuq7wcuH3Zvbn0yfzPPAClTqBdfb3OV+5XV8vtNDKrEnCQWwivmxBITN7nSn
         NLTJhSpmWBLgTp1l0qFFaS3XhOEy2oTC2QGeIwSRTyZvWTYFX6WsQUqgmfOgLdkRoVmZ
         Imig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781370978; x=1781975778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHnjrYe71b0/9xawuiMitiqCxEUiRYNpMNNAG+kyN10=;
        b=FtdrtOTuMvgE912H3QmKOpsNoekFqOjpwu0/qkF7El4UvIYlZbuBdPZE8qZN2penCg
         kFnzH9NxmLVZsjtGUmIdKc/ruznkaKdpMaX5kzmaUFEivjMQ7St+JTqEo+2vqofTAUVT
         jviqw4lHeIrEds25/0si+Uu2Lo26DWgS7vNzY6V4b4oW+H+XvQO8bSuW+VhxkWcQL3KJ
         p3wPb4sEuuTGGyLwxp0LzVAFFZvJcwzyHJonTOWaB7ZL8ZOuSjTnFn0+EsPicSBypZG2
         Bz3haa3pkowEduCaMpNQxI5Zkfl3sfC+e8kCrdpSV/KllLWmM5uoOFLGzdZbV4tGQgUc
         FAsw==
X-Gm-Message-State: AOJu0YySFaXcBxLCwEPG1AwI1AZMohh/E2USVTElRXIzEbAYvSmQVxI7
	T5IWszAIvxyYlO6TDtuugUqVldvNl2U+ZuJS+WgaXBz+1w7p3a17PMcS
X-Gm-Gg: Acq92OFnwjdFmrJywz9az+ZWwlm2ygrC9x8msN79hSddkZyaPSJwtcAAGyB9nH0iP0I
	UKuutrDSmnaAGOR2mJMGYq3zqvYsvZo9WDBLZcGZArdTVjI/QE7YK4v61fjmyfsmjp4HLVfVp4h
	c1tO2uIIodNATJiWkAPMH0FJwmgaodI9Tb1Q6pWqbBFRdr3pdNRlOMVMMsaUoGmxTKW6JBtx2CA
	aJtlRFY0lYUCDzMr4jw9EW0hXkRsAYkduG5nB0pAbPzuq0MEzb9c8fh7v9tdhCofcBfXXpxTOtW
	bUchJp7BKrJb/ZisSQnWQ/DospPO20WN6hI0CJ4JNKYuQ7WrrAoVjwWMuvmIo63NTRqGkCn/wly
	QILyDGdlPWYoqowrjZzFccXkep7TChXB8gKM15JO/8glYCpGsDRYfRsUtCRpVMgJcNgDhZhaDpg
	+V4iD+OazQu1kO/lo8K63vHTjpNnZamifYjfKHGqUWRY8aFxcYqJK/RwC/yd/7FA04a6ZdiUsMN
	9eMjaHWrEQ=
X-Received: by 2002:a17:90b:1dc3:b0:366:3ac:f730 with SMTP id 98e67ed59e1d1-37a041aea48mr7976711a91.25.1781370978172;
        Sat, 13 Jun 2026 10:16:18 -0700 (PDT)
Received: from bloom (S010680dac2bce256.cg.shawcable.net. [174.0.186.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e810f98fsm2588542a91.2.2026.06.13.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 10:16:17 -0700 (PDT)
From: Jack Lee <skunkolee@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongqiu.han@oss.qualcomm.com,
	Jack Lee <skunkolee@gmail.com>
Subject: [PATCH] cpufreq: powernow-k6: replace symbolic permissions with octal
Date: Sat, 13 Jun 2026 11:15:59 -0600
Message-ID: <20260613171559.43079-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <12116e07-040c-4536-958a-d55d04d163c8@oss.qualcomm.com>
References: <12116e07-040c-4536-958a-d55d04d163c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Symbolic permissions S_IRUGO are not preferred. Replace with octal
permissions 0444 as recommended by checkpatch.

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


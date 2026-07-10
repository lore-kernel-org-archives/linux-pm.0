Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4623D297
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712060; cv=none; b=bumMyjwTb/SGG1NPOHrgf+AICGgCnoHcbtpUhEuM4BqHCpE0pEjof7UnAyp+CnIAuuE8N4IQrE8lvi8ZwPwLuzYCtWRHJMG5HtZONB0sbMr6LSZm2oLNh9+Wpqj9iyRfMN+u22cqfxjDN3R1k7nayPAbOYZ6Sl/5yQP3v803QhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712060; c=relaxed/simple;
	bh=qHpuXgwyDt7gd+u5X5Fkon+TXwHaSS4B0GanO68bKIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n92tJjr3Amih5naEHSP0De2XPqYvpP+KktovSYfFlFB/g1/QaUVxN/5M993h0JNDbwNjFOP8l2d4qo+5AIN+ma/WvH0UHW3rTLJk/+f1ZwQPqYl1kKD/3CS0jXLJQKiDYE+lsJMtfYgPMh725ex81dR/5N1iHR40tXJ+Nu8yL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp7BUVRC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp7BUVRC"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47362928f65so1294527f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783712057; x=1784316857; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfcK5+z71wUpvsd64BXWRq+fNxeTLDfjOVwwJT3IZWQ=;
        b=mp7BUVRCV6sBSk3Cyl0MmDhzS0DpU1e+WtFIJKshfm5vJ+Wmr/hE9ygy2/w/EpMwxY
         5freLJnLgcWP9u5secg2uhg6fUdXf8Q6H57dzAnXJlGGj+zl6s6xMGOv9Ybanw6ZTH+y
         ySWOdxo/AHjFgIOBYPN0C26uTmIjtixY5UpwVrImj9js3CwxZ6ySpwVplWAaZ/icVVMz
         14CNLvxuTWWGVGzmIjbaIk+HzLrOXhhT2OQtI41UmOCDvfZ3UM40lI/ce8Z0nDs45prq
         cN3sekgLqWtMox7PjY6zLsmX7Pmhy5y3kLZ7mVER2wj+hMNANw432iXKOMjaYxZpoLpU
         JH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712057; x=1784316857;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfcK5+z71wUpvsd64BXWRq+fNxeTLDfjOVwwJT3IZWQ=;
        b=G+zLNpURzVBuzUU4HXgiBmdBPCMvOgtXGP9F9orQXp5WFZpBu8WzFSoP7Vo2jVKQpG
         /IviCR/fNiLfJRAhjKvZuEeqLDMsdRuimuHHOcxGiyyAO7z0gKOTcye6Gs3ef3NdjJBR
         RvRiQDxRDFMpsh9VzE4LecbQl7ZlVwf46w0Y19OVoKbYwAoT/IMumd4j3pRlk/fIVQdh
         liTFdrXEXY7tUSrO+cugfEbdP6l22HKRz+lqkEFOfyOZY4zaRNDOqi2DHnPuawGvPQ3j
         eyx85xshSmoIZWrdLWKH7dNBubFYquir6jvETBOj/ZZ0wP8h7C2qmGqwcBm5aXUgH6YI
         g6OA==
X-Forwarded-Encrypted: i=1; AHgh+Roe6WTIP/YD8y+0ljxOQnui9Gt46lRRrHl6dsM2XBBv4RySjsHOx+I1+uv+lhplkE1gCrb/3weouA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM8uxOZba1QN2cGdzgNDZMI7yCn4DBMhTGf/9EKzGprDSvIIAw
	yqx8/wfhQkiy3iND1Y7GW9cjfc5SuBlFKQBsgHPixnkXnn5MRov2pXwl
X-Gm-Gg: AfdE7cmAU5fgoboHBWt0PbFJo5gkj2JUxJKDM3Yi2pyKYCqGG18piFHfP6H2akbSBvA
	j7VfHmWxciDLwxbdqnawFmSca2Jfm9wYuWkdtuDck2A4YMA24VCLHOp2CaaTa8vYax6Qrj78qxn
	iJvkCAVdcmd+cfidl/V3G8lN4aRVtgNJVetUShkAKLl/TheD9T9Eo9U7/4bDL2DoiuePu72c+fU
	lZoufEUu0yVKY9XXU1aBR97ddKRpIZ6vJ8sZBUkM0y+kgl8HIhfsLoePrdeSQB3R6eqARi3QI4m
	XRiEZAOpxsyBG46msPQRY/YpcNLVzCMu/C/rVQ62vsZKhHieh2+cIpqE0esd4Y8uxb4nXQF3ach
	Tjs1+qeb35ssxYoboI5RgqNZe9lNHfpuFgM44xxzYDezpRTZsJxu49e84BHDZ5TiSgXfcshmcbD
	mVtpZUIVK4
X-Received: by 2002:a5d:5c84:0:b0:478:65a8:6305 with SMTP id ffacd0b85a97d-47f2dcebd30mr143287f8f.49.1783712057358;
        Fri, 10 Jul 2026 12:34:17 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm61104797f8f.33.2026.07.10.12.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:34:16 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:34:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: Deepak Sikri <deepak.sikri@st.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cpufreq: Fix an IS_ERR() vs NULL bug in
 spear1340_set_cpu_rate()
Message-ID: <alFJNUllC3JOKv6z@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The clk_get_parent() function doesn't return error pointers, it returns
NULL on error.  Update the error checking to match.

Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/cpufreq/spear-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 81a0780b2ebf..ffe5eda82f0b 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -79,9 +79,9 @@ static int spear1340_set_cpu_rate(struct clk *sys_pclk, unsigned long newfreq)
 	int ret = 0;
 
 	sys_clk = clk_get_parent(spear_cpufreq.clk);
-	if (IS_ERR(sys_clk)) {
+	if (!sys_clk) {
 		pr_err("failed to get cpu's parent (sys) clock\n");
-		return PTR_ERR(sys_clk);
+		return -EINVAL;
 	}
 
 	/* Set the rate of the source clock before changing the parent */
-- 
2.53.0


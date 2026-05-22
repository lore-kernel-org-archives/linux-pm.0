Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382555CDF1
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 04:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423565; cv=none; b=Z9YfGy1UVmP6pfgtESTcCqNvgO1iNsK5CxXW76hl5/vGNbzcKnvdzsnCsPs0m34gA9CyJCN/cDwI907rOhrQiXbZTzqkTnJ5xDT8fvwlGDfQeEZkByXxMSM45Zgq691Rh5q01/DV50DwFtJKLNiKuAzhCeFOqncxe6Z83FOiH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423565; c=relaxed/simple;
	bh=X+OMHpg8btcTwn/3SgI5X5ZbFvp8zQhW9sq8l8+v24Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXG5XP++EDNSlacFaQrK+viI4Q8vBS0gn79ZBDispxBm9lbxOYrsW7NqxBI4QzHeDg7s9yKK1RDqGu5jjCC86zF2siGCb6R/f5mIrVhyp1mdaViazxsx64K+aX248rN2HlRzPG8R0X+ZQ9h1o87NrRekpaIswXNMwLz3Wc+Bhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wK/O1b6q; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wK/O1b6q"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so3538655b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 21:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779423563; x=1780028363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvPRe9hOtVwaxWBgyXeepmou3/2lXZNBTxSJL7S6tjw=;
        b=wK/O1b6qBZ8jp5stpUMj30osEDwiGg6wmYJA3H3ddwM5870/QeQyyzbfCMOKc06iK6
         oTdQXoAsWDjIOulgzan/l7f+iGxrlASWL3PDCv39oeYlVsGtoumTcsHRzgKQsyG7SPK8
         K1JyZgsUPAWGPcJ7qSd0boSAz6nP/aPJ+GTvRnpD69UPQV3AxdlZyvc0asFrI7PEu//I
         g5gQK/pd+VJjxE9elDfXEiR4Cz66uTW0VXyjKvVvxZsZMmh66u2DNGewDTWQN841jUkI
         1oA7JQUpYqGpRQY8QaZIW11g/fXaFZTff4dJtCLvCYBpHweuk4yIz5cOqMXzG7rw8UZ5
         EZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779423563; x=1780028363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvPRe9hOtVwaxWBgyXeepmou3/2lXZNBTxSJL7S6tjw=;
        b=pumGAO1bVIKDHKZM3kgb7XrkqF7tixzleTeGOa1Fr1jmlitEaecuhOOqR7e1bvTgQ3
         C0uKqjb05K09zFvlhGlfujh02nvNAmnJ77jH7C37B6IsBHi1MiOvDKADIFr5hID91iQ7
         pHuWT07r3v1pmlGL2UYKhD6zpv7ulEPLeaX7sBCLOWdppmoiOcx+FlAq8mmWTJIvK1uH
         qaNlgktEi8YOLE8k0qNxrJz590BS+8RWoDfAgFmWSysNJ5sHNc3FS2O5BCEKrHR/8PsG
         NHKisAGeFWLhShLcJV/U0c6Q/mJaCDTOCIbaYeqR3QSn8EEJF8vyTQhqts2CD7onjSD9
         94SA==
X-Gm-Message-State: AOJu0YyzuoBjeeEoVF4t+JxN/ULGvayUpW1dEdbeX1rMMhS1iEiDDyX0
	3IkjUmsvcMOG/DfqkyxGYYpoVShaOsl0LGodYS2W/JFO7b9nwyKZAII3XyrwHSDjrPg=
X-Gm-Gg: Acq92OGKY45IFBp9XC/HPNGyduY7F6FV9IC6yv1jzQZtNf0o0xM74C4wXr3DrqLkRbU
	7N7nrUMa1wwf1AoeWKHnZo1saLHzc5qMUXCE6Cv9YX6OIIeNiZlanaukMPZXjt3dkmLzlzkiUtJ
	3i25TZavCQc6B+9/jcg52Op50MpnAaECRFr3eAHX1UaO7bbXplMWACVxAsUOh5+UJ5n/6KPat2+
	8eYhngynbrk3O4AAElg/7PvWlIEhqekf83AKC1+SbKi6kw/u0eR4Ph6jiw1JOZ9uxch1HgbH5Fo
	x+O4lkwRQTimEzfSUfDPXptC3lob6daD346DBL9JUJ7IUXeyYB/CizsZ+pBhjvfknHqaqvgHKhE
	vSOGBWmtZYZpeiz8nTorlH2RnoICOGK4vQ/5YegMhCAfKCUW5S5A0+oGas2pTc6WQ/yoDuUXQVl
	IKL3Ogpjp++1QM3WLSqoOa6Jo=
X-Received: by 2002:a05:6a00:1c8a:b0:834:e092:2631 with SMTP id d2e1a72fcca58-8415f2ddc83mr2132366b3a.8.1779423563208;
        Thu, 21 May 2026 21:19:23 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009761sm503948b3a.60.2026.05.21.21.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 21:19:22 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] cpufreq: Fix typo in comment
Date: Fri, 22 May 2026 09:49:08 +0530
Message-Id: <396f64411431ffbb5b4f07d1f2e0bbf9763d468f.1779423281.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1779423281.git.viresh.kumar@linaro.org>
References: <cover.1779423281.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace "diver" with "driver" in the comment describing
CPUFREQ_NEED_UPDATE_LIMITS.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 include/linux/cpufreq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2ab691828e48..4d4b4ed24b30 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -434,7 +434,7 @@ struct cpufreq_driver {
 /*
  * Set by drivers that need to update internal upper and lower boundaries along
  * with the target frequency and so the core and governors should also invoke
- * the diver if the target frequency does not change, but the policy min or max
+ * the driver if the target frequency does not change, but the policy min or max
  * may have changed.
  */
 #define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)
-- 
2.31.1.272.g89b43f80a514


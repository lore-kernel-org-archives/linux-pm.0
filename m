Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355A12CDBE
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773123385; cv=none; b=fklfli82JNIMYeLBPYziUMwXNOI1vW7lGwBmTn7w9RUcpTq0z4wcOdDkm6Z8k/GMU6GhqYuQc1hfVWeKUaIx/LVHlJY/aPSJ/aUwWqxFENjl5u1THR0GSLwplrggnUNjT6kNQYOzILs1YND8mz6caIJiNm5IFteR17fP4MZbhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773123385; c=relaxed/simple;
	bh=nR69aaPS9yVCcLKfaP+AetapE4H0B9qnq39XbFXIvm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VOntMKXib8D5wW0unqXhplmXlfnj0n4GVEso1Pb6HiYbPgbfzWLAq3KyAtDv2zY3I6zFDdBAJC9zds0IpqtpYEPtAQvP5mtHL9fFt1AMz/oL3VChBA/yjopmj2xWd2K+J7CcuH1I3LHjbWmvTcz9+HfxGelyIju2d3KEgKhXKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IS/pEVRq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IS/pEVRq"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8299c75f730so2290670b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773123384; x=1773728184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/BwIIg5Iwvx2GTLZg0LGSdSidB1IAUOBncBMVs3N9v4=;
        b=IS/pEVRqcCSanSwI0++Nv7apjl04wYoLF0wH00ofTsttF3XHijZnc34BBZsLC+oonk
         8ifyvRhy0/GGeBg+FrNe+XrPMylTeM/Z+wz6vXh6ILwRypFylchaOouoWzFf3kQs1dNE
         MjZGEgu8BYqd9GDLsd/PW2qfQ4LTD9iDxLYtEhyTO8ojLPWLjsq/rNixhJ3qdsoJT3g6
         cbq1FhfojOgnLS5wizsDnu6zdBBAZiFcaIBZui2vqBhZ1xGK/gL+IagP35+GRaaspDmP
         YT7kRplcj8+dtqobNYmTSQ3hbwc8s9K6EVswG4xa/P+qeN2TXr4RKTdQwuU2hgH/OqC3
         ZkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773123384; x=1773728184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BwIIg5Iwvx2GTLZg0LGSdSidB1IAUOBncBMVs3N9v4=;
        b=ez9KfHWiDCxRJkcSxdViCsJA6JuDUZEVHoyd0lUIwdFjK+/5ToKR3NADbcPVYuFWjj
         cDahaqXpRdSHTAv0nGYe43v1EyoKXhpkvwONg8PpChRyE6tbKv0xMgnv0Mq482yAMm7J
         DI5rIblfDd8GOjOn834TmoTvsti9a/ExYPQgNKXgKi4vplAs39dGm+rcyxRfIhYfIDSy
         VW82lqhWkCxF79CO441+va+yvcwZgN9jWO8N0KBk5mXwQ8Z7mIiN7lttFaCAoO252Dwj
         9v3jwiJORcfQCtfLPaKKwlODqBnqFKwUFAodMJmRQqPxqaIty8nChsCFRZXTTasi80is
         UBOw==
X-Forwarded-Encrypted: i=1; AJvYcCUTd/wvrAw7nyqAnLhSFkrWW7jabQgoMNGWkUCYBS5+L9FPlAXr/i6gTKWpflRCj8TycyzRubnqgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpzA77ZZmEk74ff4AJV0B5PaLoaEvaoIyZf6+oDm0hCAlu3NQ5
	6ACO0GlXSX2/DWOSiWeAvyDEVybZiETm5KNqnToPMihl5dpjJ3W3JE6Uy3ti11/WF1s=
X-Gm-Gg: ATEYQzxHecxD+DryEDCfgDb1OW0KiPkDH4OZaa8GQcnRFCZYDieC3ADrHdXepaE6HmO
	Fkva0S1L77hppdVSKBJhRLFKdoPy6hre3yCT1kluOidyU+d0GvexhC7czXCuC74WNWJVwidAFu6
	8DMuriWPOvVQY6wEBIiRjy2NfMXCwRKXWbmS4QiirlKKxybE6JS2M4vyJ6UqBpjl37PP/JPimm2
	hpF1Ny9QsD6NH3mgUIvsWuo8KuHJBvLM/u7V4G3aE7/P73MABL2UD04RpZjQSAiIIdC7e7iZfGH
	8JRK/sSw9t/ADmNqL6xj3GzaGjhDwX7zxoFhZ/LTr8Ubxm8ul3k3vbenC9/TFFFUT1io7079+ME
	RFLv4gSnZOhfGxaiqq14ly0uqOckyBwi5vT4Rpx0MpFCvvQQ0ZlSvkGr7Y2TXQHM9TxMbnUJ2Ko
	Yme2ys8oRqz6sYWWI+n+sdqnzL
X-Received: by 2002:a05:6a00:2d14:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-829e4077415mr2127413b3a.25.1773123383382;
        Mon, 09 Mar 2026 23:16:23 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829aeea8644sm12926924b3a.33.2026.03.09.23.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 23:16:22 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Add MAINTAINERS entry for CPPC driver
Date: Tue, 10 Mar 2026 11:46:18 +0530
Message-Id: <db5e64651a1b3ddf33a25ccfc1d28da1c427780b.1773123282.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for the CPPC driver, with a list of reviewers
from multiple organizations.

Also sort the list alphabetically while doing so.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rafael,

I will apply this to the ARM cpufreq tree.

 MAINTAINERS | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..7622601a36f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6620,6 +6620,17 @@ M:	Bence Csókás <bence98@sch.bme.hu>
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cp2615.c
 
+CPU FREQUENCY DRIVERS - CPPC CPUFREQ
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+R:	Jie Zhan <zhanjie9@hisilicon.com>
+R:	Lifeng Zheng <zhenglifeng1@huawei.com>
+R:	Pierre Gondois <pierre.gondois@arm.com>
+R:	Sumit Gupta <sumitg@nvidia.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/cpufreq/cppc_cpufreq.c
+
 CPU FREQUENCY DRIVERS - VEXPRESS SPC ARM BIG LITTLE
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 M:	Sudeep Holla <sudeep.holla@kernel.org>
@@ -6628,6 +6639,12 @@ S:	Maintained
 W:	http://www.arm.com/products/processors/technologies/biglittleprocessing.php
 F:	drivers/cpufreq/vexpress-spc-cpufreq.c
 
+CPU FREQUENCY DRIVERS - VIRTUAL MACHINE CPUFREQ
+M:	Saravana Kannan <saravanak@kernel.org>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/cpufreq/virtual-cpufreq.c
+
 CPU FREQUENCY SCALING FRAMEWORK
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
@@ -6647,12 +6664,6 @@ F:	kernel/sched/cpufreq*.c
 F:	rust/kernel/cpufreq.rs
 F:	tools/testing/selftests/cpufreq/
 
-CPU FREQUENCY DRIVERS - VIRTUAL MACHINE CPUFREQ
-M:	Saravana Kannan <saravanak@kernel.org>
-L:	linux-pm@vger.kernel.org
-S:	Maintained
-F:	drivers/cpufreq/virtual-cpufreq.c
-
 CPU HOTPLUG
 M:	Thomas Gleixner <tglx@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.31.1.272.g89b43f80a514


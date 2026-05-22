Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725A280CD2
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423571; cv=none; b=Tpfkm82bcQj019/XBujEh7JCIaWtbX5XByDAm0ApLc/XYShDDQn9gxWeAbT1HWhaNmIrC/GXyKOlKfz9KT9fbNBeZtAAsoGxBcoxNyoXAcw3+jpKQ3H/xgPCwDY+rlW3D3IFquB+c4XgJ8Rb31fw/qo7lF3p6z++cx7hsIfqi8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423571; c=relaxed/simple;
	bh=18MmaV5xr2ThwoQ2TPzXDnYl8fpUMUsNy/8B7Nk7jqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaxVAR9XuTQI9CGLX92tdCjrxCASTKQfy4tMCNlc3MEme32KGYmyl273KarNgep7D+aw50Di+HRfGlK/tNs2Fpr8pFu6tSJWOVG8zqfV0+M3obRayLfQADt0xOmMVLudhFAkdvom5WKUPV2H4XuLcCU791MSLsMnUpRxwjQP8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y5tfumFG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y5tfumFG"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83975e992e1so2705444b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 21:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779423568; x=1780028368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlnszKvaLYniJylzFLq6RdE/rVHviJLfN/ZjcktsGLA=;
        b=y5tfumFGLhHlkvcAnKurVV10IR6yUIUVvdkji615TSwLn3f0VxrHKGqATySVV/5P59
         8BVDGlB70y75U40HICCfYOkVmmDCDHE3yT6JnQz/M33JvdQhVOwMmhWmPmgjyATJT3Rl
         E4o3jqfPFF7stSo26uZ8mYJY6iyQGTVWnI9N49cfY7k+FbERYiRrPhK1xx4QAo6IQxNd
         Ju6CyY4ELSdCK/8/NQYullQeA/Ady0a6lzTp0pdu6W7jjYfMMZaAlnAX/y1Zlm3wZvgb
         nTt4dFhxq3nlGWW5T+gDuNRJxyxZCTgFG0IC09fdBA6kDIK+dFw6i4HHAAB1mFbqxExh
         ogeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779423568; x=1780028368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MlnszKvaLYniJylzFLq6RdE/rVHviJLfN/ZjcktsGLA=;
        b=idFvJ7gH1cDojorMIJzQ2ZvEdYNmP4GDogck4MqlPJyhdbZhX++i5gP0gpgYlrbCU3
         8lweSMXZ/PRSRAlfV+JENp2oc+cIKJ4CxFIRjTDeb16CN3ZAtzt0xLZQxfWplhZaidKJ
         itVlF64+PJikFiAPAp1ea9MnH8kEnaTB/GxGCzuV8H01Nhk5VLML/Yj4yxAswu7haXi0
         In65FDawAFfyGThBDasCBQvnjVCMSUB7HxatVWEvyiX3yXXDC7HUyHrMMoEgHdrNNw40
         GVHnzi01ua5nB8ZrX+axa+f3yWGUXhGJpefm27AxH+X96mlUZ70SqrtUIhhc9S5IP4wQ
         yFGg==
X-Gm-Message-State: AOJu0YxIhOKSwegT1FNDyyEIpNlmUsjvQ+rd+ybddcMiqo+unEasSilr
	9V+wP2FkOWV6Y1roWVnRrn81yPMkVD3hxiP7q6+8VKFk3Sjm6sJLOGZnQktoM47dmUs=
X-Gm-Gg: Acq92OEUWGOgX4PkcF6MaqdC0EEzkyysFvNM/UIeB2Ii5fHFMN1aUR3TFlr4xXOO8Oh
	eofOZ7F9P88zMQlfA2txF3FD+BIKwL6Zb9E/fZGxdSj9yhnhU3F2VMtumsGcl25XGYW2gihjK+E
	co5Fhov8zgonmLtaGUb1MAr3RmykES+UCLNWMWoasGyPxGek3yXXfaG1jvNtjbyD8A3FjimIpnc
	hCkw9HkhqfFo5kDh4RXSx+vHxJ46TyDuJKi3AMtMjErDttEHjVjyZhw8V9mZvQ0OW/WtYHeM5py
	QEj7A4YJLlvTtD7lUzoaJ13C9n4QtHB5K3hy1tr/Ut6q+3jDLdy+V1Ujyc++nBsSCt0UF+qADZ2
	bF+QX0XFF8c6dSXdxFjMS7VaO8IJLadpO3DP647LvUjOhVK6vN1fnK4Vmr6QHj+uTT8gCY6XAGl
	Q9GB/7h/L5DaVmCmz/E6S8d1k=
X-Received: by 2002:a05:6a00:2e17:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-8415f332af0mr1909886b3a.17.1779423568066;
        Thu, 21 May 2026 21:19:28 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ad2ca6sm467296b3a.5.2026.05.21.21.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 21:19:26 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] cpufreq: Avoid redundant target() calls for unchanged limits
Date: Fri, 22 May 2026 09:49:09 +0530
Message-Id: <d0107c364b709abca21acf88072220bc05478594.1779423281.git.viresh.kumar@linaro.org>
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

Drivers setting CPUFREQ_NEED_UPDATE_LIMITS expect target() to be
invoked even if the target frequency remains unchanged, so they can
update their internal policy limits state.

Currently the core invokes target() unconditionally whenever the
requested frequency matches policy->cur for such drivers, even if
policy->min and policy->max haven't changed since the previous update.

Track pending policy limit updates explicitly and skip redundant
target() invocations when neither the target frequency nor the
effective limits changed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 31 ++++++++++++++++++++++---------
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44eb1b7e7fc1..225228e9f4ed 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2366,9 +2366,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	 * exactly same freq is called again and so we can save on few function
 	 * calls.
 	 */
-	if (target_freq == policy->cur &&
-	    !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS))
-		return 0;
+	if (target_freq == policy->cur) {
+		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
+		    !policy->update_limits)
+			return 0;
+
+		policy->update_limits = false;
+	}
 
 	if (cpufreq_driver->target) {
 		/*
@@ -2620,6 +2624,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
+	unsigned int freq;
 	int ret;
 
 	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
@@ -2652,12 +2657,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * compiler optimizations around them because they may be accessed
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
-	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
-					       new_data.min, new_data.max,
-					       CPUFREQ_RELATION_H));
-	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
-				      new_data.max, CPUFREQ_RELATION_L);
-	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
+	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
+			      CPUFREQ_RELATION_H);
+	if (freq != policy->max) {
+		WRITE_ONCE(policy->max, freq);
+		policy->update_limits = true;
+	}
+
+	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
+			      CPUFREQ_RELATION_L);
+	freq = min(freq, policy->max);
+	if (freq != policy->min) {
+		WRITE_ONCE(policy->min, freq);
+		policy->update_limits = true;
+	}
 
 	trace_cpu_frequency_limits(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 4d4b4ed24b30..ae9d1ce4f49c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -146,6 +146,9 @@ struct cpufreq_policy {
 	/* Per policy boost supported flag. */
 	bool			boost_supported;
 
+	/* Pending policy->min/max update for the driver */
+	bool			update_limits;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
-- 
2.31.1.272.g89b43f80a514


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978441;
	b=atZc/3aTyoNoTVld1R3GueyFv5ZC/rD92fdJIG93+aLOoqcsFRHkS3qcIehZslX9CSkj
	 /WWt2MG3iWzhWDudcHqLK1HZaZQquzbccjI6KVolf668kgW3S2qkCUv63XxY7EJIkkXNv
	 SgihjqgumcMiMtZDS17CVmLZqq9J2XZ71v73+uYVWPbk8DeboJM4SUuulCCP+J22Bo7jf
	 pJV0ZCI2EjwnZQLx4b43NFr82BrUB8Zc8EwDyfFgMQrMjfwHYtbeM7BXh0bO5nYpjs9/L
	 fn44RD964evvXuTHX0c8mQ3dGpenLQVV0S6zvaCnxy6l5czXtmDuaeyF23o42HZCj1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
	b=jXpT2OhBEwbpGbi3oFuco6GmCBJ6WOrkIwJQOeHm0VNqVwv22sGKSH6VWPT4On2ygHGk
	 WEROyg9EXXC3MD+0t5PgC7/daAO3y7gnKcFBz/8XMeW4WuzNpagfNNAMOnoh16Ar2oNtk
	 /qTc1e2E5jeJrZHfzwzJzyoaMQORBc9mvvA5Cjxkt29ll1haUiYpvPHLeyv1b3myiWI8u
	 6vgaJSlQe2HeTW0lyxMfZJnt64YncOVuRpWO+CFs2SnRnKO6DvW+Gr/+3F5L7Wrdu9U/r
	 /10SS57HCI3ZWzYCPTh5xvBOYl/lOkzwn6ZLN1dzff9PgB/3fvdgZFH8SELgkOWQpGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EPmVDwt7;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C2606A334
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C7C2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EPmVDwt7
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so425014f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978420; x=1794583220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
        b=EPmVDwt7MDNBSyzasZO/fwgLcTwsfX10VI6Sdmp2MoS1s3qYjTYQuxNhjk6vZb90qc
         HN2Agpl3P/XTuo7joYmQB4KVNmYlWOGZb7oSzylwGaVrwRlb+fWItxP8iDx4kSkB6VRP
         Hjamh0vZb/8dd59TY97RWiGTqgB9kSa+oIhGaHIn4IMppGHKDHCtYgVIetVByUl6GAKg
         xXRyehaAe08fZfWpaHSot1uoijPSCmMqL/INOzycwIvnUqtfMXJ/JZujWGfWsY8Shylm
         fWlsodZ+3u6lfFMGr7gU6BJJXL8ftcwEH50OkaeJk3ox4y3cqV1ZWQDuL2mVHE2OU9zx
         H0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978420; x=1794583220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
        b=pdKpCm+du3qtf50lSCwpgXRpZSmJh+FQhs1iaJxkRWzGaDRkYqRLLFrfsDoX0mF/Y8
         9JY6aOmRL/6zVoTJyvLbb5aJ7kQQ7C/nRcgPsKeMgqwKj3GcP9IVEvr+wwtDxQrEvG79
         nv/ygD3TiayMvh710VrHA+Ns1b0HBjpATgW/2171A0XCwluJo4fW6pvXCGh0fht90vl/
         AF+RKzrPBG9S4Vj5wdyZcmkoPrrY4ZFGgpoRJY3fIzCSyvHdHR9LWyXXkJjYHa4syTs7
         Rdgtaz/g9nbAVmDP0hAUUgSqcSxhUte2IcRAEcEMOFGQUcnxhIey/L59hBRG05c9rxJz
         ip9g==
X-Forwarded-Encrypted: i=1; AL+hErGwQT9TGFYSz07un7pzJjkdBERfGqpy+U0ayTfHMqqN5gzpSCKpW1Livcu4+wcHE4Qu+ljZ3GZcHA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9+++JusFzZF3yQLrxzzwh4NQ56noWN1NbkAkAVhw5kIfOvz5LC
	V27hQAekfmqLKZ5J7xbXfDLk/1kaxJkznPhg6oY0dtINzC7AMiZO0NCcbYigOAkYVRM=
X-Gm-Gg: AYBFou2NnVo9TAmTyYqIB+8nPPlPxJHIuyxoy5Xy4E4ynATZlLQS6vzgeWGHXI1wJzW
	bxpCMS0jqOjC7OUM3yhlp62ncxukQX+DcldkvehZxkpsK9qMr4D7mKsQ5JtdkTxGmiZVZ5tSY1j
	NV5+fp7t0CJ+4+UabsjU46tv1xG+JoFDLCI3NLBrAvco98tVHcCWU7GyoMWs0ZHhLkx7tZVNRAe
	nGYSJf28xO70Z1FVK4++ouLAdoqdc8HEkGGiyBiIbisauMVYhg7ubGOdNFu3CBcghb+ANY9zJ1n
	sSIN6RROduVWP2vBwcbJ8PW1lQ5W5/PW4VR4IR8/rxkYun4ZIUETKIjb7jN6iRZp8Gplm5q2uUQ
	DlSWdJViV2HFyGrbjYgEizUQ/w/xAZm1cE/TR02b7rXzdFIEUfL3msPypWMAYzhoiPuoZSo5e8c
	IYO/sb4fjRNfvPrfn4o2GJXEyaFnhblExX4MNW+BFyLEUIOuVb77c/29IsL5HnIp9jMe8caLJmh
	6HUKCpHyExr7/Xtzmh8IrFQf7Y8cC1jnj+QOjkSLa6Vuyp3Z7ijw8ayRTrI7iDIzrJi6cr4IJHl
	VGIrGjaaGsCQVTEBzZgF7GIWvMOXylHt
X-Received: by 2002:a5d:5f86:0:b0:491:fd47:5df3 with SMTP id ffacd0b85a97d-49272a3aef0mr6257082f8f.7.1793978419738;
        Fri, 06 Nov 2026 07:20:19 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:18 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 16/20 v3] energy model: Add a get previous state function
Date: Fri,  6 Nov 2026 16:19:43 +0100
Message-ID: <20261106151947.3991524-17-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of parsing the entire EM table everytime, add a function to get the
previous state.

Will be used in the scheduler feec() function.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index c909a8ba22e8..89cf109cbca6 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -224,6 +224,26 @@ em_pd_get_efficient_state(struct em_perf_state *table,
 	return max_ps;
 }
 
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	unsigned long pd_flags = pd->flags;
+	int min_ps = pd->min_perf_state;
+	struct em_perf_state *ps;
+	int i;
+
+	for (i = idx - 1; i >= min_ps; i--) {
+		ps = &table[i];
+		if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
+		    ps->flags & EM_PERF_STATE_INEFFICIENT)
+			continue;
+		return i;
+	}
+
+	return -1;
+}
+
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
  *		performance domain
@@ -375,6 +395,18 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 {
 	return NULL;
 }
+static inline int
+em_pd_get_efficient_state(struct em_perf_state *table,
+			  struct em_perf_domain *pd, unsigned long max_util)
+{
+	return 0;
+}
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	return -1;
+}
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 			unsigned long max_util, unsigned long sum_util,
 			unsigned long allowed_cpu_cap)
-- 
2.53.0


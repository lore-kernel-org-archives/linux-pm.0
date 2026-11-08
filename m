Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149435;
	b=33RGNl0fL8DQWxWiIfLuxetB7U/cgOW+KBa4/lruDnoNX8rpgIvsXouO8c5T/EVnZ29g
	 7Le/TmSZaH6lJD+XpjqG7I7JzqG1+yKXFQttSA0zkDdx3v/Jpu8Rlkj5QG8+FK0m95He5
	 fBT0n6BhTT9uQOe0w5v3tINSl/NFAHlT4zZSNgLykRd/rBITRD1ktXys02878LivvGr3+
	 oT9/0aCIX0EWfEVB5PzMWLpTYIS9jcCRQfdCzvF3EQME64nvnWMmc0lyaD8MJLE1lv6T8
	 Qh8pXMr0PiRMMyPCGffE9YqqMfeJqjpPvJJQOQck+HzZGSPNLlr81QKtSAi2QnHvfdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cEyRyjk6OI+iUhMYK1UgnN10zyMryNz1Exvd9CmPK78=;
	b=HjsViGBnPXdb94EAv1zg7Ro7WGDjGERgGNoRljxbi17Hg6uj2HhFjRzHShVsPiVKxC+/
	 wDEtGqKzpx/1TeIDDIwXZzf0rph/kydk9aZ5IgyTLfItRGf8ZTHlnwfIz/+ZQ882AJM1T
	 l//m3DDOBM8gjm1yBKqRZMs2jU3aa/g7AJ3MyCYFi/aZnBsxkiSnHOzW6F08Y2Yn0VTbS
	 zlEvzmURSJVtHXJ9lD+UJmcZB7MuonTWt8k7eM4J3vGcwKDiGpQHt9qYhb67wi64Mtl3U
	 xqmf9lSoX5hLz3NifLse5LHeBURalG7AILlIvJsExVIq+s9FBXn7F/TuwrUz0h4PW5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uz5or+x8;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF6606A320
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 14:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EAF6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uz5or+x8
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso472035e9.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794149434; x=1794754234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEyRyjk6OI+iUhMYK1UgnN10zyMryNz1Exvd9CmPK78=;
        b=Uz5or+x8VV4+vxKRyC0WjD/O1dt6rPOP0C/8LCbhHKwxVQU+qvISn1+YlDEcQk0vi2
         Vp2FN2OOS9j0GTc8fv3Qot/kxnIAuCLpiYrjLJfVJGrV5zDY2njPfz9yqrFjR1QTtPJt
         HnjLqnpirqmWaiFK6pP6pOGy+jIuYi3DV+UeyYhlD7D7UX4iuHzugrfW2BdFwRFg7MXz
         X1IVipPFQlbtFM9eKU2KkTBaZV0JNHlgtAqQy71PWhvB+5644zwrIghsmZx4Ku7zos66
         +T7eCVKI71z0+/WyWjyhp/uXKLnHblQs6Un66Dt2yntxJ7enf1skwtpbmdl14P+p9Q/j
         jARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794149434; x=1794754234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEyRyjk6OI+iUhMYK1UgnN10zyMryNz1Exvd9CmPK78=;
        b=JZmKxknO84ClIVQuCKS8QHLn6cltDjAas5otTpZRRa0lmzVT0reSnQdDxNMvscx7pL
         m8AGnyTrgFC0Ba5yMEitI3hIMQi4gtL+c1Ya3XMywBXBS/68OYCrh5imCIjhbIUw6Qp3
         hKzrGSqy6oBryngaXRqNIgtbl+n9K8L/CEHeJjzcU/0AKSGaOVAXdPgT9Rhg3ylQmaxC
         ehx83IBCZWpFLJdfidrpeUSQdqH+U64fReRrfIY+oXpqWEwvf6UONjdobllVw/oxFYzt
         TXbqvICiS7/a6XSn314O94p+EtJJUv0uMX5KY+8TWDF5DCNfotI+Z1tIgB3jiivXnBp3
         hxsg==
X-Forwarded-Encrypted: i=1; AL+hErGC8df1Q2SVevjItRLkghBRzTScRLxWA4mMlk/PvXd3G7PYaPKYD/qUBsfQpbKBblEhoApjRrUlQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+uBTted3t6qPGApWjnK48/1HUN4jclpwDz/3PC0Jiws1H/XUrf
	DD1EcjWM7U0hjNJF73U0Dndd8al4kW0gyesU7L+mN2jUPX2AP12Mhfzb
X-Gm-Gg: AYBFou0C/j/olXLvlsDlmdjuzOUTQW5xoO7wIPCwpyQmRkiegO/6ga/UzpQobUGAU0q
	fpAqKu+CamF3kPOTn7mR5Df2bfLK8BH/ix9dMRQJfdbXucbF+KlNKJF/tLUDj6H9TYG0Gn33+bn
	p4MIopclfUHmqoPii5vifgSMZzh1mhb8EcktXRqzODqD1md92soimj4rpWi15mNnoc66ZNFn8Aw
	nqrwMnF9xrGqQsArLEXYpMyx0Kw1mPwOhIMuoB4Ckup2DE6/A5a5AUzn9SmPSABtGnp+opDjJ4F
	FovAAU2xRL5XNNsD5G6v6X2/rhGWecrZPto7OLVTY9IMSuQzS4iuzckcRQ+txhUs2VGiFH7/J6J
	l96IzNXzna6r2akN5yzI95Arz5HSJnYKvZMumAL3+QMFwzpJCIvvh9RkSmxcdSAcf02Et+w2/4S
	zy6t1N3QywphblEmX+WRz9Kt/MYnZzEtptpVW4oVH+Yem4MsXwcJCgjAbrGskwt8IZd8L6myWXe
	8020je1YlewcibAfgeFvclFRbDhF5PHcfiZHR5n2eQlJthZ0GwIHUb+QpSX4uQ3ikEPWeS4RIlN
	m990R8LTiberLKmiw5itilY5QuW3gCYOg19T
X-Received: by 2002:a05:600c:1d08:b0:4a1:f377:5c6c with SMTP id 5b1f17b1804b1-4b960d9bae2mr31054665e9.10.1794149433516;
        Sun, 08 Nov 2026 06:50:33 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:474b:1700:5392:d94f:6171:6773])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee2b8c0sm69612945e9.9.2026.11.08.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 06:50:33 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	zhanxusheng1024@gmail.com,
	zhongqiu.han@oss.qualcomm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is inactive
Date: Sun,  8 Nov 2026 16:50:28 +0200
Message-ID: <20261108145028.2483131-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

sugov_hold_freq() uses the NOHZ idle-call counter to determine whether
a CPU has been idle recently. When NOHZ is disabled or fails to
activate, the counter does not advance, causing schedutil to treat
the CPU as continuously busy and potentially prevent frequency
reductions.

Skip the busy-CPU hold when tick_nohz_is_active() is false. This
also handles systems where NOHZ was enabled but never activated.

Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
Cc: stable@vger.kernel.org
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
v2:
- use tick_nohz_is_active() instead of tick_nohz_enabled to also
  handle NOHZ enabled but never activated, as suggested by Zhan Xusheng

 kernel/sched/cpufreq_schedutil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 14405a614991..50249cc1a594 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -397,6 +397,9 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
 	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
 		return false;
 
+	if (!tick_nohz_is_active())
+		return false;
+
 	/*
 	 * Maintain the frequency if the CPU has not been idle recently, as
 	 * reduction is likely to be premature.

base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
-- 
2.43.0


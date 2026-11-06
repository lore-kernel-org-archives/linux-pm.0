Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978416;
	b=XUmFhpAwtvaX7QiNr2/seLYjaQ1HEA2WGFf+y/YSz2Qft2dlmFFH/3GagXPNYAMIFFXv
	 UqTMcLmo+drOrY4qR4EQgIGj2g+as1wS3pePK7usaocElZu4Lu9Q0s0cY/llSePpvk9eu
	 9sUcmAcTeSxs11pZeDz+PkZaSZ3aHSrqAHAQf8WnHPFnC32kWz+pp4R4yepiChsNEE07Z
	 9sQ1fXkayIsnlPDBKz4qeyDlacXvQrLLYY92y1II4byH6+kqPLP9In2NgEG30kyCQK2o3
	 6Df3VHqXugs3OqOakIy0J25rKUal3g50NB22OtupTJb4CwWF2iHwaV+yX3iD2gOwtoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X7cjgrh5Yg6Kt2t9tmwbzYSsxzemzPkOn8ZYOdbmvek=;
	b=V30y8SoYhlI4s9FdfoMTsaMFmxTCOyGXBchR6CDu/8ETpuaFtXd8rslv64KsGTcl4zYN
	 8V0YFaNqvEM1QexmuQL8toVShQv5ErFLm/KvPV6nWpE8G8fGtZflvWgbkF4tYvPuxZHf/
	 oygVUk+qT3a4VRfF8uz1UDV5zrawVNLG1QGmo8VY5p59KhWyJOfQ/kNBbDyg4VXkOJapu
	 jSZIM4YQvJg313yMx7SRAP0KvIVRJaq5az3S0TPNrbsFoYw6um/nysmDFSjFDiqQadbFx
	 F9Mx4rC0aSBliSSQOUpyCPoKGH+FljoQDaCrPLURmg8HT134E9+1QUUXQhSD1krx3OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v3rkNR8c;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949796082BE0
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 949796082BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v3rkNR8c
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e4831c028so773882f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978414; x=1794583214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7cjgrh5Yg6Kt2t9tmwbzYSsxzemzPkOn8ZYOdbmvek=;
        b=v3rkNR8cc8u0mM6I32Zs57dGK/AcATh7qjOpbzCxROaoF59kzHGoZU7fR5VNljGcse
         tOjzTDac6/QgSQn5vM7xTHTJyo+I2GQl0qgxTNIk+APVQy8/+f9T6T+lGfxQfdpYCdtY
         cGuAAU2KTVuEZisxKt3Uxe3PHNCxY6rE2EwkWpYck3KhqMsUHsbdqB6SS2i0DTVAfRyk
         lHFnZs0jaR1EwRZQl3LC1yt0Gxy0OnXnwjTwG6w97KujtR0FG/pI1aPvm35xn7XjjLeR
         H9MG/mLZck9d49RI2oiFjJHpMu51jmBnmHIp9ER5atOP1rYtnu8gPpFpWVvm+lp4RyPL
         yvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978414; x=1794583214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7cjgrh5Yg6Kt2t9tmwbzYSsxzemzPkOn8ZYOdbmvek=;
        b=ytBY254MOgXWxLisGiq0E5F3shEuKcfqrgLQZCAKPkZMQs929IxuUReZUr9ewaJQb5
         aTbYW54ewQ5SzaLX4OoLcLMaCrbwbUvUPD9oi4FfdY52bYfgTZvhZOjdvcWCCySQnWsM
         N5KV6yq/MAB609c7ul639YTzEmG/56YoDHmQsRKU4+mKrTTbWASyFh2N/xAtJQtI+41T
         Fyx8C9K6zOb7rpd6owi+PYmrypRhFGGs389kr/EVjg43wNxxBQ3hUMNqs00kH2rnn3vo
         DgmTmIHoqC/G0dazmZXBUL8SawjdhrCLvgUTsgHiHq4EyuUA/AvbH6a9nP4VuBeZsL/s
         4Egw==
X-Forwarded-Encrypted: i=1; AL+hErHf+U/SMyr93f0gnSz9e3WuoLimX9KMPucssXi+KPD99Fs3bYKF9rROVBTEowmxfXF/X+vJx/t+3A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/3TByo1+8PSgZvCtRsV0cSSC0USY/p9hGXsPXyj53FbGbOkZlL
	vmp/6wo1X6yww+vMfLhbGBZR6uohO4ullX945IVt7ByJostfm8CaOFUMrLv+YJZSstw=
X-Gm-Gg: AYBFou1gxUwbFZGl0AMQR1v8yUKRneyCxDeXSR+C67RtnvHee5nTvbfKBbwt8ASatoq
	sqb5zuoNnbd1FTC00bGFTS472iLpojIHzeihzrdLRmLf0abK+3Pb1igJoRI+sFYSfWdlACmRiQs
	cNJjPm9JerAl5Peqc1Iu9DaeAeFVYjOxnFqoVmifCinDQfeOplARZDbAAV+tFGT5f58kmwJfJIT
	20slE/fxZmGb56F1YrYUd2cqGZ9d+Ji+HR51+UyE1uq8RsTtXfY3jcES/41S7OMN0co/utKN3OV
	KYyMQlL2cm1zmHIkhr7SSgMtu8UkFcjN5mtXYVIBN+fhbh1GJ9SLyuFjQdZAsSUNmuT+T8ZVDb3
	RF6peJdLgox5rLIxv0rGkW8Z6PMG41TGvl5ZSp/cIU7OtsrqQdLT8BN1zZUZa/DDEM5bK6R37F0
	04gRoDy6QAr51a9W6XrtzkEjALBsX4/IUbhTu2sAV9EaWW0u3EmF8mBQPHrwIiXJFAkrmGPRgRb
	uEzRrytTMwAYRcURJoFbeCbtYr4cH0zgBWBFIFtEyFeVtQMDHazNShT/4A5TDRWKO0g39DyBFlA
	c9XcRXIahXARvZQ/tFnkLk8NP28lSPWuuXpOfk4kFkX77l4=
X-Received: by 2002:a05:6000:22c1:b0:491:ef0a:1f5d with SMTP id ffacd0b85a97d-4927678d572mr6661924f8f.39.1793978413847;
        Fri, 06 Nov 2026 07:20:13 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:12 -0800 (PST)
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
Subject: [PATCH 13/20] sched/eevdf: Try to push short slice task on a better CPU
Date: Fri,  6 Nov 2026 16:19:40 +0100
Message-ID: <20261106151947.3991524-14-vincent.guittot@linaro.org>
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

When a task is put back in the runnable list, we check if we should try to
push it on a better CPU, i.e. when fair is preempted by a higher class or
the task is preempted by another fair task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 980eda9c935a..3923587b66e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10112,6 +10112,23 @@ static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
 	return true;
 }
 
+static bool check_pushable_short_task(struct rq *rq, struct task_struct *p)
+{
+	struct sched_entity *pse = &p->se;
+	struct cfs_rq *cfs_rq = &rq->cfs;
+
+	if (cfs_rq->h_nr_runnable <= 1)
+		return false;
+
+	if (!entity_eligible(cfs_rq, pse))
+		return false;
+
+	if (pse->slice < cfs_rq_max_slice(cfs_rq))
+		return true;
+
+	return false;
+}
+
 static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	if (!__check_pushable_fair_task(rq, p))
@@ -10120,6 +10137,12 @@ static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struc
 	if (next == p)
 		return false;
 
+	if (next && next->sched_class != p->sched_class)
+		return true;
+
+	if (check_pushable_short_task(rq, p))
+		return true;
+
 	return false;
 }
 
-- 
2.53.0


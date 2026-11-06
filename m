Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978398;
	b=Y+YtjXxOAJ6Q35VXdnLEv1s894963fEHQZ0g9G4axxp0BnO13HxpucCjIxvBeOd0kMFY
	 1/8Qi5w/eFy3xFwwKrjocaBkJfaIWMHVQNlkI4iTq5eNAdJ/q+7ae+wl2KLdmkYLbO/P4
	 9Cvnm4ycAMt2Lw2GAGNLAv932RZdzSn0mAbvGDsye0qyPYhfz2o9c+NvvWfwEbMvTF3rn
	 F+8JmdriSTjbY25Co1DuUW+kh2E72jz7SocrkKpwNwPw/I/AsX3F5tsS2BfhzeG+6mjBY
	 7LHHwZmk2+4RwoymSGPHDl6/xq6ehMKb5S7KYd5dMVsW8Y3G/+BZKGkqZRLIo9HKBfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lQD/JukA7YFLaFe55TCX0scvCEQxeNBxiWugJcrZ3hk=;
	b=k0nmLpbrIt8cqb3KO8pe87NGHHZ+XROz/yhnFt1+FnG8lVMd360pC8niRqxtqvGujcsN
	 9EefGMaVge6TggfWeiLHxzRKQGQLT+du9eTlyUJ5kuKqQ3mB7b3IWJkPMUF7jkeuVxurI
	 deI6TiYW3XqWMQVCoDbMDWqqYEXCqX2mH9op1QzzvTQV1Q9LNA8+rqa09QVqVIU61BYS6
	 LulPaokOIBda5FofvjjPpONVYDzIFIWQ9JlDw1Imj5ikxu4ALmd54x+5860It1jZ+33XA
	 RgbQ6uRdDEZlHEZ3H1Ph94HRZT8hheV+QE9empMBfb+OE68jzs4p2yxnpqZoW6BCb+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cRp+jICZ;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413D606D803
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8413D606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cRp+jICZ
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so5374465e9.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978396; x=1794583196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQD/JukA7YFLaFe55TCX0scvCEQxeNBxiWugJcrZ3hk=;
        b=cRp+jICZddLUG3WxwpMKj55RPYwFKHSIVGChBaWvHD69EMEPmxvR5HUnetbuB+oWsS
         hXILm/YLbDHT7bm7w6IU06nqn32YkidOnv+DPobYE23Xbw2svrz4sngMunXT5GL+ETgF
         g6dnXybVQ8pk8FPjrcXNIfRKPWd7ggmTquisz8YidcySKFTMMNR9fUH5kBJJTYbXQx8I
         0QgYyC+BasCiy3lGY+DfeN6sGtz+/ZU2gUpvRNxzHn3QBsllJuYelJnsuiq6X+mWb+yH
         T/Dv1Lon+jmszQyT9f4j9ghYjSTrv8ttx45yBOP52+SShuh2jguv6svbiumQbcHe1vx5
         1abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978396; x=1794583196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQD/JukA7YFLaFe55TCX0scvCEQxeNBxiWugJcrZ3hk=;
        b=IMV/ZXBQ7oDnAqtBMTxdIg2n9dfJjamk0WY0egm9aoC8wtcJM0Zh/ZQ5SaJTASVeFE
         3gL0Uwta2wXGZv7OWhmNsh4dGeJxzJy3JU0OwpdFus1g473X28bEGDtGAQYCTYDVPl2f
         VXZk3/HNP7WFLC6SKS9ig0tORnyFA6jdYLA7uV527w2Tkv3Y3hHR6Og59nAGNl0nCeju
         3/Z/462354fgq9zZiKvR7FzZFcqQP5oO/IqAONEEdJimMNFk7K259d74fFe5TEm5+Ws1
         zE6TiWhBCLVeska0N/CM7pkeksULsByPx4jitcf+Q76bDQ8DEbCPh8t+vBD4R4FUnX6G
         pUeA==
X-Forwarded-Encrypted: i=1; AKwUvBzjEGI/ibcyDMn/eHv8JF9Glg7MsMVvcyPkYn1LhFFtnNUwDAN5jdGuUC1EZLkh81rGZZ8PpIxsXg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/UhaaX4VjOdCtbdsCV2mGkWF+s5TQOPpI4ngkEix77t7eP0anI
	X4QAsrztlgKVaIwytBw3Fxecsw51Tyf4CX2r5Yjw5+Fo5ZI8AVpJssuirXle69zGQow=
X-Gm-Gg: AYBFou3kWioHmKzBMbGacOp2JRNbtgE8gPLlcOipaOKZevpR/ZNoWvvmCs7x3yBCAiX
	wO/9rHRA5eYBLjzc5h81y1sSJUFH1JMePO7vg157ZjasoY45MNAYh/Gav2MhP39pDKJHdD8wEQG
	bWEnBqHJC8zRTfsALgTH6kGdhUHc8LSF/S9oWGgpkIcOf9IX9iief7DGp2J9i3W1dr0GM73oH4n
	F9+GSQIAY/pak0s3b0mhrnfM/sXCP9QPiX3kAZaLE9XOW8I+cYbK7NCG/tlRT3SoNqHqMosAjKi
	9vn5XvcGQ4lUnHwCuW7B7AVfsF2l68qBFWk/XF/4s0amDwdgHrbfRkBMZCLYVf51p/IBaBDFTSg
	Fl202BGpHymIqME69kYpzyEl0BfPpBtuJYoBe5uKK10soOyfj2FvthXwwrugpipnoAqpYBZxBkz
	5F5yWBiwC8iNI9YVRLlj5o9XDj8A6d3UP+OR5koCYLiXnHrHmezbDiv5npyLUSV5CLqEguPSDEC
	vZi7cntuIYcqD2p0doV+lhve6e4y83aHF+Hh4FAWMryH2FxykS2t29tNJhMAbAsEMgP/gEqL+DG
	Cjj1k8Hc2J7UxJYJMmS3rZMXRyHQZDkvbg8QyFRFW/BE/3I=
X-Received: by 2002:a05:600c:6384:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4b6de9739f5mr48102355e9.21.1793978395940;
        Fri, 06 Nov 2026 07:19:55 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:55 -0800 (PST)
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
Subject: [PATCH 03/20 v3] sched/eevdf: Reset lag at wakeup when migrating and prev has been idle
Date: Fri,  6 Nov 2026 16:19:30 +0100
Message-ID: <20261106151947.3991524-4-vincent.guittot@linaro.org>
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

When prev CPU entered idle while a task was sleeping, we assume that the
latter received enough running time and the lag can be cleared similarly to
what happens for a negative lag.
While migrating the waking task to a new cpu, Check if prev CPU entered
idle in the meantime.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 79f53811274e..945de0215abb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -932,6 +932,27 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
 static unsigned long task_h_load(struct task_struct *p);
 
+static __always_inline
+void entity_clear_lag(struct task_struct *p)
+{
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+
+	if (READ_ONCE(p->__state) != TASK_WAKING)
+		return;
+
+	se = &p->se;
+	/* Negative lag implies delayed dequeue */
+	if (se->vlag <= 0)
+		return;
+
+	cfs_rq = &task_rq(p)->cfs;
+
+	/* CPU has been idle in between so the lag has been removed */
+	if (se->vlag_seq != READ_ONCE(cfs_rq->idle_seq))
+		se->vlag = 0;
+}
+
 static __always_inline
 void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
 {
@@ -10049,6 +10070,12 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	struct sched_entity *se = &p->se;
 
 	if (!task_on_rq_migrating(p)) {
+		/*
+		 * Clear the positive lag of a waking task before migrating to
+		 * the new cpu.
+		 */
+		entity_clear_lag(p);
+
 		remove_entity_load_avg(se);
 
 		/*
-- 
2.53.0


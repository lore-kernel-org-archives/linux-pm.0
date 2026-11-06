Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978414;
	b=surFhZ5/LPIvFdCnNefqxydTGW/tC43a1kyW9wQM4Pz135q12Fc74VKEIFs5dCz10vl4
	 gpIbMa7wE3sCwTOEwxXb0puMd4EBzzmhVcxFSIaJeI7wbz1wc6Q60Tyk8TWvMs8NpGt65
	 6cmPJ7W0CnI+mVbMRB3kHthUETBTCbStJJ4/s6+0gaDH8lKZn2R7cyPNYSzQZcLtOsWvn
	 HacNGIysLXqDD1BCZ+2s1oQOqvw43E54Y9YKidpucaw6vjLQ5e0ybgbchFjNOMxepXw4G
	 KkSJRFzPyaui36vdA7llO26VWuc1m0T9v1QKxQ1YCsrH0PPEFQ7jf4wwP0JdJpeQrlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uTux42or8tslpeNsQeZIKjxhj1hCw7fR6WEWeRorK0M=;
	b=vYF22z/wMCY+UN+LGAXsZ0UaCXUmVOI8LlAq1HVZIPtYOStg4lxyUmaYs/7xRE8JTpnV
	 9J1y5FcqLFFwBc1jYy4UmRlAGPeag9CX3g2Aak6l6i1Ax7Grx6rk+nY7OrRvtzxFdbO4N
	 OfzSEQS1EqZHq7Bae1ztpLa3D7sIkGX4LmgcS1jsdfZRocB94EtO5xgCrGu8+/SVYBwnN
	 4pt5078h+a+4P/yZw7Z4ArXjPd5hafMR6qAy1l6MDuQHdVSlj2SbTZDpwFnp7m5HJZJaD
	 GKD/t4lN6fYCsyAIH9mkfOokrWzldDhd5WHMF+O4sRHWZg8Rs3JJr/xtJTn0EKd6aCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WpY12vZq;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B906082BCC
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B906082BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WpY12vZq
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-491971ac844so670289f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978412; x=1794583212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTux42or8tslpeNsQeZIKjxhj1hCw7fR6WEWeRorK0M=;
        b=WpY12vZqX9HaWMiktbe3oRxr5j75D0BUxxbxanSa9dzlMNfi2+8Mg4rWPrIlVge5Ed
         tGK1SqzO8ieW+6T3iMtcIdp4nKgjj96tsOMyrToe9zCVb8ki+NOcCYCcQXNGYHNVr6z0
         QhiGqk13/k7qBsoxYxgxw+1/6PhgLo2mMe3OIjNFWir9P9h2+J4i+82WhAz3W58ooJZj
         XzD8hv/kLcr8qOaRrcz/J3cRl74oo+VyEjGiuSoNfliRv/gq9YlpbjNzaTQVzlYWbzPt
         +uQuu/2OJwBgB3s94xOjgse7mY2AqqSlsgZpxu3oft2ZiXTmNw53ngVO+cXRpvQpEfcD
         R6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978412; x=1794583212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uTux42or8tslpeNsQeZIKjxhj1hCw7fR6WEWeRorK0M=;
        b=vSs+4MKMFvH0OLRzIrQLYmQV2KZ910SSos3SZnqT57GgmK6aSJBfuP/cP9Se3k+U1x
         scY2RNGES4mRBioMwa/aeQzxYAFYhDQDzOxyzJ2Xza5uafRmzhtbjvtFAtG07vSl1Hzb
         K5HK+so864k8jJaqs+xMjEuifSyhHkCvWyUOWcmqtQqAcyRNC/9k1SEr57oZIAEKj5Tw
         o1QwJBTKAbXcyTSUypFvIh8rp7qwfp5oigEZRr/lMIGwLP7QtRm1SRWqWBLUf/Si0tnM
         mwpP7I0G/PKwz1lhndPr7krrJF4DW0ealSu78SaYasMcKlSvuwGMWyChHSJhcH21awIw
         Uh+g==
X-Forwarded-Encrypted: i=1; AL+hErEQnW7IUEeFotB2Ozyh8Pg91HEprVN3VfdoIQnG9ctMW1RrCMwIEa3tYhbZS0FvRaqhpvGfon/qlQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+BLLD1WimAJdzDLqjPjyRMupncWBDOG1ZBa+hQ70WmlGq/8Blg
	i7isaEYz18HxhZYIiXS5Ct089jKtM2UTWa4FcPC8zsbss0cNJJHkxKtOApCAdSbknBk=
X-Gm-Gg: AYBFou2FUec1+Ti/hB1ZY1OZ0caOnyUgqX8tugh2Eng24prtvkNAYSHJbjAY7DXljPW
	BEKIRbcWcD/4w4tvGu9OOALHMk7Zrnxz/TPlCeh9JArmwMwkWbCCCo0Ck2xRycsEFbS01R7ALJU
	/jmSApH8bSJ2aIIPeCwYQlXzPA3O5gHjDaw8Tfcg3UOGJZp4XWMywaRi7/Pq/KAkHtWPv7w2Qqb
	n0iuj55mATE5XO2c5A8KrUWs03K4Am+Mm8jYAg4L9kAaAndLTpKcQeokEeF/OChLvTjwa569kY/
	xY8tMYNMe2Wm7+qdsQwS5klOgKZ7JLjnTKh9J7DrKnLlPghQZZgaQWdQTVPig/gdiDx0mtdzNSR
	LhTQ7o5a6oyVGAU7bU5hGZyuUaCfyUo+KPNzbs4uux68WTh2a7+6WFYfS2igcXy82mK++SI4pyb
	7U1C2J2N4LzgUfe5W3Yhy7+Fcwcdp82sVZYpbuX+wD0BrYhm99bvTbzXTX92PqJz1oO1wkVmrkg
	LFN39I+KtJecxzJWJ01eTAvmlp4+5vhw/2cytXfajY6EiWiBxlYg+TiK4lzdhLEjOpP7wQnpbvb
	oSRqWTfFOFVbVxV6HOOaPdM4x44EQd7LvE+IepkXaiSDkMg=
X-Received: by 2002:a05:6000:25eb:b0:490:421f:1555 with SMTP id ffacd0b85a97d-49275b1bc23mr5251354f8f.22.1793978411922;
        Fri, 06 Nov 2026 07:20:11 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:11 -0800 (PST)
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
Subject: [PATCH 12/20 v3] sched/fair: Support not wakeup case in select_idle_sibling
Date: Fri,  6 Nov 2026 16:19:39 +0100
Message-ID: <20261106151947.3991524-13-vincent.guittot@linaro.org>
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

With push callback mecanism, select_task_rq_fair() can be called for a
task that is already enqueued. Task into account this case when choosing
an idle CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f2a0d2c2bb63..980eda9c935a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8187,10 +8187,27 @@ static int choose_sched_idle_rq(struct rq *rq, struct task_struct *p)
 	return sched_idle_rq(rq) && !task_has_idle_policy(p);
 }
 
+static int idle_rq_without(struct rq *rq, struct task_struct *p);
+static unsigned int task_running_on_cpu(int cpu, struct task_struct *p);
+
+static int choose_idle_rq_without(struct rq *rq, struct task_struct *p)
+{
+	if (rq->nr_running != 1)
+		return 0;
+
+	if (!task_running_on_cpu(cpu_of(rq), p))
+		return 0;
+
+	return idle_rq_without(rq, p);
+}
+
 static int choose_idle_cpu(int cpu, struct task_struct *p)
 {
+	struct rq *rq = cpu_rq(cpu);
+
 	return available_idle_cpu(cpu) ||
-	       choose_sched_idle_rq(cpu_rq(cpu), p);
+	       choose_sched_idle_rq(rq, p) ||
+	       choose_idle_rq_without(rq, p);
 }
 
 static void
@@ -12968,23 +12985,21 @@ static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
 }
 
 /**
- * idle_cpu_without - would a given CPU be idle without p ?
+ * idle_rq_without - would a given CPU be idle without p ?
  * @cpu: the processor on which idleness is tested.
  * @p: task which should be ignored.
  *
  * Return: 1 if the CPU would be idle. 0 otherwise.
  */
-static int idle_cpu_without(int cpu, struct task_struct *p)
+static int idle_rq_without(struct rq *rq, struct task_struct *p)
 {
-	struct rq *rq = cpu_rq(cpu);
-
 	if (rq->curr != rq->idle && rq->curr != p)
 		return 0;
 
 	/*
 	 * rq->nr_running can't be used but an updated version without the
 	 * impact of p on cpu must be used instead. The updated nr_running
-	 * be computed and tested before calling idle_cpu_without().
+	 * be computed and tested before calling idle_rq_without().
 	 */
 
 	if (rq->ttwu_pending)
@@ -13027,9 +13042,9 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		sgs->sum_nr_running += nr_running;
 
 		/*
-		 * No need to call idle_cpu_without() if nr_running is not 0
+		 * No need to call idle_rq_without() if nr_running is not 0
 		 */
-		if (!nr_running && idle_cpu_without(i, p))
+		if (!nr_running && idle_rq_without(rq, p))
 			sgs->idle_cpus++;
 
 		/* Check if task fits in the CPU */
-- 
2.53.0


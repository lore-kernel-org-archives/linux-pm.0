Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0454F4CEB
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955936; cv=none; b=jHDKbVFWwslZeN7czJrRjHyLXH4zdzCxjkC2+v94nUzaZlXfCUIVg7MPyg+F3ufvBHqxKJdz02ANjbDR0T+NSk1qqtik+t/TyMMnY8jJ6SLZefimDOY6bmEOwIVEWWRXZogAvz09zmZoLtAufcr2ORZYdd8dq3U7eADW19rdQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955936; c=relaxed/simple;
	bh=ggoTRpIipo8tqYS4OC5rdC9P6GonVqjlFQkkxo9kZmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmPin6hkDs3btXWi1HiB+I8AoQMyIznS0tPwE2Zm1YmEo2rSZXt7d4kAdhTHWGR/GgImWhsZdrk6mbyLvWG9bsDWfT4TEv7doiluoJwrDN5ikJzn8rabsicIXTLbHWm8b2QKTMyptKNPDvU5NuClQA7Mhuu23vbRksCh0bpxHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zhHLfqS6; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhHLfqS6"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so183445e9.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955930; x=1791560730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+9o8MqrHYpJJITgMWl7mhC4JEDEuTdaJ3vXHPZaTZo=;
        b=zhHLfqS65QYZtpgjTDwgvC5wEtkTS5jmuA6hyQs44qa5zPlp4nfvbjgthN5TbUKxTk
         jDCzokOIoX9H5q7sy8BxS2mD35SOmMySWlFdMcUpjAVjISL65jjb17VO7A5KfE6b1+DL
         EIec452lQGpiltfIPVTg2pe8j6p1L2mngJKoTsGejueE9jXSLILHbuiBa2QYhr2bzdON
         wiwoLqdH4vk75SOISmD/rkX9RWuzuFR9TAfdZg5xXdf8SkVKcBcRUGaF4vxjbzHyJ3zn
         WajYkJy9SfB9FH/Z9rYs1+SarC+BjHiP3S/lm7p88uH4qoSGYWHdC/bwTY+EAbsMfOgg
         A1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955931; x=1791560731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+9o8MqrHYpJJITgMWl7mhC4JEDEuTdaJ3vXHPZaTZo=;
        b=XMRQxY8qVG8guXKmRomG0+nN88YJFnl+vBcQdoHHcuH/LXlNYMBK4dcZkOZ/c9V4xC
         k/1dPYlAy2pyJ9i2Lh3Y9ZAAwdhfmzUXQnYlYHT6LpjpxJ/ezdcrTHA4AgX1itn1rn8z
         nYCO/qcbmGfIIP34iPQYjp0edcCCXbMSf/cDt8SFamJ4uUsw5GJNul0xbKcwyXYDSOCl
         noRqbEgt4aeX18aHrhsPCw56p0Qg59wBa1ULJ6EaC6QjeKPuaS4emPivzc3pOoRNGFSD
         CNgkeb/uFepfa1BZ5ngyn19EdUoYLj6vBBx8oIdnW9DbqyoYJLNkdsIRTsf6O0Wb0duT
         M49Q==
X-Forwarded-Encrypted: i=1; AKwUvBxo50/Mc4kwKVJGazSQkFxIj+qWm19Om8bze67j+tdPFixoMgZUtlK1D9NrKph1mXkBSHaWu1IyHQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kDIuGXwFC+Y8AtK/UEFnA7AK8L/rODx2hSGOxC7wxoe3Rutt5D
	MtKxCAs3wqbXMVHRjvkBvx1qw7Dn0ebq5Qv1Wu6Kbu9obfQrJSGrIpuo1W2W1a3YgQ8=
X-Gm-Gg: AYBFou1dm0Pslc9dJhmkdt5hUxQSAaKhEblvLUvManqaAcmTzJAscvqke5I6PFy4kKt
	O+cle2Dbm4QtWxec504teAPXxrEv/NXPTHj33e3jhbUG1ILMW2oQrsBvGu7c6SCk9NXxsaTs8A5
	68OcETGtCuGfjbLlhl3/4eBaqP5HijtWtzgv4ZNSCOpY4N01amKmMb2pvOa/mB02t6uzhNvQfq/
	QLce9bPP35GxKE92WRlPGwxE5z/CeiKzxxNOWxUO/Kq55yxxvHrE8Zo0W8zonXoe35kaRLrUB4f
	VSXZNcKOBOPoQMcK55OYLPjp3OrojtCtHtv+VNO/oi10Oo7CEcN66MIHgggio7gzRIrBu2umlKq
	6qscfBGtEzHiPutIibFI0kiXMYJ9nN6enwkw2bOp8x9yyQNUE7iQdoTwgl4NbLt0AezlW6STs0s
	1xGHBD2qOv2bDWlWYBXB9kVKrugwccLxQOacQZyMwBcwQy0QhGl6zGY1areT6noarNdl9UM03TI
	G3SV+fpqTzKR3fi
X-Received: by 2002:a05:600c:46ca:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-4a0274f96a8mr58318145e9.1.1790955930554;
        Fri, 02 Oct 2026 08:45:30 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:29 -0700 (PDT)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 18/18 v2] sched/fair: Take into account slice in EAS
Date: Fri,  2 Oct 2026 17:44:15 +0200
Message-ID: <20261002154415.2270586-19-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the cost is the same, take into account the slice of a task to try to
select a CPU where is will run first.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 94554f165f42..d60bb6db4ce9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9598,8 +9598,17 @@ static int check_cpu_with_task(struct task_struct *p, int cpu)
  */
 static bool update_best_cpu(struct energy_cpu_stat *target,
 			    struct energy_cpu_stat *min,
-			    int prev, struct sched_domain *sd)
+			    int prev, struct sched_domain *sd,
+			    struct task_struct *p)
 {
+	unsigned long task_slice = p->se.slice;
+
+	/*  Select the one where you can run first */
+	if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
+	    task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
+		return true;
+
+	/* Favor previous CPU */
 	if (target->cpu == prev)
 		return true;
 	if (min->cpu == prev)
@@ -9762,7 +9771,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 */
 			if (target_perf < min_stat.min_perf)
 				find_pd_cost(pd->em_pd, target_perf, &target_stat);
-			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
+			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd, p))
 				continue;
 
 			/* Save the new most efficient CPU of the PD */
-- 
2.53.0


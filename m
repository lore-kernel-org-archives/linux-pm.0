Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978427;
	b=DUeA7kp51HOnZpofviQb0TcMVV1qziPKmjXbV9Wq11QC6go52iDywYKxIRtNQeGahNFs
	 IzbzAw45BmDkIvQmKCZu7SOtjbevIvYsiZjvHrDbLB9BGpKs8iRGj7VjRu/BafzfeeHtf
	 TBkhUCPDpTE2/eAol3+bvtQT5WSZF0CPoyjjmR3oBKKyyEVMF1UMkuBI+SPXQojllDGrT
	 RtNfgo2wa59sCVfgocXxlkwfFqyeFl9E7ZAzLaAvdLeG01HOGHyrlIcg502owojGd0c+L
	 qFw/FGKdTt3YDT/tA9QOQ/oBELggxWQgMS1QmvKGwN+7iSt2v1Tps9KGOB/l9+vqWRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fjXC0m7vB3Xiy5SvbhOFI4wpy3VxvAkCMaqlqhn8FJg=;
	b=qrcYUpXYFekNoObKQi5uTBkNAGDZH73lXPeiw4S/f2+2Z+mNcgxlEmTrCW3K6uHdumY7
	 5KhPrkldV0YfKEzSp3vDiY/ZrLN0lVLetETdUu9VAPRqgIXjLJI2Nz4ynLHKiFaHfBa09
	 TLnp2eofUHdl9CilWOnoXnRYAI44rPzjeIdaGGOMcgEB9LxvI7bnemrO8hhUvNPS6fIGf
	 QrgSZoOiaGMQtmgjNaCFtHYL0Ptn7p8nS/A0GiY2xrt/quJbRoNQ2RO6kU2oJWwBg5YJT
	 4V72DNVNKgSdRuDrG90A8zBNTQNucAQ8pmLXbrvKiXfPEkoM5V/kx1jl0SKdpNpn0og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VQ9mT3Z4;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB060A2608
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FCB060A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VQ9mT3Z4
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so7306385e9.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978425; x=1794583225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fjXC0m7vB3Xiy5SvbhOFI4wpy3VxvAkCMaqlqhn8FJg=;
        b=VQ9mT3Z40Y/6uILB8CrK66n8XzgP67TgOVMzoUK3dk9L6kIb8vRs/1sWkaVM8smMDO
         kDdV99OSlvAMI0Sm6ARwKgqRoJZ8c4IoKFQVrVhY2EpOoWDogMRlIkQCCEfT1xgS1gel
         xVG5JMWtSCyuI9AaWiQzBqxhbYauF11tpTzNzsKqci+dOZmO11unBZEnR/XAGjnCB87f
         e0NRwXaLfjeI4NecAh5ZaNoM3x6TSA8DxlHIClxIJ+HvgoeiV0M1bPqEKvxSr8mK7zJA
         PBLnFYxeOqD+hGBCHmfc4Clttp89ikntRaMt7E9zxIpTO75QFUI8ZE68xa+MxIdza9xX
         k89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978425; x=1794583225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fjXC0m7vB3Xiy5SvbhOFI4wpy3VxvAkCMaqlqhn8FJg=;
        b=2dcv+et3i9NKECY9TGBCY4DRHPdYQfwI/aAYDcUmj+sPeqraIrt8WgXCt4RKt3GQjh
         fnLQh7nZMEpRjzy8KcDboNuDoiXNSI3t5vb4hv/Irm/dq+8gdz0vn2q7M4UN+AwQKjMy
         eOQ4I4DiIIm2YLnPKbCps+bm+NUOOglqsCn+T/KOzDxvbuLAtv7trrIIkLTKzcJamN2x
         YhBbWS8bk3X1w5SPFgOJHeeYDn0Ai4L30Xr8YbLT5pzOfCN6sOqqN+vcWrBUnpSYpdA7
         G+t6Y/KeADnVOPzrDvccPiAOwS2rFIIzyps1gS171uE5LWiS6VgazREAFphp5Yp1UuXb
         GhYA==
X-Forwarded-Encrypted: i=1; AL+hErH/jCncHeu3RlLnYEZLLDaZrKi0/SNgRI0auAbV++fEzW0ZAKV3k+4tMjIJPBbX2IGx3z5DhgXl9w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Es8lQZksewAD7cIBnXlV2gx1/YJo3cuCcYe+mS5ZSTgOcNXkj
	lplnlLp/hN71tcBwjgGR4m8VP37uqiXKeuRmE9yaf9gdDodEakiB4Njg79MMMc/4WU4=
X-Gm-Gg: AYBFou0/Swcki5JHQB8QQ7FoYB+6QCr4xrQTsfjvGLNqI9LlfxOVF63ltzGv5QLAkCG
	vpsAqz2x7EEG14Cm0/VDa9uFCrzxaJMXNCgCv6FcFAixshLhI4FY8CYQXX7RIZWsKjn/N/M6JcL
	m0GzhL4BnRMgPgfdfdxqyfu9kLPGoF3bxHk1sEapl8cY4a8dyIJvjr06zXRvoheP6oiODY8Or6H
	TywFtjUcIZidOq0eoV7xSUt37cPV2YFVmuokNZy3reT/iYadntfesECNfCD716LgGp/peqtRRT6
	Vqg8A63ZJ0MC5UdFVjHOxvpx4xEAgt+Z3hm36erMRpocl0naIps00cbKpMBH/Z2pBsdSf312OTd
	ixteuB2g68DL8vIGxUBHHrVl2ulVaCur5qXNIfuOr2uPQuSqsiNLveIA11wwUy93iMeC2VL0Vsx
	kd0zlDrhKacHXpqyQFZAnntp6yMeUe+y/mchzdkVL67HYPVW9kcnZnk5rPveiF41/YouZr/WHbV
	bSfjgRhmwo0khGuOi9LCqehenjVtnGk2/KgN5aqphMwlDnwUDLVITEeKAbWo6MvjbiBsPu8kqxT
	4q9xxbeLAghqlcvH7ygbNgBscWP3qAxkjefjI2PredcY6AQ=
X-Received: by 2002:a05:6000:22c1:b0:48d:eec6:308b with SMTP id ffacd0b85a97d-492765a4011mr6585904f8f.21.1793978424778;
        Fri, 06 Nov 2026 07:20:24 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:24 -0800 (PST)
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
Subject: [PATCH 19/20 v3] sched/fair: Take into account slice in EAS
Date: Fri,  6 Nov 2026 16:19:46 +0100
Message-ID: <20261106151947.3991524-20-vincent.guittot@linaro.org>
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

When the cost is the same, take into account the slice of a task to try to
select a CPU where is will run first.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ea117c3d0dd7..da9c4416f1b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9885,13 +9885,22 @@ static bool update_best_cpu(struct energy_cpu_stat *target,
 			    int prev, struct sched_domain *sd,
 			    struct task_struct *p)
 {
+	unsigned long task_slice = p->se.slice;
 	bool target_idle = choose_idle_cpu(target->cpu, p);
 	bool min_idle = choose_idle_cpu(min->cpu, p);
+	bool target_first, min_first;
 
 	/*  Select the one which is idle */
 	if (target_idle != min_idle)
 		return target_idle;
 
+	target_first = task_slice < get_rq_min_slice(cpu_rq(target->cpu));
+	min_first = task_slice < get_rq_min_slice(cpu_rq(min->cpu));
+
+	/*  Select the one where you can run first */
+	if (target_first != min_first)
+		return target_first;
+
 	/* Favor previous CPU */
 	if (target->cpu == prev)
 		return true;
@@ -10055,7 +10064,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 */
 			if (target_perf < min_stat.min_perf)
 				find_pd_cost(pd->em_pd, target_perf, &target_stat);
-			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
+			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd, p))
 				continue;
 
 			/* Save the new most efficient CPU of the PD */
-- 
2.53.0


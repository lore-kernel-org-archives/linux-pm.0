Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B34ED18D
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955927; cv=none; b=a2I1TJ9VvwTDxC346yzKXf5E8Oi1LqLd6Hl5yJJCjRFs1eBr272WGuEPtNTa3k57W/huzhIX4nuSY22rQhlNtOoxnyPtkTHUA1sc+Qj9PtmMxPka3pot32qDCihJu7LgJ65voGghCS6JgBasrUA8s4MtyeNL/d68HfqQVuTgi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955927; c=relaxed/simple;
	bh=l/sMIazjd6/XZe5VjWiBFYnMVb+KTN/KyoP8XpNG3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzLTEfnaTxRkFdfsg5WupfQ03fSSZhTzWPYA7d3l6Zgh0j3U/m0/qKYBRekMMlG5lPgdrvS6cWXwYchydQKUYpxWAiYQmSRJTRqxBe04mvETFNVJd2qfVHRQ2ZkhFPOySxGbd448p65I/mzj15rY3XrtZi/nrowDqIdy8VowiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xbx7b7Wz; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbx7b7Wz"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso180475e9.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955921; x=1791560721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xi089Mm6/ZAPKnWvbv/ns1gYplgqzCAMNfNdfYd/S2Q=;
        b=xbx7b7WzA7QOrgoqlrsNhe/45nG7JXZO5kNdXTCEg58+W3amXOTqOgUDLO+nE/QFUD
         bR2zvr3XL0bPRp5tzXGCs2Qwa32jCU/ziUw5SkQcuSr6o0VW8ewhp3Tv4639TEg9Kl8p
         GPiVHkYgrtWxe5fboBhjTwJ6zWH3O1kcvCEqrXJjT5btTgDB91t/FGFLQn9n/k0LrG9g
         LAxHSv0rsdPLE7ocmaUnVFxas3GtNCGz9bLZ49srkKDCSNEorpDZPynP+x7/8qci3YWD
         C9C5x7CpacuY1vDpQ3+8qp917vM9NDrQFxZIh6wLf25T+liVx2IjxYirRSE2M/DhbaYU
         nLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955921; x=1791560721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xi089Mm6/ZAPKnWvbv/ns1gYplgqzCAMNfNdfYd/S2Q=;
        b=nK57LkvKOq8sW5NlOmkN1hdLwzyBaCBVpI6PnydFXGW64NjHZ8/f6curMSly0ai4sH
         YnolWgWO4FDvtlET3nmZkn4io34Rcp01V+tlHPSzOeZQ/4RJUhk38Lv5nSc+tSHP0qf/
         iNcH/CxEls7DTQf7RburtZJ4HWQdxHWJa4ph34mAE5px8HsTse0Vh+3y4u91HbDmOxTA
         VSVVOcOMPhHrbCjo+J0dfQXcdkT7xOOPF6XISS8FszGq3U3V+YvUri/rBLJ6xmqxU6Rc
         qtPukom4/S67A3GDLyEPwtBdOZED+8V6vGajNS4zzv6pDlePk5wCFgQBNPXZtbs6sM5K
         1Mfg==
X-Forwarded-Encrypted: i=1; AKwUvBwBPwnqgxU0lzTwmFolaMM5SxsxGzyVYaJsjl+Ud6bFLhRV+vb5mOq1wabq2/0QJjb+E07YnjMgXQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lJ31sKgpAoXPfiATmFO1La+ZkuUgkaIls1HabuDAM7Ks18RYL/
	kupvziTqwESa7c/dYq0i52K0MTvNLDSM1O12HPXWY4TqIHyZXaOn8D/kocqJp8ERX2g=
X-Gm-Gg: AYBFou1zmuXD/J+vt0eGjuw6geolT/paIOac/vcAz/sh9IMQZYVQ6eJKwcSr8LqsC10
	X0TFIP/eWYrD9NFXnPtPzmg/Q+tKAbk2qXuPo/Y0JJ+5SOvKWitvGdG8CX5OQcJx5Mg9Fb1B8Mu
	shsWquCz+VZFWfl0Xl6cnGgAMzWu/a8M2NQ2TjLKorpmf66Bkercykqo1cQKT8D/ZF1kmz7GHJd
	pQ6gSdc5RI2iBVDeR1eK0I8Cj+Vkkqoqqk7/1eGTq5MLoCgTbxlnMLRkcA7hqTMjT8K61MCuohw
	A/RVbi/opZ79FxrYdMuaKTvCgrqjyqfdo/EacTPUIbIuey8y48xblaAuTfx7QRXOhwvf25EFPGb
	u66bCkXLgeibL1i4Nj/WqRcDib3N7Lp/8AhoJqeZPldBBXFY2iEy585PpzEyExkNX3cipoffklj
	jJjJjqJCk93P3ejkErgE/u6GvLXfwP6V6gKYAolzhlQIBTkgR7LDKB4wppY6vptDXmqMVZweuWG
	x2t525g7ArQX8sO
X-Received: by 2002:a05:600c:8710:b0:49f:ce73:5e96 with SMTP id 5b1f17b1804b1-4a02759555dmr49483355e9.34.1790955920408;
        Fri, 02 Oct 2026 08:45:20 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:19 -0700 (PDT)
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
Subject: [PATCH 12/18 v2] sched/eevdf: Try to push short slice task on a better CPU
Date: Fri,  2 Oct 2026 17:44:09 +0200
Message-ID: <20261002154415.2270586-13-vincent.guittot@linaro.org>
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

When a task is put back in the runnable list, we check if we should try to
push on a better CPU, i.e. when fair is preempted by a higher class or the
task is preempted by another fair task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 38eb80dbd1a4..186f10173eed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9826,11 +9826,34 @@ static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
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


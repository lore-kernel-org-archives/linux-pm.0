Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978396;
	b=lGlFwmKxtTlkbhO+EaTzovykWQprhl+3eZ5EweVPUOBZGbD5Fopkapp2ArUnrSXaNbVz
	 xVfh+YAHtRB8blAd4Z/7LBRx4rYY2b6uv1aRhPVe0nkpqI+ugox0GivWV7H5E3vob9A1H
	 b2j+pg+rrDPCpfOxY9qp55gxmA7eI1f5ZK1cOm8e9mT3xts6EXH2hQox3JgOB9sx755xy
	 rNXJ8enzYmXSFh2Vtbp/9GhvvYAi7DAOfbtBOFi9XN8mt1HvPPl6NRCc0izK5l3/vD6zu
	 KkDttJMdUR4Y1JM9AVZ5tqid/lYIJcdti1rIvf2yK9eC8sVH5rlMenyiL3ltf71YB9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mqum8wvj/7Uuzw1gTiTBSXxhGiPLwY6qFIUmcHJ68Sg=;
	b=YNvOheBy0OyuOE/BbwZBk7ubcB/AQO64ENIwc6C6m6YpjpNxofl1CAfvfD6bI0TlJ5Az
	 tZ3hCG2J0bewtjAWu8W2krWJaxECrhkMctq2lWwEGFwH5sAwUWUrt+tBycfken+Hqf0Z4
	 PLee5OcQvOBA88fB8rv1feVCmr4jPlwzO9hqgCh1hBdV50iiyQLiZlKI1Z5Qiz+yaxaq2
	 SOZOvzUmuR6TQ2MbWQVFKIKrUE0go0+cjZjMQDEaHwXYvNpqW2FJ2zWGL0NtXqB/auqfF
	 YgmR9tk7QdOnT/IHQWzbtTOHuC2VwtuZ4/E0trnILg4HEjUDMiwWs76ahXyKe33EnEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ySx2WBIF;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E5606D80B
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D4E5606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ySx2WBIF
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4918c2d727fso437481f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978395; x=1794583195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mqum8wvj/7Uuzw1gTiTBSXxhGiPLwY6qFIUmcHJ68Sg=;
        b=ySx2WBIFXxx9MsZHeDJMKeXXBlzWeWU+9kk1ipjqhVf59IGNRa0hVy9RktXxy8FpJ0
         MFHcgesSVF5Xw+/0uVn5BpFhZpsrSKfWtLfKcEUu9VTtPk0RTKHJCD+vSevIvIPtuEvM
         unV1pIUg5gm8by6K+UvaMZBE63iW3fLDqicpNjNHorNLSqltxSilTnigOZ+ZRNluDIBi
         CUYZfLh4Z55O7ekcAwIyrHjA+kAd9/ueRPVIP7gbmRWQJ0Aqwb7XAj0iErdjylwNyBbU
         sUqkBxm6ITAgWsAGxpynl5vPh3Xdce+btf4O5ZwGfQ5WxwfHqiL1dCmC8akD4xHV3cel
         797w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978395; x=1794583195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mqum8wvj/7Uuzw1gTiTBSXxhGiPLwY6qFIUmcHJ68Sg=;
        b=qfsQOTmlxrNHxfgLCoQR3PypGEM91KA3wkUmqdSr6tycPaLkWasiERUybdU4GRTr3b
         BQdj6Ybude4FWKRRjHSQcKBgdoS2/rP95cwMhBT2VnO+KwOKFwLWHbPs8FI2RpndZwIw
         r7mc89J+YUJ6uD87EfyCdQIPuJDdlf30fZE2rdoEbXR2PnPXYQ/i+nKNUvceKEs2sT4O
         4gMTwE+ZKMoKmXEYUK6gDtusDkGpvFM01FhwC20vVhcSBvD5J976xMrRubP5J5DNLYrU
         VMPAVoclfbq1TdpdbWQCekq9rCWubslXrdGYzxidGQTaro9iH6exu5BNibdM63vmXduU
         dFJw==
X-Forwarded-Encrypted: i=1; AL+hErHrFY7vtGXKuAGOXEXWKVwodkmbhSk9AeMfXcsSRoIPpuBTTFzc0NyYsI0aDy5jN76TqUy2ZY42Xg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/PDpdIuZlLiohuyEpfgQmdItQTvUWSr3hbDu1BZEfEv7W8xwIO
	23v+SRT1ULn4V3ueUgusR/f2jg0DAPXIBUDk4XZAJM+mxA9wmub/7V3m2P1yq8RoUe4=
X-Gm-Gg: AYBFou31sizu/i+Rmz5jE8GAJ+rjjljcxcUCp9FAI3geQkwavGLL/Qj7bpuoo7a7bYz
	CmCEkk/z0fVyS4v269wXnJo4UOPTCsTrCCtc2ShJ/BZxiQz0h292v4c8LjRBr8J9XWWoVPFl0Gv
	r/4EWtMJhUWezfPCLnlxKoA3HMfcsk/+S4Tlt3Zu4KycMjy/Zp44n/hAkvYMVdqG7jxK2l63QeD
	fM2jN/3/jk6inoDgN/A5DYw6hqU6XPji17pRdTx6I2O3EnXk6x+/x/iDuKpyMo7+brgrVI2bz/g
	RFRXQERAUR3dY9mRKJVPCszkDeBs1ZuQhdYS2p721AKQEzAWq0C+EhI+2ITZMM7ubSAlgec041c
	xG3Rgs/ENc2Eze01yBj56/Z0iSUng+W3otDqm/auhoPZK8tclI+oCFdDYyxouVuAgUDqTuibQM4
	0wjDvYM1d3hCiG+oFaKDcD0VqRW6gFd0XZZ/R5BM3JQGTgattGGGd/zGAR1A0dG8JmF/SND15Qc
	gXTvMUzWrug0sNDDAptyyB9f8u2wSC5BBlRCRQZ735l5zIpnf1RU9ziCS/AuE/0gm3qjmN9g8kN
	G7DeY3JRn3opxSWMAYbnWqHRFguNM2fV
X-Received: by 2002:a05:6000:4312:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-49274bc8429mr6643038f8f.14.1793978394356;
        Fri, 06 Nov 2026 07:19:54 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:53 -0800 (PST)
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
Subject: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU has been idle
Date: Fri,  6 Nov 2026 16:19:29 +0100
Message-ID: <20261106151947.3991524-3-vincent.guittot@linaro.org>
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
Track CPU's idle phase and save it when a task goes to sleep. Then check if
the local CPU entered idle while the task was sleeping when enqueuing the
waking task.
This only applies if the task didn't migrate at wakeup.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/fair.c   | 14 ++++++++++++--
 kernel/sched/sched.h  |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0cb03f9acfe3..3d31e9a698c3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -593,6 +593,7 @@ struct sched_entity {
 	u64				vruntime;
 	/* Approximated virtual lag: */
 	s64				vlag;
+	u32				vlag_seq;
 	/* 'Protected' deadline, to give out minimum quantums: */
 	u64				vprot;
 	u64				slice;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5cd171f830d8..79f53811274e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -893,6 +893,7 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 			vlag = min(vlag, 0);
 	}
 	se->vlag = vlag;
+	se->vlag_seq = cfs_rq->idle_seq;
 
 	return avruntime - vlag != se->vruntime;
 }
@@ -945,12 +946,18 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
 	if (vlag <= 0)
 		return;
 
-	rq = rq_of(cfs_rq);
-
 	/* No fast access to prev rq task clock */
 	if (flags & ENQUEUE_MIGRATED)
 		return;
 
+	/* CPU has been idle in between so the lag has been removed */
+	if (se->vlag_seq != cfs_rq->idle_seq) {
+		se->vlag = 0;
+		return;
+	}
+
+	rq = rq_of(cfs_rq);
+
 	/* Compute sleep time */
 	delta_exec = rq_clock_task(rq) - se->exec_start;
 	if (unlikely(delta_exec <= 0))
@@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	dequeue_hierarchy(p, flags);
 
+	if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
+		cfs_rq->idle_seq++;
+
 	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
 		se->deadline -= se->vruntime;
 		se->rel_deadline = 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7d2ec527b8a2..24f9b7bd8f0f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -689,6 +689,7 @@ struct cfs_rq {
 	u64			sum_weight;
 	u64			zero_vruntime;
 	unsigned int		sum_shift;
+	u32			idle_seq;
 
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
-- 
2.53.0


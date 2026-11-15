Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702698;
	b=h3TcqHnmCyGDgXy8jZeWIQG1vaKF4ftP2QtvC2jWosTyxMM7w+YOpSyZIcSKDVWpvKv8
	 6t5DjDoIRGzydAITJZnaLktgdrzTzcrrBPr1WhJzh8q3x/VJ01gYaTBNF22BFBPd+W7EJ
	 qD8UITqax1hckWLxU5NPK5wyV/4MN/NBp841z0qmdtuqAUGNzxWEu2dOye93lpzWyUVW4
	 zfLVs+vT8Hf2fryGwZevss0u2qvh4JRFImxhZt1BGPG4oFFb9ijIh6o3LkclgsvjvcdRt
	 5I1GOkKQaKVTw7t1Gpr/RA8ksbqm3lU2Nn0IWIaGUpZ93TdkrPwaYpKVJr6cfL7xJdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=H1r4s03OTSXpAk2qDHWsbzmDBzynW8D8hOIi23yx2Ig=;
	b=PPhyUIAayIJBFM074Bzfk1zrNwWnbeoYQVdnNfAtyhtda0v/kIfJXgHev9QeyiI3q5VC
	 gmeyQwne1wrlVxJSaVvgnIX6Y4aPJLwctnnEpEHsEXi1sTjSgZowdnVBI3gCdp1xNBHnt
	 UHM9gHV34Tja+zH+ltv1ReSWZmWeuyDPAgg+7JygoxxcqPoKJ1HwOoUp6SKK/8/AgLOPd
	 kitqcbg6ReKgl9uzXL6mNSPAFODfg6yxcubeHpHMp3NQzIZx8um4f3Ll/HoAQ7dK4vNT4
	 G1pV1Y01Xpp+HXTE9ytKHByYQmVvR3iytRWVYTBglWXQRoVdavdmKB+KEsTyVubS3+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RYa83dtg;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A7606A323
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A7A7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RYa83dtg
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2858249eec.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794702696; x=1795307496; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H1r4s03OTSXpAk2qDHWsbzmDBzynW8D8hOIi23yx2Ig=;
        b=RYa83dtge/FdEuzcYRvxVhHPyikTfmNhRJKuI9jVYDCPdq1boSjHVLHp6+f6FcR0UL
         Be/l6pP6kOHWRO9ecpFdF+YHWd6XpqPmrjU1BYjcEFCgRxq+9anjbyekb6J92ajdAfFq
         rJx9bhIX1KVfD1aMWUCUk4axYXyAtALg0sHVzw5HMp6n95rQ2cw5iM4r44NsojWMmBI8
         t7ET74LBEfU802nnXA+tU5gIUJ12UxJguLsv95pKub5/0ihDMhlSZsrDMuQOc3eYiEgU
         kw80Sv+lOb3/vXbNN++Cd+eJgc8c1rRfxOOCvnVvJzKKqXBXB+LE1pMmcdO2Orw0viCh
         mJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702696; x=1795307496;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1r4s03OTSXpAk2qDHWsbzmDBzynW8D8hOIi23yx2Ig=;
        b=1jdqI3JmkbJMotoQNeY0yQa9lR86EeUCUf+4cnaEb0uBqu1oRUjrOiddsKGm3PAaK5
         Oushln+innQD4nMu5OW3kQDbcshxcrsb5csPpkHUkho1UvCDp2aPUBWY8UAw7x7zrF7M
         GTnIiNK+dadt5Bt0Xivv8RrK1qwmQcZBcFabAZ9CTRkTr50Stf4DWwAyMJ+7pxXV2Dj3
         5lOwMwbaVYi2ZMdBLLQQ3B9qKaXDbhwCT0XWBjvkHx3Z41LENxqJCIdMl5b5uhw8ATZ3
         OblQV13HsyR7KpJ3szinKj9/W503bRnRrXycUEItypE9MwGXQcWvo44WYnlXze11DJqq
         zUKQ==
X-Forwarded-Encrypted: i=1; AL+hErHHSRfZZgNNyN/MlTz2cvwCXky/rraJ1GfMAgWcD6Fycjk4HjFaFakXNAcsbmm133Imodajp904aQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8vkazRAGKLpcNMY0u6pK7jtHza42Aa3nd8rH4o5XaL5AZ0z3rU
	diKdMucp4gauYoNkJ7uHvxZZus/866xOjwxLzXxAQqq+AJjIp1qrzYMSFh/dLmU5j0fE14k7xaA
	pJhggekEQ5Ym52g==
X-Received: from dyaw16-n2.prod.google.com ([2002:a05:693c:4150:20b0:34c:9660:9612])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:8816:20b0:36f:350b:3838 with SMTP id 5a478bee46e88-379671247e7mr6454518eec.31.1794702696356;
 Sat, 14 Nov 2026 16:31:36 -0800 (PST)
Date: Sat, 14 Nov 2026 16:31:14 -0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261115003113.1852160-2-wusamuel@google.com>
Subject: [PATCH] freezer: Check frozen() before freezing() in freeze_task()
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During the freeze stage of suspend, there are multiple passes over the
same list of tasks. Each pass tries to freeze non-frozen tasks, meaning
that the number of frozen tasks increase monotonically, and that each
subsequent pass will mostly be iterating over frozen tasks. Therefore,
it is faster to *first* check that a task is frozen before other checks,
especially since the frozen check is computationally trivial.

Check frozen(p) before !freezing(p) to short circuit the more expensive
freezing_slow_path() calls, while retaining identical return semantics.

On a v7.3 Pixel 9 device, this consistently reduces freeze_processes
latency by ~10% (~4.5 ms).

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index a76bf957fb32..1adf09321389 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -166,7 +166,7 @@ bool freeze_task(struct task_struct *p)
 	unsigned long flags;
 
 	spin_lock_irqsave(&freezer_lock, flags);
-	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
+	if (frozen(p) || !freezing(p) || __freeze_task(p)) {
 		spin_unlock_irqrestore(&freezer_lock, flags);
 		return false;
 	}
-- 
2.56.0.679.gc527c65306-goog


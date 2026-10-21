Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585567;
	b=4ofnFLuEL1pSSmqrZWyw6Z55J3dNDkBgJxvP2oj9bQxJLvA1bX8vhbPnfBUSezBCHnfd
	 WgMCW3I43gg6FAjriwDF7OFzhcokffs3MFrm7GYKh8ZvpvCUSDCAZp/2Abaq36t5R+Q2m
	 e0nZFnh2HkC7JiTmSVPqNDjKYzlVbiS2cNU/NZwKELwerUSdEK7Drj6pRyY0SiRbW+UfE
	 2ZKVJArgn99Vb1FM+owxYqLfbqShAqF4X696t6RsKYadhTYUFe1jv99Du7mNJbZOGT1hx
	 HjGx2zhIoSo4Z5YBg816cqawEUfFJeEjdb2Q1hSHgStPv04Ra0vWibGkBIqCGXFMMfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=NR/6ReBtZzWPhL7shMo8n0oVFcpdIbC1mfBQJ9hh1jE=;
	b=b73k2cfy9NO05AO1SDAELt4p3gTDI/kTGcOP/QVfQilod1sLMbis8vsSEJzNjXFYT6ug
	 csGxp1cyCLhj0yHE0a7nmwoOy2RZ0ua6aoIem3BW2koStOfWKZ39C3RNAZBapAV36MOCz
	 x44385wapXPUTEfcfAjbEcDFyZ3gqkzPcpL3Yo9kWZdCha3FCruOFQZV77hB6TpLKxUhF
	 V8aBCAqd7ut4B5XZ0YPvQCH+QM63pyP83WLIoZ62oKLKbi6ITCHa7bP6LGang+SrtACA8
	 0fH8H85MOWSoTKsFnizzNpT+H1IXXUzvtgqJ5p/3ZY/ISduFvrZvZOemiIoXMSLeksA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RDQptoAr;
	arc=none smtp.remote-ip=209.85.160.197
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F24606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 12:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8F24606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RDQptoAr
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53380b67cfdso16614061cf.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792585566; x=1793190366; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NR/6ReBtZzWPhL7shMo8n0oVFcpdIbC1mfBQJ9hh1jE=;
        b=RDQptoAr7ZarafLjdYmo2ZhJs4b25kqadd7r9xdWurdX2lBuxGBC9Un5Wy9mY8DA8s
         S/EMrM1T7nR0PBt/Y0xm8VF9eNGiLRMoVXPt/kGWXFhWAcj7TRw4+Kiu3hHTHKThZw9u
         6yD7HXvvIffk42RgAKcF0R3gIqmN2WrFdmIpZEkWOmcD6+TWDw8mNnyCclW0HuRUq8F+
         HcVbwviKLbVDr5SOr7KfK5TXb7yEjdkwEyhNoQbWuJfo/H4d8WJ+tEbouL/sQx9/Mvdg
         XtTdKWWip+Q0SF0MzPVNw6NXwEN15KIyzfU+5ajNZfiVxrSjsAVximiJRVsT0HvCgQ2/
         4x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585566; x=1793190366;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NR/6ReBtZzWPhL7shMo8n0oVFcpdIbC1mfBQJ9hh1jE=;
        b=cmC1B2fG/pBxd9ncLQtuKZ9M5fruj9SXrrvx0K+r0O7aWBjVrk017EePiSHWUsv4wE
         33X2Q/hQEt3nnErEm7jN8JzqCyXVf0BtOq3xrZF1DYh5n6v1PV36LvcYKTRSH9vXMCZt
         IDTdSvJdBDX4hGSOYkTpM/ugrJa1M+xXLBkwvRc2E1RxUDGfqPVBVMTXWGuJ+MKF14CJ
         U8dI0o+63/uyZxZfakWcqYbMv13GhAbo7JV3l19L6wihO+Cj1FGddUhEqdWmbIOGpXoh
         5OREgzZQkSzP1G9mBFfFTPfA/r9paxz/yjTCwsoAXtiaD17V8ZXkFuKJXD9x1rFeOxMu
         s7BA==
X-Forwarded-Encrypted: i=1; AKwUvBxyLrqphqkqaJuyt8uNuIH7uekSLrlKyldXQwu2YIyEHY5o87QSm8lTMoZOIDpysk4ByjjgMTpK8Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIfM0dgilfTw8PpBK0M1HvG7ZuhJYwvaZntsUtbn4d8bvH0BAz9
	Pq+hvfqJXN1yjlqGaEkh7N7J8f0QI3zvHsN2+6BUheSK5+BZK5iAoo2lHuHZ7YI3niHtPLb1iah
	SjI0DRA==
X-Received: from qvbfi13.prod.google.com ([2002:a05:6214:1a4d:b0:91b:88d2:29c0])
 (user=sadrul job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:488:b0:535:855e:6e25
 with SMTP id d75a77b69052e-5369b8c7082mr28413131cf.47.1792585565409; Wed, 21
 Oct 2026 05:26:05 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:25:42 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021122543.3547778-1-sadrul@google.com>
Subject: [PATCH v2 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
From: Sadrul Chowdhury <sadrul@google.com>
To: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Sadrul Chowdhury <sadrul@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

During system suspend (freeze_processes) and resume (thaw_processes),
threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
try_to_freeze_tasks() executes, it must wake up every sleeping thread
with a synthetic signal so the thread can schedule, run try_to_freeze(),
enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes them
all up simultaneously, only for each thread to re-enter ep_poll(),
observe no ready I/O events, and call schedule() to go back to sleep.

On systems with numerous event-driven daemons (where hundreds of
threads idle in event loops), this causes a large wakeup stampede and
thousands of redundant context switches per suspend/resume cycle.

An earlier attempt to make epoll_wait() freezable in commit 1c441e921201
("epoll: use freezable blocking call") was reverted in commit
c511851de162 ("Revert "epoll: use freezable blocking call"") due to
reports of userspace corruption (Bugzilla #61781). Under the legacy
freezer design, freezable tasks could wake up prematurely while
hardware and peripheral drivers were still suspended.

With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sched:
Rewrite core freezer logic")), the legacy fake-signal mechanism was
replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
are safely frozen in-place without waking them up, and the scheduler
guarantees they cannot be woken until thaw_processes() explicitly clears
the frozen state.

Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
ARM64 test device demonstrate that combining this with freezable
select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 ms
mean at fixed CPU frequency) and reduces context switches during
freeze/thaw by 87%.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
---
v1 -> v2:
- Rebased against current mainline (torvalds/linux.git master).
- Collected Reviewed-by from Jan Kara and Acked-by from Rafael J. Wysocki.

 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f48b829a710f..76906ced2b86 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2327,7 +2327,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * the same lock on wakeup ep_poll_callback() side, so it
 		 * is safe to avoid an explicit barrier.
 		 */
-		__set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 
 		/*
 		 * Do the final check under the lock. ep_start/done_scan()
-- 
2.56.0.212.g129ede20d9-goog


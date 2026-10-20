Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498343;
	b=vyDgIhd9bgteeuiT18pIrqo4xShj7VxQ0lwTAbaCoTqFGHc6YxHYJGMG1Md7gitLkBz7
	 JvnIYzGUQi0tJctAf1OZS9Kv9A+tVG3hxAVukqXb9nQTL8pC+UCxGwl4O/Afr6J7A+yMl
	 B/6ieouZrAXkYpKLKLEJRg2BXffEA4wU2P5hwj8QGDgQWpeerfAPmsmjYFr24K5oia9u2
	 6JHswL49kfzAp5uBDM9lGKny0DoP4gGbigLovyVDSFiTSny1bGGnlyoQZ8ZetG1LCvIt7
	 gCI/ZaDtVwSIkmG8muoGN8e1gIB1IlNSfv6CIuL9XtHLxlPNu2Rt3JZG9/I7YlLlyiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6XUtngxDYkw/Y7D3ufCXmiJQV0M0BWIAb8OzCueSqgM=;
	b=zrbskoFatM/fcyeMQKEEUYNNAQN3BL2CXI+4aELKtAw7tb3qTs+NtK8gdloQqZ5qKUrM
	 S0K1J05PIKJ0PrT9vjWTA8D1G8HJ+MLAVJpDjmGDXTLmw5QZmT1dkNyD43Xuuq8bm41iC
	 LTRvhrrONl6Mq0/F04f5gdvhvwJxva44tsyFxLyGBusOJGiHOPJWE5qAWniRxIc6A0IcB
	 hEoCpzD5vKwofaVUBlVPBNyxnyX6Si1aOIJEOKMNov9msHx5tUtdNiQG7muJjBBxD9H3U
	 zNmXhmamPj+Q4vnR+Kccsr6Zw5vBewRJpa49HaKNfQUgX43S+Jjt4IR9I2tn498F+2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mjaxFbC2;
	arc=none smtp.remote-ip=209.85.222.197
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62932606A31C
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62932606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mjaxFbC2
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb6391e89so706292585a.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792498342; x=1793103142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6XUtngxDYkw/Y7D3ufCXmiJQV0M0BWIAb8OzCueSqgM=;
        b=mjaxFbC2aFXaJQU3N2ZkgNo6hbsXk4tvgk/9++2CdzHgbFIWJdNnUzpPbKu//HVMEb
         85aRBJa1wJ4mNX2qondJxFxk3sI3lglpoQaJQv46lO6gGSuPZOaPWn+bXbpC/H/89F+n
         4pt7tB5QG6W36RYUN+KF+nii7eUeGaGahyFkQRz6Yy6JQLH4FO6PE3gCh9YH8HX3z7PZ
         pFE1crgepOTFWMgXgmE5TV1oXvw4WGcZZBovxpHhPbVhPhS4UNZzEX2rF/VZsOFcVqhd
         ydvsjMkIC4xp/Z0xtZpOyYWS9cfsLEeQBZg+ZmXpqfUBytsoQqF6kSdluw7AQMwYkCCO
         RGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792498342; x=1793103142;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6XUtngxDYkw/Y7D3ufCXmiJQV0M0BWIAb8OzCueSqgM=;
        b=w0TfO+oVItYL/l48aFsD8r7xP5RD8WEf5kt3o1waJnZDbrzdxS86yn40UnoDsvWZ/C
         q13GiFcACT84KUOo7fgi+h1R2CqQH8Sc3yBQbU83BUwotR3CGAUTZzRb+ZdBRtBq64Sm
         7qy3o0MsetRlFSfjYJW5MCUA9mWNfjTW/2HDDwbK3IxLX349/v6a4pOkFv+6GZ+D5fvD
         JTtoD5r15xucdHa3AMbrTyKPE+PkFg9H4ZJyFYGPVF34qv0LA9ugvPtP38TcO/y+Va7P
         VAH1JdbTUGD2sE3I8mpgwQCdJJQIF0jRHNFCoyL6ygekbYYvTXU+k6HAyglbdEmgBbVy
         qMIg==
X-Forwarded-Encrypted: i=1; AKwUvBzS8zup7YDEptefeOm/ccq4eYBUSuxNW+lN2m6jaeH4UAuQBfOzenRcMxUwy2nRZeUE3FsEJkI01w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIox6Dm+rqLoOpPduOWwUYIE8atXY19vuknLPqzwOEdZ1StFsXv
	Bqi/0/V3e9N9qKw6FZL2E7SJVy1gaDFXG2luniT88UxOJsg4sj9Wz3CP0zfESLaS5jkmi0Br2tW
	umqXq1Q==
X-Received: from qvbkh14.prod.google.com ([2002:a05:6214:514e:b0:91b:e0f0:871a])
 (user=sadrul job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:2913:b0:93c:c7c6:90b5
 with SMTP id af79cd13be357-93f29b9af28mr1655598185a.9.1792498341848; Tue, 20
 Oct 2026 05:12:21 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:11:58 +0000
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
Message-ID: <20261020121159.2154649-1-sadrul@google.com>
Subject: [RESEND 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
From: Sadrul Chowdhury <sadrul@google.com>
To: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Sadrul Chowdhury <sadrul@google.com>
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
Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
---
 fs/eventpoll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 6cbef8b4c2e0..35992f6457bf 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -39,6 +39,7 @@
 #include <linux/rculist.h>
 #include <linux/capability.h>
 #include <net/busy_poll.h>
+#include <linux/freezer.h>
 
 #include <trace/hooks/fs.h>
 
@@ -1987,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * the same lock on wakeup ep_poll_callback() side, so it
 		 * is safe to avoid an explicit barrier.
 		 */
-		__set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 
 		/*
 		 * Do the final check under the lock. ep_start/done_scan()
-- 
2.56.0.212.g129ede20d9-goog


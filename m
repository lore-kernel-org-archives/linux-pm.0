Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2A47ACD3
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111788; cv=none; b=UUVmprIAewchi22XlAym/ag37/IA0A9jlbcLDi59D6yF0khq3ScQfGLk7QL08khMncin4DNYzJ4wiGB5BvVZegq5Q0gY/tOoAzNzuX2nbwntOS+JZYXYKbapemNxU2KrmFfxqG09LtF3IG4jtITunmLci64VIjwSwmDmbXWOqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111788; c=relaxed/simple;
	bh=ixLGB47crLxI18ihdGIJWtIJwAae7M6fUXuOZAeqNE4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GzFnQzfLmt2SrchVNN9evwXzn3gbNmqiiN0bQIUPUtr5QM8JHWq4CiC3Re/UIDFmGOn09r6G9xoLjDtsoo0U1T88SSCy4YgNFXahuTgaqqqQmVObFSOijFvUhVA2uWxGPbvhvqcHxCWOahtN1UoKajUZZUewCWBBLqB//z32Hug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VhB73VrW; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VhB73VrW"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-912054a1c29so4038706d6.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790111768; x=1790716568; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eYbuPsDBzCXtcz1fsWIpvPOcQDX2jZraMqs3+0aPrKY=;
        b=VhB73VrWXoNizpZpc0Uky+TwA25I41/kLmQdZjzPP+jof1A5s6fFtK2r1LZKCEBKxo
         3qYN1QOJtufl89TW91qtp0HdTIoOpCcwHo9TXeC9595fGDv+2XYwr7Axt1St73M4Tva7
         iCnk1HktVHnc2+pzmDam2ykh3VmSUVGo4h2PXaVp+Q/RJW0yzp9iitgPbkyM73rtsqxl
         1UjCJ9lH+aUZCJRASd4u1Fq7/B130qG10s0O+NUlgo5/LTLRIMBUmfcbddMO7+kz1jaP
         BoYLMWxCsPa2AVf/x0pdgkS8K1Hufqj9KijYIXziL7jsyQkAbXdh+dvE3+38ojqXSqIZ
         PpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111768; x=1790716568;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eYbuPsDBzCXtcz1fsWIpvPOcQDX2jZraMqs3+0aPrKY=;
        b=hHNrrrIONq/mNJjxNevtfWWLJ5lIWvNFtwxHbZ7R+ie30bdxfVvAfRUm+MgjS9JElL
         4fvu3mH/dhYMHcmhTbBvBYbQ174K5tZWqq7aN6lE09HBpO/C0geK7QKfUDMDbSO3QXXY
         RoR0X2bIseCXNV21mcHKX71E4AHojmNc64w35WaR+DHAzIDZ7+8Axp68xfd+wCSDK827
         AAl8BJruc3VHJGvHS0f5i2SFDoGSAdrco+nrkitlAVJqyqHzgRNcSQJSfWoRbIn4ml5/
         dRTGGMjk2jKqWyxxTEroyAwmH1nyq5KlpPuxUnIm+OUy9xTzc9qj3Mrm7yTEwn1ijkcN
         xWyg==
X-Forwarded-Encrypted: i=1; AKwUvBzGoay5Z+fX/hKWnJx5RhWMmA6BYgpRi4cvGSqdLnLvwKPdx3Csd/JSZTL8hMqzQNQa50ZJhW7GdA==@vger.kernel.org
X-Gm-Message-State: AFuF++mBw81kPYhqNr/WWP+zeVdo6VyWc3YgWH9HeZKmDsQMIbX6hDC3
	Q3V8U5tZ6FsueW7qN2m9BuVkWddpLfgnZkx4HpUDiq+9MqtoWp9OhOItkZajo6izWs42Qm+kKGo
	wF/Ca5A==
X-Received: from qvbeb6.prod.google.com ([2002:ad4:4e46:0:b0:910:6ecb:e29])
 (user=sadrul job=prod-delivery.src-stubby-dispatcher) by 2002:ad4:5c4b:0:b0:90e:8dcc:4e5
 with SMTP id 6a1803df08f44-9140c3a94c6mr13744106d6.28.1790111767372; Tue, 22
 Sep 2026 14:16:07 -0700 (PDT)
Date: Tue, 22 Sep 2026 21:15:58 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922211559.3633398-1-sadrul@google.com>
Subject: [PATCH 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
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
2.55.0.1082.g2b9226bbc0-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498351;
	b=bqDNG9VmICBxrBruu8ALcC4p3e3MWuIEaHqFr5i14ECi8zsg0dkeO7w+wCrgz5qAzELL
	 sdOjNcqiV9yMs1H81NLQNk2QD3UAHJxeXPvlu9nS9YpJXLTRyCC4iR2m9BjRbhjVshXCQ
	 Bd6MXbuSaxqvbWb9nrhVbqVNtmS9z7zqv3TnrvWgdVPted7+ErnZLbHbcrH2/UvEOSVhR
	 c0In2DdNKRn/8N8iYCHl7tB9fVWhVqc7gpx030pfy+VKpyxhEt/kFgls6cSd+nMZFENdc
	 0aYTAhmN2BTmLuOGC7d2aejR/ZbqfQuBGVlz6UUXryMI9EVSPccnbpS/JlWXiMOnGIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=15y+rjAagndMWGwtM7jZ3FI/6ZLw41O6Mm1RADPXVig=;
	b=fUGo5DZB6c2VpFQV0Y7sZrWhRQSDEPe+c3DXmCGVGHHWqh/DW6JXMemKBD5vbMeAFLHo
	 eZ67vNQHS6M3rFlel/0fpBaqLB8xbmAiGDsBJfJOrOHXtQ9uCO5cEhUUN4S6MWCc4+PHu
	 3CpRgY+bH4q1I+AXhAewjT2GuOkqh+Hjy5CxZ4FT7R5+S9M3Ze5OrWuLNMtZB13k4CcDo
	 YeGxBXCBAYp+qSvZaviWMejbt2wfzvrvOBCQAaHPMBfNckDySICsOZsfZRsH/HWX38NBs
	 lerP0N2N47ltcY93SK9y4BQT1wfD/G2ezbu5EDJM/HD3yxSgIcEU4xafnBx1oW4F8Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PAKoiuvQ;
	arc=none smtp.remote-ip=209.85.128.199
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C589606A329
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C589606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PAKoiuvQ
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b0c6e715e2so35006757b3.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792498349; x=1793103149; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15y+rjAagndMWGwtM7jZ3FI/6ZLw41O6Mm1RADPXVig=;
        b=PAKoiuvQQkkjHkOs6RfgGQJ+nnDlik4X7i6u61dIqwoIw8wnmSwygTSoMCH/cnLbEC
         PnAbGc5ep7OxEwUw1jUbJqyGNK7UnX6q9jAugMXaNpfYmdLbCE0by9Gg4oRjZjffIOhy
         nDIZ3BsJ8Jkf/atrremfB07vYT36J8ZhyCjeB4A6GsW/fOOvLyDYI8oUV5OeG7TqxBdy
         DLAMR4kt3sp7Gw/8NBWv2KmFezzjD6nO9xiDrYGDxUO6g/F8cDIE1CqAxxj5xVBMMQI8
         Jn6ZyOCxm9dKCksnIl4lXV/J5p6KCBt/XDOPLunLv1bbHwRIn1VHsFl3RoLUmM7046lU
         gCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792498349; x=1793103149;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15y+rjAagndMWGwtM7jZ3FI/6ZLw41O6Mm1RADPXVig=;
        b=PKpb36Cr3lfbzezwQf4xrBt8TNMmX3tWCHHnYrHO6PXZkrEWI8Zqf6Dw1ZaanUq5mO
         irXln+YP2YpXzCvog6CesAb1N+/cLWMxY2GrBknIUxLDlD5PMN7P7Kq8bcZf3dqQAOvi
         dPGEnrV1iawj5jl/YJuUdOmuAkdgqgFQZCL40FyNSLNi9T8jMEYKgyDOpMeAWkhnupL+
         SbReydSEhtd7k6BEP/mp7NaMlSXQM6vDFFhGJSj9UWvgkpQt5kVSgc+vqFfhoOak9/vv
         ZkrXaf1ABxtmZ7TZrMiVhXL4aGKlYgnT1NOOgeTG2FyY8yQZ0PSKlxAlpfUD+l7WPd8s
         RZFg==
X-Forwarded-Encrypted: i=1; AKwUvBw3wVGNeROsv9vlIvhw+BfNT/W1/O2xwApAi7Ke6PaX/jnbxtjw9WZBJStLuSjOumUZLYMj+jFr4g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKRrF0emTMQDQW9Csjkbjjnz9yhhqaMrvM4Vsf7hut3VNQ7nX3A
	CMtMqa9ix4IKLuEKVdyPZpIHHb8Ix3j/x9LEKSiuJPFmWj2OYKB3QSo7x/3aaZ8H+qinfe1Yb6o
	/jk4TbA==
X-Received: from yxrc11.prod.google.com ([2002:a53:c80b:0:b0:679:5b49:e5a2])
 (user=sadrul job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:128e:b0:677:d251:ccc6
 with SMTP id 956f58d0204a3-679f88d3ecdmr739083d50.71.1792498349203; Tue, 20
 Oct 2026 05:12:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:11:59 +0000
In-Reply-To: <20261020121159.2154649-1-sadrul@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020121159.2154649-1-sadrul@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020121159.2154649-2-sadrul@google.com>
Subject: [RESEND 2/2] fs/select: mark select and poll tasks TASK_FREEZABLE
From: Sadrul Chowdhury <sadrul@google.com>
To: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Sadrul Chowdhury <sadrul@google.com>
Content-Type: text/plain; charset="UTF-8"

Similar to epoll_wait(), threads sleeping in do_select() and do_poll()
sleep in TASK_INTERRUPTIBLE via poll_schedule_timeout(). During system
suspend and resume, these threads are woken up by the freezer solely to
transition to TASK_FROZEN, and woken again upon thaw only to re-evaluate
file descriptors with no pending activity and sleep again.

A previous attempt to make select() and poll() freezable in commit
9745cdb36da8 ("select: use freezable blocking call") was reverted in
commit 59612d187912 ("Revert "select: use freezable blocking call"")
alongside the epoll revert due to issues caused by the legacy freezer
architecture.

Following the freezer overhaul in commit f5d39b020809 ("freezer,sched:
Rewrite core freezer logic"), tasks in TASK_FREEZABLE are safely frozen
in-place into TASK_FROZEN without running userspace code or experiencing
premature wakeups before resume completes.

Pass TASK_FREEZABLE to poll_schedule_timeout() in do_select() and
do_poll() (TASK_INTERRUPTIBLE | TASK_FREEZABLE) so that polling threads
remain asleep undisturbed across suspend/resume cycles.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 8943f20e8300..5cbbe86135bc 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -601,7 +601,7 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
+		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE | TASK_FREEZABLE,
 					   to, slack))
 			timed_out = 1;
 	}
@@ -961,7 +961,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
+		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE | TASK_FREEZABLE, to, slack))
 			timed_out = 1;
 	}
 	return count;
-- 
2.56.0.212.g129ede20d9-goog


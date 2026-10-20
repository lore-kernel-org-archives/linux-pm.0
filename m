Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502326;
	b=YDN31OXVIwi7O5V3gUluNip0fvNoKwmqPnSXvVRJGEgZa+rEa5FZTcjZho3o7sReT0T+
	 Ln2t+Q8hsKRlFCQwARoS9ONdQXwN5Q7Pcra2vY56xJX+a2/wCbZ9RXnVgdFvHjnCHaWOA
	 FwcXNrTj7/7W0oB+Z48H2G23I2RvK+BnsHQx93J3Sk01EqStNbQiKq18NZkO8W19XHQdA
	 t/wyC+l6Ul50E9sdqua9VCMsznA5nxHhLM4xMrxJ3Y94/zLUqkRdQJa299s99xjS9BA3g
	 rubWlOM162grF+zzIPrflxbhTz5+DGtBsYYetzp+YwZFJGxjJyYhrIfgoZ6dKPKeMvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502326;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nT5qVJtMsZOOQN5bDd9xQKpWcAmBmpPjDikwtQK4oYA=;
	b=MDyB4PPBdr6C+wAwqKXfKNKQEPbp01rTLs+M++GTMzdLWRlt9GAOMFmXlvoQoXEWf8bE
	 v4tFbfCWrq4y3bTYW0oa8pcvLbSRXO2zwzaQE2d445XxigHh59D0Jx+a/M0QcIe5IZXwD
	 kqR0TlkBvA8IzBLHpeIRKVHGpEjM4nM/cDl+qHoZ+o0GcXQEzcP+k89ujD823S3SOhj+K
	 6FFFAYII4lKZrjHjbdKs9ilqNQ9NoGJHuO/of5U96fvg2/eBMH5s4LlWM93nsiykVq7HE
	 IhK9YnB3SxzN+o30k3VS/oMaW7nFsO5kFh0AD/hKoWfiYTGtahHloIKFYRBtcpuEEwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXzD36CU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9011606A323
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXzD36CU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708E51F000C5
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502325;
	bh=nT5qVJtMsZOOQN5bDd9xQKpWcAmBmpPjDikwtQK4oYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MXzD36CUho2eKSkBxRNu6P8CLs3bu7ImIjnUVFcPPTSnHTwb2gO3IhGWuNdOAkdbm
	 2S29sSWAaRcj29ziXE7wk//nIjJzXZd6DLfxdQJk2TRRY4U2TNsuOXfNeycG10RHlK
	 iZLiyy9TPE4l6RoPJtQoHoi7eJGfWfONBM/3QdgeQzCxrXPkBz2cCcfZRbhKRKDGuv
	 +xJHwtaj1gepUKm2Nr7/a+2A74IcFiYuoyX4xYaSRzplCQWoqMqmR3urW/KgK5nRdk
	 hOsyxnzgV8vvmk56GnAt+XtI+zSIfXvuga5wqsHPzScTbaXXtV6JvjbSE+hGhl/9Cw
	 nyU4eNlHto96w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso574840e87.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 06:18:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxyzEua2YYCMk7M/OdFYUBrjphZOENn0rIZb4wsQ6fKB6UyH53VcK+dMbLjmFXTWtHq8O5yDcbTfw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIiCf1F2rRjDPmayUe6vh3bCx7K4GVEa6XFPyor15Cm/hQSGWRH
	u1fJtfYUyq4KjSTm3ojBjoH6OrEUxxl3QreUIJ6XDsy3Hytjg326BP7E0QJLiCvca1ZtFwViYfq
	Lp/j4zv4XHHLO+I3iG3o0wvQMIY8sMmw=
X-Received: by 2002:a05:6512:b8f:b0:5be:44be:569f with SMTP id
 2adb3069b0e04-5be66a23859mr739003e87.2.1792502323872; Tue, 20 Oct 2026
 06:18:43 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020121159.2154649-1-sadrul@google.com>
In-Reply-To: <20261020121159.2154649-1-sadrul@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 20 Oct 2026 15:16:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hfGZWp9kWF1Fi4pYqwkukPrbw=MOiQ1yxd31mXg5zR6Q@mail.gmail.com>
X-Gm-Features: AclHuK-M3XHHa8FV_F0N1LJ5FfL6gSK9Mdl9J8PTsQYLf0xcHyilyfaYZUWI-tU
Message-ID: <CAJZ5v0hfGZWp9kWF1Fi4pYqwkukPrbw=MOiQ1yxd31mXg5zR6Q@mail.gmail.com>
Subject: Re: [RESEND 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
To: Sadrul Chowdhury <sadrul@google.com>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 2:12=E2=80=AFPM Sadrul Chowdhury <sadrul@google.com=
> wrote:
>
> During system suspend (freeze_processes) and resume (thaw_processes),
> threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
> try_to_freeze_tasks() executes, it must wake up every sleeping thread
> with a synthetic signal so the thread can schedule, run try_to_freeze(),
> enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes them
> all up simultaneously, only for each thread to re-enter ep_poll(),
> observe no ready I/O events, and call schedule() to go back to sleep.
>
> On systems with numerous event-driven daemons (where hundreds of
> threads idle in event loops), this causes a large wakeup stampede and
> thousands of redundant context switches per suspend/resume cycle.
>
> An earlier attempt to make epoll_wait() freezable in commit 1c441e921201
> ("epoll: use freezable blocking call") was reverted in commit
> c511851de162 ("Revert "epoll: use freezable blocking call"") due to
> reports of userspace corruption (Bugzilla #61781). Under the legacy
> freezer design, freezable tasks could wake up prematurely while
> hardware and peripheral drivers were still suspended.
>
> With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sched:
> Rewrite core freezer logic")), the legacy fake-signal mechanism was
> replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
> are safely frozen in-place without waking them up, and the scheduler
> guarantees they cannot be woken until thaw_processes() explicitly clears
> the frozen state.
>
> Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
> ARM64 test device demonstrate that combining this with freezable
> select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 ms
> mean at fixed CPU frequency) and reduces context switches during
> freeze/thaw by 87%.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Sadrul Chowdhury <sadrul@google.com>

For both patches in the series:

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  fs/eventpoll.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 6cbef8b4c2e0..35992f6457bf 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -39,6 +39,7 @@
>  #include <linux/rculist.h>
>  #include <linux/capability.h>
>  #include <net/busy_poll.h>
> +#include <linux/freezer.h>
>
>  #include <trace/hooks/fs.h>
>
> @@ -1987,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct epo=
ll_event __user *events,
>                  * the same lock on wakeup ep_poll_callback() side, so it
>                  * is safe to avoid an explicit barrier.
>                  */
> -               __set_current_state(TASK_INTERRUPTIBLE);
> +               __set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
>
>                 /*
>                  * Do the final check under the lock. ep_start/done_scan(=
)
> --
> 2.56.0.212.g129ede20d9-goog
>
>

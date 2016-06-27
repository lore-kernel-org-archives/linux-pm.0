From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] freezer, oom: check TIF_MEMDIE on the correct task
Date: Mon, 27 Jun 2016 23:17:33 +0200
Message-ID: <CAJZ5v0iGE+4RYq81GwyF3H-si06H_qPOqkrtzNZw7CC9E4h2ww@mail.gmail.com>
References: <1467029719-17602-1-git-send-email-mhocko@kernel.org> <1467029719-17602-2-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34248 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbcF0VRf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 17:17:35 -0400
In-Reply-To: <1467029719-17602-2-git-send-email-mhocko@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, Miao Xie <miaox@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Michal Hocko <mhocko@suse.com>

On Mon, Jun 27, 2016 at 2:15 PM, Michal Hocko <mhocko@kernel.org> wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> freezing_slow_path is checking TIF_MEMDIE to skip OOM killed
> tasks. It is, however, checking the flag on the current task rather than
> the given one. This is really confusing because freezing() can be called
> also on !current tasks. It would end up working correctly for its main
> purpose because __refrigerator will be always called on the current task
> so the oom victim will never get frozen. But it could lead to surprising
> results when a task which is freezing a cgroup got oom killed because
> only part of the cgroup would get frozen. This is highly unlikely but
> worth fixing as the resulting code would be more clear anyway.
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Looks reasonable to me, so ACK.

> ---
>  kernel/freezer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index a8900a3bc27a..6f56a9e219fa 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -42,7 +42,7 @@ bool freezing_slow_path(struct task_struct *p)
>         if (p->flags & (PF_NOFREEZE | PF_SUSPEND_TASK))
>                 return false;
>
> -       if (test_thread_flag(TIF_MEMDIE))
> +       if (test_tsk_thread_flag(p, TIF_MEMDIE))
>                 return false;
>
>         if (pm_nosig_freezing || cgroup_freezing(p))
> --

From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -v2 1/5] oom: add helpers for setting and clearing
 TIF_MEMDIE
Date: Sat, 6 Dec 2014 07:56:17 -0500
Message-ID: <20141206125617.GB18711@htj.dyndns.org>
References: <20141110163055.GC18373@dhcp22.suse.cz>
 <1417797707-31699-1-git-send-email-mhocko@suse.cz>
 <1417797707-31699-2-git-send-email-mhocko@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1417797707-31699-2-git-send-email-mhocko@suse.cz>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@suse.cz>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 05, 2014 at 05:41:43PM +0100, Michal Hocko wrote:
> +/**
> + * Marks the given taks as OOM victim.

/**
 * $FUNCTION_NAME - $DESCRIPTION

> + * @tsk: task to mark
> + */
> +void mark_tsk_oom_victim(struct task_struct *tsk)
> +{
> +	set_tsk_thread_flag(tsk, TIF_MEMDIE);
> +}
> +
> +/**
> + * Unmarks the current task as OOM victim.

Ditto.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

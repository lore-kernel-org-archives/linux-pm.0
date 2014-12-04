From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [RFC 2/2] OOM, PM: make OOM detection in the freezer path
 raceless
Date: Thu, 4 Dec 2014 18:18:22 +0100
Message-ID: <20141204171822.GE25001@dhcp22.suse.cz>
References: <20141118210833.GE23640@dhcp22.suse.cz>
 <1416345006-8284-1-git-send-email-mhocko@suse.cz>
 <1416345006-8284-2-git-send-email-mhocko@suse.cz>
 <20141202220804.GS10918@htj.dyndns.org>
 <20141204141623.GA25001@dhcp22.suse.cz>
 <20141204144454.GB15219@htj.dyndns.org>
 <20141204165601.GD25001@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20141204165601.GD25001@dhcp22.suse.cz>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu 04-12-14 17:56:01, Michal Hocko wrote:
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1d55ab12792f..032be9d2a239 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -408,7 +408,7 @@ static void dump_header(struct task_struct *p, gfp_t gfp_mask, int order,
>   * Number of OOM victims in flight
>   */
>  static atomic_t oom_victims = ATOMIC_INIT(0);
> -static DECLARE_COMPLETION(oom_victims_wait);
> +static DECLARE_WAIT_QUEUE_HEAD(oom_victims_wait);
>  
>  bool oom_killer_disabled __read_mostly;
>  static DECLARE_RWSEM(oom_sem);
> @@ -435,7 +435,7 @@ void unmark_tsk_oom_victim(void)
>  	 * is nobody who cares.
>  	 */
>  	if (!atomic_dec_return(&oom_victims) && oom_killer_disabled)
> -		complete_all(&oom_victims_wait);
> +		wake_up_all(&oom_victims_wait);
>  	up_read(&oom_sem);
>  }
>  
> @@ -464,16 +464,11 @@ bool oom_killer_disable(void)
>  		return false;
>  	}
>  
> -	/* unmark_tsk_oom_victim is calling complete_all */
> -	if (!oom_killer_disable)
> -		reinit_completion(&oom_victims_wait);
> -
>  	oom_killer_disabled = true;
> -	count = atomic_read(&oom_victims);
>  	up_write(&oom_sem);
>  
>  	if (count)

whithout this count test obviously

> -		wait_for_completion(&oom_victims_wait);
> +		wait_event(oom_victims_wait, atomic_read(&oom_victims));
>  
>  	return true;
>  }
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Date: Mon, 12 Nov 2018 09:15:18 +0100
Message-ID: <20181112081517.GA23178@redhat.com>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Christian Brauner <christian@brauner.io>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Seungho Park <seungho1.park@lge.com>, Inkyu Hwang <inkyu.hwang@lge.com>, Donghwan Jung <donghwan.jung@lge.com>, Jongsung Kim <neidhard.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

On 11/12, Chanho Min wrote:
>
> @@ -1083,7 +1084,7 @@ static int de_thread(struct task_struct *tsk)
>  	while (sig->notify_count) {
>  		__set_current_state(TASK_KILLABLE);
>  		spin_unlock_irq(lock);
> -		schedule();
> +		freezable_schedule();
>  		if (unlikely(__fatal_signal_pending(tsk)))
>  			goto killed;
>  		spin_lock_irq(lock);
> @@ -1111,7 +1112,7 @@ static int de_thread(struct task_struct *tsk)
>  			__set_current_state(TASK_KILLABLE);
>  			write_unlock_irq(&tasklist_lock);
>  			cgroup_threadgroup_change_end(tsk);
> -			schedule();
> +			freezable_schedule();
>  			if (unlikely(__fatal_signal_pending(tsk)))
>  				goto killed;
>  		}

Thanks, looks good to me.

Acked-by: Oleg Nesterov <oleg@redhat.com>

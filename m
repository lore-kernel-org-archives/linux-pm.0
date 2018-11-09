From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] exec: make de_thread() freezable
Date: Fri, 9 Nov 2018 10:21:24 +0100
Message-ID: <20181109092123.GA29945@redhat.com>
References: <1541752656-12857-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541752656-12857-1-git-send-email-chanho.min@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Christian Brauner <christian@brauner.io>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Seungho Park <seungho1.park@lge.com>, Inkyu Hwang <inkyu.hwang@lge.com>, Donghwan Jung <donghwan.jung@lge.com>, Jongsung Kim <neidhard.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

On 11/09, Chanho Min wrote:
>
> @@ -1083,7 +1084,7 @@ static int de_thread(struct task_struct *tsk)
>  	while (sig->notify_count) {
>  		__set_current_state(TASK_KILLABLE);
>  		spin_unlock_irq(lock);
> -		schedule();
> +		freezable_schedule();

Thanks, but please note another schedule() in "if (!thread_group_leader(tsk))"
branch, we probably want to change it too?

Oleg.

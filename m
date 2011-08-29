From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH pm-freezer 2/4] freezer: set PF_NOFREEZE on a
	dying	task right before TASK_DEAD
Date: Mon, 29 Aug 2011 20:02:48 +0200
Message-ID: <20110829180248.GA13346__10862.8648719334$1314641259$gmane$org@redhat.com>
References: <20110829140418.GB18871@mtj.dyndns.org>
	<20110829140509.GC18871@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110829140509.GC18871@mtj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Paul Menage <paul@paulmenage.org>, containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 08/29, Tejun Heo wrote:
>
> There's no try_to_freeze() call in the exit path and the only
> necessary guarantee is that freezer doesn't hang waiting for zombies.
> Set PF_NOFREEZE right before setting tsk->state to TASK_DEAD instead.

Agreed.

But I'd like to repeat, this looks "asymmetrical". do_each_thread()
can't see the (auto)reaped tasks after they do exit_notify(). So we
can only see this PF_NOFREEZE if the thread becomes a zombie.

> @@ -1044,6 +1038,10 @@ NORET_TYPE void do_exit(long code)
>
>  	preempt_disable();
>  	exit_rcu();
> +
> +	/* this task is now dead and freezer should ignore it */
> +	current->flags |= PF_NOFREEZE;
> +
>  	/* causes final put_task_struct in finish_task_switch(). */
>  	tsk->state = TASK_DEAD;

May be freezing_slow_path() can check TASK_DEAD along with PF_NOFREEZE
instead? (or tsk->exit_state != 0 to avoid the asymmetry above). Just
to keep this logic in the freezer code. I dunno.

But this all is up to you and Rafael, I am not arguing. Just random
thoughts.

Oleg.

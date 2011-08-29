From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH pm-freezer 4/4] freezer: use
	lock_task_sighand() in	fake_signal_wake_up()
Date: Mon, 29 Aug 2011 18:36:47 +0200
Message-ID: <20110829163647.GC9973__2386.58133098415$1314636073$gmane$org@redhat.com>
References: <20110829140418.GB18871@mtj.dyndns.org>
	<20110829140509.GC18871@mtj.dyndns.org>
	<20110829140549.GD18871@mtj.dyndns.org>
	<20110829140621.GE18871@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110829140621.GE18871@mtj.dyndns.org>
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
> --- work.orig/kernel/freezer.c
> +++ work/kernel/freezer.c
> @@ -103,9 +103,10 @@ static void fake_signal_wake_up(struct t
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&p->sighand->siglock, flags);
> -	signal_wake_up(p, 0);
> -	spin_unlock_irqrestore(&p->sighand->siglock, flags);
> +	if (lock_task_sighand(p, &flags)) {
> +		signal_wake_up(p, 0);
> +		unlock_task_sighand(p, &flags);
> +	}

Yes, this looks correct.

Oleg.

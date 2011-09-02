From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH pm-freezer 3/4] freezer: restructure
	__refrigerator()
Date: Fri, 2 Sep 2011 19:08:17 +0200
Message-ID: <20110902170817.GA8070__33759.7074955285$1314983595$gmane$org@redhat.com>
References: <20110831102100.GA2828@mtj.dyndns.org>
	<20110831102143.GB2828@mtj.dyndns.org>
	<20110831102210.GC2828@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110831102210.GC2828@mtj.dyndns.org>
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

On 08/31, Tejun Heo wrote:
>
>  	for (;;) {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
> +
> +		spin_lock_irq(&freezer_lock);
> +		current->flags |= PF_FROZEN;
>  		if (!freezing(current) ||
> -		    (check_kthr_stop && kthread_should_stop()))
> +		    (check_kthr_stop && kthread_should_stop())) {
> +			current->flags &= ~PF_FROZEN;
> +			break;

Argh! sorry I missed this...

This "break" is typo, it should be removed.

Otherwise I believe this is correct.

Oleg.

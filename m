From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH pm-freezer 3/4] freezer: check freezing()
	before	leaving FROZEN state
Date: Mon, 29 Aug 2011 18:35:33 +0200
Message-ID: <20110829163533.GB9973__32015.7951479361$1314636012$gmane$org@redhat.com>
References: <20110829140418.GB18871@mtj.dyndns.org>
	<20110829140509.GC18871@mtj.dyndns.org>
	<20110829140549.GD18871@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110829140549.GD18871@mtj.dyndns.org>
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
> @@ -60,6 +60,7 @@ bool __refrigerator(bool check_kthr_stop
>  	 */
>  	spin_lock_irq(&freezer_lock);
>  	current->flags |= PF_FROZEN;
> +refreeze:
>  	spin_unlock_irq(&freezer_lock);
>
>  	save = current->state;
> @@ -78,8 +79,10 @@ bool __refrigerator(bool check_kthr_stop
>  		schedule();
>  	}
>
> -	/* leave FROZEN */
> +	/* leave FROZEN after checking freezing() holding freezer_lock */
>  	spin_lock_irq(&freezer_lock);
> +	if (freezing(current))
> +		goto refreeze;

Looks like, you should move "save = current->state" up then.

Oleg.

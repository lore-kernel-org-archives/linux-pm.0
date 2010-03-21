From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Regression,
 post-2.6.34-rc1][PATCH] x86 / perf: Fix suspend to RAM on HP nx6325
Date: Sun, 21 Mar 2010 10:31:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003211029480.18017__41033.5405300886$1269193001$gmane$org@i5.linux-foundation.org>
References: <201003201507.15358.rjw@sisk.pl> <1269106609.9440.529.camel@laptop>
	<alpine.LFD.2.00.1003201043530.18017@i5.linux-foundation.org>
	<201003202148.01312.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003202148.01312.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Peter Zijlstra <peterz@infradead.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sat, 20 Mar 2010, Rafael J. Wysocki wrote:
>
> The appended patch fixes the breakage for me too.

Please don't use a 'goto' for something like this.

>  	raw_spin_lock(&amd_nb_lock);
>  
> +	if (!cpuhw->amd_nb)
> +		goto unlock;
> +
>  	if (--cpuhw->amd_nb->refcnt == 0)
>  		kfree(cpuhw->amd_nb);
>  
>  	cpuhw->amd_nb = NULL;
>  
> + unlock:
>  	raw_spin_unlock(&amd_nb_lock);
>  }

Just do

	raw_spin_lock(&amd_nb_lock);
	if (cpuhw->amd_nb) {
		if (!--cpuhw->amd_nb->refcnt)
			kfree(cpuhw->amd_nb);
		cpuhw->amd_nb = NULL;
	}
	raw_spin_unlock(&amd_nb_lock);

instead. Much more readable.

Let's keep 'goto' for cases where we have error returns that we don't want 
to nest, not trivial stuff like this.

		Linus

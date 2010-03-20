From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Regression,
 post-2.6.34-rc1][PATCH] x86 / perf: Fix suspend to RAM on HP nx6325
Date: Sat, 20 Mar 2010 10:47:47 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003201043530.18017__35102.0370064818$1269107613$gmane$org@i5.linux-foundation.org>
References: <201003201507.15358.rjw@sisk.pl> <1269106609.9440.529.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1269106609.9440.529.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sat, 20 Mar 2010, Peter Zijlstra wrote:
>  
>  	cpuhw = &per_cpu(cpu_hw_events, cpu);
> +	if (!cpuhw)
> +		return;

How can an address-of expression be NULL?

Yes, 'per_cpu()' is magic, but it shouldn't be possible to be _that_ 
magic. It's rather against the whole C model.

		Linus

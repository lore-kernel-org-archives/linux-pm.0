From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Regression,
 post-2.6.34-rc1][PATCH] x86 / perf: Fix suspend to RAM on HP nx6325
Date: Sun, 21 Mar 2010 02:10:35 +0100
Message-ID: <1269133835.9440.621.camel__34190.5857938856$1269133920$gmane$org@laptop>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-03-20 at 21:48 +0100, Rafael J. Wysocki wrote:
> On Saturday 20 March 2010, Linus Torvalds wrote:
> > 
> > On Sat, 20 Mar 2010, Peter Zijlstra wrote:
> > >  
> > >  	cpuhw = &per_cpu(cpu_hw_events, cpu);
> > > +	if (!cpuhw)
> > > +		return;
> > 
> > How can an address-of expression be NULL?
> > 
> > Yes, 'per_cpu()' is magic, but it shouldn't be possible to be _that_ 
> > magic. It's rather against the whole C model.
> 
> Yeah.
> 
> A field in the object pointed to by it can be NULL, though.

That's what I was aiming for,. might have missed it by a mile though :/

> The appended patch fixes the breakage for me too.

ok, works for me, thanks

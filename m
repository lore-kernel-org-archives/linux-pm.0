From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [SUSPECTED SPAM] Re: Proposal for a new algorithm
 for reading & writing a hibernation image.
Date: Sat, 05 Jun 2010 04:16:09 +0300
Message-ID: <1275700569.18384.12.camel__32666.6613029831$1275700661$gmane$org@maxim-laptop>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
	<1275694775.3853.29.camel@maxim-laptop>  <4C09930E.20306@crca.org.au>
	<1275698169.10045.8.camel@maxim-laptop> <4C099E8C.7070302@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C099E8C.7070302@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org


> If the memory it writes to isn't protected, there'll be no recursive 
> page fault and no problem, right? I'm imagining this page fault handler 
> will only set a flag to record that the page needs to be atomically 
> copied, copy the original contents to a page previously prepared for the 
> purpose, remove the write protection for the page and allow the write to 
> continue. That should be okay, right?
I think so, although I have no experience yet to comment on such things.
Despite that I think you might run out of 'page previously prepared for
the purpose'
However you can adopt a retrial process, like you do today in tuxonce.
Just abort suspend, and do it again.

> 
> > Of course the sucky part will be how to edit the page tables.
> > You might need to write your own code to do so to be sure.
> > And this has to be arch specific.
> 
> Yeah. I wondered whether the code that's already used for creating page 
> tables for the atomic restore could be reused, at least in part.
This is very dangerous.
The code might work now, and tomorrow somebody will add a code that does
memory writes.
The point is that you must be sure that there are no recursive faults,
or somehow deal with them (this is probably too dangerous to even think
of)


> 
> > Since userspace is frozen, you can be sure that faults can only be
> > caused by access to WO memory or kernel bugs.
> 
> Userspace helpers or uswsusp shouldn't be forgotten.
This is especially bad. because a fault in userspace will mean swapping.
You won't get away with custom page fault for this.
You could assure before suspend that all relevant userspace is not
swapped, or forget about userspace, because its minor thing compared to
speed increases of full memory write.


Best regards,
Maxim Levitsky

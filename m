From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/7] PCI PM: Fix saving of device state in
 pci_legacy_suspend
Date: Thu, 05 Feb 2009 12:29:23 +1100
Message-ID: <1233797363.4612.49.camel__25153.6836186007$1233797663$gmane$org@pasglop>
References: <200902040154.36018.rjw@sisk.pl>
	<200902040159.10258.rjw@sisk.pl> <200902040159.10258.rjw@sisk.pl>
	<1233712613.16867.136.camel@pasglop>
	<200902041115.00842.elendil@planet.nl>
	<1233783502.4612.7.camel@pasglop>
	<alpine.LFD.2.00.0902041355320.3247@localhost.localdomain>
	<1233794410.4612.34.camel@pasglop>
	<1233795431.15714.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233795431.15714.13.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: michael@ellerman.id.au
Cc: linux-pci@vger.kernel.org, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> > Yup, missed that change in the patch. In fact, I even missed the
> > existence of a WARN_ONCE that takes those text arguments... baaaah. I
> > suppose I should try to read more of lkml :-)
> 
> But don't expect to see them on powerpc, they never make it to the
> console.

Allright, that's the problem with our implementation of WARN using a
conditional trap, we don't carry all the variable arguments for the
printf over.

I'm tempted to turn our implementation back to normal C code with an if
and a branch out of line, but Michael seems to say that even with
appropriate use of unlikely() etc... gcc decides to generate the worst
possible code every single time ...

<rant>
such as always inlining the whole printf mumbo jumbo and having the
not-warning case branch over it, not -all- CPUs have good branch
prediction dude, so the icache is going to scream but gcc folks know
better of course....
</rant>

Anyway, I'll see Michael what exactly the situation is here and if we
can fix it a way or another.

Ben.

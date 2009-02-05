From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/7] PCI PM: Fix saving of device state in
 pci_legacy_suspend
Date: Thu, 05 Feb 2009 15:06:10 +1100
Message-ID: <1233806770.4612.68.camel__24616.2266623744$1233807537$gmane$org@pasglop>
References: <200902040154.36018.rjw@sisk.pl>
	<200902040159.10258.rjw@sisk.pl> <200902040159.10258.rjw@sisk.pl>
	<1233712613.16867.136.camel@pasglop>
	<200902041115.00842.elendil@planet.nl>
	<1233783502.4612.7.camel@pasglop>
	<alpine.LFD.2.00.0902041355320.3247@localhost.localdomain>
	<1233794410.4612.34.camel@pasglop>
	<1233795431.15714.13.camel@localhost>
	<1233797363.4612.49.camel@pasglop>
	<1233802690.15714.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233802690.15714.25.camel@localhost>
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


> Well I'm glad you listened to me when I told you not to fire off a rant
> email before I had another look at it ;)
> 
> Because Arjan has patched the generic bug.h so that we at least get the
> printk on powerpc, and then use our version of __WARN().

Right. A deep breath later or two ... the current upstream code in
pci-driver.c doesn't have a message, which is why I didn't see it. The
-new- code from Rafael does, and it would work thanks to Arjan fix. Now
I should indeed stop listening to you telling me it's broken before I
get a chance to verify it :-)

> As far as the code gen, with gcc 4.3.1 (debian).

 .../...

> So it's jumping over the if body, rather than moving it out of the
> straight line. It is hinting it right, so we should check if that helps
> us at all.

Right, gcc is full of sh*t as usual. Now try replacing the magic trap
which we still use in there, with a normal C function call (ie branch
out of line), see if it makes a difference. The trap statement uses an
inline asm statement and I know for a fact that the mere existence of
such a thing will make gcc already dubious idea of whether to go out of
line or not completely bonkers.

Cheers,
Ben.

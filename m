From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Fri, 20 May 2011 13:53:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1105201330590.14430__16207.675523083$1306167679$gmane$org@xanadu.home>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
	<20110520150348.GB3141@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110520150348.GB3141@arm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 20 May 2011, Dave Martin wrote:

> On Fri, May 20, 2011 at 01:39:37PM +0100, Frank Hofmann wrote:
> > I've simply done there what the "setmode" macro from
> > <asm/assembler.h> is doing, have chosen not to include that file
> > because it overrides "push" on a global scale for no good reason and
> > that sort of thing makes me cringe.
> 
> Actually, I guess you should be using that header, from a general
> standardisation point of view.  In particular, it would be nicer to
> use setmode than to copy it.

Absolutely.  If there are issues with the generic infrastructure 
provided to you, by all means let's find a way to fix them instead of 
locally sidestepping them.

> The setmode macro itself could be improved to use cps for Thumb-2,
> but that would be a separate (and low-priority) patch.
> 
> Re the push/pop macros, I'm not sure of the history for those.

I'm responsible for those, from many years ago (November 2005 according 
to Git) when push didn't even exist as an official ARM mnemonic.  BTW 
the converse macro is pull not pop.  Those are used to write endian 
independent assembly string copy routines.

> In the kernel, it seems customary to write stmfd sp!, / ldmfd sp!,
> instead of push / pop, so you could always use those mnemonics instead.
> They're equivalent.

Yes, and more importantly they're backward compatible with older 
binutils version with no knowledge of the latest "unified" syntax.  We 
preferably don't want to break compilation with those older tools, which 
is why we stick to ldmfd/stmfd.

> > >>+	stm	r0!, {r4-r12,lr}	/* nonvolatile regs */

This asks to be written as "stmia r0!, ..." as well for the same 
reasons.


Nicolas

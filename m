From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Fri, 20 May 2011 17:24:05 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1105201703260.8018__43550.2065382481$1305908699$gmane$org@localhost6.localdomain6>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
	<20110520150348.GB3141@arm.com>
Reply-To: frank.hofmann@tomtom.com
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

[ ... ]
>> I've simply done there what the "setmode" macro from
>> <asm/assembler.h> is doing, have chosen not to include that file
>> because it overrides "push" on a global scale for no good reason and
>> that sort of thing makes me cringe.
>
> Actually, I guess you should be using that header, from a general
> standardisation point of view.  In particular, it would be nicer to
> use setmode than to copy it.
>
> The setmode macro itself could be improved to use cps for Thumb-2,
> but that would be a separate (and low-priority) patch.
>
>
> Re the push/pop macros, I'm not sure of the history for those.

arch/arm/lib are the only users.

>
> In the kernel, it seems customary to write stmfd sp!, / ldmfd sp!,
> instead of push / pop, so you could always use those mnemonics instead.
> They're equivalent.

The "customary" seems largely a consequence of having the #define in 
<asm/assembler.h> as you get a compile error if you use push/pop as 
instruction.

I've made the change to "setmode" and stmfd/ldmfd, ok.

[ ... ]
> I think I agree.  Few drivers use FIQ, and if there are drivers
> which use FIQ but don't implement suspend/resume hooks, that sounds
> like a driver bug.
>
> Assuming nobody disagrees with that conclusion, it would be a good
> idea to stick a comment somewhere explaining that policy.

<speak up or remain silent forever> ;-)

Since the change which moved get/set_fiq_regs() to pure assembly has just 
gone in, would a simple comment update in the header file along those 
lines be sufficient ?

I.e. state "do not assume persistence of these registers over power mgmt 
transitions - if that's what you require, implement suspend / resume 
hooks" ?

>
>>
>> See also Russell's mails about that, for previous attempts a year
>> and half a year ago to get "something for ARM hibernation" in:
>>
>> https://lists.linux-foundation.org/pipermail/linux-pm/2010-July/027571.html
>> https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029665.html
>
> Relying on drivers to save/restore the FIQ state if necessary seems
> to correspond to what Russell is saying in his second mail.

Agreed, and largely why I haven't bothered touching FIQ.

>
>>
>> The kernel doesn't do IRQ/FIQ/ABT/UND save / restore for
>> suspend-to-ram either. CPU hotplug support (re)initializes those. I
>> believe we're fine.
>
> OK, just wanted to make sure I understood that right.

By and large, "if suspend-to-ram works, suspend-to-disk should too" seems 
a good idea; if the former doesn't (need to) save/restore such state even 
though it's not off-mode-persistent, then the latter doesn't need either.

That said, I've seen (out-of-tree) SoC-specific *suspend() code that 
simply blotted everything out. Seems the most trivial way to go, but not 
necessarily the best.

>
> I'll leave it to others to comment on the actual SoC-specific routines,
> but thanks for the illustration.

To make this clear, I'm not personally considering these parts optimal as 
the attached patch is doing them.

That's why preferrably, only the "enabler" code should go in first.

I do wonder, though, whether the machine maintainers are willing to make 
the change to these low-level suspend parts that'd split chip state 
save/restore from the actual power transition. That'd allow to turn this 
from a "backdoor" into a proper use of the interface.

Russell has made the change to pass the context buffer as argument, but 
not split the power transition off; things are getting there, eventually 
:)

>
> Cheers
> ---Dave

Thanks again,
FrankH.

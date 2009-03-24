From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/2] Export
 platform_pci_set_power_state() and make radeonfb use it
Date: Tue, 24 Mar 2009 11:57:19 +1100
Message-ID: <1237856239.25062.696.camel__31522.7315565155$1237856768$gmane$org@pasglop>
References: <200903210003.55161.rjw@sisk.pl>
	<200903222208.22434.rjw@sisk.pl> <200903232230.10831.rjw@sisk.pl>
	<20090323152330.536a5a1c@hobbes.virtuouswap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090323152330.536a5a1c@hobbes.virtuouswap>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-03-23 at 15:23 -0700, Jesse Barnes wrote:
> The thing I didn't like was that it made the radeon driver use an
> internal interface; I'd really prefer a proper return value from
> pci_set_power_state, which in turn means auditing all its current
> callers. But that doesn't seem worth it unless we see other drivers
> needing something similar...
> 
> And if we did go with something like your first patch, I'd still rather
> see the timeout done in the driver, rather than having the attempts &
> delay included in the function...

So what ? The driver would call pci_set_power_state() until it stops
failing ?

I'm not too fan of that, because it will change the access pattern
to the chip:

 - write PM to 2
 - short delay
 - read PM, see 0, return error
 - driver does big delay
 - write PM to 2
 - short delay
 - read PM ....

vs. the current sequence which is

 - write PM to 2
 - long delay
 - read PM, be happy

Which -seems- to be pretty much what happens in practice, though on that chip,
I don't know for sure about others.

I'm worried of the possible side effects of the first sequence that you propose
since it would do 2 things potentially confusing to the HW:

 - read PM after a short delay... it -should- be harmless but you know
HW as well as I do ...

 - write PM to 2 a second time after the long delay. Again, it -should- be
harmless since the chip at this stage should already be in D2 state but god
knows how the HW will react.

I'm especially worried about the later in fact. Maybe we can minimize it by
having pci_set_power_state() dbl check the content of the PM reg before writing
to it...

Ben.

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/7] PCI PM: Fix handling of devices without
	drivers
Date: Wed, 04 Feb 2009 13:49:15 +1100
Message-ID: <1233715755.16867.149.camel__11270.6578606323$1233715909$gmane$org@pasglop>
References: <200902040154.36018.rjw@sisk.pl> <200902040156.15200.rjw@sisk.pl>
	<alpine.LFD.2.00.0902031815550.3247@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902031815550.3247@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Sesterhenn <snakebyte@gmx.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2009-02-03 at 18:23 -0800, Linus Torvalds wrote:
> Whaa? This is basically totally obfuscated code both in the caller _and_ 
> in the callee.
> 
> Now, it looks like this all then goes away in PATCH 7/7, so I guess I 
> shouldn't complain too much, but I just don't see much point in carrying 
> this broken patch around in the series, since it's then going away and 
> rewritten almost immediately again.
> 
> Apart from that complaints, Acked-by: for the series. 

Same comments. It took me a while to figure the logic out, which I end
up agreeing with but the code is pretty obfuscated ... And yes, patch 7
seems to improve things, but then, that makes reading the patch itself
nearly impossible :-) I ended up patching the file and -then- reading
it.

I tried the whole thing on various powerbooks, along with some patches
I'm about to send for radeonfb, atyfb and aty128fb to make them properly
call pci_save_state() before they hand-change the D state, and things
appear to be working fine. (well, appart from some unrelated problems
leading to some might_sleep() hits but as I said, they are unrelated to
this series)

I need a couple more tests of the fbdev patches on some machine variants
and once done, I'll post them out. Hopefully tonight.

Cheers,
Ben.

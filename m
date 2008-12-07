From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
 and resume
Date: Sat, 6 Dec 2008 19:02:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812061858160.16554-100000__7356.94910767979$1228608291$gmane$org@netrider.rowland.org>
References: <200812062236.44111.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812062236.44111.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:

> > Rafael, I'd be happy to help with fixing up the USB PCI PM code.  At
> > this point I'm not sure exactly what's needed, though.  For instance,
> > is there any compelling reason to switch over to the new dev_pm_ops
> > approach?
> 
> Certainly not at the moment.  There will be a reason some time after .29.
> 
> That said, it apparently is possible to clean up the resume callbacks of PCI
> USB controllers, as mentioned here: http://lkml.org/lkml/2008/12/6/38
> 
> > And what should the correct sequence of calls be?
> 
> Well, that's something I'm not exactly sure about myself.  Surely it seems
> reasonable to call pci_restore_state() with interrupts disabled and do the rest
> of resume after that.  Also, I think that the core could execute things like
> pci_enable_device() during resume and pci_set_power_state()/pci_enable_wake()
> on suspend so that the drivers didn't have to.  This way we could reduce code
> duplication quite a bit.

Do you plan to change the PCI core to do these things any time soon?  
Wouldn't that require changing a whole bunch of PCI drivers too?  I
tend to agree that having the core take care of these choreographed
activities would be good -- it would leave less room for drivers to
make mistakes.

So for now maybe it would be best just to rearrange the existing calls
in USB, and wait for the core changes before doing anything more
ambitious.

> However, I'm not quite sure about the freeing and requesting IRQs during
> suspend and resume.  Many drivers do that, many others don't.  Still,
> apparently some drivers don't work correctly after resume if this is not done.
> So, if that should generally be done, I also think that moving it to the core
> might be a good idea.

For USB this doesn't matter; we don't free the IRQs during suspend.

Alan Stern

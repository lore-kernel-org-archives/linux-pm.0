From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
 and resume
Date: Sat, 6 Dec 2008 14:24:55 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812061420190.3425__43813.4912671105$1228602533$gmane$org@nehalem.linux-foundation.org>
References: <Pine.LNX.4.44L0.0812061324260.13426-100000@netrider.rowland.org>
	<200812062236.44111.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:
> 
> However, I'm not quite sure about the freeing and requesting IRQs during
> suspend and resume.  Many drivers do that, many others don't.  Still,
> apparently some drivers don't work correctly after resume if this is not done.
> So, if that should generally be done, I also think that moving it to the core
> might be a good idea.

I'd suggest against it.

A lot of drivers that want to disable (or unregister) interrupts almost 
certainly want to do it simply because they are not ready and willing to 
handle any interrupts after having run their "suspend()" function. 

So if the generic layer does it _after_ calling ->suspend() (or at 
suspend_late()) time, it's too late.

And the generic layer certainly must not disable/unregister interrupts 
_before_ calling ->suspend(), since the driver may well need to handle 
interrupts for suspending.

So there is no right time for the generic layer to do this. Not to mention 
that the generic layer doesn't even know what kind of interrupt (if any - 
or if perhaps even _multiple_) that the driver has registered.

I also suspect that a lot of drivers simply do not want or need to 
unregister the interrupt handler. I'm personally pretty sure that the only 
reason that drivers do this in the first place is exactly because they do 
their suspend() thing with interrupts enabled in the first place, and 
moving the core suspend routines to inside the irq-off region just means 
that they don't even want/need to do anything about interrupts.

			Linus

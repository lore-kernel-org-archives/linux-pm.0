From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
 and resume
Date: Sun, 7 Dec 2008 08:34:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812070824260.3425__3047.63552635468$1228667840$gmane$org@nehalem.linux-foundation.org>
References: <Pine.LNX.4.44L0.0812061324260.13426-100000@netrider.rowland.org>
	<alpine.LFD.2.00.0812062157590.3425@nehalem.linux-foundation.org>
	<alpine.LFD.2.00.0812062201230.3425@nehalem.linux-foundation.org>
	<200812071439.27712.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812071439.27712.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 7 Dec 2008, Rafael J. Wysocki wrote:
> 
> So, can we just say that PCI drivers shouldn't free IRQs during suspend and
> request them during resume, and if there's any problem that leads to, then it
> should be solved differently?

Well, there are reasons why _individual_ drivers might want to free and 
re-request irq's during suspend, so I wouldn't say it's wrong either.

For example, let's say that driver xyzzy has a suspend function (note: not 
"suspend_late" or "suspend_noirq"), and that in that suspend routine it 
turns off some slow part of itself (ie it doesn't go into D3, but let's 
say that it's a wireless device and it turns off its radio).

And maybe that driver is written in such a way that the interrupt routine 
wants to access the radio chip.

Now, the driver has two choices:

 - just make the irq handler happy with the partially suspended state (and 
   admittedly this is likely the _sane_ choice and interrupt handlers 
   should always be robust, but never mind)

 - or just make the suspend routine make sure that the chip doesn't 
   generate any interrupts, and release the interrupt handler (the latter 
   is needed because of shared interrupts - even if _that_ chip doesn't 
   generate any interrupts, the interrupt handler will still get called if 
   there are shared interrupts, of course)

IOW, I think an _acceptable_ solution to a problem like this is "hey, I'm 
turning myself off, so I'll also turn off my interrupts and disable my irq 
handler).

I just don't think it's a very -good- approach. I think it's an acceptable 
one, but it sure as hell shouldn't be the _default_ one. Especially not 
for a lot of simple devices that can probably do all of their save/restore 
entirely inside the "noirq" window, so they would never have this kind of 
issue anyway.

			Linus

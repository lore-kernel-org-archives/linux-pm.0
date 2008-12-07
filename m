From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
	and resume
Date: Sun, 7 Dec 2008 08:44:00 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812070835040.3425__4797.33662582493$1228668381$gmane$org@nehalem.linux-foundation.org>
References: <200812020320.31876.rjw@sisk.pl>
	<alpine.LFD.2.00.0812060952100.3425@nehalem.linux-foundation.org>
	<20081207054149.GA20415@kroah.com> <200812071347.18608.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812071347.18608.rjw@sisk.pl>
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
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 7 Dec 2008, Rafael J. Wysocki wrote:
> 
> If there is no objection from Jesse and if you don't mind, I'll prepare a
> version of the $subject patch on top of the patch in your tree and send it to
> you.

Rafael: there's a bug in your 1/3 patch. 

It looks like "pci_save_state()" is currently unhappy with being called 
with interrupts disabled. Or at least "pci_save_pci[ex]_state()" state 
are. They both do a kzalloc(GFP_KERNEL).

So you should change that GFP_KERNEL into a GFP_ATOMIC. Or do something 
more complicated like pre-allocate them during early suspend, but just 
changing it to GFP_ATOMIC seems to be the trivial fix.

I'm not seeing any other issues with saving/restoring things with irq's 
disabled, but people should be on the lookout for details like this.

			Linus

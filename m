From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
	and resume
Date: Sun, 7 Dec 2008 14:39:27 +0100
Message-ID: <200812071439.27712.rjw__35889.9658117027$1228657397$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0812061324260.13426-100000@netrider.rowland.org>
	<alpine.LFD.2.00.0812062157590.3425@nehalem.linux-foundation.org>
	<alpine.LFD.2.00.0812062201230.3425@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0812062201230.3425@nehalem.linux-foundation.org>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 7 of December 2008, Linus Torvalds wrote:
> 
> On Sat, 6 Dec 2008, Linus Torvalds wrote:
> > 
> > And btw, I'm talking suspend, not hibernate. 

Even as far as hibernation is concerned, I wouldn't _expect_ any BIOS to do
anything like this as long as we use the ACPI facility to enter S4.

> And, btw, even if anybody actually does this, it should be up to the 
> interrupt controller logic to re-initialize the interrupts so that they 
> are back where they belong. IOW, we should never show such _idiotic_ 
> brokenness to any actual driver, it should all be remapped and handled 
> below them.
> 
> And I still have never heard any valid reason to do it in the first place, 
> so until somebody actually gives a real example and an explanation, I 
> would suggest ignoring the whole issue as some insane rumblings from crazy 
> hw/firmare people doing idiotic things.

While I'd really like to do that, I also think that we should make all drivers
behave in the same way in this area.

Also, we need to state clearly what the _recommended_way of doing that is,
at least as a guidance for driver writers if not for anything else.

So, can we just say that PCI drivers shouldn't free IRQs during suspend and
request them during resume, and if there's any problem that leads to, then it
should be solved differently?

Rafael

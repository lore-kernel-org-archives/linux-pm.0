From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
	and resume
Date: Sat, 6 Dec 2008 18:43:58 +0100
Message-ID: <200812061843.59495.rjw__25167.5027692274$1228585629$gmane$org@sisk.pl>
References: <200812020320.31876.rjw@sisk.pl> <200812061822.35763.rjw@sisk.pl>
	<alpine.LFD.2.00.0812060930490.3425@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0812060930490.3425@nehalem.linux-foundation.org>
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
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 6 of December 2008, Linus Torvalds wrote:
> 
> On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:
> > 
> > USB doesn't use that for PCI suspend-resume, it uses it for suspend-resume of
> > USB devices behind the controller.
> 
> Oh, in that case there are no PCI users of this at all, and what the PCI 
> driver does is immaterial ;)
> 
> > But then we will save the device's registers in the "sleeping" state. 
> 
> No no. The rule would be that a PCI driver - if it uses the new 
> infrastructure, which apparently nobody does _as_ a PCI driver - simply 
> would never do the whole "pci_set_power_state(PCI_D3hot)" etc crud AT ALL.

Now _that_ sounds good. :-)

> So a PCI driver would only do higher-level stuff in its suspend/resume 
> code. For example, a USB host controller would initiate the USB bus level 
> stuff, and likely just stop the controller (not suspend it - just stop 
> it).

I like this idea very much.

So, to fix the issue at hand, I'd like the $subject patch to go first.  Then,
there is a major update of the new framework waiting for .29 in the Greg's
tree (that's the main reason why nobody uses it so far, BTW) and I'd really
prefer it to go next.  After it's been merged, I'm going to add the mandatory
suspend-resume things (save state and go to a low power state on suspend,
restore state on resume) to the new framework in a separete patch.

Is this plan acceptable?

Rafael

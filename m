From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend code ordering (again) (was: Re: x86: Increase
	PCIBIOS_MIN_IO to 0x1500 to fix nForce 4 suspend-to-RAM)
Date: Tue, 25 Dec 2007 17:13:11 +0100
Message-ID: <200712251713.13223.rjw__4158.28390182487$1198598146$gmane$org@sisk.pl>
References: <200712231419.40207.carlos@strangeworlds.co.uk>
	<200712241444.24031.rjw@sisk.pl>
	<alpine.LFD.0.9999.0712241008150.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.9999.0712241008150.21557@woody.linux-foundation.org>
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
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Monday, 24 of December 2007, Linus Torvalds wrote:
> 
> On Mon, 24 Dec 2007, Rafael J. Wysocki wrote:
> > 
> > Well, having considered that for a longer while, I think the AML code is
> > referring to a device that we have suspended already, and since it's in a low
> > power state, it just can't handle the reference.
> > 
> > If that is the case, we'll have to find the device (that should be possible
> > using some code instrumentation) and move the suspending of it into the late
> > stage.
> 
> Yes. 
> 
> In general, I'm personally of the opinion that drivers should *not* 
> actually go into D3 at all in the regular "->suspend()" phase. It should 
> be done in ->suspend_late. The early suspend is for saving state and 
> returning errors.
> 
> Sadly, we've made it a bit too inconvenient to actually do that. Almost 
> all drivers only do the "->suspend" thing, and the default PCI behaviour 
> doesn't help us in any way either.
> 
> Anyway, I wonder if a patch like this could make it easier for driver 
> writers to handle things. It basically does:
> 
>  - if you don't have a regular "suspend()" function, we'll just save state 
>    at suspend time.
> 
>  - if you don't have a "suspend_late()" function, we'll look at the 
>    current state, and if it's still in PCI_D0, we'll suspend to PCI_D3hot 
>    if it's a regular PCI device (ie not a bridge or something else odd).
> 
>  - then, at resume time, by default we don't do anything in the early 
>    resume, but in the late resume we'll undo everything, of course.
> 
> Anyway, with this, most drivers could just remove the 
> "pci_set_power_state()" call *entirely*, and let the default 
> suspend_late action power the device down. But if you want to override 
> that default action, you can either:
> 
>  - set the power state in your own ->suspend() routine (either by using 
>    pci_set_power_state(), or by just explicitly setting the state to 
>    unknown with "dev->current_state =  PCI_UNKNOWN"
> 
>  - have a "late_suspend()" action, which obviously will override the 
>    default action entirely.
> 
> Hmm?

Well, as Carlos correctly noticed, the problem is related to the change in
the ACPI specification between versions 1.0x and 2.0.  Namely, while ACPI
2.0 and later wants us to put devices into low power states before calling
_PTS, ACPI 1.0x wants us to do that after calling _PTS.  Since we're following
the 2.0 and later specifications right now, we're not doing the right thing for
the (strictly) ACPI 1.0x-compliant systems.

We ought to be able to fix things on the high level, by calling _PTS earlier on
systems that claim to be ACPI 1.0x-compliant.  That will require us to modify
the generic susped code quite a bit and will need to be tested for some time.

I'm going to prepare patches to implement this idea targeted for the 2.6.25
time frame.

Greetings,
Rafael

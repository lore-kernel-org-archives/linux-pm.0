From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend code ordering (again) (was: Re: x86:
	Increase PCIBIOS_MIN_IO to 0x1500 to fix nForce 4 suspend-to-RAM)
Date: Wed, 26 Dec 2007 16:07:17 +0100
Message-ID: <200712261607.18429.rjw__43626.0490598672$1198680573$gmane$org@sisk.pl>
References: <200712231419.40207.carlos@strangeworlds.co.uk>
	<200712251713.13223.rjw@sisk.pl>
	<alpine.LFD.0.9999.0712252006330.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.9999.0712252006330.21557@woody.linux-foundation.org>
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

On Wednesday, 26 of December 2007, Linus Torvalds wrote:
> 
> On Tue, 25 Dec 2007, Rafael J. Wysocki wrote:
> >
> > the ACPI specification between versions 1.0x and 2.0.  Namely, while ACPI
> > 2.0 and later wants us to put devices into low power states before calling
> > _PTS, ACPI 1.0x wants us to do that after calling _PTS.  Since we're following
> > the 2.0 and later specifications right now, we're not doing the right thing for
> > the (strictly) ACPI 1.0x-compliant systems.
> > 
> > We ought to be able to fix things on the high level, by calling _PTS earlier on
> > systems that claim to be ACPI 1.0x-compliant.  That will require us to modify
> > the generic susped code quite a bit and will need to be tested for some time.
> 
> That's insane. Are you really saying that ACPI wants totally different 
> orderings for different versions of the spec?

Yes, I am.

> And does Windows really do that?

I don't know.

> Please don't make lots of modifications to the generic suspend code. The 
> only thing that is worth doing is to just have a firmware callback before 
> the "device_suspend()" thing (and then on a ACPI-1.0 system, call _PTS 
> *there*), and on an ACPI-2.0 system, call _PTS *after* device_suspend().

Yes, that's what I'm going to do, but I need to untangle some ACPI code for
this purpose.

> Still, the fact is, some (most, I think) drivers *should* put themselves 
> into D3 only in "late_suspend()", so if ACPI-2.0 really expects _PTS to be 
> called after that, we're just screwed.

Well, section 9.1.6 of ACPI 2.0 specifies the suspend ordering directly and
says exactly that _PTS is to be executed after putting devices into respective
D states.

> That's when the system is really down, interrupts disabled etc, we don't want
> to call anything but the final ACPI "turn us off" stuff there!

OTOH, we ought to be able to put devices into low power states at any time, for
example when they are not used, without any problems and having to put them
back into D0 just in order to execute _PTS doesn't seem very logical to me. ;-)

Greetings,
Rafael

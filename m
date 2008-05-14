From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 14 May 2008 23:41:51 +0300
Message-ID: <200805142341.52078.maximlevitsky__28173.5180564739$1210797888$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803140231.39282.rjw@sisk.pl>
	<m1prtsug2e.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1prtsug2e.fsf@ebiederm.dsl.xmission.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 18 March 2008 18:56:09 Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Friday, 14 of March 2008, Eric W. Biederman wrote:
> >
> >> > Still, it would be sufficient if we disconnected the drivers from the
> > hardware
> >> > and thus prevented applications from accessing that hardware.
> >> 
> >> My gut feeling is that except for a handful of drivers we could even
> >> get away with simply implementing hot unplug and hot replug.  Disks
> >> are the big exception here.
> >> 
> >> Which suggests to me that it is at least possible that the methods we
> >> want for a kexec jump hibernation may be different from an in-kernel
> >> hibernation and quite possibly are easier to implement.
> >
> > I'm not sure about the "easier" part, quite frankly.  Also, with our current
> > ordering of code the in-kernel hibernation will need the same callbacks
> > as the kexec-based thing.  However, with the in-kernel approach we can
> > attempt (in the future) to be more ACPI compliant, so to speak, but with the
> > kexec-based approach that won't be possible.
> >
> > Whether it's a good idea to follow ACPI, as far as hibernation is concerned, is
> > a separate question, but IMO we won't be able to answer it without _lots_ of
> > testing on vaious BIOS/firmware configurations.  Our experience so far
> > indicates that at least some BIOSes expect us to follow ACPI and misbehave
> > otherwise, so for those systems there should be an "ACPI way" available.
> > [Others just don't work well if we try to follow ACPI and those may be handled
> > using the kexec-based approach, but that doesn't mean that we can just ignore
> > the ACPI compliance issue, at least for now.]
> 
> If we do use the ACPI S4 state I completely agree we should be at
> least spec compliant in how we use it.
> 
> I took a quick skim through my copy of the ACPI spec so I could get a
> feel for this issue.  Hibernation maps to the ACPI S4 state.  The only
> thing we appear to gain from S4 is the ability to tell the BIOS (so it
> can tell a bootloader) that this was a hibernation power off instead
> of simply a software power off.
> 
> It looks like entering the ACPI S4 state has a few advantages with
> respect to how the system wakes up.  In general using the ACPI S5
> state (soft off) appears simpler, and potentially more reliable.
> 
> The sequence we appear to want is:
> - Disconnecting drivers from devices.
> - Saving the image.
> - Placing the system in a low power or off state.
> 
> - Coming out of the low power state.
> - Restoring the image.
> - Reconnecting drivers to devices.
>   (We must assume the device state could have changed here
>    no matter what we do)
> 
> It is mostly a matter of where we place the code.
> 
> Right now I don't see a limitation either with a kexec based approach
> or without one.  Especially since the common case would be using
> the same kernel with the same drivers both before and after the
> hibernation event.
> 
> The low power states for S4 seem to be just so that we can
> decide which devices have enough life that they can wake up
> the system.  If we handle all of that as a second pass after
> we have the system in a state where we have saved it we should
> be in good shape.
> 
> My inclination is to just use S5 (soft off).
> 
> One of the cool things about hibernation to disk was that we were
> supposed to get the BIOS totally out of that path so we could get
> something that was rock solid and reliable.  I don't see why we should
> use ACPI S4 when the BIOS doesn't seem to give us anything useful, and
> causes us headaches we should even consider using S4.
> 
> Does using the S4 state have advantages that I currently do not
> see?
First of all S4 ACPI code turns some leds on some systems,
cosmetic thing, but still nice.

Secondary, what about wakeup devices?
Hardware can disable some devices in S5 while leave them running in S4
on my system for example network card will do WOL in S4,
but to make it WOL in S5 I have to turn a specific option in BIOS.

While my system doesn't have this, it isn't uncommon for system to leave USB ports
running so one can turn the PC with keyboard/mouse even in S4.
in S5 those ports  will probably  be disabled.
My system on have this for S3 only.

On laptops we can expect even more ACPI functionality, so some more differences between
S4 and S5 can happen.

Last thing that I want to say is that, when linux puts PC in S? state, on top of executing 
_PTS, _GTS acpi functions, it writes the destination S state to a fixed register, thus the hardware
can (and does) behave differently.

Best regards,
	Maxim Levitsky

> 
> Len? Rafael? Anyone?
> 
> Eric
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> 

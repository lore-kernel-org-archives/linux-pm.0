From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/ACPI: Fix regression caused by 16ee7b3dcc56 & c50f13c672df7
Date: Mon, 13 Apr 2015 21:46:42 +0200
Message-ID: <4158829.0NcmmvhrBf@vostro.rjw.lan>
References: <55214A0D.9000404@xs4all.nl> <2925091.27rsycJUfM@vostro.rjw.lan> <552BD898.60603@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <552BD898.60603@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Bos <jim876@xs4all.nl>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bob Moore <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, April 13, 2015 04:54:16 PM Jim Bos wrote:
> On 04/13/2015 03:36 PM, Rafael J. Wysocki wrote:
> > On Monday, April 13, 2015 01:30:20 AM Rafael J. Wysocki wrote:
> >> On Sunday, April 12, 2015 11:03:30 AM Jim Bos wrote:
> >>> On 04/12/2015 03:29 AM, Rafael J. Wysocki wrote:
> >>>> On Saturday, April 11, 2015 05:08:38 PM Jim Bos wrote:
> >>>>> On 04/10/2015 03:56 AM, Jiang Liu wrote:
> >>>>>> On 2015/4/10 0:41, Jim Bos wrote:
> >>>>>>> On 04/09/2015 12:15 PM, Jiang Liu wrote:
> >>>>>>>> On 2015/4/8 23:51, Jim Bos wrote:
> >>>>>>>>> On 04/08/2015 07:26 AM, Jiang Liu wrote:
> >>>>>>>>>> On 2015/4/8 0:49, Jim Bos wrote:
> >>>>>>>>>>> On 04/07/2015 04:34 PM, Jiang Liu wrote:
> >>>>>> <snip>
> >>>>>>>> Hi Jim,
> >>>>>>>> 	I'm really confused. I can't even explain why my previous
> >>>>>>>> patch fixes the issue on AMD geode board now:(
> >>>>>>>>
> >>>>>>>> For the Dell laptop, seems you have:
> >>>>>>>> 1) build a kernel with Local APIC and IOAPIC enabled
> >>>>>>>> 2) lapic is disabled by BIOS, so there's no ACPI MADT(APIC)
> >>>>>>>> table at all.
> >>>>>>>> That means the laptop is working with 8259 PICs only.
> >>>>>>>> There's little change between 3.16 and 4.0 related to 8259.
> >>>>>>>>
> >>>>>>>> For the AMD geode board, I still think original code is right.
> >>>>>>>> I can't explain why the patch fix the issue.
> >>>>>>>>
> >>>>>>>> So could you please help to:
> >>>>>>>> 1) Try to enable lapic on Dell laptop in BIOS
> >>>>>>>> 2) Dump acpi tables and dmesg on AMD board
> >>>>>>>>
> >>>>>>>> If that still doesn't help, I will try to send you some
> >>>>>>>> debug patches to gather more info.
> >>>>>>>> Thanks!
> >>>>>>>> Gerry
> >>>>>>>>> _
> >>>>>>>>> Jim
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>> Gerry,
> >>>>>>>
> >>>>>>> As you mentioned your patch shouldn't make a difference, run some more
> >>>>>>> tests, as it turns out:
> >>>>>>> - geode system  broken on 3.16+ up to and including 3.19, however, on
> >>>>>>> plain 4.0-rc6 it works!  Root cause appears to be there isn't an ACPI
> >>>>>>> interrupt assigned in non-working kernels.
> >>>>>>> - other system I got my hands on: Pentium(R) CPU G3220, broken on 3.19.0
> >>>>>>> when boot parameter 'nosmp' is specified, again no acpi entry in
> >>>>>>> /proc/interrupts,  working fine on 4.0-rc6
> >>>>>>>
> >>>>>>> So obviously between 3.19 and 4.0-rc6 something got fixed here!
> >>>>>> Hi Jim,
> >>>>>> Yes, the bugfix patch should be:
> >>>>>> commit 1ea76fbadd66("x86/irq: Fix regression caused by commit b568b8601f05")
> >>>>>>
> >>>>>>> The Dell laptop remains the only problem then on 4.0-rc6, there IS an
> >>>>>>> acpi interrupt  (but firing once apparently).
> >>>>>>> There isn't an option in BIOS to enable LAPIC, however, when specifying
> >>>>>>> 'lapic' as boot parameter I got interesting result, still not working
> >>>>>>> and /proc/interrups still shows XT-PIC.  Doing a diff between dmesg on
> >>>>>>> 3.19 and 4.0-rc6 this pops out:
> >>>>>>>
> >>>>>>> -Local APIC disabled by BIOS -- you can enable it with "lapic"
> >>>>>>> -APIC: disable apic facility
> >>>>>>> -APIC: switched to apic NOOP
> >>>>>>> +Local APIC disabled by BIOS -- reenabling.
> >>>>>>> +Found and enabled local APIC!
> >>>>>>>
> >>>>>>> +Enabling APIC mode:  Flat.  Using 0 I/O APICs
> >>>>>> What's the last know working kernel for Dell laptop?
> >>>>>> Does it work as expected with v3.19 kernel?
> >>>>>> Do you means this message is from plain v4.0-rc6 kernel?
> >>>>>> Thanks!
> >>>>>> Gerry
> >>>>>>
> >>>>>>>
> >>>>>>> Jim
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>> Gerry, Rafael,
> >>>>>
> >>>>> Ok, found it.
> >>>>> It was very 'interesting' bisect, because there were 2 overlapping
> >>>>> issues here.  On the Dell laptop some kernels there wasn't an ACPI
> >>>>> interrupt at all or it fired once and then seemed to get stuck.
> >>>>> Turns out that kernel version:
> >>>>> 3.16: OK
> >>>>> 3.17: Broken (no acpi interrupt)
> >>>>> 3.18: actually fine
> >>>>> 3.19: Broken
> >>>>>
> >>>>> So started bisecting between 3.18 or 3.19, in the end found Rafael's
> >>>>> patch which broke it:
> >>>>>
> >>>>> ==
> >>>>> commit c50f13c672df758b59e026c15b9118f3ed46edc4
> >>>>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>> Date:   Mon Dec 1 23:50:16 2014 +0100
> >>>>>
> >>>>>     ACPICA: Save current masks of enabled GPEs after enable register writes
> >>>>> ==
> >>>>>
> >>>>> Reverting that patch on top of 4.0-rc7 (with some offsets and one
> >>>>> trivial manual edit) and I finally got a working ACPI interrupt again!
> >>>>
> >>>> That's unexpected.
> >>>>
> >>>> Is system suspend/resume involved in the reproduction of the problem in any way?
> >>>>
> >>>> In any case, does it help if you replace "enable_mask" with "enable_for_run"
> >>>> in line 127 of drivers/acpi/acpica/hwgpe.c (without reverting the whole commit)?
> >>>>
> >>>>
> >>>
> >>> No suspends/resumes, but this suggestion works :-)
> >>
> >> OK
> >>
> >>> --- hwgpe.c.ORIG        2015-04-12 10:41:11.754104398 +0200
> >>> +++ hwgpe.c     2015-04-12 10:42:38.021283593 +0200
> >>> @@ -124,7 +124,7 @@
> >>>
> >>>                 /* Only enable if the corresponding enable_mask bit is
> >>> set */
> >>>
> >>> -               if (!(register_bit & gpe_register_info->enable_mask)) {
> >>> +               if (!(register_bit & gpe_register_info->enable_for_run)) {
> >>>                         return (AE_BAD_PARAMETER);
> >>>                 }
> >>>
> >>> Tested-by: Jim Bos <jim876@xs4all.nl>
> >>
> >> No, no, this is not a fix. :-)
> >>
> >> It means, though, that enable_for_run and enable_mask diverge at one point and,
> >> moreover, enable_for_run has more bits set, which is *really* mysterious.
> >>
> >> So the only place modifying enable_for_run is acpi_ev_update_gpe_enable_mask()
> >> which roughly does this:
> >> 	(a) Find the register bit corresponding to the given GPE.
> >> 	(b) Clear that bit in enable_for_run.
> >> 	(c) If runtime_count is set for the GPE, set that bit in enable_for_run.
> >> Thus the only case when a bit may be set in enable_for_run is when runtime_count
> >> is nonzero for the GPE in acpi_ev_update_gpe_enable_mask().
> >>
> >> Now, acpi_ev_update_gpe_enable_mask() is only called from two places,
> >> acpi_ev_add_gpe_reference() and acpi_ev_remove_gpe_reference().  The former
> >> calls it when runtime_count has just been incremented and is now equal to one
> >> and the latter calls it when runtime_count has just been decremented and is now
> >> equal to zero.  Hence, if all of the involved functions return AE_OK,
> >> acpi_ev_add_gpe_reference() may set the corresponding bit in enable_for_run
> >> and acpi_ev_remove_gpe_reference() may clear it.
> >>
> >> Further, having set the bit in enable_for_run, acpi_ev_add_gpe_reference() calls
> >> acpi_ev_enable_gpe() which then calls acpi_hw_low_set_gpe() with ACPI_GPE_SAVE_MASK
> >> set in the second argument.  Again, this causes the corresponding bit to be set in
> >> the register's enable_mask, unless any errors are returned.  In that case the
> >> bit will be set in both enable_for_run and enable_mask and analogously for
> >> acpi_ev_remove_gpe_reference().  So if I'm not overlooking anything and if all of
> >> the involved calls are successful, enable_for_run and enable_mask will always be
> >> in sync.
> >>
> >> As far as I can say that may change *only* if there's an error, because in that
> >> case (1) we may not save the mask that we attempted to write to the register and
> >> (2) we will reset runtime_count *without* updating enable_for_run which arguably
> >> is a bug.  So the previous patch might just work accidentally.
> >>
> >> If that theory holds any water, the patch below may help too (instead of the
> >> previous one), so please test it.  If it doesn't help, we'll need to find out
> >> what exactly happens on that system, but surely it is *not* usual behavior.
> > 
> > Actually, the one below is better, so please test this one instead.
> > 
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: ACPICA: Store GPE register enable masks upfront
> > 
> > It is reported that ACPI interrupts do not work any more on
> > Dell Latitude D600 after commit c50f13c672df (ACPICA: Save
> > current masks of enabled GPEs after enable register writes).
> > The problem turns out to be related to the fact that the
> > enable_mask and enable_for_run GPE bit masks are not in
> > sync (in the absence of any system suspend/resume events)
> > for at least one GPE register on that machine.
> > 
> > Address this problem by writing the enable_for_run mask into
> > enable_mask as soon as enable_for_run is updated instead of
> > doing that only after the subsequent register write has
> > succeeded.  For consistency, update acpi_hw_gpe_enable_write()
> > to store the bit mask to be written into the GPE register
> > in enable_mask unconditionally before the write.
> > 
> > Since the ACPI_GPE_SAVE_MASK flag is not necessary any more after
> > that, drop it along with the symbols depending on it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/acpica/evgpe.c |    5 +++--
> >  drivers/acpi/acpica/hwgpe.c |   11 ++++-------
> >  include/acpi/actypes.h      |    4 ----
> >  3 files changed, 7 insertions(+), 13 deletions(-)
> > 
> > Index: linux-pm/drivers/acpi/acpica/hwgpe.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/acpica/hwgpe.c
> > +++ linux-pm/drivers/acpi/acpica/hwgpe.c
> > @@ -89,6 +89,8 @@ u32 acpi_hw_get_gpe_register_bit(struct
> >   * RETURN:	Status
> >   *
> >   * DESCRIPTION: Enable or disable a single GPE in the parent enable register.
> > + *              The enable_mask field of the involved GPE register structure
> > + *              must be updated by the caller if necessary.
> >   *
> >   ******************************************************************************/
> >  
> > @@ -119,7 +121,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_even
> >  	/* Set or clear just the bit that corresponds to this GPE */
> >  
> >  	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info);
> > -	switch (action & ~ACPI_GPE_SAVE_MASK) {
> > +	switch (action) {
> >  	case ACPI_GPE_CONDITIONAL_ENABLE:
> >  
> >  		/* Only enable if the corresponding enable_mask bit is set */
> > @@ -149,9 +151,6 @@ acpi_hw_low_set_gpe(struct acpi_gpe_even
> >  	/* Write the updated enable mask */
> >  
> >  	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
> > -	if (ACPI_SUCCESS(status) && (action & ACPI_GPE_SAVE_MASK)) {
> > -		gpe_register_info->enable_mask = (u8)enable_mask;
> > -	}
> >  	return (status);
> >  }
> >  
> > @@ -286,10 +285,8 @@ acpi_hw_gpe_enable_write(u8 enable_mask,
> >  {
> >  	acpi_status status;
> >  
> > +	gpe_register_info->enable_mask = enable_mask;
> >  	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
> > -	if (ACPI_SUCCESS(status)) {
> > -		gpe_register_info->enable_mask = enable_mask;
> > -	}
> >  	return (status);
> >  }
> >  
> > Index: linux-pm/include/acpi/actypes.h
> > ===================================================================
> > --- linux-pm.orig/include/acpi/actypes.h
> > +++ linux-pm/include/acpi/actypes.h
> > @@ -736,10 +736,6 @@ typedef u32 acpi_event_status;
> >  #define ACPI_GPE_ENABLE                 0
> >  #define ACPI_GPE_DISABLE                1
> >  #define ACPI_GPE_CONDITIONAL_ENABLE     2
> > -#define ACPI_GPE_SAVE_MASK              4
> > -
> > -#define ACPI_GPE_ENABLE_SAVE            (ACPI_GPE_ENABLE | ACPI_GPE_SAVE_MASK)
> > -#define ACPI_GPE_DISABLE_SAVE           (ACPI_GPE_DISABLE | ACPI_GPE_SAVE_MASK)
> >  
> >  /*
> >   * GPE info flags - Per GPE
> > Index: linux-pm/drivers/acpi/acpica/evgpe.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/acpica/evgpe.c
> > +++ linux-pm/drivers/acpi/acpica/evgpe.c
> > @@ -92,6 +92,7 @@ acpi_ev_update_gpe_enable_mask(struct ac
> >  		ACPI_SET_BIT(gpe_register_info->enable_for_run,
> >  			     (u8)register_bit);
> >  	}
> > +	gpe_register_info->enable_mask = gpe_register_info->enable_for_run;
> >  
> >  	return_ACPI_STATUS(AE_OK);
> >  }
> > @@ -123,7 +124,7 @@ acpi_status acpi_ev_enable_gpe(struct ac
> >  
> >  	/* Enable the requested GPE */
> >  
> > -	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE_SAVE);
> > +	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
> >  	return_ACPI_STATUS(status);
> >  }
> >  
> > @@ -202,7 +203,7 @@ acpi_ev_remove_gpe_reference(struct acpi
> >  		if (ACPI_SUCCESS(status)) {
> >  			status =
> >  			    acpi_hw_low_set_gpe(gpe_event_info,
> > -						ACPI_GPE_DISABLE_SAVE);
> > +						ACPI_GPE_DISABLE);
> >  		}
> >  
> >  		if (ACPI_FAILURE(status)) {
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Works!  If this is actually the fix ;-)
> 
> Tested-by: Jim Bos <jim876@xs4all.nl>

Yes, this is the fix I'd like to apply unless others have objections.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] ACPICA: Introduce acpi_enable_all_wakeup_gpes()
Date: Tue, 30 Sep 2014 21:52:28 +0200
Message-ID: <3883340.iE5nWN8xny@vostro.rjw.lan>
References: <1622293.rpSt5UtDk3@vostro.rjw.lan> <4021848.ZWdxDcq97A@vostro.rjw.lan> <94F2FBAB4432B54E8AACC7DFDE6C92E37D20AA35@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D20AA35@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 30, 2014 03:52:16 PM Moore, Robert wrote:
> If you need it, sure.

Thanks!

I hope this applies to https://patchwork.kernel.org/patch/4999321/ too?

> Let me know when there is an ACPICA version

OK


> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Monday, September 29, 2014 5:26 PM
> > To: ACPI Devel Maling List; Moore, Robert
> > Cc: Linux Kernel Mailing List; Zhang, Rui; Linux PM list
> > Subject: [PATCH 4/5] ACPICA: Introduce acpi_enable_all_wakeup_gpes()
> > 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Add a routine for host OSes to enable all wakeup GPEs and disable all of
> > the non-wakeup ones at the same time.
> > 
> > It will be used for the handling of GPE wakeup from suspend-to-idle in
> > Linux.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > Bob, please let me know if I can fast-track this one.
> > 
> > ---
> >  drivers/acpi/acpica/evxfgpe.c |   32 ++++++++++++++++++++++++++++++++
> >  include/acpi/acpixf.h         |    1 +
> >  2 files changed, 33 insertions(+)
> > 
> > Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
> > +++ linux-pm/drivers/acpi/acpica/evxfgpe.c
> > @@ -596,6 +596,38 @@ acpi_status acpi_enable_all_runtime_gpes
> > 
> >  ACPI_EXPORT_SYMBOL(acpi_enable_all_runtime_gpes)
> > 
> > +/**********************************************************************
> > +********
> > + *
> > + * FUNCTION:    acpi_enable_all_wakeup_gpes
> > + *
> > + * PARAMETERS:  None
> > + *
> > + * RETURN:      Status
> > + *
> > + * DESCRIPTION: Enable all "wakeup" GPEs and disable all of the other
> > GPEs, in
> > + *              all GPE blocks.
> > + *
> > +
> > +***********************************************************************
> > +*******/
> > +
> > +acpi_status acpi_enable_all_wakeup_gpes(void) {
> > +	acpi_status status;
> > +
> > +	ACPI_FUNCTION_TRACE(acpi_enable_all_wakeup_gpes);
> > +
> > +	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
> > +	if (ACPI_FAILURE(status)) {
> > +		return_ACPI_STATUS(status);
> > +	}
> > +
> > +	status = acpi_hw_enable_all_wakeup_gpes();
> > +	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
> > +
> > +	return_ACPI_STATUS(status);
> > +}
> > +
> > +ACPI_EXPORT_SYMBOL(acpi_enable_all_wakeup_gpes)
> > +
> > 
> > /*************************************************************************
> > ******
> >   *
> >   * FUNCTION:    acpi_install_gpe_block
> > Index: linux-pm/include/acpi/acpixf.h
> > ===================================================================
> > --- linux-pm.orig/include/acpi/acpixf.h
> > +++ linux-pm/include/acpi/acpixf.h
> > @@ -692,6 +692,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
> >  						     *event_status))
> >  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
> > ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
> > acpi_enable_all_runtime_gpes(void))
> > +ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
> > +acpi_enable_all_wakeup_gpes(void))
> > 
> >  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
> >  				acpi_get_gpe_device(u32 gpe_index,
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

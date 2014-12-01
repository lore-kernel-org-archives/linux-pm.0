From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPICA: Save current masks of enabled GPEs after enable register writes
Date: Mon, 01 Dec 2014 23:33:18 +0100
Message-ID: <1906259.Y3CVpWVIyR@vostro.rjw.lan>
References: <2017469.J3BZteXtBu@vostro.rjw.lan> <5837035.VZ0lP2ZXdi@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E88026A57CA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56258 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754026AbaLAWLz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 17:11:55 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88026A57CA@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Monday, December 01, 2014 05:03:04 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Monday, December 01, 2014 9:53 AM
> > 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > There is a race condition between acpi_hw_disable_all_gpes() or
> > acpi_enable_all_wakeup_gpes() and acpi_ev_asynch_enable_gpe() such
> > that if the latter wins the race, it may mistakenly enable a GPE
> > disabled by the former.  This may lead to premature system wakeups
> > during system suspend and potentially to more serious consequences.
> > 
> > The source of the problem is how acpi_hw_low_set_gpe() works when
> > passed ACPI_GPE_CONDITIONAL_ENABLE as the second argument.  In that
> > case, the GPE will be enabled if the corresponding bit is set in the
> > enable_for_run mask of the GPE enable register containing that bit.
> > However, acpi_hw_disable_all_gpes() and acpi_enable_all_wakeup_gpes()
> > don't modify the enable_for_run masks of GPE registers when writing
> > to them.  In consequence, if acpi_ev_asynch_enable_gpe(), which
> > eventually calls acpi_hw_low_set_gpe() with the second argument
> > equal to ACPI_GPE_CONDITIONAL_ENABLE, is executed in parallel with
> > one of these functions, it may reverse changes made by them.
> > 
> > To fix the problem, introduce a new enable_mask field in struct
> > acpi_gpe_register_info in which to store the current mask of
> > enabled GPEs and modify acpi_hw_low_set_gpe() to take this
> > mask into account instead of enable_for_run when its second
> > argument is equal to ACPI_GPE_CONDITIONAL_ENABLE.  Also modify
> > the low-level routines called by acpi_hw_disable_all_gpes(),
> > acpi_enable_all_wakeup_gpes() and acpi_enable_all_runtime_gpes()
> > to update the enable_mask masks of GPE registers after all
> > (successful) writes to those registers.
> 
> Both the solution and the patch looks OK.
> You'll still need the following fix to ensure the atomicity of acpi_ev_asynch_enable_gpe():
> https://bugzilla.kernel.org/attachment.cgi?id=157391
> 
> Acked-by: Lv Zheng <lv.zheng@intel.com>

Thanks!

Can you please submit the patch from
https://bugzilla.kernel.org/attachment.cgi?id=157391
to linux-acpi officially?

I'd like it to be included into 3.19 as a fix.

Rafael


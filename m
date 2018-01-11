From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ACPI / PM: Use Low Power S0 Idle on more systems
Date: Thu, 11 Jan 2018 14:55:34 +0200
Message-ID: <1515675334.7000.919.camel@linux.intel.com>
References: <4046497.JI7UjL75gC@aspire.rjw.lan>
         <12541194.33112yYDjW@aspire.rjw.lan>
         <1515590661.7000.855.camel@linux.intel.com>
         <2293881.tBporBhK0J@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61280 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbeAKNLs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Jan 2018 08:11:48 -0500
In-Reply-To: <2293881.tBporBhK0J@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Valentin Manea <valy@mrs.ro>

On Thu, 2018-01-11 at 02:13 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some systems don't support the ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT
> functions in their Low Power S0 Idle _DSM, but still expect EC
> events to be processed in the suspend-to-idle state for power button
> wakeup (among other things) to work.  Surface Pro3 turns out to be
> one of them.
> 
> Fortunately, it still provides Low Power S0 Idle _DSM with the screen
> on/off functions supported, so modify the ACPI suspend-to-idle to use
> the Low Power S0 Idle code path for all systems supporting the
> ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT or the ACPI_LPS0_SCREEN_OFF and
> ACPI_LPS0_SCREEN_ON functions in their Low Power S0 Idle _DSM.
> 
> Potentially, that will cause more systems to use suspend-to-idle by
> default, so some future corrections may be necessary if it leads
> to issues, but let it remain more straightforward for now.
> 

FWIW, 
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198389#add_comment
> Reported-by: Valentin Manea <valy@mrs.ro>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> 
> -> v2: Rename ACPI_LPS0_S2I_MASK to ACPI_LPS0_PLATFORM_MASK.
> 
> ---
>  drivers/acpi/sleep.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -707,7 +707,8 @@ static const struct acpi_device_id lps0_
>  #define ACPI_LPS0_ENTRY		5
>  #define ACPI_LPS0_EXIT		6
>  
> -#define ACPI_S2IDLE_FUNC_MASK	((1 << ACPI_LPS0_ENTRY) | (1 <<
> ACPI_LPS0_EXIT))
> +#define ACPI_LPS0_SCREEN_MASK	((1 << ACPI_LPS0_SCREEN_OFF) |
> (1 << ACPI_LPS0_SCREEN_ON))
> +#define ACPI_LPS0_PLATFORM_MASK	((1 << ACPI_LPS0_ENTRY) | (1
> << ACPI_LPS0_EXIT))
>  
>  static acpi_handle lps0_device_handle;
>  static guid_t lps0_dsm_guid;
> @@ -910,7 +911,8 @@ static int lps0_device_attach(struct acp
>  	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
>  		char bitmask = *(char *)out_obj->buffer.pointer;
>  
> -		if ((bitmask & ACPI_S2IDLE_FUNC_MASK) ==
> ACPI_S2IDLE_FUNC_MASK) {
> +		if ((bitmask & ACPI_LPS0_PLATFORM_MASK) ==
> ACPI_LPS0_PLATFORM_MASK ||
> +		    (bitmask & ACPI_LPS0_SCREEN_MASK) ==
> ACPI_LPS0_SCREEN_MASK) {
>  			lps0_dsm_func_mask = bitmask;
>  			lps0_device_handle = adev->handle;
>  			/*
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

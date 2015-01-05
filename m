From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / PM: Fix PM initialization for devices that are
 not present
Date: Mon, 5 Jan 2015 15:40:10 +0200
Message-ID: <20150105134010.GF1386@lahna.fi.intel.com>
References: <4453924.d7c5RYZUJi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50437 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbbAENkU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 5 Jan 2015 08:40:20 -0500
Content-Disposition: inline
In-Reply-To: <4453924.d7c5RYZUJi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jan 01, 2015 at 11:38:28PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If an ACPI device object whose _STA returns 0 (not present and not
> functional) has _PR0 or _PS0, its power_manageable flag will be set
> and acpi_bus_init_power() will return 0 for it.  Consequently, if
> such a device object is passed to the ACPI device PM functions, they
> will attempt to carry out the requested operation on the device,
> although they should not do that for devices that are not present.
> 
> To fix that problem make acpi_bus_init_power() return an error code
> for devices that are not present which will cause power_manageable to
> be cleared for them as appropriate in acpi_bus_get_power_flags().
> However, the lists of power resources should not be freed for the
> device in that case, so modify acpi_bus_get_power_flags() to keep
> those lists even if acpi_bus_init_power() returns an error.
> Accordingly, when deciding whether or not the lists of power
> resources need to be freed, acpi_free_power_resources_lists()
> should check the power.flags.power_resources flag instead of
> flags.power_manageable, so make that change too.
> 
> Furthermore, if acpi_bus_attach() sees that flags.initialized is
> unset for the given device, it should reset the power management
> settings of the device and re-initialize them from scratch instead
> of relying on the previous settings (the device may have appeared
> after being not present previously, for example), so make it use
> the 'valid' flag of the D0 power state as the initial value of
> flags.power_manageable for it and call acpi_bus_init_power() to
> discover its current power state.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

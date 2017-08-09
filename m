From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/2] ACPI / Sleep: Check low power idle constraints for debug only
Date: Thu, 10 Aug 2017 01:17:02 +0200
Message-ID: <2200531.jeIBytVRuy@aspire.rjw.lan>
References: <1502232075-23832-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1502232075-23832-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1502232075-23832-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 9, 2017 12:41:15 AM CEST Srinivas Pandruvada wrote:
> For SoC to achieve its lowest power platform idle state a set of hardware
> preconditions must be met. These preconditions or constraints can be
> obtained by issuing a device specific method (_DSM) with function "1".
> Refer to the document provided in the link below.
> 
> Here during initialization (from attach() callback of LPS0 device), invoke
> function 1 to get the device constraints. Each enabled constraint is
> stored in a table.
> 
> The devices in this table are used to check whether they were in required
> minimum state, while entering suspend. This check is done from platform
> freeze wake() callback, only when /sys/power/pm_debug_messages attribute
> is non zero.
> 
> If any constraint is not met and device is ACPI power managed then it
> prints the device name to kernel logs.
> 
> Also if debug is enabled in acpi/sleep.c, the constraint table and state
> of each device on wake is dumped in kernel logs.
> 
> Link: http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/sleep.c | 162 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 162 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 2b881de..b3ef577 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -669,6 +669,7 @@ static const struct acpi_device_id lps0_device_ids[] = {

[cut]

>  
> @@ -773,6 +933,8 @@ static void acpi_freeze_wake(void)
>  	 */
>  	if (acpi_sci_irq_valid() &&
>  	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
> +		if (pm_debug_messages_enabled())
> +			lpi_check_constraints();

I'm not sure why you only want to check the constraints when we do the
_cancel_wakeup() thing.

IMO the check is relevant regardless of whether or not the wakeup was
via ACPI.

>  		pm_system_cancel_wakeup();
>  		s2idle_wakeup = true;
>  	}
> 



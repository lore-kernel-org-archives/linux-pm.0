From: Boris Ostrovsky <boris.ostrovsky@amd.com>
Subject: Re: [PATCH] Use safe_halt() rather than halt() in acpi_idle_play_deay()
Date: Tue, 3 Apr 2012 12:52:19 -0400
Message-ID: <4F7B2AC3.3060706@amd.com>
References: <4f7b27487632dad07@agluck-desktop.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4f7b27487632dad07@agluck-desktop.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 04/03/12 12:37, Luck, Tony: <tony.luck@intel.com wrote:
> ACPI code is shared by arch/x86 and arch/ia64. ia64 doesn't provide a plain
> "halt()" function.  Use safe_halt() instead.
>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
>
> ---
>
> E-mail discussion indicated this would be OK. Please check on x86
> before applying.

Tested-by: Boris Ostrovsky <boris.ostrovsky@amd.com>

-boris

>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index b3447f6..f3decb3 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -786,7 +786,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>   	while (1) {
>
>   		if (cx->entry_method == ACPI_CSTATE_HALT)
> -			halt();
> +			safe_halt();
>   		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>   			inb(cx->address);
>   			/* See comment in acpi_idle_do_entry() */
>



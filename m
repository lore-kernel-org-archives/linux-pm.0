From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: Fall back to manually changing SCI_EN
Date: Wed, 28 Apr 2010 20:58:20 +0200
Message-ID: <201004282058.20910.rjw__16977.4429560222$1272481150$gmane$org@sisk.pl>
References: <1271711614-15527-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1271711614-15527-1-git-send-email-mjg@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday 19 April 2010, Matthew Garrett wrote:
> The ACPI spec tells us that the ACPI SCI_EN bit is under hardware control
> and shouldn't be touched by the OS. It seems that the Leading Other OS
> ignores this and some machines expect this behaviour. We have a blacklist
> for these, but given that we're able to detect the failure case and the
> alternative to breaking the spec is letting the machine crash and burn,
> let's try falling back when we know the alternative is a mostly-dead
> machine.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

I guess we can try that, but I'd prefer it if that went into .35.

It _should_ be safe, but ...

Anyway, Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/acpi/sleep.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index f74834a..79df8d4 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -227,6 +227,7 @@ static int acpi_suspend_begin(suspend_state_t pm_state)
>  static int acpi_suspend_enter(suspend_state_t pm_state)
>  {
>  	acpi_status status = AE_OK;
> +	acpi_status enable_status = AE_OK;
>  	unsigned long flags = 0;
>  	u32 acpi_state = acpi_target_sleep_state;
>  
> @@ -254,10 +255,19 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
>  	}
>  
>  	/* If ACPI is not enabled by the BIOS, we need to enable it here. */
> -	if (set_sci_en_on_resume)
> +	if (!set_sci_en_on_resume)
> +		enable_status = acpi_enable();
> +
> +	if (set_sci_en_on_resume || enable_status == AE_NO_HARDWARE_RESPONSE)
> +		/* If we're still in legacy mode then we have a problem. The
> +		 * spec tells us that this bit is under hardware control, but
> +		 * there's no plausible way that the OS can transition back to
> +		 * legacy mode so our choices here are to either ignore the
> +		 * spec or crash and burn horribly. The latter doesn't seem
> +		 * like it's ever going to be the preferable choice, so let's
> +		 * live dangerously.
> +		 */
>  		acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
> -	else
> -		acpi_enable();
>  
>  	/* Reprogram control registers and execute _BFS */
>  	acpi_leave_sleep_state_prep(acpi_state);

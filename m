From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] ACPI suspend: Blacklist boxes that require
	us to set	SCI_EN directly on resume
Date: Thu, 20 Nov 2008 14:17:38 +0100
Message-ID: <20081120131738.GB1408__6039.97049988738$1227276011$gmane$org@ucw.cz>
References: <200811172333.13466.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200811172333.13466.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tino Keitel <tino.keitel@gmx.de>, Bob Copeland <me@bobcopeland.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: ACPI suspend: Blacklist boxes that require us to set SCI_EN directly on resume
> 
> Some Apple boxes evidently require us to set SCI_EN on resume
> directly, because if we don't do that, they hung somewhere in the
> resume code path.  Moreover, on these boxes it is not sufficient to
> use acpi_enable() to turn ACPI on during resume.  All of this is
> against the ACPI specification which states that (1) the BIOS is
> supposed to return from the S3 sleep state with ACPI enabled
> (SCI_EN set) and (2) the SCI_EN bit is owned by the hardware and we
> are not supposed to change it.
> 
> For this reason, blacklist the affected systems so that the SCI_EN
> bit is set during resume on them.
> 
> [NOTE: Unconditional setting SCI_EN for all system on resume doesn't
>  work, because it makes some other systems crash (that's to be
>  expected).  Also, it is not entirely clear right now if all of the
>  Apple boxes require this workaround.]


Silent bug workarounds are evil. In this case, MSI insisted their BIOS
is correct because it works with opensuse11, and forced us to backport
workaround to sled instead of fixing their bios :-(.


> This patch fixes the recent regression tracked as
> http://bugzilla.kernel.org/show_bug.cgi?id=12038
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Tested-by: Tino Keitel <tino.keitel@gmx.de>
> Tested-by: Bob Copeland <me@bobcopeland.com>

ACK.


> ---
>  drivers/acpi/sleep/main.c |   40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/sleep/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/sleep/main.c
> +++ linux-2.6/drivers/acpi/sleep/main.c
> @@ -104,6 +104,18 @@ void __init acpi_s4_no_nvs(void)
>  	s4_no_nvs = true;
>  }
>  
> +/*
> + * According to the ACPI specification the BIOS should make sure that ACPI is
> + * enabled and SCI_EN bit is set on wake-up from S1 - S3 sleep states.  Still,
> + * some BIOSes don't do that and therefore we use acpi_enable() to enable ACPI
> + * on such systems during resume.  Unfortunately that doesn't help in
> + * particularly pathological cases in which SCI_EN has to be set directly on
> + * resume, although the specification states very clearly that this flag is
> + * owned by the hardware.  The set_sci_en_on_resume variable will be set in such
> + * cases.
> + */
> +static bool set_sci_en_on_resume;
> +
>  /**
>   *	acpi_pm_disable_gpes - Disable the GPEs.
>   */
> @@ -249,7 +261,11 @@ static int acpi_suspend_enter(suspend_st
>  	}
>  
>  	/* If ACPI is not enabled by the BIOS, we need to enable it here. */
> -	acpi_enable();
> +	if (set_sci_en_on_resume)
> +		acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1);
> +	else
> +		acpi_enable();
> +
>  	/* Reprogram control registers and execute _BFS */
>  	acpi_leave_sleep_state_prep(acpi_state);
>  
> @@ -337,6 +353,12 @@ static int __init init_old_suspend_order
>  	return 0;
>  }
>  
> +static int __init init_set_sci_en_on_resume(const struct dmi_system_id *d)
> +{
> +	set_sci_en_on_resume = true;
> +	return 0;
> +}
> +
>  static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
>  	{
>  	.callback = init_old_suspend_ordering,
> @@ -354,6 +376,22 @@ static struct dmi_system_id __initdata a
>  		DMI_MATCH(DMI_PRODUCT_NAME, "HP xw4600 Workstation"),
>  		},
>  	},
> +	{
> +	.callback = init_set_sci_en_on_resume,
> +	.ident = "Apple MacBook 1,1",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "MacBook1,1"),
> +		},
> +	},
> +	{
> +	.callback = init_set_sci_en_on_resume,
> +	.ident = "Apple MacMini 1,1",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Macmini1,1"),
> +		},
> +	},
>  	{},
>  };
>  #endif /* CONFIG_SUSPEND */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

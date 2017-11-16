From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] acpi/x86: Fix improper handling of SCI INT for
 platforms supporting only IOAPIC mode
Date: Thu, 16 Nov 2017 12:04:52 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711161147200.2191@nanos>
References: <1510824595-12287-1-git-send-email-vikas.cha.sajjan@hpe.com> <1510824595-12287-2-git-send-email-vikas.cha.sajjan@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1510824595-12287-2-git-send-email-vikas.cha.sajjan@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Cc: rjw@rjwysocki.net, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kkamagui@gmail.com, mingo@kernel.org, Sunil V L <sunil.vl@hpe.com>, Abdul Lateef Attar <abdul-lateef.attar@hpe.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 16 Nov 2017, Vikas C Sajjan wrote:

Thanks for splitting this up.

> The platforms which support only IOAPIC mode and whose SCI INT is
> greater than 16, passes SCI INT via FADT and not via MADT int src override

greater? I think that's >= 16 because the legacy space is 0-15

> structure. In such cases current logic fails to handle it and throws error
> "Invalid bus_irq %u for legacy override".

Up to this point the changelog is informative. It just lacks the
information WHY the current logic fails to handle it.

> This patch fixes it.

This part is completely useless. You should at least explain the concept of
the fix, not the details (they can be seen from the code).

Let me give you an example:

 Platforms which support only IOAPIC mode pass the SCI information of
 interrupts above the legacy space (0-15) via the FADT mechanism and not
 via MADT, i.e. the table parser ends up calling acpi_sci_ioapic_setup().

 acpi_sci_ioapic_setup() uses mp_override_legacy_irq() to register SCI
 interrupts, which fails for interrupts >= 16, because it only handles
 interrupts 0-15.

 Provide a separate function to handle SCI interrupts >= 16 and invoke it
 conditional in acpi_sci_ioapic_setup().

 This creates some code duplication, which will be cleaned up in a separate
 patch.

See?
 
> Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
> Signed-off-by: Sunil V L <sunil.vl@hpe.com>
> Signed-off-by: Abdul Lateef Attar <abdul-lateef.attar@hpe.com>

This Signed-off-by chain is broken. It says:

     Vikas wrote the patch and handed it to Sunil
     Sunil handed it to Abdul
     Abdul sent it to lkml

Which is obviously not the case.

> ---
>  arch/x86/kernel/acpi/boot.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index ef9e02e..40c24d1b 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -429,6 +429,37 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
>  	return 0;
>  }
>  
> +static int __init mp_register_ioapic_irq(u8 bus_irq, u8 polarity,
> +						u8 trigger, u32 gsi)
> +{
> +	int ioapic;
> +	int pin;
> +	struct mpc_intsrc mp_irq;

I know you copied that, but please get rid of the extra line and sort the
variables in reverse fir tree fashion, i.e.:

	struct mpc_intsrc mp_irq;
	int ioapic, pin;

That takes less space and is better to read/parse.

> +
> +	/*
> +	 * Convert 'gsi' to 'ioapic.pin'.
> +	 */

Please make this a one line comment. It's useful, but not that important to
stand out.

> +	ioapic = mp_find_ioapic(gsi);
> +	if (ioapic < 0) {
> +		pr_warn("Failed to find ioapic for gsi : %u\n", gsi);
> +		return ioapic;
> +	}
> +
> +	pin = mp_find_ioapic_pin(ioapic, gsi);
> +
> +	mp_irq.type = MP_INTSRC;
> +	mp_irq.irqtype = mp_INT;
> +	mp_irq.irqflag = (trigger << 2) | polarity;
> +	mp_irq.srcbus = MP_ISA_BUS;
> +	mp_irq.srcbusirq = bus_irq;	/* IRQ */

Please get rid of these tail comments. First of all tail comments are
disturbing the reading flow. Secondly these comment have exactly zero value.

> +	mp_irq.dstapic = mpc_ioapic_id(ioapic); /* APIC ID */
> +	mp_irq.dstirq = pin;	/* INTIN# */

except for this one, but that information should go into that other comment
above, i.e.:

       /* Convert 'gsi' to ioapic.pin (INTIN#) */

Other than these more formal nitpicks, the patch is fine.

Thanks,

	tglx

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Delete some unusefull operations for centaur CPU/platform
Date: Fri, 02 Mar 2018 12:31:34 +0100
Message-ID: <1983196.2xaV79s388@aspire.rjw.lan>
References: <1519963908-4359-1-git-send-email-davidwang@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519963908-4359-1-git-send-email-davidwang@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wang <davidwang@zhaoxin.com>
Cc: len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@kernel.org, linux-kernel@vger.kernel.org, brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com, timguo@zhaoxin.com, cobechen@zhaoxin.com, jiangbowang@zhaoxin.com
List-Id: linux-pm@vger.kernel.org

On Friday, March 2, 2018 5:11:48 AM CET David Wang wrote:
> For Centaur CPU, the ucode will make sure that each CPU core can keep cache
> coherency with each other when the CPU core entering to any C state. So the
> cache flush operations when enter C3 is not necessary and will cause large
> C3 enter/exit latency.
> And the bus master disable operation when CPU core entering C3 state is not
> needed too. Because the chipset will automatically do this operation.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>

I've queued up the previous version of your patch with some changes to
comments/subject/changelog made by me for v4.17.

Please see linux-next.

> ---
>  arch/x86/kernel/acpi/cstate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index dde437f..1cd357b 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -51,6 +51,18 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>  	if (c->x86_vendor == X86_VENDOR_INTEL &&
>  	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
>  			flags->bm_control = 0;
> +
> +        if (c->x86_vendor == X86_VENDOR_CENTAUR) {
> +		/*
> +		 * on all centaur CPUs, sw need not execute cache flush operation
> +		 * when entering C3 type State.
> +		 *
> +		 * On all Centaur platforms, sw need not execute ARB_DISABLE while
> +		 * entering C3 type state.
> +		 */
> +		flags->bm_check = 1;
> +		flags->bm_control = 0;
> +	}
>  }
>  EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
>  
> 

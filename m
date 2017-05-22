From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
 systems
Date: Mon, 22 May 2017 18:21:43 +0200
Message-ID: <20170522162143.GA19781@nazgul.tnic>
References: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:57254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758238AbdEVQVv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 May 2017 12:21:51 -0400
Content-Disposition: inline
In-Reply-To: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz

On Wed, May 17, 2017 at 09:20:19AM -0500, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> AMD systems support the Monitor/Mwait instructions and these can be used
> for ACPI C1 in the same way as on Intel systems, with appropriate BIOS
> support.
> 
> Allow ffh_cstate_init() to succeed on AMD systems and make the Cstate
> description vendor-agnostic.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kernel/acpi/cstate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 8a908ae..4c5dd5d 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -109,7 +109,7 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
>  			cx->type);
>  	}
>  	snprintf(cx->desc,
> -			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> +			ACPI_CX_DESC_LEN, "ACPI FFH X86 MWAIT 0x%x",
>  			cx->address);
>  out:
>  	return retval;
> @@ -169,7 +169,8 @@ static int __init ffh_cstate_init(void)
>  {
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  
> -	if (c->x86_vendor != X86_VENDOR_INTEL)
> +	if (c->x86_vendor != X86_VENDOR_INTEL &&
> +	    c->x86_vendor != X86_VENDOR_AMD)
>  		return -1;
>  
>  	cpu_cstate_entry = alloc_percpu(struct cstate_entry);

What about x86_idle?

That whole select_idle_routine() jumping through hoops. That's still
doing default_idle() on Zen, AFAICT.

Or am I missing something?

Because that still asks prefer_mwait_c1_over_halt() and that needs a
family check or whatever...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

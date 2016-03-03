From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: Fix crash on graph trace through x86 suspend
Date: Thu, 3 Mar 2016 01:19:09 +0100
Message-ID: <CAJZ5v0gX+FEHryK=dJvQ1kXO19Addk5nr4jid012CpZzVdE_tA@mail.gmail.com>
References: <1456963529-4962-1-git-send-email-todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33647 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbcCCATL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 19:19:11 -0500
Received: by mail-lb0-f180.google.com with SMTP id k15so4622193lbg.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 16:19:10 -0800 (PST)
In-Reply-To: <1456963529-4962-1-git-send-email-todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, todd.e.brandt@intel.com

On Thu, Mar 3, 2016 at 1:05 AM, Todd Brandt
<todd.e.brandt@linux.intel.com> wrote:
> Pause/unpause graph tracing around do_suspend_lowlevel as it has
> inconsistent call/return info after it jumps to the wakeup vector.
> The graph trace buffer will otherwise become misaligned and
> may eventually crash and hang on suspend.
>
> To reproduce the issue and test the fix:
> Run a function_graph trace over suspend/resume and set the graph
> function to suspend_devices_and_enter. This consistently hangs the
> system without this fix.
>
> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>

OK

I guess we'll need that in -stable, right?

> ---
>  arch/x86/kernel/acpi/sleep.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index d1daead..311360e 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -16,6 +16,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/realmode.h>
>
> +#include <linux/ftrace.h>
>  #include "../../realmode/rm/wakeup.h"
>  #include "sleep.h"
>
> @@ -107,7 +108,13 @@ int x86_acpi_suspend_lowlevel(void)
>         saved_magic = 0x123456789abcdef0L;
>  #endif /* CONFIG_64BIT */
>
> +       /*
> +        * Pause/unpause graph tracing around do_suspend_lowlevel as it has
> +        * inconsistent call/return info after it jumps to the wakeup vector
> +        */
> +       pause_graph_tracing();
>         do_suspend_lowlevel();
> +       unpause_graph_tracing();
>         return 0;
>  }
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

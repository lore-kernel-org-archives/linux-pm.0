From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] powercap/rapl: Do not load in virtualized environments
Date: Wed, 18 May 2016 02:50:07 +0200
Message-ID: <CAJZ5v0g59CvQVePgCbEsXvw5UqOcqvn-Snh3=0Jcnj=mhT_mfg@mail.gmail.com>
References: <1463484845-9839-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33897 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbcERAuJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2016 20:50:09 -0400
In-Reply-To: <1463484845-9839-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Jun Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, May 17, 2016 at 1:34 PM, Prarit Bhargava <prarit@redhat.com> wrote:
> intel_rapl is currently not supported in virtualized environments.  When
> booting the warning message
>
> intel_rapl: no valid rapl domains found in package 0

You seem to be saying that this message is problematic for some
reason, so why is it?

> is output for every virtual core.
>
> This patch stops the driver from being loaded in virtual boots.
>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Jacob Jun Pan <jacob.jun.pan@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  drivers/powercap/intel_rapl.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index f2201d42a9cd..bebfbe8acccd 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -29,6 +29,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/cpu.h>
>  #include <linux/powercap.h>
> +#include <asm/hypervisor.h>
>  #include <asm/iosf_mbi.h>
>
>  #include <asm/processor.h>
> @@ -1600,6 +1601,10 @@ static int __init rapl_init(void)
>                 return -ENODEV;
>         }
>
> +       /* Intel RAPL is not supported on virtualized environments */
> +       if (x86_hyper)
> +               return -ENODEV;
> +
>         rapl_defaults = (struct rapl_defaults *)id->driver_data;
>
>         cpu_notifier_register_begin();
> --

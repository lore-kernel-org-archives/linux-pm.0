From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 05/12][RFC v3] x86-32, hibernate: Enable
 CONFIG_ARCH_HIBERNATION_HEADER set on 32bit system
Date: Wed, 19 Sep 2018 12:31:42 +0200
Message-ID: <CAJZ5v0jHZDCqCS=rT2G1Vx4Q1xH52TtJWurH_5Y4mVM=M=BRYQ@mail.gmail.com>
References: <cover.1537275915.git.yu.c.chen@intel.com> <ec80ac5b3ef0505e4f4786c4ed1e4f88a7770f12.1537275915.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ec80ac5b3ef0505e4f4786c4ed1e4f88a7770f12.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, kookoo.gu@intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 19, 2018 at 9:32 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> From: Zhimin Gu <kookoo.gu@intel.com>
>
> Enable CONFIG_ARCH_HIBERNATION_HEADER for 32bit system so that
> md5 check is enabled and prepare for relocated code executing
> and jump address mapping.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1a0be022f91d..e8de5de1057f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2422,7 +2422,7 @@ menu "Power management and ACPI options"
>
>  config ARCH_HIBERNATION_HEADER
>         def_bool y
> -       depends on X86_64 && HIBERNATION
> +       depends on HIBERNATION
>
>  source "kernel/power/Kconfig"
>
> --

In this patch, in addition to the above, I would start moving the code
in hibernate.c that you want to be common in the end out of #ifdef
CONFIG_X86_64 blocks.

To start with, that would be the checksum handling code and the parts
of arch_hibernation_header_save/restore() that refer to it and the
"magic" value.

I would continue doing that in the subsequent patches to make it
easier to follow which pieces of code start to be used on 32-bit after
each patch.  The impact of each patch would be more clear this way
IMO.

Thanks,
Rafael

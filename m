From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM/reboot: call syscore_shutdown() after disable_nonboot_cpus()
Date: Sun, 07 Apr 2013 10:46 +0200
Message-ID: <3513307.9cks2gqsZt@vostro.rjw.lan>
References: <1365300854-3133-1-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365300854-3133-1-git-send-email-chenhc@lemote.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huacai Chen <chenhc@lemote.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, April 07, 2013 10:14:14 AM Huacai Chen wrote:
> As commit 40dc166c (PM / Core: Introduce struct syscore_ops for core
> subsystems PM) say, syscore_ops operations should be carried with one
> CPU on-line and interrupts disabled. However, after commit f96972f2d
> (kernel/sys.c: call disable_nonboot_cpus() in kernel_restart()),
> syscore_shutdown() is called before disable_nonboot_cpus(), so break
> the rules. We have a MIPS machine with a 8259A PIC, and there is an
> external timer (HPET) linked at 8259A. Since 8259A has been shutdown
> too early (by syscore_shutdown()), disable_nonboot_cpus() runs without
> timer interrupt, so it hangs and reboot fails. This patch call
> syscore_shutdown() a little later (after disable_nonboot_cpus()) to
> avoid reboot failure, this is the same way as poweroff does.
> 
> BTW, add disable_nonboot_cpus() in kernel_halt() for consistency.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Cc: <stable@vger.kernel.org>

While I agree with the changes, I'm not sure if I'm the right maintainer,
as this isn't really PM code.

Andrew, should I take this?

Rafael


> ---
>  kernel/sys.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 39c9c4a..0da73cf 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -324,7 +324,6 @@ void kernel_restart_prepare(char *cmd)
>  	system_state = SYSTEM_RESTART;
>  	usermodehelper_disable();
>  	device_shutdown();
> -	syscore_shutdown();
>  }
>  
>  /**
> @@ -370,6 +369,7 @@ void kernel_restart(char *cmd)
>  {
>  	kernel_restart_prepare(cmd);
>  	disable_nonboot_cpus();
> +	syscore_shutdown();
>  	if (!cmd)
>  		printk(KERN_EMERG "Restarting system.\n");
>  	else
> @@ -395,6 +395,7 @@ static void kernel_shutdown_prepare(enum system_states state)
>  void kernel_halt(void)
>  {
>  	kernel_shutdown_prepare(SYSTEM_HALT);
> +	disable_nonboot_cpus();
>  	syscore_shutdown();
>  	printk(KERN_EMERG "System halted.\n");
>  	kmsg_dump(KMSG_DUMP_HALT);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

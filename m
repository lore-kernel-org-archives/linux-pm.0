From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [RFC][PATCH 1/2] PM: Split up
	sysdev_[suspend|resume] from	device_power_[down|up]
Date: Sun, 22 Feb 2009 22:56:54 +0200
Message-ID: <20090222205654.GC4485__42253.2407254495$1235336352$gmane$org@localhost.pp.htv.fi>
References: <200902221837.49396.rjw@sisk.pl> <200902221838.51548.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902221838.51548.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 22, 2009 at 06:38:50PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Move the sysdev_suspend/resume from the callee to the callers, with
> no real change in semantics, so that we can rework the disabling of
> interrupts during suspend/hibernation.
> 
> This is based on an earlier patch from Linus.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>...
> --- linux-2.6.orig/arch/x86/kernel/apm_32.c
> +++ linux-2.6/arch/x86/kernel/apm_32.c
> @@ -1192,6 +1192,7 @@ static int suspend(int vetoable)
>  	device_suspend(PMSG_SUSPEND);
>  	local_irq_disable();
>  	device_power_down(PMSG_SUSPEND);
> +	sysdev_suspend(PMSG_SUSPEND);
>  
>  	local_irq_enable();
>  
> @@ -1208,6 +1209,7 @@ static int suspend(int vetoable)
>  	if (err != APM_SUCCESS)
>  		apm_error("suspend", err);
>  	err = (err == APM_SUCCESS) ? 0 : -EIO;
> +	sysdev_resume();
>  	device_power_up(PMSG_RESUME);
>  	local_irq_enable();
>  	device_resume(PMSG_RESUME);
> @@ -1228,6 +1230,7 @@ static void standby(void)
>  
>  	local_irq_disable();
>  	device_power_down(PMSG_SUSPEND);
> +	sysdev_suspend(PMSG_SUSPEND);
>  	local_irq_enable();
>  
>  	err = set_system_power_state(APM_STATE_STANDBY);
> @@ -1235,6 +1238,7 @@ static void standby(void)
>  		apm_error("standby", err);
>  
>  	local_irq_disable();
> +	sysdev_resume();
>  	device_power_up(PMSG_RESUME);
>  	local_irq_enable();
>  }
>...

This causes the following build error with CONFIG_APM=m:

<--  snip  -->

...
  MODPOST 2586 modules
ERROR: "sysdev_resume" [arch/x86/kernel/apm.ko] undefined!
ERROR: "sysdev_suspend" [arch/x86/kernel/apm.ko] undefined!
make[2]: *** [__modpost] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

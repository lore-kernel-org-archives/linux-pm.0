From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: Do not load if user overrides
 idle function via idle= boot param
Date: Wed, 03 Nov 2010 02:33:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1011030150560.3378__4249.8582428836$1288766094$gmane$org@localhost.localdomain>
References: <201011021441.09258.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201011021441.09258.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2 Nov 2010, Thomas Renninger wrote:
> 
> if idle= boot param is passed, cpuidle drivers should not register
> and only arch specific idle routines should get active.
> 
> Ideally cpuidle subsystem would be made aware of this.
> But acpi parses sleep state tables before registering for cpuidle
> which should not happen if idle= is passed.
> 
> -> Check for boot_option_idle_override in cpuidle drivers, not
> cpuidle subsystem.
> 
> Compare with:
> arch/x86/kernel/process.c
> and
> drivers/acpi/processor_idle.c

idle=halt and idle=nomwait will not
set boot_option_idle_override,
so checking that option in intel_idle
is a NOP for those incantations.

idle_setup() is a confusing mess.
That function and all these idle workaround flags
need to be re-whacked.

thanks,
-Len Brown, Intel Open Source Technology Center

> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: lenb@kernel.org
> CC: linux-acpi@vger.kernel.org
> CC: stable@kernel.org
> CC: linux-pm@lists.linux-foundation.org                                                                                                                               
>  
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 41665d2..e50389b 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -410,6 +410,9 @@ static int __init intel_idle_init(void)
>  {
>  	int retval;
>  
> +	if (boot_option_idle_override)
> +		return -ENODEV;
> +
>  	retval = intel_idle_probe();
>  	if (retval)
>  		return retval;
> 

From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] ACPI / cpuidle: fix deadlock between cpuidle_lock and
 cpu_hotplug.lock
Date: Wed, 17 Sep 2014 14:11:12 +0530
Message-ID: <20140917084112.GC31806@in.ibm.com>
References: <alpine.LNX.2.00.1409031404110.12309@pobox.suse.cz>
 <alpine.LNX.2.00.1409031503140.12309@pobox.suse.cz>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1409031503140.12309@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Oleg Nesterov <oleg@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Jiri,

On Wed, Sep 03, 2014 at 03:04:28PM +0200, Jiri Kosina wrote:
> There is a following AB-BA dependency between cpu_hotplug.lock and 
> cpuidle_lock:
> 
> 1) cpu_hotplug.lock -> cpuidle_lock
> enable_nonboot_cpus()
>  _cpu_up()
>   cpu_hotplug_being()
>    LOCK(cpu_hotplug.lock)
>  cpu_notify()
>   ...
>   acpi_processor_hotplug()
>    cpuidle_pause_and_lock()
>     LOCK(cpuidle_lock)
> 
> 2) cpuidle_lock -> cpu_hotplug.lock
> acpi_os_execute_deferred() workqueue
>  ...
>  acpi_processor_cst_has_changed()
>   cpuidle_pause_and_lock()
>    LOCK(cpuidle_lock)
>   get_online_cpus()
>    LOCK(cpu_hotplug.lock)
> 
> Fix this by reversing the order acpi_processor_cst_has_changed() does 
> thigs -- let it first execute the protection against CPU hotplug by 
> calling get_online_cpus() and obtain the cpuidle lock only after that (and 
> perform the symmentric change when allowing CPUs hotplug again and 
> dropping cpuidle lock).
> 
> Spotted by lockdep.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Looks good to me.
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  drivers/acpi/processor_idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 3dca36d..17f9ec5 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1071,9 +1071,9 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
> 
>  	if (pr->id == 0 && cpuidle_get_driver() == &acpi_idle_driver) {
> 
> -		cpuidle_pause_and_lock();
>  		/* Protect against cpu-hotplug */
>  		get_online_cpus();
> +		cpuidle_pause_and_lock();
> 
>  		/* Disable all cpuidle devices */
>  		for_each_online_cpu(cpu) {
> @@ -1100,8 +1100,8 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>  				cpuidle_enable_device(dev);
>  			}
>  		}
> -		put_online_cpus();
>  		cpuidle_resume_and_unlock();
> +		put_online_cpus();
>  	}
> 
>  	return 0;
> -- 
> Jiri Kosina
> SUSE Labs
> 

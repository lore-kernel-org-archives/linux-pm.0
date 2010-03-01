From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Mon, 1 Mar 2010 13:40:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003011329550.1341-100000@iolanthe.rowland.org>
References: <201002272350.16523.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002272350.16523.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 27 Feb 2010, Rafael J. Wysocki wrote:

> What about the patch below, then (untested)?
> 
> Use GENERIC_SUBSYS_PM_OPS for the subsystem and then
> UNIVERSAL_DEV_PM_OPS for drivers, possibly passing NULL as idle_fn.


> +#ifdef CONFIG_PM_SLEEP
> +#define GENERIC_SYSTEM_SLEEP_PM_OPS \
> +	.suspend = pm_generic_suspend, \
> +	.resume = pm_generic_resume,
> +#else
> +#define GENERIC_SYSTEM_SLEEP_PM_OPS

Wouldn't you want to have this work for hibernation as well as suspend?  
So the .freeze, .thaw, etc. members should be defined too.

> +/*
> + * Use this for subsystems (bus types, device types, device classes) that only
> + * need to invoke PM callbacks provided by device drivers supporting both the
> + * system sleep PM and runtime PM.
> + */  
> +#define GENERIC_SUBSYS_PM_OPS(name) \
> +const struct dev_pm_ops name = { \
> +GENERIC_SYSTEM_SLEEP_PM_OPS \
> +GENERIC_RUNTIME_PM_OPS \
>  }

There's no reason for this to have "name" as a parameter, since all
instances of the structure will be identical.  Instead you can put

	extern const struct dev_pm_ops generic_subsys_pm_ops;
	EXPORT_SYMBOL_GPL(generic_subsys_pm_ops);

in the header file and define the structure in generic_ops.c.

Alan Stern

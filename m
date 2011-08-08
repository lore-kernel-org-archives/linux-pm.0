From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] PM: add statistics debugfs file for
	suspend to ram
Date: Mon, 8 Aug 2011 22:46:24 +0200
Message-ID: <201108082246.24726.rjw__27795.2648270459$1312836450$gmane$org@sisk.pl>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B8057C04B@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6E3BC7F7C9A4BF4286DD4C043110F30B5B8057C04B@shsmsx502.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Liu, ShuoX" <shuox.liu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, August 08, 2011, Liu, ShuoX wrote:
...
> @@ -982,6 +1003,8 @@ int dpm_suspend(pm_message_t state)
>  		error = async_error;
>  	if (!error)
>  		dpm_show_time(starttime, state, NULL);
> +	else
> +		suspend_stats.failed_suspend++;
>  	return error;
>  }

I'd prefer it to be

  if (error)
      something;
  else
      something else;

> @@ -1090,6 +1113,8 @@ int dpm_suspend_start(pm_message_t state)
>  	error = dpm_prepare(state);
>  	if (!error)
>  		error = dpm_suspend(state);
> +	else
> +		suspend_stats.failed_prepare++;
>  	return error;
>  }

Same here.

>  EXPORT_SYMBOL_GPL(dpm_suspend_start);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 6bbcef2..6a8ff23 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -34,6 +34,22 @@ typedef int __bitwise suspend_state_t;
>  #define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
>  #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
>  
> +struct suspend_stats {
> +	int	success;
> +	int	fail;
> +	int	failed_freeze;
> +	int	failed_prepare;
> +	int	failed_suspend;
> +	int	failed_suspend_noirq;
> +	int	failed_resume;
> +	int	failed_resume_noirq;
> +#define	REC_FAILED_DEV_NUM	2
> +	char	failed_devs[REC_FAILED_DEV_NUM][40];
> +	int	last_failed;
> +};
> +
> +extern struct suspend_stats suspend_stats;
> +
>  /**
>   * struct platform_suspend_ops - Callbacks for managing platform dependent
>   *	system sleep states.
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 6c601f8..0977f5d 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -12,6 +12,8 @@
>  #include <linux/string.h>
>  #include <linux/resume-trace.h>
>  #include <linux/workqueue.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
>  
>  #include "power.h"
>  
> @@ -133,6 +135,59 @@ power_attr(pm_test);
>  
>  #endif /* CONFIG_PM_SLEEP */
>  
> +#ifdef CONFIG_DEBUG_FS
> +static int suspend_stats_show(struct seq_file *s, void *unused)
> +{
> +	int i, index, last_index;
> +
> +	last_index = suspend_stats.last_failed + REC_FAILED_DEV_NUM - 1;
> +	last_index %= REC_FAILED_DEV_NUM;
> +	seq_printf(s, "%s: %d\n%s: %d\n%s: %d\n%s: %d\n"
> +			"%s: %d\n%s: %d\n%s: %d\n%s: %d\n",
> +			"success", suspend_stats.success,
> +			"fail", suspend_stats.fail,
> +			"failed_freeze", suspend_stats.failed_freeze,
> +			"failed_prepare", suspend_stats.failed_prepare,
> +			"failed_suspend", suspend_stats.failed_suspend,
> +			"failed_suspend_noirq",
> +				suspend_stats.failed_suspend_noirq,
> +			"failed_resume", suspend_stats.failed_resume,
> +			"failed_resume_noirq",
> +				suspend_stats.failed_resume_noirq);
> +	seq_printf(s,	"failed_devs:\n  last_failed:\t%s\n",
> +			suspend_stats.failed_devs[last_index]);
> +	for (i = 1; i < REC_FAILED_DEV_NUM; i++) {
> +		index = last_index + REC_FAILED_DEV_NUM - i;
> +		index %= REC_FAILED_DEV_NUM;
> +		seq_printf(s, "\t\t%s\n",
> +			suspend_stats.failed_devs[index]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int suspend_stats_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, suspend_stats_show, NULL);
> +}
> +
> +static const struct file_operations suspend_stats_operations = {
> +	.open           = suspend_stats_open,
> +	.read           = seq_read,
> +	.llseek         = seq_lseek,
> +	.release        = single_release,
> +};
> +
> +static int __init pm_debugfs_init(void)
> +{
> +	debugfs_create_file("suspend_stats", S_IFREG | S_IRUGO,
> +			NULL, NULL, &suspend_stats_operations);
> +	return 0;
> +}
> +
> +late_initcall(pm_debugfs_init);
> +#endif /* CONFIG_DEBUG_FS */
> +
>  struct kobject *power_kobj;
>  
>  /**
> @@ -194,6 +249,10 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	}
>  	if (state < PM_SUSPEND_MAX && *s)
>  		error = enter_state(state);
> +		if (error)
> +			suspend_stats.fail++;
> +		else
> +			suspend_stats.success++;
>  #endif
>  
>   Exit:
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index b6b71ad..9bb4281 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -106,6 +106,8 @@ static int suspend_prepare(void)
>  	error = suspend_freeze_processes();
>  	if (!error)
>  		return 0;
> +	else
> +		suspend_stats.failed_freeze++;
>  

And same here.

Apart from the above, I don't have complaints.

Thanks,
Rafael

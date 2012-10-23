From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] rtpm-core: enable counters for PM state transitions
Date: Wed, 24 Oct 2012 01:37:03 +0200
Message-ID: <4780242.tbR0uvdI2F@vostro.rjw.lan>
References: <1351011142-6249-1-git-send-email-sundar.iyer@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:33454 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933579Ab2JWXdI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Oct 2012 19:33:08 -0400
In-Reply-To: <1351011142-6249-1-git-send-email-sundar.iyer@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sundar Iyer <sundar.iyer@intel.com>
Cc: vivek.thakkar@intel.com, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday 23 of October 2012 22:22:22 Sundar Iyer wrote:
> Add usage counters for every runtime suspend/resume
> to enable runtime characteristics debug
> 
> Change-Id: I174dbf3ffc4161eb9baf597ae545a1bc4108e516
> Signed-off-by: Sundar Iyer <sundar.iyer@intel.com>

First off, the linux-pm@lists.linux-foundation.org list is dead.
Please use linux-pm@vger.kernel.org instead (as documented in multiple places).

Second, what's the performance impact of this patch?

Rafael


> ---
>  drivers/base/power/runtime.c |    6 +++++
>  drivers/base/power/sysfs.c   |   44 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm.h           |    2 +
>  3 files changed, 52 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 1f339d5..5895bc2 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -52,6 +52,10 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
>  	update_pm_runtime_accounting(dev);
>  	trace_runtime_pm_status(dev, status);
>  	dev->power.runtime_status = status;
> +	if (status == RPM_SUSPENDED)
> +		atomic_inc(&dev->power.suspend_transition_count);
> +	else if (status == RPM_ACTIVE)
> +		atomic_inc(&dev->power.resume_transition_count);
>  }
>  
>  /**
> @@ -1240,6 +1244,8 @@ void pm_runtime_init(struct device *dev)
>  
>  	dev->power.disable_depth = 1;
>  	atomic_set(&dev->power.usage_count, 0);
> +	atomic_set(&dev->power.suspend_transition_count, 0);
> +	atomic_set(&dev->power.resume_transition_count, 0);
>  
>  	dev->power.runtime_error = 0;
>  
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index a9f5b89..32c372e 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -186,6 +186,46 @@ static ssize_t rtpm_status_show(struct device *dev,
>  
>  static DEVICE_ATTR(runtime_status, 0444, rtpm_status_show, NULL);
>  
> +static ssize_t suspend_transition_count_store(struct device *dev,
> +		struct device_attribute *attr, char *buf, size_t n)
> +{
> +	atomic_set(&dev->power.suspend_transition_count, 0);
> +
> +	return n;
> +}
> +
> +static ssize_t suspend_transition_count_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n",
> +			atomic_read(&dev->power.suspend_transition_count));
> +}
> +
> +static DEVICE_ATTR(runtime_suspend_transition, 0644,
> +		suspend_transition_count_show,
> +		suspend_transition_count_store);
> +
> +static ssize_t resume_transition_count_store(struct device *dev,
> +		struct device_attribute *attr, char *buf, size_t n)
> +{
> +	atomic_set(&dev->power.resume_transition_count, 0);
> +
> +	return n;
> +}
> +
> +
> +static ssize_t resume_transition_count_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n",
> +			atomic_read(&dev->power.resume_transition_count));
> +}
> +
> +static DEVICE_ATTR(runtime_resume_transition, 0644,
> +		resume_transition_count_show,
> +		resume_transition_count_store);
> +
> +
>  static ssize_t autosuspend_delay_ms_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> @@ -438,6 +478,8 @@ static struct attribute *power_attrs[] = {
>  #endif
>  #ifdef CONFIG_PM_RUNTIME
>  	&dev_attr_runtime_status.attr,
> +	&dev_attr_runtime_suspend_transition.attr,
> +	&dev_attr_runtime_resume_transition.attr,
>  	&dev_attr_runtime_usage.attr,
>  	&dev_attr_runtime_active_kids.attr,
>  	&dev_attr_runtime_enabled.attr,
> @@ -472,6 +514,8 @@ static struct attribute *runtime_attrs[] = {
>  #ifdef CONFIG_PM_RUNTIME
>  #ifndef CONFIG_PM_ADVANCED_DEBUG
>  	&dev_attr_runtime_status.attr,
> +	&dev_attr_runtime_suspend_transition.attr,
> +	&dev_attr_runtime_resume_transition.attr,
>  #endif
>  	&dev_attr_control.attr,
>  	&dev_attr_runtime_suspended_time.attr,
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 411e4f4..4001ba2 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -442,6 +442,8 @@ struct dev_pm_info {
>  	wait_queue_head_t	wait_queue;
>  	atomic_t		usage_count;
>  	atomic_t		child_count;
> +	atomic_t		suspend_transition_count;
> +	atomic_t		resume_transition_count;
>  	unsigned int		disable_depth:3;
>  	unsigned int		ignore_children:1;
>  	unsigned int		idle_notification:1;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

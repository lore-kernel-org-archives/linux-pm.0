Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC644A384A;
	Mon, 19 Oct 2026 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399890; cv=none; b=EQRL5s8sbrYyQxxvWtfKISu+KvOtXcvt7tbup+bUw+SKO6EXEo44xEZxWmWqG1vFybAIqmtD6ud+z6PTmWhByfgkJbMxXCKvthQrk4g7M/UGiDCUHukcSrBitPL0vt6WwLF8Mqh6IjudCVqkpzKI16cEP0FZY2ZI37MNjuNcf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399890; c=relaxed/simple;
	bh=2NSqRpEuX7v4Xg6GlQD2CRZRzWslpUrxuvy9cVQX8KA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o/45fPUTakJGwko3WzQecXC6Ah4/RoaStGNxmY7oXVzSi6DN/HcEOEKCcOFxXse2jvTOOseXuiH4cWLDzxnUsNIj1h/keZzgw0kww1nmmP4Hx6viJ9rWhqyTktvTz4d9sdyqsDvPjzmMasHluzLYrH0zGMsfusySPo52myQ19dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZU/Ytda9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZU/Ytda9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399889; x=1823935889;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2NSqRpEuX7v4Xg6GlQD2CRZRzWslpUrxuvy9cVQX8KA=;
  b=ZU/Ytda98a15JME8b7XfeFYCF+rMiC1EOQFoyAZv3igQd93AxpHJhr0N
   jSkOnYBHjgswa9HWj5KvuEk/LHu/KLz9MbGMihIzeTnr3VLNrG6w6MfZo
   cJDV1L0aWKZfCaVL0KgCHD3Bz+vYdpeHOFWSE7KLylbXSts84Qjb+ruSD
   2xbdxjt8LeN2d8idDfXGppTTcMopPzwhLFlXVdnresDGyYTBOdjwIN8J1
   BlbfcKsd54xuijH/7NUDXqI/Dhz8ibPbzAOcGrXDAk7vQ0bzjJvjWnkU0
   f0emVCaKEMXyDXOb7O7RFVJftyDEZ1xSvdgJnXNOUPiatJG1sk6Jg7Fxs
   w==;
X-CSE-ConnectionGUID: K0+cD5I9Qi2bf4ETsBrW7w==
X-CSE-MsgGUID: 2nJnt8ONQciwEddG5LPw3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1100550"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1100550"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:51:09 -0700
X-CSE-ConnectionGUID: Ks/3HmzpQyy4sifFt1K2aA==
X-CSE-MsgGUID: 9uRHwIj9TzqlaBf9HksSbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4239543"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:51:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 Oct 2026 11:50:56 +0300 (EEST)
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Daniel Lezcano <daniel.lezcano@kernel.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Mario Limonciello (AMD)" <superm1@kernel.org>, 
    Jack Wu <jackbb_wu@compal.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Zhang DM <jixianqiang1540@gmail.com>, linux-acpi@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, 
    linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/5] platform profile: Separate handler locking from
 sysfs lifetime
In-Reply-To: <20261019073930.2352283-2-daniel.lezcano@oss.qualcomm.com>
Message-ID: <2818716f-3502-aa4b-0b7b-4efc61e46f6c@linux.intel.com>
References: <20261019073930.2352283-1-daniel.lezcano@oss.qualcomm.com> <20261019073930.2352283-2-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 Oct 2026, Daniel Lezcano wrote:

> Registration and removal currently hold profile_lock across
> device_unregister() and sysfs_update_group(). These operations can remove
> sysfs attributes and wait for their active callbacks to finish. The
> profile read and write callbacks acquire profile_lock themselves, so a
> concurrent access can deadlock:
> 
>   Removal/update path             Active sysfs callback
>   -------------------             ---------------------
>   acquire profile_lock            hold kernfs active reference
>   remove a sysfs attribute         wait for profile_lock
>   wait for its active references
> 
> The removal path cannot finish until the callback returns, and the
> callback cannot return until the removal path releases profile_lock.
> This applies both to per-provider device teardown and to updates of the
> legacy aggregate attribute group.
> 
> Commit 041142d7d252 ("ACPI: platform-profile: Fix possible deadlock in
> platform_profile_remove()") previously fixed this lock ordering by moving
> sysfs_remove_group() outside profile_lock. Commit 55b1e68134bf ("ACPI:
> platform_profile: Use guard(mutex) for register/unregister") reintroduced
> the issue by extending the mutex guard over sysfs_remove_group(). Later,
> commit 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
> platform profile") replaced that teardown with device_unregister() and
> sysfs_update_group(), still under the same mutex, extending the problem
> to class-device teardown and aggregate attribute updates.
> 
> Simply dropping profile_lock around these operations is insufficient.
> Aggregate operations currently discover providers through the class
> device list. A provider being unregistered could therefore still be
> selected for an aggregate read, write or cycle while its sysfs files are
> being torn down. Concurrent registrations and removals would also race
> when updating aggregate attribute visibility.
> 
> Introduce profile_registration_lock to serialize registration, removal
> and aggregate sysfs updates. Sysfs callbacks never acquire this mutex.
> Retain profile_lock for profile operations and use it to protect an
> explicit list of handlers participating in the aggregate interface.
> 
> Add a handler to that list only after device_register() succeeds. On
> removal, unlink it under profile_lock before calling device_unregister().
> Acquiring profile_lock first waits for any aggregate operation already
> using the handler to complete; unlinking prevents later aggregate
> operations from finding it. Release profile_lock before draining sysfs
> callbacks, allowing active per-provider callbacks to complete before the
> device is released. Apply the same unlink-before-unregister ordering to
> registration error cleanup.
> 
> Walk this list for aggregate reads, writes and profile cycling, and use
> its emptiness to determine aggregate attribute visibility. The class
> devices remain the per-provider userspace interface.
> 
> There can now be an interval between removing the last handler from the
> list and removing the aggregate attributes. Explicitly reject choices
> reads and writes during that interval: the intersection bitmap starts
> with every bit set, so an empty traversal must not advertise all profiles
> or report a successful write without updating a provider.
> 
> This separates aggregate membership from class device teardown while
> preserving the existing class and ACPI sysfs interfaces.
> 
> Fixes: 55b1e68134bf ("ACPI: platform_profile: Use guard(mutex) for register/unregister")
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/acpi/platform_profile.c | 75 ++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 79d2e92e5c28..f98ce4cda02c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -8,6 +8,7 @@
>  #include <linux/bits.h>
>  #include <linux/cleanup.h>
>  #include <linux/init.h>
> +#include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
> @@ -15,8 +16,12 @@
>  #define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, dev))
>  
>  static DEFINE_MUTEX(profile_lock);

Should definitely add comment to this lock as well to explain what it 
protects.

> +/* Serialize registration and sysfs updates without blocking sysfs callbacks. */
> +static DEFINE_MUTEX(profile_registration_lock);
> +static LIST_HEAD(profile_handlers);

-- 
 i.


>  struct platform_profile_handler {
> +	struct list_head node;
>  	const char *name;
>  	struct device dev;
>  	int minor;
> @@ -44,6 +49,22 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>  
>  static DEFINE_IDA(platform_profile_ida);
>  
> +static int profile_walk_handlers(void *data,
> +				 int (*fn)(struct device *dev, void *data))
> +{
> +	struct platform_profile_handler *handler;
> +	int ret;
> +
> +	lockdep_assert_held(&profile_lock);
> +	list_for_each_entry(handler, &profile_handlers, node) {
> +		ret = fn(&handler->dev, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * _commmon_choices_show - Show the available profile choices
>   * @choices: The available profile choices
> @@ -306,20 +327,18 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
>  	int err;
>  
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		err = class_for_each_device(&platform_profile_class, NULL,
> -					    &data, _aggregate_choices);
> +		err = profile_walk_handlers(&data, _aggregate_choices);
>  		if (err)
>  			return err;
>  		if (data.count == 1) {
> -			err = class_for_each_device(&platform_profile_class, NULL,
> -						    &data, _remove_hidden_choices);
> +			err = profile_walk_handlers(&data, _remove_hidden_choices);
>  			if (err)
>  				return err;
>  		}
>  	}
>  
>  	/* no profile handler registered any more */
> -	if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
> +	if (!data.count || bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
>  		return -EINVAL;
>  
>  	return _commmon_choices_show(data.aggregate, buf);
> @@ -384,8 +403,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
>  	int err;
>  
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		err = class_for_each_device(&platform_profile_class, NULL,
> -					    &profile, _aggregate_profiles);
> +		err = profile_walk_handlers(&profile, _aggregate_profiles);
>  		if (err)
>  			return err;
>  	}
> @@ -423,15 +441,13 @@ static ssize_t platform_profile_store(struct kobject *kobj,
>  		return -EINVAL;
>  
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		ret = class_for_each_device(&platform_profile_class, NULL,
> -					    &data, _aggregate_choices);
> +		ret = profile_walk_handlers(&data, _aggregate_choices);
>  		if (ret)
>  			return ret;
> -		if (!test_bit(i, data.aggregate))
> +		if (!data.count || !test_bit(i, data.aggregate))
>  			return -EOPNOTSUPP;
>  
> -		ret = class_for_each_device(&platform_profile_class, NULL, &i,
> -					    _store_and_notify);
> +		ret = profile_walk_handlers(&i, _store_and_notify);
>  		if (ret)
>  			return ret;
>  	}
> @@ -450,22 +466,11 @@ static struct attribute *platform_profile_attrs[] = {
>  	NULL
>  };
>  
> -static int profile_class_registered(struct device *dev, const void *data)
> -{
> -	return 1;
> -}
> -
>  static umode_t profile_class_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
>  {
> -	struct device *dev;
> -
> -	dev = class_find_device(&platform_profile_class, NULL, NULL, profile_class_registered);
> -	if (!dev)
> -		return 0;
> -
> -	put_device(dev);
> +	guard(mutex)(&profile_lock);
>  
> -	return attr->mode;
> +	return list_empty(&profile_handlers) ? 0 : attr->mode;
>  }
>  
>  static const struct attribute_group platform_profile_group = {
> @@ -502,8 +507,7 @@ int platform_profile_cycle(void)
>  	int err;
>  
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		err = class_for_each_device(&platform_profile_class, NULL,
> -					    &profile, _aggregate_profiles);
> +		err = profile_walk_handlers(&profile, _aggregate_profiles);
>  		if (err)
>  			return err;
>  
> @@ -512,8 +516,7 @@ int platform_profile_cycle(void)
>  		    profile == PLATFORM_PROFILE_LAST)
>  			return -EINVAL;
>  
> -		err = class_for_each_device(&platform_profile_class, NULL,
> -					    &data, _aggregate_choices);
> +		err = profile_walk_handlers(&data, _aggregate_choices);
>  		if (err)
>  			return err;
>  
> @@ -525,8 +528,7 @@ int platform_profile_cycle(void)
>  					  PLATFORM_PROFILE_LAST,
>  					  profile + 1);
>  
> -		err = class_for_each_device(&platform_profile_class, NULL, &next,
> -					    _store_and_notify);
> +		err = profile_walk_handlers(&next, _store_and_notify);
>  
>  		if (err)
>  			return err;
> @@ -583,7 +585,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>  		}
>  	}
>  
> -	guard(mutex)(&profile_lock);
> +	guard(mutex)(&profile_registration_lock);
>  
>  	/* create class interface for individual handler */
>  	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> @@ -604,6 +606,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>  		put_device(ppdev);
>  		goto cleanup_ida;
>  	}
> +	scoped_guard(mutex, &profile_lock)
> +		list_add_tail(&to_pprof_handler(ppdev)->node, &profile_handlers);
>  
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>  
> @@ -614,6 +618,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>  	return ppdev;
>  
>  cleanup_cur:
> +	scoped_guard(mutex, &profile_lock)
> +		list_del(&to_pprof_handler(ppdev)->node);
>  	device_unregister(ppdev);
>  
>  cleanup_ida:
> @@ -636,7 +642,10 @@ void platform_profile_remove(struct device *dev)
>  
>  	pprof = to_pprof_handler(dev);
>  
> -	guard(mutex)(&profile_lock);
> +	guard(mutex)(&profile_registration_lock);
> +
> +	scoped_guard(mutex, &profile_lock)
> +		list_del(&pprof->node);
>  
>  	ida_free(&platform_profile_ida, pprof->minor);
>  	device_unregister(&pprof->dev);
> 

Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E3E84039;
	Mon, 30 Mar 2026 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862087; cv=none; b=VcZLOl2RqTpwaxc3LQyb6DO4JWCP1DWQ8QgrKh3w7DAXHIjdPx9coh//uPY2zbP3JbK8YOyIoDaKI7tdOvCFJGli+t+1luQpOYVWRYDcntBjTE3E8kf7PZJZ2ox6q6O/Q70dY1GpYwc0Ubq4VoXDoN1Xanw8Ks9/Fjd5cZh+xRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862087; c=relaxed/simple;
	bh=f8/BwshsYMnwx+EW19kSiHhopy5IVdDUPJgs11/Wxpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQwbrmAoz6MvlvvGX5oM5kyiMWgtrG2V4rzVjb/kXxmbA48oagSevhc4f1xFYBE+9aA+5qmLg3K6pVNJGW3tsKtpfyq8wxLOoxdiMaInxBvvQUexnmBQbEotSEMqvMKac29fCLKiUueL/sskisHmEP5e4X3XLijGLZmPNrCQ+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LIzdztfk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LIzdztfk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37D8C1C01;
	Mon, 30 Mar 2026 02:14:39 -0700 (PDT)
Received: from [10.57.19.7] (unknown [10.57.19.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4421C3F641;
	Mon, 30 Mar 2026 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774862085; bh=f8/BwshsYMnwx+EW19kSiHhopy5IVdDUPJgs11/Wxpw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LIzdztfk8YMcdIT3+wFB4DSOM/hGFMsPLHUTRKhSuw2GfO9qH06Gq86o2oFI7lxb9
	 dz2EZDXG7UN2iSxjZEO8b9frWL1bRgMm/n6H7rk/9Ap2lu9JfQLuxbOTRuA10JVU1D
	 O6lLThDIYOiml7fJWVqUdXsPSOOMmLJkfsuJ/MBk=
Message-ID: <5321acf9-0de4-4b8a-811d-e1d71b152887@arm.com>
Date: Mon, 30 Mar 2026 10:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Address thermal zone removal races with
 resume
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <6267615.lOV4Wx5bFT@rafael.j.wysocki>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <6267615.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/27/26 09:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_zone_pm_complete() and thermal_zone_device_resume()
> re-initialize the poll_queue delayed work for the given thermal zone,
> the cancel_delayed_work_sync() in thermal_zone_device_unregister()
> may miss some already running work items and the thermal zone may
> be freed prematurely [1].
> 
> There are two failing scenarios that both start with
> running thermal_pm_notify_complete() right before invoking
> thermal_zone_device_unregister() for one of the thermal zones.
> 
> In the first scenario, there is a work item already running for
> the given thermal zone when thermal_pm_notify_complete() calls
> thermal_zone_pm_complete() for that thermal zone and it continues to
> run when thermal_zone_device_unregister() starts.  Since the poll_queue
> delayed work has been re-initialized by thermal_pm_notify_complete(), the
> running work item will be missed by the cancel_delayed_work_sync() in
> thermal_zone_device_unregister() and if it continues to run past the
> freeing of the thermal zone object, a use-after-free will occur.
> 
> In the second scenario, thermal_zone_device_resume() queued up by
> thermal_pm_notify_complete() runs right after the thermal_zone_exit()
> called by thermal_zone_device_unregister() has returned.  The poll_queue
> delayed work is re-initialized by it before cancel_delayed_work_sync() is
> called by thermal_zone_device_unregister(), so it may continue to run
> after the freeing of the thermal zone object, which also leads to a
> use-after-free.
> 
> Address the first failing scenario by ensuring that no thermal work
> items will be running when thermal_pm_notify_complete() is called.
> For this purpose, first move the cancel_delayed_work() call from
> thermal_zone_pm_complete() to thermal_zone_pm_prepare() to prevent
> new work from entering the workqueue going forward.  Next, switch
> over to using a dedicated workqueue for thermal events and update
> the code in thermal_pm_notify() to flush that workqueue after
> thermal_pm_notify_prepare() has returned which will take care of
> all leftover thermal work already on the workqueue (that leftover
> work would do nothing useful anyway because all of the thermal zones
> have been flagged as suspended).
> 
> The second failing scenario is addressed by adding a tz->state check
> to thermal_zone_device_resume() to prevent it from re-initializing
> the poll_queue delayed work if the thermal zone is going away.
> 
> Note that the above changes will also facilitate relocating the suspend
> and resume of thermal zones closer to the suspend and resume of devices,
> respectively.
> 
> Fixes: 5a5efdaffda5 ("thermal: core: Resume thermal zones asynchronously")
> Reported-by: Mauricio Faria de Oliveira <mfo@igalia.com>
> Closes: https://lore.kernel.org/linux-pm/20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Return -ENOMEM from thermal_init() when the workqueue allocation
>     fails (Sashiko)
> 
> Lukasz, Daniel, I'm quite confident about this patch, but I would appreciate
> your feedback.

My apologies for delay...

> 
> ---
>   drivers/thermal/thermal_core.c |   31 ++++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)
> 
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -42,6 +42,8 @@ static struct thermal_governor *def_gove
>   
>   static bool thermal_pm_suspended;
>   
> +static struct workqueue_struct *thermal_wq __ro_after_init;
> +
>   /*
>    * Governor section: set of functions to handle thermal governors
>    *
> @@ -314,7 +316,7 @@ static void thermal_zone_device_set_poll
>   	if (delay > HZ)
>   		delay = round_jiffies_relative(delay);
>   
> -	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
> +	mod_delayed_work(thermal_wq, &tz->poll_queue, delay);
>   }
>   
>   static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
> @@ -1795,6 +1797,10 @@ static void thermal_zone_device_resume(s
>   
>   	guard(thermal_zone)(tz);
>   
> +	/* If the thermal zone is going away, there's nothing to do. */
> +	if (tz->state & TZ_STATE_FLAG_EXIT)
> +		return;
> +
>   	tz->state &= ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING);
>   
>   	thermal_debug_tz_resume(tz);
> @@ -1825,6 +1831,9 @@ static void thermal_zone_pm_prepare(stru
>   	}
>   
>   	tz->state |= TZ_STATE_FLAG_SUSPENDED;
> +
> +	/* Prevent new work from getting to the workqueue subsequently. */
> +	cancel_delayed_work(&tz->poll_queue);
>   }
>   
>   static void thermal_pm_notify_prepare(void)
> @@ -1843,8 +1852,6 @@ static void thermal_zone_pm_complete(str
>   {
>   	guard(thermal_zone)(tz);
>   
> -	cancel_delayed_work(&tz->poll_queue);
> -
>   	reinit_completion(&tz->resume);
>   	tz->state |= TZ_STATE_FLAG_RESUMING;
>   
> @@ -1854,7 +1861,7 @@ static void thermal_zone_pm_complete(str
>   	 */
>   	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
>   	/* Queue up the work without a delay. */
> -	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
> +	mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
>   }
>   
>   static void thermal_pm_notify_complete(void)
> @@ -1877,6 +1884,11 @@ static int thermal_pm_notify(struct noti
>   	case PM_RESTORE_PREPARE:
>   	case PM_SUSPEND_PREPARE:
>   		thermal_pm_notify_prepare();
> +		/*
> +		 * Allow any leftover thermal work items already on the
> +		 * worqueue to complete so they don't get in the way later.
> +		 */
> +		flush_workqueue(thermal_wq);
>   		break;
>   	case PM_POST_HIBERNATION:
>   	case PM_POST_RESTORE:
> @@ -1909,9 +1921,16 @@ static int __init thermal_init(void)
>   	if (result)
>   		goto error;
>   
> +	thermal_wq = alloc_workqueue("thermal_events",
> +				      WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);


Why we need those workqueue instances per-cpu?
It isn't a concurrent work, only one CPU can manage the cpufreq domain.

I would drop that flag and allow to have single instance and migrate
between cpus (to not wake up the one which queued the work).


> +	if (!thermal_wq) {
> +		result = -ENOMEM;
> +		goto unregister_netlink;
> +	}
> +
>   	result = thermal_register_governors();
>   	if (result)
> -		goto unregister_netlink;
> +		goto destroy_workqueue;
>   
>   	thermal_class = kzalloc_obj(*thermal_class);
>   	if (!thermal_class) {
> @@ -1938,6 +1957,8 @@ static int __init thermal_init(void)
>   
>   unregister_governors:
>   	thermal_unregister_governors();
> +destroy_workqueue:
> +	destroy_workqueue(thermal_wq);
>   unregister_netlink:
>   	thermal_netlink_exit();
>   error:
> 
> 
> 


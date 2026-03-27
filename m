Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF63F99D2;
	Fri, 27 Mar 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622873; cv=none; b=eV57i9wqoXFQjTWxyjWRJB/it83YKzR1wj3PFJpihRG7zQok3x/AitypnhArEgjrvgKw3f62Ff/N0V0ASYN9nezTqyyl6PEl8ccsPD6zH3K/FAfXJxKMbe62/09F0P4YtIUqNen8S1QvWABSmBnP7GNPjwZ1rwH8FaKgwzfO8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622873; c=relaxed/simple;
	bh=oHyrw4uQS3b40PHGpcB6VbJSMhal/yp99UtU2YfzYSU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=enIUB0+p3MuREbo4pQssitLMAeHCZzh2jVEP4QV9F8Jww/TYxawCMi/z3qwnPVdIos9TEXc5SHTeYdGhok5duyrzf3Ys5hi755zwUTd27CIkEjN/cdKAn7kIrpjjkseruq5IeBa95yJH6JfWFjiMhmyTyWI+zvzcWkxc+oLZhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=diPOXisl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="diPOXisl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mXRw+sYj3KhccQPMNVPhA3xuZKAUfSJWmMqrlVqp1so=; b=diPOXislFLPPFebB2eBeavbnoZ
	TaAczAc885X4a1ss2g4ar2T3MX5RZ1shIYCRcOvk6pssXaTJADE1amztFcuWPMzGy1dSgo8KTb67d
	WgF03VgEZfuwEyXpdtHtfWjRyHZ2PdaS4qS6i+povVd4Cj8z+ns47kBNpbOL4heUnweDuFv1GkraW
	2+9yXv6l/jDcr8dsppXLhAbeqjoFA4y2VNyoA7dtrCDenjnEHzEytcRO8FQAPnnTQxjtK0moRVqid
	jFo/z1DgR4eV1BythOXt+gcICAHC1FgXI8HFW4yeOhMUS1RNgrnk5yUXJ7xDWW1rl2m935pv5NBC+
	rYSiEIWA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w68TN-007FWw-R6; Fri, 27 Mar 2026 15:47:41 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1w68TL-00AcRt-81; Fri, 27 Mar 2026 15:47:41 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1w68TK-00BFUJ-2T;
	Fri, 27 Mar 2026 15:47:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Mar 2026 11:47:39 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, LKML
 <linux-kernel@vger.kernel.org>, Kernel Dev <kernel-dev@igalia.com>
Subject: Re: [PATCH v2] thermal: core: Address thermal zone removal races with
 resume
In-Reply-To: <6267615.lOV4Wx5bFT@rafael.j.wysocki>
References: <6267615.lOV4Wx5bFT@rafael.j.wysocki>
Message-ID: <00a83964cc75f86bed096bac6256b890@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.0, Tests=ALL_TRUSTED=-3,AWL=-1.825,BAYES_50=0.8,URIBL_BLOCKED=0.001,URIBL_ZEN_BLOCKED_OPENDNS=0.001
X-Spam-Score: -39
X-Spam-Bar: ----

On 2026-03-27 06:49, Rafael J. Wysocki wrote:
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

I spent some hours reviewing and thinking of corner cases for this
patch,
and found the code to correctly handle all cases I thought of.

I also tested it with the synthetic reproducers for the 2 cases reported
in [1], and it prevented the errors.

Please feel free to add:

Reviewed-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Tested-by: Mauricio Faria de Oliveira <mfo@igalia.com>

And please carry these from [1], if that's OK with you:

Reported-by: syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=3b3852c6031d0f30dfaf

Thanks,
Mauricio

> 
> v1 -> v2: Return -ENOMEM from thermal_init() when the workqueue allocation
>    fails (Sashiko)
> 
> Lukasz, Daniel, I'm quite confident about this patch, but I would appreciate
> your feedback.
> 
> ---
>  drivers/thermal/thermal_core.c |   31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -42,6 +42,8 @@ static struct thermal_governor *def_gove
>  
>  static bool thermal_pm_suspended;
>  
> +static struct workqueue_struct *thermal_wq __ro_after_init;
> +
>  /*
>   * Governor section: set of functions to handle thermal governors
>   *
> @@ -314,7 +316,7 @@ static void thermal_zone_device_set_poll
>  	if (delay > HZ)
>  		delay = round_jiffies_relative(delay);
>  
> -	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
> +	mod_delayed_work(thermal_wq, &tz->poll_queue, delay);
>  }
>  
>  static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
> @@ -1795,6 +1797,10 @@ static void thermal_zone_device_resume(s
>  
>  	guard(thermal_zone)(tz);
>  
> +	/* If the thermal zone is going away, there's nothing to do. */
> +	if (tz->state & TZ_STATE_FLAG_EXIT)
> +		return;
> +
>  	tz->state &= ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING);
>  
>  	thermal_debug_tz_resume(tz);
> @@ -1825,6 +1831,9 @@ static void thermal_zone_pm_prepare(stru
>  	}
>  
>  	tz->state |= TZ_STATE_FLAG_SUSPENDED;
> +
> +	/* Prevent new work from getting to the workqueue subsequently. */
> +	cancel_delayed_work(&tz->poll_queue);
>  }
>  
>  static void thermal_pm_notify_prepare(void)
> @@ -1843,8 +1852,6 @@ static void thermal_zone_pm_complete(str
>  {
>  	guard(thermal_zone)(tz);
>  
> -	cancel_delayed_work(&tz->poll_queue);
> -
>  	reinit_completion(&tz->resume);
>  	tz->state |= TZ_STATE_FLAG_RESUMING;
>  
> @@ -1854,7 +1861,7 @@ static void thermal_zone_pm_complete(str
>  	 */
>  	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
>  	/* Queue up the work without a delay. */
> -	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
> +	mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
>  }
>  
>  static void thermal_pm_notify_complete(void)
> @@ -1877,6 +1884,11 @@ static int thermal_pm_notify(struct noti
>  	case PM_RESTORE_PREPARE:
>  	case PM_SUSPEND_PREPARE:
>  		thermal_pm_notify_prepare();
> +		/*
> +		 * Allow any leftover thermal work items already on the
> +		 * worqueue to complete so they don't get in the way later.
> +		 */
> +		flush_workqueue(thermal_wq);
>  		break;
>  	case PM_POST_HIBERNATION:
>  	case PM_POST_RESTORE:
> @@ -1909,9 +1921,16 @@ static int __init thermal_init(void)
>  	if (result)
>  		goto error;
>  
> +	thermal_wq = alloc_workqueue("thermal_events",
> +				      WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
> +	if (!thermal_wq) {
> +		result = -ENOMEM;
> +		goto unregister_netlink;
> +	}
> +
>  	result = thermal_register_governors();
>  	if (result)
> -		goto unregister_netlink;
> +		goto destroy_workqueue;
>  
>  	thermal_class = kzalloc_obj(*thermal_class);
>  	if (!thermal_class) {
> @@ -1938,6 +1957,8 @@ static int __init thermal_init(void)
>  
>  unregister_governors:
>  	thermal_unregister_governors();
> +destroy_workqueue:
> +	destroy_workqueue(thermal_wq);
>  unregister_netlink:
>  	thermal_netlink_exit();
>  error:

-- 
Mauricio

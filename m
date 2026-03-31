Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA03ED5DE;
	Tue, 31 Mar 2026 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949294; cv=none; b=L8k7+WPeygKZyXAc+rR2+dTejw5faB5B/LkhsieLfA26+EjAkN9Icjdh1mbEwxjqiFQ0v7JyIF4VE3EQF1+KHJdZFmFT/pUf2nf0O5BuidwHHhrXdP9xe0uaPqXSf1vdBOf/0OwdNM3hBd9ZFCCxwqGdI02JAORdmR+iDPsKH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949294; c=relaxed/simple;
	bh=zN8QNV8pP0y9QlTzvYjQC4x7mBUek3E6/zcKwqVIUYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZ6rFML4Ih+g2NyhpfKRGiA15Es7TQPgF2GGMaLbcah7T+NpPAUHlwricEkyiRxznVPcBI8FCljfxFjgIfgRLnADQNaqMkQT0hjA3LFzTcQgi/FLrtLBH6izMEAIRY9rzuPThlo9XzDSzyFdSQWFEFI1Wvw3DOZwk326b/hwoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gVxBpbb/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gVxBpbb/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 900B5288E;
	Tue, 31 Mar 2026 02:28:03 -0700 (PDT)
Received: from [10.57.17.68] (unknown [10.57.17.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC683F641;
	Tue, 31 Mar 2026 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774949289; bh=zN8QNV8pP0y9QlTzvYjQC4x7mBUek3E6/zcKwqVIUYk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gVxBpbb/207a5HHnn2mbrwa+5HcEeKbQQQXjsVrXClKAOPliPqBh1B0HeYvFPaZMa
	 UspjZZOcfI01BWoD4VljWBmrUmfaajkbn5TAguawtqnE3a6NekDN9+n95R28fP/85P
	 1nuRzdK+LznzbsfUSLLGOCcbXTnbi+Ws23G2IXuk=
Message-ID: <6dc1841b-f944-44d8-9a65-75d8f66b5d2a@arm.com>
Date: Tue, 31 Mar 2026 10:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Address thermal zone removal races with
 resume
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Mauricio Faria de Oliveira <mfo@igalia.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <6267615.lOV4Wx5bFT@rafael.j.wysocki>
 <5321acf9-0de4-4b8a-811d-e1d71b152887@arm.com>
 <CAJZ5v0i82o40kS8=KsWjpB1QaCWLTrk9jmM8ZymW_tdz6b0sRA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0i82o40kS8=KsWjpB1QaCWLTrk9jmM8ZymW_tdz6b0sRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/30/26 12:41, Rafael J. Wysocki wrote:
> On Mon, Mar 30, 2026 at 11:14 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 3/27/26 09:49, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Since thermal_zone_pm_complete() and thermal_zone_device_resume()
>>> re-initialize the poll_queue delayed work for the given thermal zone,
>>> the cancel_delayed_work_sync() in thermal_zone_device_unregister()
>>> may miss some already running work items and the thermal zone may
>>> be freed prematurely [1].
>>>
>>> There are two failing scenarios that both start with
>>> running thermal_pm_notify_complete() right before invoking
>>> thermal_zone_device_unregister() for one of the thermal zones.
>>>
>>> In the first scenario, there is a work item already running for
>>> the given thermal zone when thermal_pm_notify_complete() calls
>>> thermal_zone_pm_complete() for that thermal zone and it continues to
>>> run when thermal_zone_device_unregister() starts.  Since the poll_queue
>>> delayed work has been re-initialized by thermal_pm_notify_complete(), the
>>> running work item will be missed by the cancel_delayed_work_sync() in
>>> thermal_zone_device_unregister() and if it continues to run past the
>>> freeing of the thermal zone object, a use-after-free will occur.
>>>
>>> In the second scenario, thermal_zone_device_resume() queued up by
>>> thermal_pm_notify_complete() runs right after the thermal_zone_exit()
>>> called by thermal_zone_device_unregister() has returned.  The poll_queue
>>> delayed work is re-initialized by it before cancel_delayed_work_sync() is
>>> called by thermal_zone_device_unregister(), so it may continue to run
>>> after the freeing of the thermal zone object, which also leads to a
>>> use-after-free.
>>>
>>> Address the first failing scenario by ensuring that no thermal work
>>> items will be running when thermal_pm_notify_complete() is called.
>>> For this purpose, first move the cancel_delayed_work() call from
>>> thermal_zone_pm_complete() to thermal_zone_pm_prepare() to prevent
>>> new work from entering the workqueue going forward.  Next, switch
>>> over to using a dedicated workqueue for thermal events and update
>>> the code in thermal_pm_notify() to flush that workqueue after
>>> thermal_pm_notify_prepare() has returned which will take care of
>>> all leftover thermal work already on the workqueue (that leftover
>>> work would do nothing useful anyway because all of the thermal zones
>>> have been flagged as suspended).
>>>
>>> The second failing scenario is addressed by adding a tz->state check
>>> to thermal_zone_device_resume() to prevent it from re-initializing
>>> the poll_queue delayed work if the thermal zone is going away.
>>>
>>> Note that the above changes will also facilitate relocating the suspend
>>> and resume of thermal zones closer to the suspend and resume of devices,
>>> respectively.
>>>
>>> Fixes: 5a5efdaffda5 ("thermal: core: Resume thermal zones asynchronously")
>>> Reported-by: Mauricio Faria de Oliveira <mfo@igalia.com>
>>> Closes: https://lore.kernel.org/linux-pm/20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com/ [1]
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v1 -> v2: Return -ENOMEM from thermal_init() when the workqueue allocation
>>>      fails (Sashiko)
>>>
>>> Lukasz, Daniel, I'm quite confident about this patch, but I would appreciate
>>> your feedback.
>>
>> My apologies for delay...
>>
>>>
>>> ---
>>>    drivers/thermal/thermal_core.c |   31 ++++++++++++++++++++++++++-----
>>>    1 file changed, 26 insertions(+), 5 deletions(-)
>>>
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -42,6 +42,8 @@ static struct thermal_governor *def_gove
>>>
>>>    static bool thermal_pm_suspended;
>>>
>>> +static struct workqueue_struct *thermal_wq __ro_after_init;
>>> +
>>>    /*
>>>     * Governor section: set of functions to handle thermal governors
>>>     *
>>> @@ -314,7 +316,7 @@ static void thermal_zone_device_set_poll
>>>        if (delay > HZ)
>>>                delay = round_jiffies_relative(delay);
>>>
>>> -     mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
>>> +     mod_delayed_work(thermal_wq, &tz->poll_queue, delay);
>>>    }
>>>
>>>    static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
>>> @@ -1795,6 +1797,10 @@ static void thermal_zone_device_resume(s
>>>
>>>        guard(thermal_zone)(tz);
>>>
>>> +     /* If the thermal zone is going away, there's nothing to do. */
>>> +     if (tz->state & TZ_STATE_FLAG_EXIT)
>>> +             return;
>>> +
>>>        tz->state &= ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING);
>>>
>>>        thermal_debug_tz_resume(tz);
>>> @@ -1825,6 +1831,9 @@ static void thermal_zone_pm_prepare(stru
>>>        }
>>>
>>>        tz->state |= TZ_STATE_FLAG_SUSPENDED;
>>> +
>>> +     /* Prevent new work from getting to the workqueue subsequently. */
>>> +     cancel_delayed_work(&tz->poll_queue);
>>>    }
>>>
>>>    static void thermal_pm_notify_prepare(void)
>>> @@ -1843,8 +1852,6 @@ static void thermal_zone_pm_complete(str
>>>    {
>>>        guard(thermal_zone)(tz);
>>>
>>> -     cancel_delayed_work(&tz->poll_queue);
>>> -
>>>        reinit_completion(&tz->resume);
>>>        tz->state |= TZ_STATE_FLAG_RESUMING;
>>>
>>> @@ -1854,7 +1861,7 @@ static void thermal_zone_pm_complete(str
>>>         */
>>>        INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
>>>        /* Queue up the work without a delay. */
>>> -     mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
>>> +     mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
>>>    }
>>>
>>>    static void thermal_pm_notify_complete(void)
>>> @@ -1877,6 +1884,11 @@ static int thermal_pm_notify(struct noti
>>>        case PM_RESTORE_PREPARE:
>>>        case PM_SUSPEND_PREPARE:
>>>                thermal_pm_notify_prepare();
>>> +             /*
>>> +              * Allow any leftover thermal work items already on the
>>> +              * worqueue to complete so they don't get in the way later.
>>> +              */
>>> +             flush_workqueue(thermal_wq);
>>>                break;
>>>        case PM_POST_HIBERNATION:
>>>        case PM_POST_RESTORE:
>>> @@ -1909,9 +1921,16 @@ static int __init thermal_init(void)
>>>        if (result)
>>>                goto error;
>>>
>>> +     thermal_wq = alloc_workqueue("thermal_events",
>>> +                                   WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
>>
>>
>> Why we need those workqueue instances per-cpu?
> 
> That's to limit the changes in this fix to what's needed to address
> the problem at hand.
> 
> The previously used workqueue was also per-CPU and freezable.
> 
>> It isn't a concurrent work, only one CPU can manage the cpufreq domain.
>>
>> I would drop that flag and allow to have single instance and migrate
>> between cpus (to not wake up the one which queued the work).
> 
> I have a separate patch for that on top of this one, will post it later.
> 
> Let's avoid mixing fixes with changes that aren't directly related to them.

Thanks Rafael for clarification. With that in mind feel free to
add:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


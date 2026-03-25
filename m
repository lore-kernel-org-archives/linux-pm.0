Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A23A874B;
	Wed, 25 Mar 2026 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448283; cv=none; b=bezfFbLcHE4mn5+PW/f4P2bur2qJuZcjO+JqsnxUV9lMlfwRQMX+ZgpnuGHjyo29Zk2iF1+DAWIayYM4CSW3E0nhBauvKlO/QIeLzRY2e10QvHhB/LmRvP1V5bybX5gPwC6pr7mOHkQb1Vwzav6vaM9Zklqac/52NKdU5Jzyfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448283; c=relaxed/simple;
	bh=6fLvbno2zMp660HjQ2GNpWDPogmQO9L1G8K4jOVuONI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GxYBytZ+NKToPheKdb3BYdwtwPc54HeKQbs+RpZht6vsWmRt2YV/b18H7FCgE7jK33XSNoRLM5UrH0EaUWp3kAo7RagDNdvfSyRbQi9rlPuUrx6/1xZrRYyD5FR5c9Z9ZhMSAPdca0qfwj8uYdwR2eafU0PR2cJPGPmQfmYtgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=i01KFJMP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="i01KFJMP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2kF3M4rKuIujHd8+vAEaZvkIB+re++6Y1UHInRBFRLw=; b=i01KFJMPeo4xFmnDNwOhv1ErMo
	7UJO6oGkEAe54JFRjUtPPxDJEPS4eQ9rw8drhUI+0mMFxLdLYnOP7pBkRIiGqydm6SroS+rsf0HTt
	USIoHoEuBZaVUEcuJTPCTWaT/AA6NYPHUfIfx2U5UsEAV+kw78wGPWpvA31WV9qP7M+Z/wBA6auzn
	KJp+yA0ALZow/whgBJVCCAt2//95fLxS0cyhjTjgecptYGYBjfW4G+jOxrzqv/r9ahsZK4zAWbny3
	VMfPQF4VlpgHH4auLhexr9OMD83iWrvuLP3o3LKu8vE1H9DgjFmyyBa5UR03TV2/e8EwQFraVV+LO
	Gme0D3kQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5P3N-005rut-8i; Wed, 25 Mar 2026 15:17:49 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1w5P3L-007YX0-1d; Wed, 25 Mar 2026 15:17:49 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1w5P3K-00AhX2-1r;
	Wed, 25 Mar 2026 15:17:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Mar 2026 11:17:46 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
In-Reply-To: <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
References: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
 <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
 <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
Message-ID: <772a77c80b6ad216dec4cc10d3fbb133@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-4.1, Tests=ALL_TRUSTED=-3,AWL=-1.854,BAYES_50=0.8
X-Spam-Score: -40
X-Spam-Bar: ----

Thanks for looking into this.

On 2026-03-25 09:47, Rafael J. Wysocki wrote:
> On Wed, Mar 25, 2026 at 1:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, Mar 25, 2026 at 12:51 AM Mauricio Faria de Oliveira
>> <mfo@igalia.com> wrote:
>> >
>> > If INIT_DELAYED_WORK() is called for a currently running work item,
>> > cancel_delayed_work_sync() is unable to cancel/wait for it anymore,
>> > as the work item's data bits required for that are cleared.
>> >
>> > In the resume path, INIT_DELAYED_WORK() is called twice:
>> > 1) to replace the work function: thermal_zone_device_check/resume()
>> > 2) to restore it.
>> >
>> > Both cases might race with the unregister path and bypass the call to
>> > cancel_delayed_work_sync(),
>>
>> So this is the problem, isn't it?
>>
>> > after which struct thermal_zone_device *tz
>> > is freed, and the non-canceled/non-waited for work hits use-after-free.
>>
>> Which basically means that a TZ_STATE_FLAG_EXIT check is missing in
>> both thermal_zone_pm_complete() and thermal_zone_device_resume().
> 
> Actually, thermal_zone_pm_complete() runs under thermal_list_lock and
> thermal_zone_device_unregister() removes the zone from
> thermal_tz_list, also under thermal_list_lock, before calling
> cancel_delayed_work_sync().
> 
> So either thermal_zone_device_unregister() removes the zone from the
> list before thermal_zone_pm_complete() can run, in which case the
> latter won't run for the given zone at all because that zone is not
> there in thermal_tz_list, or the cancel_delayed_work_sync() will see
> the work item queued up by thermal_zone_pm_complete().

(I think this reply clarifies your previous points too; or tell me.)

Regarding the latter: yes, cancel_delayed_work_sync() will see the
work item queued up by thermal_zone_pm_complete(), but the issue is
it will not see the _previously queued up (and running)_ work item,
due to the INIT_DELAYED_WORK() in thermal_zone_pm_complete().

That work item, thermal_zone_device_check() might be past a check
for TZ_STATE_FLAG_EXIT by the time it is set. Please read on.

> So where's the race between thermal_zone_pm_complete() and
> thermal_zone_device_unregister()?

I'll append a more detailed view below, but the summary is:

thermal_pm_notify_complete() can acquire thermal_list_lock before
thermal_zone_device_unregister() -> thermal_zone_exit() does,
thus proceed to thermal_zone_pm_complete() which calls
INIT_DELAYED_WORK().

This makes future calls to cancel_delayed_work_sync() to wait only
for the newly initialized work function, not a previous one, which
might be running -- in this case, thermal_zone_device_check().

Then thermal_zone_pm_complete() and thermal_pm_notify_complete()
return, releasing thermal_list_lock.

Now, thermal_zone_device_unregister() -> thermal_zone_exit()
can set finally set TZ_STATE_FLAG_EXIT, but it might be too late.

The previously queued, currently running, work item might be past
any check for it (say, it acquired the lock to read it earlier,
or before thermal_zone_device_unregister() was even called).

So, thermal_zone_device_unregister() reaches cancel_delayed_work_sync(),
which waits for thermal_zone_device_resume() (new work function),
but _not_ for thermal_zone_device_check() (old work function).

That finishes, tz is freed, and now the old work funtion continues
to run and accesses tz -- hitting a use-after-free.

> I can see the one between thermal_zone_device_unregister() and
> thermal_zone_device_resume(), but that can be addressed by adding a
> TZ_STATE_FLAG_EXIT check to the latter AFAICS.

In the example describe above and detailed below, apparently that
is not sufficient, if I'm not missing anything. See, if _resume()
is reached with thermal_list_lock held, thermal_zone_device_exit()
is waiting for thermal_list_lock before setting TZ_STATE_FLAG_EXIT,
thus a check for it in _resume() would find it clear yet.

Hope this helps. Please let me know your thoughts. Thanks!

Detailed view)

Thread A:
  ...
  WORK: tz->poll_queue
    thermal_zone_device_check() // started running before
TZ_STATE_FLAG_EXIT could be set  
      ... // wait a bit
      
Thread B:

  thermal_pm_notify()
    thermal_pm_notify_complete()
      guard(mutex)(&thermal_list_lock)  // acquires the lock
      ...
      
Thread C:

  thermal_zone_device_unregister()
    thermal_zone_exit()
      guard(mutex)(&thermal_list_lock)  // blocks waiting for the lock
        ...
        tz->state |= TZ_STATE_FLAG_EXIT // not run yet
        list_del_init(&tz->node)        // not run yet

Thread B: // continues with tz in thermal_tz_list and without
TZ_STATE_FLAG_EXIT
      ...
      list_for_each_entry(tz, &thermal_tz_list, node)
        thermal_zone_pm_complete(tz)
          cancel_delayed_work(&tz->poll_queue) // does not wait for
thermal_zone_device_check() to finish
          INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume)
      ...
      returns, releases the thermal_list_lock.
      
From now on, cancel_delayed_work_sync(&tz->poll_queue)
will _not_ wait for thermal_zone_device_check() anymore 
(note it _is_ running in Thread A)
it will only wait for thermal_zone_device_resume().

Thread C:

        tz->state |= TZ_STATE_FLAG_EXIT
        list_del_init(&tz->node)

These are now set, but no longer effective for the already running
thermal_zone_device_check().

      cancel_delayed_work_sync(&tz->poll_queue) // as mentioned, waits
for the other function.
      kfree(tz)
      
Thread A: // not waited for
       ...
       thermal_zone_device_update()
         // access to tz (freed)

-- 
Mauricio

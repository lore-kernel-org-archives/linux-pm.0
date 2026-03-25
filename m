Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96C2FDC2C;
	Wed, 25 Mar 2026 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466546; cv=none; b=DVk6wWJHMw+3usiQrIeaas4zNbKkMJ6g3w0OAjTzb0jL60TbgUUq2vg5BIvIaOuea61G09AAUX+WXsasYnZ9H0re2tMwzyLFHSsieo0z1XR2O/RakQcQ6fIx0U7SjiGsk8KPJbEwoNr6RzzKPB6t++Zwc85dyVS4P+ohOgxnNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466546; c=relaxed/simple;
	bh=j596zTbpwnQ7Vw7nW+HlAiQrHyRXNzagGUHDT3OTubw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ezAtfDiRCbAtvP04PogLFKtN1vzvpiSFia1gPxAI7Px3KxBXZTYV+un1tRSX1bOsj/bvFZGVDDrhZMj2OI+yY+m5Ik/4JCXIh2i+mitIe8+GL2yRwfraKqePvoPEDtfW0Sf6hZM/9VV+BLIP2pIqPFdiyI6+FjYrB1lpMZgEmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=o7keMxGw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="o7keMxGw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gsQQXWHSiIFd+ceU+Wykdl4DSkWsG6MKahEN81bOfzA=; b=o7keMxGw1u5zOljCYvA/oQLAev
	nOEx1QNrYlIpNMjwszQvy5ILDopZkp0yUO/NZP/K/bR99orrswYAxY0puq38tuunxPsePuyElFeX1
	dd8n2oqAvWp+l+qFTUG5xKz/GEDx3qlg/ySaicrEYXpZEJIiL2nASRwe5I77e7/xt3USHXY+OoQ+h
	sv0nWj44qvxhDVZ/Q6/+E53XfvlisA00/hq1Ch+Ts10NMHOF/qozs/AGMxHr0oWL3fyST7C2+iC4Y
	OMdh4zjDaIQnFzj2CpiI5ihKoRzpFv6LlhV1pPLaK4bsBF2HKa6dZ2zlIhn91nA7G/CoLFp20TNAg
	ONqF72xg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5Tnx-005zIZ-9I; Wed, 25 Mar 2026 20:22:13 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1w5Tnv-007vz0-4i; Wed, 25 Mar 2026 20:22:13 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1w5Tnu-00Am7H-28;
	Wed, 25 Mar 2026 20:22:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Mar 2026 16:22:10 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
In-Reply-To: <CAJZ5v0jcK0eg1fjSmMDDhTqNqFxUmhdNs=exs13nduRivCiLQQ@mail.gmail.com>
References: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
 <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
 <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
 <772a77c80b6ad216dec4cc10d3fbb133@igalia.com>
 <52d861b9a215150424ae4d49b4e2c90b@igalia.com>
 <a61c19043dcf579e46f7d4f124013e60@igalia.com>
 <CAJZ5v0jcK0eg1fjSmMDDhTqNqFxUmhdNs=exs13nduRivCiLQQ@mail.gmail.com>
Message-ID: <cce6cb6e12b09bc97cf684e378c874f4@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-2.2, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,URIBL_BLOCKED=0.001
X-Spam-Score: -21
X-Spam-Bar: --

On 2026-03-25 13:24, Rafael J. Wysocki wrote:
> On Wed, Mar 25, 2026 at 4:13 PM Mauricio Faria de Oliveira
> <mfo@igalia.com> wrote:
>>
>> On 2026-03-25 11:28, Mauricio Faria de Oliveira wrote:
>> > On 2026-03-25 11:17, Mauricio Faria de Oliveira wrote:
>> >> Thanks for looking into this.
>> >>
>> >> On 2026-03-25 09:47, Rafael J. Wysocki wrote:
>> >>> I can see the one between thermal_zone_device_unregister() and
>> >>> thermal_zone_device_resume(), but that can be addressed by adding a
>> >>> TZ_STATE_FLAG_EXIT check to the latter AFAICS.
>> >>
>> >
>> > Please disregard this paragraph; I incorrectly read/wrote _resume()
>> > as thermal_zone_pm_complete() discussed above. The rest should be
>> > right. I'll review this and get back shortly.
>> >
>> >> In the example describe above and detailed below, apparently that
>> >> is not sufficient, if I'm not missing anything. See, if _resume()
>> >> is reached with thermal_list_lock held, thermal_zone_device_exit()
>> >> is waiting for thermal_list_lock before setting TZ_STATE_FLAG_EXIT,
>> >> thus a check for it in _resume() would find it clear yet.
>>
>> Ok, similarly:
>>
>> Say, thermal_pm_notify() -> thermal_pm_notify_complete() ->
>> thermal_zone_pm_complete()
>> run before thermal_zone_device_unregister() is called;
>> thermal_zone_device_resume()
>> starts, and by now thermal_zone_device_unregister() is called.
>>
>> If thermal_zone_device_resume() wins the race over thermal_zone_exit()
>> for guard(thermal_zone(tz) (tz->lock), it sees TZ_STATE_FLAG_EXIT clear;
>> note its callees (eg, thermal_zone_device_init()) run with tz->lock
>> held,
>> so they see it clear as well.
>>
>> So, thermal_zone_device_init() calls INIT_DELAYED_WORK(), everything
>> returns, tz->lock is released and the thermal_zone_device_unregister()
>> -> thermal_zone_exit() path can continue to run.
>>
>> Only now thermal_zone_exit() sets TZ_STATE_FLAG_EXIT (too late),
>> returns.
>> cancel_delayed_work_sync() does not wait for
>> thermal_zone_device_resume()
>> due to INIT_DELAYED_WORK() in thermal_zone_device_init(); and kfree(tz).
>>
>> Then, thermal_zone_device_resume() accesses tz and hits use-after-free.
>>
>> Hope this clarifies. Please let me know your thoughts. Thanks!
> 
> Thanks for the analysis, it sounds accurate.
> 
> I'd say that thermal_zone_device_unregister() needs to flush the
> workqueue before calling cancel_delayed_work_sync() to get rid of the
> stuff that may be running out of it that hasn't seen the changes made
> by thermal_zone_exit().

IIUIC, cancel_delayed_work_sync() has that effect: it waits for
(specific)
work that might be running and hasn't seen changes by
thermal_zone_exit()).

> This should take care of all of the existing races because if anything
> is running out of the workqueue when thermal_zone_device_unregister()
> runs, it will be waited for after calling thermal_zone_exit() and any
> leftover stuff will be caught by cancel_delayed_work_sync().

Likewise, the wait-for part is an effect of cancel_delayed_work_sync(),
and AFAIK, there is no leftover after cancel_delayed_work_sync(), as
it waits for the running work function to finish.

And no further work is queued in the 2 code paths that can queue work:

1) thermal_zone_device_check(): even if it misses the tz->state check,
mod_delayed_work() does not requeue the current work item if it is
canceled/waited for by cancel_delayed_work_sync() (tested locally).

2) thermal_zone_pm_complete(): this function will no longer be reached
because tz is no longer in thermal_tz_list.

> Of course, it's better to switch over to using a dedicated workqueue
> in the thermal core for that.

Considering the points above, AFAICT, it should be sufficient to call
cancel_delayed_work_sync() for the 2 code paths in unregister()
(which thus require the distint work items for each code path).

Thanks,

-- 
Mauricio

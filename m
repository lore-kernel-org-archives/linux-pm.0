From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Fri, 18 Sep 2015 02:03:24 +0200
Message-ID: <CAJZ5v0jAvvG2vDEOP=yrp11xzai0tiLUuZJCebHihQ-wbFM3PQ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1509161523230.1993-100000@iolanthe.rowland.org>
	<4548634.pC6GYZYGWm@vostro.rjw.lan>
	<55FAE0CD.2030605@ti.com>
	<CAJZ5v0i6EgDxhziF4jEvsrAnRqaWO83z697VrRFQSEdPoCn4Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34839 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbIRAD0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 20:03:26 -0400
In-Reply-To: <CAJZ5v0i6EgDxhziF4jEvsrAnRqaWO83z697VrRFQSEdPoCn4Qw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Sep 18, 2015 at 1:59 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi,
>
> On Thu, Sep 17, 2015 at 5:48 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:

[cut]

>
> In any case, maybe call that from dpm_suspend_start() after
> dpm_prepare() has run successfully?  This is the point we need to
> start to block probing after all.

Actually, even before dpm_prepare().

>
>> +       }
>> +
>>         if (error)
>>                 thaw_processes();
>>         return error;
>> @@ -190,6 +197,7 @@ void thaw_processes(void)
>>                 atomic_dec(&system_freezing_cnt);
>>         pm_freezing = false;
>>         pm_nosig_freezing = false;
>> +       device_force_probe_deferral(false);
>
> And why don't you call that from dpm_resume_end()?
>
>>
>>         oom_killer_enable();
>>
>> --

Thanks,
Rafael

From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: intel_idle.max_cstate=1 required on baytrail to prevent crashes
Date: Fri, 18 Mar 2016 22:17:21 +0100
Message-ID: <CAJZ5v0hC_Wizp38YnegVKqt47snocUbDTTktacZdZcMqBefJew@mail.gmail.com>
References: <56EA5735.1060109@feix.cz>
	<3870417.33uAD9HvER@vostro.rjw.lan>
	<56EC65DA.2030701@feix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35141 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbcCRVRX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 17:17:23 -0400
Received: by mail-lb0-f170.google.com with SMTP id bc4so96170295lbc.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 14:17:22 -0700 (PDT)
In-Reply-To: <56EC65DA.2030701@feix.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Feix <michal@feix.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>

On Fri, Mar 18, 2016 at 9:32 PM, Michal Feix <michal@feix.cz> wrote:
>>> for the past few months, I'm fighting random hard lock-ups on my
>>> Baytrail machine with different linux kernels. Freezes are quite
>>> frequent, between few minutes to few hours of uptime. According to other
>>> reporters, this was pinpointed as an intel_idle problem on Baytrail. The
>>> bug report originally started as i915 regression at
>>> https://bugs.freedesktop.org/show_bug.cgi?id=88012 and was moved to
>>> kernel Bugzilla few months ago -
>>> https://bugzilla.kernel.org/show_bug.cgi?id=109051
>>>
>>> This bug seems to be a serious showstopper for Baytrail users and was
>>> already confirmed by many, but there is no obvious progress on this bug
>>> report for last few months. Meny reporters have confirmed
>>> intel_idle.max_cstate=1 or intel_idle.max_cstate=2 as a half-working
>>> workaround, which makes the interval between freezes on Baytrail longer.
>> No, it hasn't, but it turns out difficult to root-cause.
>>
>> Tell me one thing: does disabling intel_idle entirely on the affected systems
>> make the problem go away?
>>
>> That is, does intel_idle.max_cstate=0 in the kernel command line help?
>>
>> Or does idle=nomwait in the kernel command line help?
>
> intel_idle.max_cstate=1 - no hard-lockups
> intel_idle.max_cstate=0 - no hard-lockups
> idle=nomwait - with hard-lockups
>
> Someone on Bugzilla suggested to try latest 4.5 kernel, as he believes
> it's fixed already on his BYT laptop. I'm running on the longterm branch
> so I just upgraded to 4.1.19 LTS which is the latest in Arch distro for
> the moment. And yes - my uptime is 4 hours and still counting! :-) I'll
> see during next few days but maybe it's fixed.
>
> intel_idle would then be probably out of suspision, as it haven't been
> touched for last few months..

This is not an intel_idle problem in any case.  If anything, there
might be a way to work around it in that driver.

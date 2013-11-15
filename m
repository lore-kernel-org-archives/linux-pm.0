From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update PATCH 1/1] Cpufreq: Make governor data on nonboot cpus
 across system suspend/resume
Date: Fri, 15 Nov 2013 16:24:42 +0530
Message-ID: <CAKohponu0UFZig3xXTAnn8fKnqc5FnFMpxp2JfYQPQjOjAULTw@mail.gmail.com>
References: <1384495294-10565-1-git-send-email-tianyu.lan@intel.com>
	<1384503334-18809-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:42844 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab3KOKyn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2013 05:54:43 -0500
Received: by mail-ob0-f173.google.com with SMTP id wm4so3611059obc.4
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2013 02:54:43 -0800 (PST)
In-Reply-To: <1384503334-18809-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>, rainer.kaluscha@web.de
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Adding Rainer as well

On 15 November 2013 13:45, Lan Tianyu <tianyu.lan@intel.com> wrote:
> Currently, governor of nonboot cpus will be put to EXIT when system suspend.
> Since all these cpus will be unplugged and the governor usage_count decreases
> to zero. The governor data and its sysfs interfaces will be freed or released.
> This makes user config of these governors loss during suspend and resume.
>
> This doesn't happen on the governor covering boot cpu because it isn't
> unplugged during system suspend.
>
> To fix this issue, skipping governor exit during system suspend and check
> policy governor data to determine whether the governor is really needed
> to be initialized when do init. If not, return EALREADY to indicate the
> governor has been initialized and should do nothing. __cpufreq_governor()
> convert EALREADY to 0 as return value for INIT event since governor is
> still under INIT state and can do START operation.

Though the patch I have sent fixes a problem similar to this but I don't think
patch of any of us will solve the issue Rainer is facing..

I checked his system configuration and its like this:
- Four CPUs, all having separate clock domains (atleast from kernel
perspective) and so separate policy structure.
- All are using ondemand governor
- not using CPUFREQ_HAVE_GOVERNOR_PER_POLICY feature
- So there is a single set of tunables for ondemand governor that is applicable
across all CPUs..

The way INIT/EXIT are designed in cpufreq_governor.c should take care
of this scenario.

memory for tunables must not be freed unless all the CPUs are removed.
Which can't happen, as we only offline non-boot CPUs and so I believe
that memory isn't getting freed and so your solution wouldn't address his
problem..

Sorry if I said something stupid enough :)

--
viresh

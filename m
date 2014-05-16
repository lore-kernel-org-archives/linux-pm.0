From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: send notifications for intermediate (stable) frequencies
Date: Fri, 16 May 2014 11:31:50 +0530
Message-ID: <CAKohpo=6PQHwT9pP+M0khCne3sxtsKsUnijmTCLKOmgzv0wQkw@mail.gmail.com>
References: <25738681139c04272b6d2ebeff244c6d36c893f7.1400133090.git.viresh.kumar@linaro.org>
	<CAD=FV=WktXavbpf0zN4=2KyF1uWXrysaRRQpAtAzqVhfDOJB5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:39592 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbaEPGBv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 May 2014 02:01:51 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy5so2471044obc.29
        for <linux-pm@vger.kernel.org>; Thu, 15 May 2014 23:01:50 -0700 (PDT)
In-Reply-To: <CAD=FV=WktXavbpf0zN4=2KyF1uWXrysaRRQpAtAzqVhfDOJB5A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Russell King <linux@arm.linux.org.uk>, Thomas Abraham <thomas.abraham@linaro.org>

On 15 May 2014 23:43, Doug Anderson <dianders@chromium.org> wrote:
> This will have the side effect of sending twice as many notifications.
>  ...however it does allow for people registering for CPUFREQ
> notifications to be more generic...

That's not a side effect of this approach but the way platforms are
handling it, and there is no way out we can skip that. In case we
do, we will give space for the race to happen and udelay will work
badly..

> Thinking about it, I think you're right that this is the way to go.

Correct :)

> It probably makes sense to wait until Thomas Abraham's patch lands,
> since he's redoing exynos cpufreq to use cpufreq-cpu0.  ...and maybe
> Thomas would be willing to write this patch?

But cpufreq-cpu0 isn't handling this intermediate freq concept, how will
you work around that? Anyway we can get this working for tegra if
stephen agrees.

> What do you think about calling this get_safe_freq().  It took me a
> little while before I realized that this function didn't perform the
> transition to the safe frequency--it just returned it.
>
> ...the comment adds extra confusion since it makes it sound like the
> switch happens right here.

Agree.

>> +                       /* Send POST notification for the target frequency */
>> +                       freqs.new = freq_table[index].frequency;
>
> Don't you need to set freqs.old to the safe_freq?

Agree..

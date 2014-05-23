From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 3/3] cpufreq: Tegra: implement intermediate frequency callbacks
Date: Fri, 23 May 2014 09:35:28 +0530
Message-ID: <CAKohpomdOEspgfxNR5p=PVLCeSUYcUWZ2cWGGQo0b__ptKiYtw@mail.gmail.com>
References: <cover.1400662383.git.viresh.kumar@linaro.org>
	<dc2702973028425e3ded689a6da227658fb914c4.1400662383.git.viresh.kumar@linaro.org>
	<537E285C.6060608@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:57117 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbaEWEF2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 00:05:28 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so4900656obc.27
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2014 21:05:28 -0700 (PDT)
In-Reply-To: <537E285C.6060608@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Doug Anderson <dianders@chromium.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>

On 22 May 2014 22:09, Stephen Warren <swarren@wwwdotorg.org> wrote:
> I think the call to tegra_target_intermediate() is wrong here; shouldn't
> the cpufreq core guarantee that tegra_target_intermediate() has always
> been called before tegra_target(), so there's no need to repeat that
> call here?

That's what Doug requested in the previous version. get_intermediate()
can return zero in case drivers don't want to switch to intermediate
frequency for some target frequency.

Core should rather guarantee that target_index() is always called, if you
want core to guarantee that target_intermediate() is also always called,
then don't ever return zero from get_intermediate.

I did it that way for tegra as both target_intermediate() & target_index()
would have tried to set the same frequency for this particular case,
i.e. when target freq == intermediate frequency.

And both would have sent notification and the last notification wouldn't
have made any sense, both old-freq & new-freq would have been
intermediate freqs.

So, yes I see the feature suggested by Doug quite useful. Like in your
case.

> Also, tegra_target() doesn't seem to follow the rule documented by patch
> 2/3 that states ->target() should restore the orignal frequency on
> error. I'm not even sure if that's possible in general.

I thought I took care of that. Can you please give some example when
we aren't restoring original frequency on failure ?

About the rule, that has to be the expectation from core as there is no
way out that for core to know what happened at end of target_index()..

It can call get_rate() but that would be over engineering it looks ..

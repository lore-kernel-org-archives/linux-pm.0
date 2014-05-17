From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/3] cpufreq: add support for intermediate (stable) frequencies
Date: Sat, 17 May 2014 09:36:33 +0530
Message-ID: <CAKohpo=t=HcOMHfG_wRhaPAucDsOCmW4wW9_UjPmv5uE29v36g@mail.gmail.com>
References: <cover.1400230695.git.viresh.kumar@linaro.org>
	<9e1ed1bf8c3610709436fe5ef8df3a63856f8f5c.1400230695.git.viresh.kumar@linaro.org>
	<53765DD9.6040403@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:47023 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaEQEGe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 May 2014 00:06:34 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so3896454obc.37
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2014 21:06:33 -0700 (PDT)
In-Reply-To: <53765DD9.6040403@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Doug Anderson <dianders@chromium.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>

On 17 May 2014 00:20, Stephen Warren <swarren@wwwdotorg.org> wrote:
> s/Uset/Used.

:(

>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> +     unsigned int (*get_intermediate)(struct cpufreq_policy *policy,
>> +                                      unsigned int index);
>
> Should get_intermediate be passed a struct cpufreq_freqs freqs rather
> than just the target index? That way, if the intermediate frequency
> varies depending on old/new frequencies, then the driver won't have to
> go look up the current frequency in order to implement that logic.

That can be done by simply doing policy->cur and we don't require to
get it from hardware again. So, probably should stay as is.

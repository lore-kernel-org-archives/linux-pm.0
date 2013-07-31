From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 00/15] cpufreq: initialize drivers .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 22:06:08 +0530
Message-ID: <CAK9yfHwZCBk5boyiak1FJ7WVJ+FxLjPk1Wa5eYbuZw8BaOV5jw@mail.gmail.com>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:36367 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab3GaQgI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2013 12:36:08 -0400
Received: by mail-oa0-f45.google.com with SMTP id m1so1959821oag.4
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2013 09:36:08 -0700 (PDT)
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org

Hi Viresh,

On 31 July 2013 19:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> CPUFreq core does following at multiple places:
> module_{get|put}(cpufreq_driver->owner)).
>
> This is done to make sure module doesn't get unloaded if it is currently in use.
> This will work only if the .owner field of cpufreq driver is initialized with a
> valid pointer.
>
> This field wasn't initialized for many cpufreq driver, lets initialize it with
> THIS_MODULE.


Isn't it possible to do this inside cpufreq_register_driver function
in a similar way as done for platform_driver_register [1].

[1] https://lkml.org/lkml/2013/5/25/5

-- 
With warm regards,
Sachin

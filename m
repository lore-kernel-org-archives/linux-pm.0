From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/2] cpuidle: simplify multiple driver support
Date: Wed, 18 Sep 2013 10:51:23 +0530
Message-ID: <CAKohponeFAc3EVEOO_Tpd61eE7UQmEmWfuaYd-VdR=UKnDFUgw@mail.gmail.com>
References: <1370641990-13884-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:64417 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab3IRFVZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2013 01:21:25 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so6587023obc.22
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2013 22:21:24 -0700 (PDT)
In-Reply-To: <1370641990-13884-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Len Brown <lenb@kernel.org>

On 8 June 2013 03:23, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> Commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 brought the multiple driver
> support. The code added a couple of new API to register the driver per cpu.
> That led to some code complexity to handle the kernel config options when
> the multiple driver support is enabled or not, which is not really necessary.
> The code has to be compatible when the multiple driver support is not enabled,
> and the multiple driver support has to be compatible with the old api.
>
> This patch removes this API, which is not yet used by any driver but needed
> for the HMP cpuidle drivers which will come soon, and replaces its usage
> by a cpumask pointer in the cpuidle driver structure telling what cpus are
> handled by the driver. That let the API cpuidle_[un]register_driver to be used
> for the multiple driver support and also the cpuidle_[un]register functions,
> added recently in the cpuidle framework.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Sorry for jumping onto this thread so late :(
The current code in cpuidle/driver.c contains two definitions of these routines:
__cpuidle_get_cpu_driver() and __cpuidle_{set|unset}_driver(), enclosed
withing #if/else..

These duplicate routines exist only to save some space where we don't
have multiple drivers for a platform, right? So, that we don't waste up
space for per-cpu variables for holding cpuidle_driver..

But what about multi platform kernels? This config option would be enabled
then and we would finally run into the same problem again..

The worst side of this is: We will run separate code paths for a platform
which doesn't have support for multiple drivers in the multiplatform kernel..
Even if it works, it looks a bit wrong design wise..

Either we can have a runtime variable in cpuidle_driver or somewhere else
that will let us know if we want multiple drivers for our platform or not

OR

do the per-cpu stuff for everybody..

I was about to rewrite that stuff and send a patch for it, but then thought
probably its better to discuss it first..

--
viresh

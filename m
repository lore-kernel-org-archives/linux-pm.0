From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/4] cpu_cooling: cooling dev registration cleanups
Date: Wed, 15 Nov 2017 19:08:43 +0100
Message-ID: <CAJZ5v0jAWWv4awo7xG2ra5aVTxSn8dvifMJdZ8jmpQSXKpVb3g@mail.gmail.com>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:54409 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdKOSIo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 13:08:44 -0500
In-Reply-To: <cover.1510735482.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, javi.merino@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>

On Wed, Nov 15, 2017 at 10:19 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> This touches cpu_cooling and a bunch of cpufreq drivers and I am not
> sure who should take these patches really.

Well, either me or Rui anyway and it is basically fine by me either way. :-)

> This cleans up the helpers exposed by cpu_cooling driver and its users
> and removes a lot of code (around 280 lines effectively). Lots of unused
> code is removed.
>
> Tested on Hikey6220 and based over linux-next/master.
> Not targeted for 4.15-rc1 :)

Cool.

Rui, any concerns against this going in via linux-pm?

> --
> viresh
>
> Viresh Kumar (4):
>   cpu_cooling: Make of_cpufreq_power_cooling_register() parse DT
>   cpu_cooling: Remove unused cpufreq_power_cooling_register()
>   cpu_cooling: Keep only one of_cpufreq*cooling_register() helper
>   cpu_cooling: Drop static-power related stuff
>
>  Documentation/thermal/cpu-cooling-api.txt |  33 +----
>  drivers/cpufreq/arm_big_little.c          |  23 +---
>  drivers/cpufreq/cpufreq-dt.c              |  27 +---
>  drivers/cpufreq/mediatek-cpufreq.c        |  22 +---
>  drivers/cpufreq/qoriq-cpufreq.c           |  14 +--
>  drivers/thermal/cpu_cooling.c             | 201 ++++++------------------------
>  include/linux/cpu_cooling.h               |  75 +++--------
>  include/trace/events/thermal.h            |  10 +-
>  8 files changed, 64 insertions(+), 341 deletions(-)
>
> --

Thanks,
Rafael

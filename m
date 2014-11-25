From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Tue, 25 Nov 2014 16:27:44 +0530
Message-ID: <CAKohpokF8qFUz-bmKT61L879L60GYzsc3X3BRHofLYWAdHa3rg@mail.gmail.com>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
	<20141124181049.GB1449@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:48482 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbaKYK5p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 05:57:45 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so233456obc.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 02:57:45 -0800 (PST)
In-Reply-To: <20141124181049.GB1449@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>

On 24 November 2014 at 23:40, Eduardo Valentin <edubezval@gmail.com> wrote:
> Is it possible to have this registration only when we have a
> cpufreq driver up and running? The reasoning is that only after we have
> a way to control cpu frequencies, it makes sense to have the cpu_cooling
> device.
>
> I am planing to have the following check in the cpu cooling code:
>         if (!cpufreq_get_current_driver()) {
>                 dev_dbg(bgp->dev, "no cpufreq driver yet\n");
>                 return -EPROBE_DEFER;
>         }
>
> that is the way I think of checking if the cpufreq layer is ready to
> have a cpu cooling on top of it. Currently, thermal drivers check this
> before calling cpu cooling registration. But instead of having this
> check in every driver, I would like to move it to cpu cooling.
>
> However, for cpufreq-dt, the registration currently happens in the
> init phase, not in probe, so cpufreq driver is not registered, and thus
> the check won't work.

This is how the phases are present in cpufreq drivers:
-> platform_init
    -> probe()
        ->cpufreq_driver->init()

And the cooling device is registered in cpufreq_driver->init() and by
the time ->init() is called, cpufreq_driver is valid.

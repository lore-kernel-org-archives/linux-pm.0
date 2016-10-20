From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/5] Switch to the DT cpufreq policy on the Integrator
Date: Thu, 20 Oct 2016 09:50:12 +0530
Message-ID: <20161020042012.GI11766@vireshk-i7>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33518 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbcJTEUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 00:20:17 -0400
Received: by mail-pf0-f178.google.com with SMTP id 128so28161184pfz.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2016 21:20:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>

On 19-10-16, 11:59, Linus Walleij wrote:
> This switches the ARM Integrator/AP and Integrator/CP to use the
> Device Tree cpufreq policy with its definition of operating points
> using the generic OPP library.
> 
> The Integrators does not need to control a regulator to switch
> frequency, only a clock. This clock and its device tree bindings
> have been defined in the device tree and merged upstream for v4.9.
> 
> This approach provides a little better granularity on the
> Integrator/AP where I defined a few operating points: before
> this change the Integrator would just switch between min speed
> (12 MHz) and max speed (71 MHz). Now it can switch between a
> few arbitrarily chosen OPPs as in the examples below:
> 
> The following tests were made on the Integrator/AP:
> 
> /sys/devices/system/cpu/cpufreq/policy0 echo ondemand > scaling_governor
> cpu cpu0: dev_pm_opp_set_rate: switching OPP: 71000000 Hz --> 24000000 Hz
> cpu cpu0: dev_pm_opp_set_rate: switching OPP: 24000000 Hz --> 12000000 Hz
> cpu cpu0: dev_pm_opp_set_rate: switching OPP: 12000000 Hz --> 24000000 Hz
> cpu cpu0: dev_pm_opp_set_rate: switching OPP: 24000000 Hz --> 12000000 Hz
> 
> The switch from 12 to 24 MHz is triggered by as little as using the
> command line with the ondemand governor. If we do this:
> 
> yes > /dev/null &
> cpu cpu0: dev_pm_opp_set_rate: switching OPP: 12000000 Hz --> 36000000 Hz
> cpu cpu0: dev_pm_opp_set_rate: switching OPP: 36000000 Hz --> 71000000 Hz
> pkill yes
> cpu cpu0: dev_pm_opp_set_rate: switching OPP: 71000000 Hz --> 12000000 Hz
> 
> So the algorithm is indeed using all the OPPs.
> 
> Also as a confirmation test to make sure performance is affected by the
> speed changes, we set the performance governor and:
> 
> echo 12000 > scaling_max_freq
> cpu cpu0: dev_pm_opp_set_rate: switching OPP: 71000000 Hz --> 12000000 Hz
> time find /sys|sort|uniq > /dev/null
> real    0m 45.51s
> user    0m 11.15s
> sys     0m 26.74s
> 
> echo 71000 > scaling_max_freq
> cpu cpu0: dev_pm_opp_set_rate: switching OPP: 12000000 Hz --> 71000000 Hz
> time find /sys|sort|uniq
>  > /dev/null
> real    0m 9.13s
> user    0m 2.35s
> sys     0m 5.50s
> 
> So it is working.
> 
> If people are happy with this approach and approve of the patches
> I'd like an ACK from the cpufreq people and then merge the whole set
> through ARM SoC.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

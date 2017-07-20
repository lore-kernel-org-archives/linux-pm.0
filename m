From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpuidle and cpufreq coupling?
Date: Thu, 20 Jul 2017 12:48:46 +0530
Message-ID: <20170720071846.GK352@vireshk-i7>
References: <d56144f8-cb62-a458-d69d-8e2a65cbe434@gmail.com>
 <CAJZ5v0i2B0=cPB5VxXJUb36LW9hp_L7k-moj+Eg+vPvfPHFcSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34871 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbdGTHSu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 03:18:50 -0400
Received: by mail-pg0-f45.google.com with SMTP id v190so10946493pgv.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2017 00:18:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i2B0=cPB5VxXJUb36LW9hp_L7k-moj+Eg+vPvfPHFcSA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Markus Mayer <code@mmayer.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 20-07-17, 01:17, Rafael J. Wysocki wrote:
> On Thu, Jul 20, 2017 at 12:54 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > Hi,
> >
> > We have a particular ARM CPU design that is drawing quite a lot of
> > current upon exit from WFI, and it does so in a way even before the
> > first instruction out of WFI is executed. That means we cannot influence
> > directly the exit from WFI other than by changing the state in which it
> > would be previously entered because of this "dead" time during which the
> > internal logic needs to ramp up back where it left.
> >
> > A naive approach to solving this problem because we have CPU frequency
> > scaling available would be to do the following:
> >
> > - just before entering WFI, switch to a low frequency OPP
> > - enter WFI
> > - upon exit from WFI, ramp up the frequency back to e.g: highest OPP
> >
> > Some of the parts that I am not exactly clear on would be:
> >
> > - would that qualify as a cpuidle governor of some kind that ties in
> > which cpufreq?
> > - would using cpufreq_driver_fast_switch() be an appropriate API to use
> > from outside
> 
> Generally, the idle driver is expected to manipulate OPPs as suitable
> for it at the low level.

Does any idle driver do it today ?

I am not sure, but I haven't heard anyone from ARM doing it. Though I
may have completely missed it :)

So, that must call into cpufreq (somehow) and look for a low power
OPP?

@Florian: It would be more tricky then we anticipate. We don't always
want to go to low OPP on idle, as we may get out of it very quickly
and changing OPP twice (before and after idle) in that scenario would
be a complete waste of time. And then I hope your ARM CPUs must be
sharing clock/voltage lines with each other as well ? And in that case
we shouldn't touch the OPP unless the whole cluster is going down, as
some CPUs might be running code then.

-- 
viresh

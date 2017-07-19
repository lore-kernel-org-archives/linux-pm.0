From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: cpuidle and cpufreq coupling?
Date: Thu, 20 Jul 2017 01:17:28 +0200
Message-ID: <CAJZ5v0i2B0=cPB5VxXJUb36LW9hp_L7k-moj+Eg+vPvfPHFcSA@mail.gmail.com>
References: <d56144f8-cb62-a458-d69d-8e2a65cbe434@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d56144f8-cb62-a458-d69d-8e2a65cbe434@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Markus Mayer <code@mmayer.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 20, 2017 at 12:54 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Hi,
>
> We have a particular ARM CPU design that is drawing quite a lot of
> current upon exit from WFI, and it does so in a way even before the
> first instruction out of WFI is executed. That means we cannot influence
> directly the exit from WFI other than by changing the state in which it
> would be previously entered because of this "dead" time during which the
> internal logic needs to ramp up back where it left.
>
> A naive approach to solving this problem because we have CPU frequency
> scaling available would be to do the following:
>
> - just before entering WFI, switch to a low frequency OPP
> - enter WFI
> - upon exit from WFI, ramp up the frequency back to e.g: highest OPP
>
> Some of the parts that I am not exactly clear on would be:
>
> - would that qualify as a cpuidle governor of some kind that ties in
> which cpufreq?
> - would using cpufreq_driver_fast_switch() be an appropriate API to use
> from outside

Generally, the idle driver is expected to manipulate OPPs as suitable
for it at the low level.

Thanks,
Rafael

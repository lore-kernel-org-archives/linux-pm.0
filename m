From: Sameer Nanda <snanda@chromium.org>
Subject: Re: [PATCH] intel_pstate: track and export frequency residency stats
 via sysfs.
Date: Wed, 10 Sep 2014 18:04:41 -0700
Message-ID: <CANMivWa_kowDefkvLHpY=JoB9JejiJWBZL7fNqeuwQfcMu+hhQ@mail.gmail.com>
References: <1410221424-20590-1-git-send-email-anupc@chromium.org>
 <1610826.tK4V65ABJD@vostro.rjw.lan> <20140910233905.GA2439@google.com> <7546673.Ir6ttItgPU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7546673.Ir6ttItgPU@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Anup Chenthamarakshan <anupc@chromium.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 10, 2014 at 5:04 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, September 10, 2014 04:39:05 PM Anup Chenthamarakshan wrote:
>> On Thu, Sep 11, 2014 at 12:49:48AM +0200, Rafael J. Wysocki wrote:
>> > On Wednesday, September 10, 2014 03:15:08 PM Anup Chenthamarakshan wrote:
>> > >
>> > > Tools like powertop and turbostat are not present by default on all systems,
>> > > so it is not always possible to use them :(
>> >
>> > Which systems are you referring to in particular?
>>
>> We're testing on Chrome OS devices (Chromebooks).
>
> How big of a deal is it to install the tools mentioned above on such a system?
>
> At least turbostat is shipped with the kernel source.

Given the web browser based front end of Chrome OS, installing these
tools will only get us so far -- if the system is in developer mode,
the tools are accessible but when the system is in normal (verified
boot mode) these tools cannot be launched directly.

We are in the process of switching Chrome OS x86 kernels from ondemand
governor to intel_pstate.  When debugging power consumption issues,
losing the ability to easily get CPU frequency related information as
a side-effect of this switch is less than ideal.

We are happy to spin this patch to expose aperf/mperf based CPU
frequency information if you think that is the better route to take
longer term.

>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.



-- 
Sameer

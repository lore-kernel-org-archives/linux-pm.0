From: Andres Oportus <andresoportus@android.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: schedutil: Reduce frequencies slower
Date: Sat, 1 Apr 2017 16:29:42 -0700
Message-ID: <CAFEhuFnf=N3z2fvajqGT4mN7NtU3fAeGq1CUa_WRQj-PBonwUQ@mail.gmail.com>
References: <1514608.eWxQqcMBcc@aspire.rjw.lan> <20170331102223.GS19929@e106622-lin>
 <6978951.cfP8K2rCI0@aspire.rjw.lan> <CAFEhuF=sWvuC3Q1NsqdRuiGzK4uD8ie5zbEnVsuGMdJK3y9e3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35646 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdDAX3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 19:29:44 -0400
Received: by mail-qk0-f181.google.com with SMTP id g195so19373002qke.2
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2017 16:29:43 -0700 (PDT)
In-Reply-To: <CAFEhuF=sWvuC3Q1NsqdRuiGzK4uD8ie5zbEnVsuGMdJK3y9e3Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, Apr 1, 2017 at 1:39 PM, Andres Oportus
<andresoportus@android.com> wrote:
> Hi Rafael, Juri,
>
> On Fri, Mar 31, 2017 at 2:51 PM, Rafael J. Wysocki <rjw@rjwysocki.net>
> wrote:
>>
>> On Friday, March 31, 2017 11:22:23 AM Juri Lelli wrote:
>> > Hi Rafael,
>>
>> Hi Juri,
>>
>> > On 30/03/17 23:36, Rafael J. Wysocki wrote:
>> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > >
>> > > The schedutil governor reduces frequencies too fast in some
>> > > situations which cases undesirable performance drops to
>> > > appear.
>> > >
>> > > To address that issue, make schedutil reduce the frequency slower by
>> > > setting it to the average of the value chosen during the previous
>> > > iteration of governor computations and the new one coming from its
>> > > frequency selection formula.
>> > >
>> >
>> > I'm curious to test this out on Pixel phones once back in office, but
>> > I've already got some considerations about this patch. Please find them
>> > inline below.
>> >
>> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=194963
>> > > Reported-by: John <john.ettedgui@gmail.com>
>> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > > ---
>> > >
>> > > This addresses a practical issue, but one in the "responsiveness" or
>> > > "interactivity" category which is quite hard to represent
>> > > quantitatively.
>> > >
>> > > As reported by John in BZ194963, schedutil does not ramp up P-states
>> > > quickly
>> > > enough which causes audio issues to appear in his gaming setup.  At
>> > > least it
>> > > evidently is worse than ondemand in this respect and the patch below
>> > > helps.
>> > >
>> >
>> > Might also be a PELT problem?
>>
>> I don't think so.
>>
>> As mentioned below, intel_pstate had it too and it doesn't use PELT. :-)
>>
>> This appears to be a general issue with load-based (or utilization-based)
>> frequency selection algorithms using periodic sampling.  Roughly, if
>> something
>> unanticipated is going to happen shortly (such as a burst in audio
>> activity in
>> a game), it may take a whole period to notice what's going on and the
>> frequency
>> set for that period can make a difference between sufficient and
>> insufficient
>> provisioning.
>>
>>
>> What the patch does is to increase the likelihood that the frequency in
>> question will be sufficient to avoid noticeable effects (such as audio
>> cracks)
>> and it tends to do the trick most of the time.
>>
>> [Of course, you may argue that this is related to the rate limitting in
>>  schedutil and intel_pstate, but then PELT itself is sampled periodically
>>  AFAICS.]
>>
>> > > The patch essentially repeats the trick added some time ago to the
>> > > load-based
>> > > P-state selection algorithm in intel_pstate, which allowed us to make
>> > > it viable
>> > > for performance-oriented users, and which is to reduce frequencies at
>> > > a slower
>> > > pace.
>> > >
>> > > The reason why I chose the average is because it is computationally
>> > > cheap
>> > > and pretty much the max reasonable slowdown and the idea is that in
>> > > case
>> > > there's something about to run that we don't know about yet, it is
>> > > better to
>> > > stay at a higher level for a while more to avoid having to get up from
>> > > the floor
>> > > every time.
>> > >
>> >
>> > Another approach we have been playing with on Android (to solve what
>> > seem to me similar issues) is to have decoupled up and down frequency
>> > changes thresholds. With this you can decide how much quick to react to
>> > a sudden increase in utilization and how much "hysteresis" you want to
>> > have before slowing down. Every platfrom can also be easily tuned as
>> > needed (instead of having the same filter applied for every platform).
>>
>> >
>> > We seemed to actually recently come to the consideration that the up
>> > threshold is probably not much needed (and it is in fact set to very
>> > small values in practice). Once one is confident that the utilization
>> > signal is not too jumpy, responding to a request for additional capacity
>> > quickly seems the right thing to do (especially for RT/DL policies).
>> >
>> > What's your opinion?
>>
>> As I said, responding to increased load may take a whole period to notice
>> and it looks like what happens during that period may be quite important.
>>
>> To me, thresholds have a problem that from the algorithm perspective they
>> are constant values set externally.  This means they likely need to be
>> tuned
>> once in a while by whatever entity that had set them (it is difficult to
>> imagine that the same values will always be suitable for every workload)
>> and
>> that means an additional layer of (dynamic) control on top of the
>> governor.
>>
>> > > But technically speaking it is a filter. :-)
>> > >
>> > > So among other things I'm wondering if that leads to substantial
>> > > increases in
>> > > energy consumption anywhere.
>> > >
>> >
>> > Having a tunable might help getting the tradeoff right for different
>> > platforms, maybe?
>>
>> It might, but it would mean additional computational cost (at least one
>> more
>> integer multiplication AFAICS).
>>
>> > As we discussed at the last LPC, having an energy model handy and use
>> > that to decide how quickly to ramp up or slow down seems the desirable
>> > long term solution, but we probably need something (as you are
>> > proposing) until we get there.
>>
>> Well, we definitely need something to address real use cases, like the one
>> that
>> I responded to with this patch. :-)
>
> I don't know the history/intent behind schedutil rate limiting, but if we
> make it to be only "down" as Juri mentioned we would not be adding a new
> tunable but rather changing the current one to be more restricted (maybe
> some renaming would be in order if this is done), this would provide
> hysteresis to reduce this problem without locking the amount of the
> hysteresis which may not work for all platforms.  I also agree that "it is
> difficult to imagine that the same values will always be suitable for every
> workload", but without any value to control the whole system, we get nothing
> in between.  Ultimately I also think we should solve the hysteresis problem
> at the root, i.e. the input to the governor in the form of util/load that
> has not only hysteresis and energy model, but also any other behavioral
> inputs built-in.
>
> Thanks,
> Andres
>>
>>
>> Thanks,
>> Rafael
>>
>

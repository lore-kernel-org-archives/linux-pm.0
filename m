From: Stratos Karafotis <skarafotis@gmail.com>
Subject: Re: [PATCH 1/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect to
 reduce number of frequency changes
Date: Mon, 19 Sep 2016 22:39:18 +0300
Message-ID: <CADmjqpOuXnri2MdJyvGVgkJ0tsbDMb7Q1O=x65-7OHGWwViOJA@mail.gmail.com>
References: <20160819121814.GA17296@suselix.suse.de> <20160819122101.GB17296@suselix.suse.de>
 <20160829060153.GA5094@vireshk-i7> <20160901132140.GA10183@suselix.suse.de>
 <20160907050201.GK27345@vireshk-i7> <20160916094727.GA4026@suselix>
 <fecb55b0-63ed-1d11-d85b-16cc73f2010b@semaphore.gr> <CADmjqpNE9f7fzQjWsHKB4wEjLq-4ZvQpaC314OcLdQ-i_TAABg@mail.gmail.com>
 <20160919161611.GB17693@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34322 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbcISTjV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 15:39:21 -0400
In-Reply-To: <20160919161611.GB17693@suselix.suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>

On Mon, Sep 19, 2016 at 7:16 PM, Andreas Herrmann <aherrmann@suse.com> wrot=
e:
> On Fri, Sep 16, 2016 at 09:58:42PM +0300, Stratos Karafotis wrote:
>> Hi,
>>
>> [ I 'm resending this message, because I think some recipients didn't re=
ceive
>> it. ]
>>
>> On 16/09/2016 12:47 =CE=BC=CE=BC, Andreas Herrmann wrote:
>> > On Wed, Sep 07, 2016 at 10:32:01AM +0530, Viresh Kumar wrote:
>> >> On 01-09-16, 15:21, Andreas Herrmann wrote:
>> >>> On Mon, Aug 29, 2016 at 11:31:53AM +0530, Viresh Kumar wrote:
>> >
>> >>>> I am _really_ worried about such hacks in drivers to negate the eff=
ect of
>> a
>> >>>> patch, that was actually good.
>> >>>
>> >>>> Did you try to increase the sampling period of ondemand governor to=
 see if
>> that
>> >>>> helps without this patch.
>> >>>
>> >>> With an older kernel I've modified transition_latency of the driver
>> >>> which in turn is used to calculate the sampling rate.
>> >
>> >> Naah, that isn't what I was looking for, sorry
>> >
>> >> To explain it a bit more, this is what the patch did.
>> >
>> >> Suppose, your platform supports frequencies: F1 (lowest), F2, F3, F4,
>> >> F5, F6 and F7 (highest). The cpufreq governor (ondemand) based on a
>> >> sampling rate and system load tries to change the frequency of the
>> >> underlying hardware and select one of those.
>> >
>> >> Before the original patch came in, F2 and F3 were never getting
>> >> selected and the system was stuck in F1 for a long time.
>> >
>> > I think this is not a general statement. Such a behaviour is not
>> > common to all systems. Before commit 6393d6a target frequency was
>> > based on
>> >
>> >    freq_next =3D load * policy->cpuinfo.max_freq / 100;
>> >
>> > F2 would have been selected if
>> >
>> >   load =3D F2 * 100 / F7
>> >
>> > If F2 was not seen it can mean
>> >
>> > (1) either the load value was not hit in practice during monitoring of
>> >     a certain workload
>> >
>> > (2) or the calculated load value (in integer representation) would
>> >     select F1 or F3 (there is no corresponding integer value that
>> >     would select F2)
>> >
>> > E.g. for the Intel i7-3770 system mentioned in commit message for
>> > 6393d6a I think a load value of 49 should have selected 1700000 which
>> > is not shown in the provided frequency table.
>>
>> I think this is not true, because before the specific patch the relation
>> of frequency selection was CPUFREQ_RELATION_L. This is the reason
>> that a load value of 49 with a freq_next 1666490 would have a
>> target frequency 1600000.
>
> Hmm...
> CPUFREQ_RELATION_L should select "lowest frequency at or above target"
> being 1700000 in this case. Otherwise (if it would select "highest
> frequency at or below target") this would imply that load values of
> 50, 51, 52 should select 1700000 which would contradict what was
> written in commit message of 6393d6a1.

Yes, you are right. I'm sorry for the noise.

> In any case probability of seeing such load values and thus selecting
> a frequency of 1700000 is quite low. So I fully understand why the
> patch was introduced.

>> > What essentially changed was how load values are mapped to target
>> > frequencies. For the HP system (min_freq=3D1200000, max_freq=3D2800000=
)
>> > that I used in my tests, the old code would create following mapping:
>> >
>> > load | freq_next | used target frequency
>> > ________________________________________
>> > 0      0            1200000
>> > 10     280000       1200000
>> > 20     560000       1200000
>> > 30     840000       1200000
>> > 40     1120000      1200000
>> > 42     1176000      1200000
>> > 43     1204000      1204000
>> > 50     1400000      1400000
>> > 60     1680000      1680000
>> > 70     1960000      1960000
>> > 80     2240000      2240000
>> > 90     2520000      2520000
>> > 100    2800000      2800000
>> >
>> > The new code (introduced with commit 6393d6a) changed the mapping as
>> > follows:
>> >
>> > load | freq_next | used target frequency
>> > ________________________________________
>> > 0      1200000      1200000
>> > 10     1360000    1360000
>> > 20     1520000    1520000
>> > 30     1680000    1680000
>> > 40     1840000    1840000
>> > 42     1872000    1872000
>> > 43     1888000    1888000
>> > 50     2000000    2000000
>> > 60     2160000    2160000
>> > 70     2320000    2320000
>> > 80     2480000    2480000
>> > 90     2640000    2640000
>> > 100    2800000    2800000
>> >
>> > My patch creates a third mapping. It basically ensures that up to a
>> > load value of 42 the minimum frequency is used.
>> >
>> >> Which will decrease the performance for that period of time as we
>> >> should have switched to a higher frequency really.
>> >
>> > I am not sure whether it's really useful for all systems using
>> > ondemand governor to increase frequency above min_freq even if load is
>> > just above 0. Of course expectation is that performance will be equal
>> > or better than before. But how overall power consumption changes
>> > depends on the hardware and its power saving capabilites.
>> >
>> >   ---8<---
>> >
>> >>> My understanding is that the original commit was tested with certain
>> >>> combinations of hardware and cpufreq-drivers and the claim was that
>> >>> for those (two?) tested combinations performance increased and power
>> >>> consumption was lower. So I am not so sure what to expect from all
>> >>> other cpufreq-driver/hardware combinations.
>> >
>> >> It was principally the right thing to do IMO. And I don't think any
>> >> other hardware should get affected badly. At the max, the tuning need=
s
>> >> to be made a bit better.
>> >
>> >   ---8<---
>> >
>> > It seems that the decision how to best map load values to target
>> > frequencies is kind of hardware specific.
>> >
>> > Maybe a solution to this is that the cpufreq driver should be able to
>> > provide a mapping function to overwrite the current default
>> > calculation.
>> >
>>
>> I'm not familiar with ppc-cpufreq drive but maybe patch 6393d6 just
>> uncovered an "issue" that was already existed but only on higher loads.
>>
>> Because, with or without patch 6393d6, if the specific CPU doesn't
>> use a frequency table, there will many frequency transitions in
>> higher loads too. I believe, though, that the side effect it's smaller
>> in higher frequencies because CPUs tend to work on lowest and highest
>> frequencies.
>
> Might be. I didn't test this specifically.
>
>> What about a patch in ppc-cpufreq driver that permits frequency
>> changes only in specific steps and not in arbitrary values?
>
> Which steps would you use? What scheme would be universal usable for
> all affected system using this driver?

Just an idea. I would split the frequency range (max_freq - min_freq)
into ~10 steps. But I'm not familiar with the affected systems and
of course I can't prove this is an ideal approach.

> I had played with an approach to only make use of min_freq and
> max_freq which eventually didn't result in better performance
> in comparison to code before commit 6393d6.
>


Regards,
Stratos

From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: Re: Question about "Make sched entity usage tracking
 scale-invariant"
Date: Wed, 27 May 2015 14:30:33 +0100
Message-ID: <20150527133033.GI26396@e105550-lin.cambridge.arm.com>
References: <2a0eaec4.2cae.14d88a76c40.Coremail.xiechao_mail@163.com>
 <20150526110535.GG26396@e105550-lin.cambridge.arm.com>
 <180595a8.3e55.14d930f9028.Coremail.xiechao_mail@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52333 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbbE0N2q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 May 2015 09:28:46 -0400
Content-Disposition: inline
In-Reply-To: <180595a8.3e55.14d930f9028.Coremail.xiechao_mail@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chao Xie <xiechao_mail@163.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, =?ISO-8859-1?Q?=20=22mturquet=1Bte@lin?==?ISO-8859-1?Q?aro.org=22?=, mturquette@linaro.org, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, May 27, 2015 at 02:49:40AM +0100, Chao Xie wrote:
>=20
> At 2015-05-26 19:05:36, "Morten Rasmussen" <morten.rasmussen@arm.com>=
 wrote:
> >Hi,
> >
> >[Adding maintainers and others to cc]
> >
> >On Mon, May 25, 2015 at 02:19:43AM +0100, Chao Xie wrote:
> >> hi
> >> I saw the patch =E2=80=9Csched: Make sched entity usage tracking
> >> scale-invariant=E2=80=9D that will make the usage to be freq scale=
d.
> >> So if delta period that the calculation of usage based on cross a
> >> frequency change, so how can you make sure the usage calculation i=
s
> >> correct?
> >> The delta period may last hundreds of microseconds, and frequency
> >> change window may be 10-20 microseconds, so many frequency change =
can
> >> happen during the delta period.
> >> It seems the patch does not consider about it, and it just pick up=
 the
> >> current one.
> >> So how can you resolve this issue?
> >
> >Right. We don't know how many times the frequency may have changed s=
ince
> >last time we updated the entity usage tracking for the particular
> >entity. All we do is to call arch_scale_freq_capacity() and use that
> >scaling factor to compensate for whatever changes might have taken
> >place.
> >
> >The easiest implementation of arch_scale_freq_capacity() for most
> >architectures is to just return a scaling factor computed based on t=
he
> >current frequency and ignoring when exactly the change happened and
> >ignoring if multiple changes happened. Depending on how often the
> >frequency might change this might be an acceptable approximation. Wh=
ile
> >the task is running the sched tick will update the entity usage trac=
king
> >(every 10ms by default on most ARM systems), hence we shouldn't be m=
ore
> >than a tick off in term of when the frequency change is accounted fo=
r.
> >Under normal circumstances the delta period should therefore be <10m=
s
> >and generally shorter than that if you have more than one task runna=
ble
> >on the cpu or the task(s) are not always-running. It is not perfect =
but
> >it is a lot better than the utilization tracking currently used by
> >cpufreq governors and better than the scheduler being completely una=
ware
> >of frequency scaling.
> >
> >For systems with very frequent frequency changes, i.e. fast hardware=
 and
> >an aggressive governor leading to multiple changes in less than 10ms=
,
> >the solution above might not be sufficient. In that case, I think a
> >better solution might be to track the average frequency using hardwa=
re
> >counters or whatever tracking metrics the system might have to let
> >arch_scale_freq_capacity() return the average performance delivered =
over
> >the most recent period of time. AFAIK, x86 already has performance
> >counters (APERF/MPERF) that could be used for this purpose. The delt=
a
> >period for each entity tracking update isn't fixed, but it might
> >sufficient to just average over some fixed period of time. Accurate
> >tracking would require some time-stamp information to be stored in e=
ach
> >sched_entity for the true average to be computed for the delta perio=
d.
> >That quickly becomes rather messy but not impossible. I did look at =
it
> >briefly a while back, but decided not to go down that route until we
> >know that using current frequency or some fixed period average isn't
> >going to be sufficient. Usage or utilization is and average of somet=
hing
> >that might be constantly changing anyways, so it never going to be v=
ery
> >accurate anyway. If it does turn out that we can't get the overall
> >picture right, we will need to improve it.
> >
> >Updating the entity tracking for each frequency change adds to much
> >overhead I think and seems unnecessary if we do with an average scal=
ing
> >factor.
> >
> >I hope that answers your question. Have you observed any problems wi=
th
> >the usage tracking?
> >
>=20
> Thanks for the explanation.
>
> I agree that the "delta" is less than 10ms at most situation, but i
> think at least one period need to be considered.  If the frequency
> change happens just a little, for example, 10us before the task start
> to calculate its utilization which may have a delta of 10ms. The
> almost whole delta will be calculated based on new frequency, not the
> old one. The frequency change can be from the lowest to highest, so
> for this time the delta calculation has big deviation, and this
> situation is not rare.

Letting arch_scale_freq_capacity() return some average frequency over
the last tick period should at least smooth things out a bit.

Also worth noting is that this problem of frequency changes being out o=
f
phase relative to the scheduler ticks might be significantly reduced
(maybe go away entirely?) if we make frequency changes event-driven fro=
m
the scheduler. Since frequency changes would only be initiated from the
scheduler the load-tracking should be up to date whenever a frequency
change is requested and hence the scenario above shouldn't be possible.
Scheduler/dvfs integration is still being discussed though. You may wan=
t
to have a look in discussion of Mike Turquette's patches if you are
interested.

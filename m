From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: Question about "Make sched entity usage tracking scale-invariant"
Date: Tue, 26 May 2015 12:05:36 +0100
Message-ID: <20150526110535.GG26396@e105550-lin.cambridge.arm.com>
References: <2a0eaec4.2cae.14d88a76c40.Coremail.xiechao_mail@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2a0eaec4.2cae.14d88a76c40.Coremail.xiechao_mail@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Xie <xiechao_mail@163.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, Dietmar.Eggemann@arm.com, yuyang.du@intel.com, mturquette@linaro.org, preeti@linux.vnet.ibm.com, rjw@rjwysocki.net, Juri.Lelli@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

[Adding maintainers and others to cc]

On Mon, May 25, 2015 at 02:19:43AM +0100, Chao Xie wrote:
> hi
> I saw the patch =E2=80=9Csched: Make sched entity usage tracking
> scale-invariant=E2=80=9D that will make the usage to be freq scaled.
> So if delta period that the calculation of usage based on cross a
> frequency change, so how can you make sure the usage calculation is
> correct?
> The delta period may last hundreds of microseconds, and frequency
> change window may be 10-20 microseconds, so many frequency change can
> happen during the delta period.
> It seems the patch does not consider about it, and it just pick up th=
e
> current one.
> So how can you resolve this issue?

Right. We don't know how many times the frequency may have changed sinc=
e
last time we updated the entity usage tracking for the particular
entity. All we do is to call arch_scale_freq_capacity() and use that
scaling factor to compensate for whatever changes might have taken
place.

The easiest implementation of arch_scale_freq_capacity() for most
architectures is to just return a scaling factor computed based on the
current frequency and ignoring when exactly the change happened and
ignoring if multiple changes happened. Depending on how often the
frequency might change this might be an acceptable approximation. While
the task is running the sched tick will update the entity usage trackin=
g
(every 10ms by default on most ARM systems), hence we shouldn't be more
than a tick off in term of when the frequency change is accounted for.
Under normal circumstances the delta period should therefore be <10ms
and generally shorter than that if you have more than one task runnable
on the cpu or the task(s) are not always-running. It is not perfect but
it is a lot better than the utilization tracking currently used by
cpufreq governors and better than the scheduler being completely unawar=
e
of frequency scaling.

=46or systems with very frequent frequency changes, i.e. fast hardware =
and
an aggressive governor leading to multiple changes in less than 10ms,
the solution above might not be sufficient. In that case, I think a
better solution might be to track the average frequency using hardware
counters or whatever tracking metrics the system might have to let
arch_scale_freq_capacity() return the average performance delivered ove=
r
the most recent period of time. AFAIK, x86 already has performance
counters (APERF/MPERF) that could be used for this purpose. The delta
period for each entity tracking update isn't fixed, but it might
sufficient to just average over some fixed period of time. Accurate
tracking would require some time-stamp information to be stored in each
sched_entity for the true average to be computed for the delta period.
That quickly becomes rather messy but not impossible. I did look at it
briefly a while back, but decided not to go down that route until we
know that using current frequency or some fixed period average isn't
going to be sufficient. Usage or utilization is and average of somethin=
g
that might be constantly changing anyways, so it never going to be very
accurate anyway. If it does turn out that we can't get the overall
picture right, we will need to improve it.

Updating the entity tracking for each frequency change adds to much
overhead I think and seems unnecessary if we do with an average scaling
factor.

I hope that answers your question. Have you observed any problems with
the usage tracking?

Thanks,
Morten

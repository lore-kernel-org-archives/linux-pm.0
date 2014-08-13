From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [ANNOUNCE] Tools to analyse PM and scheduling behaviour
Date: Thu, 14 Aug 2014 00:11:13 +0530
Message-ID: <8761hwcjw6.fsf@matterhorn.verdurent.com>
References: <CAP245DUSAHO_VBoBMy4KQaaA6_0a-i3Y3u4utnK8ji3UMVniyA@mail.gmail.com> <20140813112234.GK9918@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140813112234.GK9918@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Gross, Mark" <mark.gross@intel.com>, Paul McKenney <Paul.McKenney@us.ibm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Mike Turquette <mturquette@linaro.org>, Juri Lelli <juri.lelli@arm.com>, sched-tools@linaro.org
List-Id: linux-pm@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Aug 08, 2014 at 07:24:01PM +0530, Amit Kucheria wrote:
>> Workload Generator Details
>> --------------------------
>> The Workload Generator is based on rt-app. Shared resources, waits, =
signals
>> and locking order can be specified for each thread in a JSON descrip=
tion to
>> construct complex interdependencies. This allows simulation of inter=
esting
>> use-cases. The repository contains examples of a mp3 and web-browsin=
g
>> workload.
>>=20
>> The method to construct the JSON description is quite manual current=
ly. We
>> capture the trace of a workload of interest (say, on Android) and an=
alyse
>> it in kernelshark. We then construct the JSON description by hand un=
til its
>> resultant trace looks similar to the trace from the real workload.
>>=20
>> The immediate goal is to expand the library to cover the common mobi=
le
>> workloads. We=E2=80=99re also working with the rt-app maintainer to =
get our changes
>> merged.
>
> With the end goal of having a program convert a trace into a JSON
> description I take it?

Either that or re-evaluate if perf record and playback can actually do
away with the need to do this.

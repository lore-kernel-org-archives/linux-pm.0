From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v7 02/14] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
Date: Wed, 12 Sep 2018 16:56:31 +0200
Message-ID: <CAKfTPtA1BDHNnadZ4a3F+ZGt_GbM825P91toMdCimsMdu7q0Ew@mail.gmail.com>
References: <20180912091309.7551-1-quentin.perret@arm.com> <20180912091309.7551-3-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912091309.7551-3-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skannan@codeaurora.org>, pkondeti@cod
List-Id: linux-pm@vger.kernel.org

Hi Quentin,

On Wed, 12 Sep 2018 at 11:13, Quentin Perret <quentin.perret@arm.com> wrote:
>
> Schedutil requests frequency by aggregating utilization signals from
> the scheduler (CFS, RT, DL, IRQ) and applying and 25% margin on top of

quite a minor thing but s/and 25%/a 25%/

> them. Since Energy Aware Scheduling (EAS) needs to be able to predict
> the frequency requests, it needs to forecast the decisions made by the
> governor.
>
> In order to prepare the introduction of EAS, introduce
> schedutil_freq_util() to centralize the aforementioned signal
> aggregation and make it available to both schedutil and EAS. Since
> frequency selection and energy estimation still need to deal with RT and
> DL signals slightly differently, schedutil_freq_util() is called with a
> different 'type' parameter in those two contexts, and returns an
> aggregated utilization signal accordingly. While at it, introduce the
> map_util_freq() function which is designed to make schedutil's 25%
> margin usable easily for both sugov and EAS.
>
> As EAS will be able to predict schedutil's frequency requests more
> accurately than any other governor by design, it'd be sensible to make
> sure EAS cannot be used without schedutil. This will be done later, once
> EAS has actually been introduced.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

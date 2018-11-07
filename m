From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v8 03/15] PM: Introduce an Energy Model management framework
Date: Wed, 7 Nov 2018 17:32:32 +0100
Message-ID: <CAKfTPtBN3HpNMrztcmAwkGuW9uHaKBi9KoqdvBEHuxf7=078NA@mail.gmail.com>
References: <20181016101513.26919-1-quentin.perret@arm.com> <20181016101513.26919-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016101513.26919-4-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skannan@codeaurora.org>, pkondeti@cod
List-Id: linux-pm@vger.kernel.org

Hi Quentin,

On Tue, 16 Oct 2018 at 12:15, Quentin Perret <quentin.perret@arm.com> wrote:
>

> +
> +/**
> + * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
> + * @pd         : performance domain for which energy has to be estimated
> + * @max_util   : highest utilization among CPUs of the domain
> + * @sum_util   : sum of the utilization of all CPUs in the domain
> + *
> + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> + * a capacity state satisfying the max utilization of the domain.
> + */
> +static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
> +                               unsigned long max_util, unsigned long sum_util)
> +{
> +       unsigned long freq, scale_cpu;
> +       struct em_cap_state *cs;
> +       int i, cpu;
> +
> +       /*
> +        * In order to predict the capacity state, map the utilization of the
> +        * most utilized CPU of the performance domain to a requested frequency,
> +        * like schedutil.
> +        */
> +       cpu = cpumask_first(to_cpumask(pd->cpus));
> +       scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> +       cs = &pd->table[pd->nr_cap_states - 1];
> +       freq = map_util_freq(max_util, cs->frequency, scale_cpu);
> +
> +       /*
> +        * Find the lowest capacity state of the Energy Model above the
> +        * requested frequency.
> +        */
> +       for (i = 0; i < pd->nr_cap_states; i++) {
> +               cs = &pd->table[i];
> +               if (cs->frequency >= freq)
> +                       break;
> +       }
> +
> +       /*
> +        * The capacity of a CPU in the domain at that capacity state (cs)
> +        * can be computed as:
> +        *
> +        *             cs->freq * scale_cpu
> +        *   cs->cap = --------------------                          (1)
> +        *                 cpu_max_freq
> +        *
> +        * So, ignoring the costs of idle states (which are not available in
> +        * the EM), the energy consumed by this CPU at that capacity state is
> +        * estimated as:
> +        *
> +        *             cs->power * cpu_util
> +        *   cpu_nrg = --------------------                          (2)
> +        *                   cs->cap
> +        *
> +        * since 'cpu_util / cs->cap' represents its percentage of busy time.
> +        *
> +        *   NOTE: Although the result of this computation actually is in
> +        *         units of power, it can be manipulated as an energy value
> +        *         over a scheduling period, since it is assumed to be
> +        *         constant during that interval.
> +        *
> +        * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
> +        * of two terms:
> +        *
> +        *             cs->power * cpu_max_freq   cpu_util
> +        *   cpu_nrg = ------------------------ * ---------          (3)
> +        *                    cs->freq            scale_cpu
> +        *
> +        * The first term is static, and is stored in the em_cap_state struct
> +        * as 'cs->cost'.
> +        *
> +        * Since all CPUs of the domain have the same micro-architecture, they
> +        * share the same 'cs->cost', and the same CPU capacity. Hence, the
> +        * total energy of the domain (which is the simple sum of the energy of
> +        * all of its CPUs) can be factorized as:
> +        *
> +        *            cs->cost * \Sum cpu_util
> +        *   pd_nrg = ------------------------                       (4)
> +        *                  scale_cpu
> +        */
> +       return cs->cost * sum_util / scale_cpu;

Why do you need to keep scale_cpu outside the cs->cost ? do you expect
arch_scale_cpu_capacity() to change at runtime ?

If the returned value of arch_scale_cpu_capacity() changes, we will
have to rebuild several others things and we can include the update of
cs->cost

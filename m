From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v2 3/3] intel_pstate: Declare
 pid_params/pstate_funcs/hwp_active __read_mostly
Date: Tue, 28 Jun 2016 10:29:27 +0800
Message-ID: <20160628102927.4d74fb2c@xhacker>
References: <1467022038-924-1-git-send-email-jszhang@marvell.com>
	<1467022038-924-4-git-send-email-jszhang@marvell.com>
	<1467048594.8970.81.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467048594.8970.81.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear Rafael,

On Mon, 27 Jun 2016 10:29:54 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Mon, 2016-06-27 at 18:07 +0800, Jisheng Zhang wrote:
> > pid_params is written once by copy_pid_params() during
> > initialization,
> > and thereafter is mostly read by hot path intel_pstate_update_util(=
).
> > The read of pid_params gets more after commit a4675fbc4a7a ("cpufre=
q:
> > intel_pstate: Replace timers with utilization update callbacks")
> >=20
> > pstate_funcs is written once by copy_cpu_funcs() during
> > initialization,
> > and thereafter is mostly read by hot path intel_pstate_update_util(=
)
> >=20
> > hwp_active is written to once during initialization and thereafter =
is
> > mostly read by hot path intel_pstate_update_util().
> >=20
> > The fact that they are mostly read and not written to makes them
> > candidates for __read_mostly declarations.
> >=20
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com> =20
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

oops, I missed Viresh's Ack in this patch, so can you please add the mi=
ssing

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Sorry for inconvenience,
Jisheng

> > ---
> > =C2=A0drivers/cpufreq/intel_pstate.c | 6 +++---
> > =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 861bcba..2eda50d 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -281,9 +281,9 @@ struct cpu_defaults {
> > =C2=A0static inline int32_t get_target_pstate_use_performance(struc=
t
> > cpudata *cpu);
> > =C2=A0static inline int32_t get_target_pstate_use_cpu_load(struct c=
pudata
> > *cpu);
> > =C2=A0
> > -static struct pstate_adjust_policy pid_params;
> > -static struct pstate_funcs pstate_funcs;
> > -static int hwp_active;
> > +static struct pstate_adjust_policy pid_params __read_mostly;
> > +static struct pstate_funcs pstate_funcs __read_mostly;
> > +static int hwp_active __read_mostly;
> > =C2=A0
> > =C2=A0#ifdef CONFIG_ACPI
> > =C2=A0static bool acpi_ppc; =20

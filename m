From: Huaisheng HS1 Ye <yehs1@lenovo.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_cur_freq after
 performance governor changes
Date: Tue, 25 Jul 2017 01:46:31 +0000
Message-ID: <KL1PR0302MB2502DDDCC1D0F4FCC2916B4392B80@KL1PR0302MB2502.apcprd03.prod.outlook.com>
References: <1500875013-123321-1-git-send-email-yehs1@lenovo.com>
 <7185077.O26hx51RqR@aspire.rjw.lan>
 <KL1PR0302MB2502C43359F4B6A738D509B992BB0@KL1PR0302MB2502.apcprd03.prod.outlook.com>
 <13292124.r3mFCOTPK8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13292124.r3mFCOTPK8@aspire.rjw.lan>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

If you delete "get" function implement within intel_pstate, the=20
sysfs interface cpuinfo_cur_freq will display <unknown> all the time.=20
To be honest, at the beginning I have consider this way like you=20
patched, but based two reasons below, it is conservative for us to do that.

1. I am worried about whether it would lead to confusion for customers or=20
Linux OS venders who are accustomed to cpuinfo_cur_freq.
2. This is the first time for me to offer patch to intel_pstate, not sure=20
whether it could be accepted by you.

> On Monday, July 24, 2017 03:32:47 PM Huaisheng HS1 Ye wrote:
> > Hi Rafael,
> > Thanks for your reply.
> >
> > > On Monday, July 24, 2017 05:43:14 AM Huaisheng HS1 Ye wrote:
> > > > After commit 82b4e03e01bc (intel_pstate: skip scheduler hook when
> > > > in "performance" mode) Software P-state control modes couldn't get
> > > > dynamic value during performance mode,
> > >
> > > Please explain what you mean here.
> > >
> > commit 82b4e03e01bc (intel_pstate: skip scheduler hook when in
> > "performance" mode) disables intel_pstate_set_update_util_hook when
> > current policy is performance within function intel_pstate_set_policy.
> > It leads to Software P-states couldn't update sysfs interface
> > cpuinfo_cur_freq's value during performance mode, because of
> > pstate_funcs.update_util couldn't set for the given CPU.
> >
> > > I guess you carried out some tests and the results were not as
> > > expected, so what was the test?
> > Exactly, we check the sysfs interface cpuinfo_cur_freq and the output
> > of cpupower frequency-info both with performance mode.
>=20
> OK, so what about the change below:
>=20
> ---
>  drivers/cpufreq/intel_pstate.c |    8 --------
>  1 file changed, 8 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1674,13 +1674,6 @@ static int intel_pstate_init_cpu(unsigne
>  	return 0;
>  }
>=20
> -static unsigned int intel_pstate_get(unsigned int cpu_num) -{
> -	struct cpudata *cpu =3D all_cpu_data[cpu_num];
> -
> -	return cpu ? get_avg_frequency(cpu) : 0;
> -}
> -
>  static void intel_pstate_set_update_util_hook(unsigned int cpu_num)  {
>  	struct cpudata *cpu =3D all_cpu_data[cpu_num]; @@ -1921,7 +1914,6 @@
> static struct cpufreq_driver intel_pstat
>  	.setpolicy	=3D intel_pstate_set_policy,
>  	.suspend	=3D intel_pstate_hwp_save_state,
>  	.resume		=3D intel_pstate_resume,
> -	.get		=3D intel_pstate_get,
>  	.init		=3D intel_pstate_cpu_init,
>  	.exit		=3D intel_pstate_cpu_exit,
>  	.stop_cpu	=3D intel_pstate_stop_cpu,

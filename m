From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] cpufreq/intel_pstate: Fix an annoying !CONFIG_SMP
 warning
Date: Mon, 13 Apr 2015 12:32:30 -0700
Message-ID: <20150413123230.065b795c@kcaccard-desk.amr.corp.intel.com>
References: <1428067193-9608-1-git-send-email-bp@alien8.de>
	<7709303.8dfyH4hoC9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7709303.8dfyH4hoC9@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 11 Apr 2015 02:22:03 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Friday, April 03, 2015 03:19:53 PM Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> >=20
> > I keep seeing
> >=20
> >   drivers/cpufreq/intel_pstate.c: In function =E2=80=98intel_pstate=
_init=E2=80=99:
> >   drivers/cpufreq/intel_pstate.c:1187:26: warning: initialization f=
rom incompatible pointer type
> >     struct cpuinfo_x86 *c =3D &boot_cpu_data;
> >=20
> > when doing randconfig builds.
> >=20
> > This is caused by the fact that when !CONFIG_SMP, asm/processor.h
> > defines cpu_info to boot_cpu_data and the local variable
> >=20
> >   struct cpu_defaults *cpu_info
> >=20
> > overshadows it leading to this unfortunate assignment in the
> > preprocessed source:
> >=20
> >  struct cpu_defaults *boot_cpu_data;
> >  struct cpuinfo_x86 *c =3D &boot_cpu_data;
> >=20
> > Rename the local variable and use static_cpu_has_safe() which allev=
iates
> > the need for defining a local cpuinfo_x86 pointer.
>=20
> Kristen, any comments here?

Seems fine to me.

Acked-by: Kristen Carlson Accardi <kristen@linux.intel.com>

>=20
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  drivers/cpufreq/intel_pstate.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel=
_pstate.c
> > index 872c5772c5d3..0b883f131a73 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -31,6 +31,7 @@
> >  #include <asm/div64.h>
> >  #include <asm/msr.h>
> >  #include <asm/cpu_device_id.h>
> > +#include <asm/cpufeature.h>
> > =20
> >  #define BYT_RATIOS		0x66a
> >  #define BYT_VIDS		0x66b
> > @@ -1183,8 +1184,7 @@ static int __init intel_pstate_init(void)
> >  {
> >  	int cpu, rc =3D 0;
> >  	const struct x86_cpu_id *id;
> > -	struct cpu_defaults *cpu_info;
> > -	struct cpuinfo_x86 *c =3D &boot_cpu_data;
> > +	struct cpu_defaults *cpu_def;
> > =20
> >  	if (no_load)
> >  		return -ENODEV;
> > @@ -1200,10 +1200,10 @@ static int __init intel_pstate_init(void)
> >  	if (intel_pstate_platform_pwr_mgmt_exists())
> >  		return -ENODEV;
> > =20
> > -	cpu_info =3D (struct cpu_defaults *)id->driver_data;
> > +	cpu_def =3D (struct cpu_defaults *)id->driver_data;
> > =20
> > -	copy_pid_params(&cpu_info->pid_policy);
> > -	copy_cpu_funcs(&cpu_info->funcs);
> > +	copy_pid_params(&cpu_def->pid_policy);
> > +	copy_cpu_funcs(&cpu_def->funcs);
> > =20
> >  	if (intel_pstate_msrs_not_valid())
> >  		return -ENODEV;
> > @@ -1214,7 +1214,7 @@ static int __init intel_pstate_init(void)
> >  	if (!all_cpu_data)
> >  		return -ENOMEM;
> > =20
> > -	if (cpu_has(c,X86_FEATURE_HWP) && !no_hwp)
> > +	if (static_cpu_has_safe(X86_FEATURE_HWP) && !no_hwp)
> >  		intel_pstate_hwp_enable();
> > =20
> >  	if (!hwp_active && hwp_only)
> >=20
>=20

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Enforce _PPC limits
Date: Wed, 20 Apr 2016 10:28:02 -0700
Message-ID: <1461173282.8946.125.camel@linux.intel.com>
References: <1459812150-9111-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <57178C09.50603@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:48542 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbcDTR1h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Apr 2016 13:27:37 -0400
In-Reply-To: <57178C09.50603@yandex-team.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

On Wed, 2016-04-20 at 17:02 +0300, Konstantin Khlebnikov wrote:
> On 05.04.2016 02:22, Srinivas Pandruvada wrote:
> >=20
> > Use ACPI _PPC notification to limit max P state driver will
> > request.
[...]
> > I guess this is consequences of my post year ago: "[PATCH RFC]
> intel_pstate:
> play well with frequency limits set by acpi". It would be nice if you
> keep me in Cc.

Sure. This patchset is mini version of the patch which you reviewed and
commented on
"	Re: [RFC PATCH] cpufreq: intel_pstate: Use ACPI perf".


> <couple notes below>
[...]

> +	turbo_pss_ctl =3D convert_to_native_pstate_format(cpu, 0);
> > +	if (turbo_pss_ctl > cpu->pstate.max_pstate)
> > +		cpu->acpi_perf_data.states[0].core_frequency =3D
> > +					policy->cpuinfo.max_freq /
> > 1000;
> I'm afraid not only first entry could have bogus frequency.
>=20
> Maybe just ignore them all and recalculate frequencies from pstates?
> (frequency =3D clamp(pstate, min_pstate, turbo_pstate) * scaling /
> 1000)

We have to trust control values in _PSS then.
This was the mistake we did when we merged the patch to 4.4-rc1, where
we were overly optimistic about the control values in _PSS table. On
some system these values were 0xff.
The _PSS table will have max_non_turbo_freq in MHz + 1 only for turbo
frequency. If ever Windows worked on that system the table should have
correct values.
Still there will be some systems, where as you suggested there can be
junk in frequency or control value, hence I am no longer turning on
this feature by default.
>=20
> >=20
> > +	cpu->valid_pss_table =3D true;

[...]

> > =C2=A0 static struct cpufreq_driver intel_pstate_driver =3D {
> > =C2=A0=C2=A0	.flags		=3D CPUFREQ_CONST_LOOPS,
> > =C2=A0=C2=A0	.verify		=3D intel_pstate_verify_policy,
> > =C2=A0=C2=A0	.setpolicy	=3D intel_pstate_set_policy,
> > =C2=A0=C2=A0	.get		=3D intel_pstate_get,
> > =C2=A0=C2=A0	.init		=3D intel_pstate_cpu_init,
> If you add
>=20
> #if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.bios_limit=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=3D acpi_processor_get_bios_limit,
> #endif
>=20
> current limit will be shown in
> /sys/devices/system/cpu/cpu*/cpufreq/bios_limit
>=20
The BIOS limit is no longer represent the max frequency you will get.
This will be start of turbo range when config tdp feature on processor
after SandyBridge.
Does it add value, when it doesn't mean what it used before?

Thanks,
Srinivas


From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: Intel P state driver: clean remnant struct
 element
Date: Tue, 19 Jul 2016 15:16:23 -0700
Message-ID: <1468966583.4150.8.camel@linux.intel.com>
References: <66b88042-0f03-893b-33ac-c4e6df17534c@osadl.org>
	 <1468859382.13661.167.camel@linux.intel.com>
	 <baa442ec-5845-6438-8c03-6793220883e1@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1265 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbcGSWSK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jul 2016 18:18:10 -0400
In-Reply-To: <baa442ec-5845-6438-8c03-6793220883e1@osadl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

On Tue, 2016-07-19 at 01:19 +0200, Carsten Emde wrote:
> Hi Srinivas,
>=20
> BTW: when I was working with the Intel P state driver I came across
> a remnant struct element that is no longer needed after the function
> intel_pstate_calc_freq() was retired.
You are right. Can you resend with proper commit message?


Thanks,
Srinivas

> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>=20
> Index: linux-4.7.0-rc7+/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-4.7.0-rc7+.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-4.7.0-rc7+/drivers/cpufreq/intel_pstate.c
> @@ -96,7 +96,6 @@ static inline u64 div_ext_fp(u64 x, u64
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read fro=
m MPERF MSR between last and current
> sample
> =C2=A0 * @tsc:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Difference of time stamp counter betwe=
en last
> and
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0current =
sample
> - * @freq:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Effective frequency calculated from
> APERF/MPERF
> =C2=A0 * @time:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Current time from scheduler
> =C2=A0 *
> =C2=A0 * This structure is used in the cpudata structure to store
> performance sample
> @@ -108,7 +107,6 @@ struct sample {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 aperf;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 mperf;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 tsc;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int freq;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 time;
> =C2=A0};
> =C2=A0
>=20

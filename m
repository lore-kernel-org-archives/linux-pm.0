From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V5 1/4] Remove extra conversions in pid calculation
Date: Mon, 07 Mar 2016 13:30:50 -0800
Message-ID: <1457386250.4361.7.camel@linux.intel.com>
References: <1457249646-23072-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1457249646-23072-2-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28411 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384AbcCGVdn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Mar 2016 16:33:43 -0500
In-Reply-To: <1457249646-23072-2-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org
Cc: rafael@kernel.org

On Sun, 2016-03-06 at 08:34 +0100, Philippe Longepe wrote:
> pid->setpoint and pid->deadband can be initialize in float so we
> can remove the int_tofp in pid_calc.

Rafael had some comments on this patch:
"s/initialize/initialized/

> can remove the int_tofp in pid_calc.

This is not "float", but "fixed point".

Also "avoid" rather than "remove".
"
Not sure if Rafael is OK without change.

> Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index eb0aef0..114e4e0 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -198,8 +198,8 @@ static struct perf_limits *limits =3D
> &powersave_limits;
> =C2=A0
> =C2=A0static inline void pid_reset(struct _pid *pid, int setpoint, in=
t
> busy,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int deadband, int integral) {
> -	pid->setpoint =3D setpoint;
> -	pid->deadband=C2=A0=C2=A0=3D deadband;
> +	pid->setpoint =3D int_tofp(setpoint);
> +	pid->deadband=C2=A0=C2=A0=3D int_tofp(deadband);
> =C2=A0	pid->integral=C2=A0=C2=A0=3D int_tofp(integral);
> =C2=A0	pid->last_err=C2=A0=C2=A0=3D int_tofp(setpoint) - int_tofp(bus=
y);
> =C2=A0}
> @@ -225,9 +225,9 @@ static signed int pid_calc(struct _pid *pid,
> int32_t busy)
> =C2=A0	int32_t pterm, dterm, fp_error;
> =C2=A0	int32_t integral_limit;
> =C2=A0
> -	fp_error =3D int_tofp(pid->setpoint) - busy;
> +	fp_error =3D pid->setpoint - busy;
> =C2=A0
> -	if (abs(fp_error) <=3D int_tofp(pid->deadband))
> +	if (abs(fp_error) <=3D pid->deadband)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	pterm =3D mul_fp(pid->p_gain, fp_error);

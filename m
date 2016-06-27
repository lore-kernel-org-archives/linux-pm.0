From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 1/3] intel_pstate: Fix incorrect placement of
 __initdata
Date: Mon, 27 Jun 2016 10:19:04 -0700
Message-ID: <1467047944.8970.79.camel@linux.intel.com>
References: <1467022038-924-1-git-send-email-jszhang@marvell.com>
	 <1467022038-924-2-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64386 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbcF0RRk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jun 2016 13:17:40 -0400
In-Reply-To: <1467022038-924-2-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2016-06-27 at 18:07 +0800, Jisheng Zhang wrote:
> __initdata should be placed between the variable name and equal sign
> (if there is) for the variable to be placed in the intended section.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index fe9dc17..44099e9 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1574,9 +1574,9 @@ static struct cpufreq_driver
> intel_pstate_driver =3D {
> =C2=A0	.name		=3D "intel_pstate",
> =C2=A0};
> =C2=A0
> -static int __initdata no_load;
> -static int __initdata no_hwp;
> -static int __initdata hwp_only;
> +static int no_load __initdata;
> +static int no_hwp __initdata;
> +static int hwp_only __initdata;
> =C2=A0static unsigned int force_load;
> =C2=A0
> =C2=A0static int intel_pstate_msrs_not_valid(void)

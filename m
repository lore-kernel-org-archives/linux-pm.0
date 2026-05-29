Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01343D16EF;
	Fri, 29 May 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068805; cv=none; b=qwO7Nt9LUpvmjFgFJcBiYFIpSscSHM+KMDVR5kEjHO9sHWu491v0qLuCKe7+LH4i31dYf+aY6HSkGV2+R/ONaLL4eMRAydwsg8rvndPTVm1F9PrOHZrhj0c2+GqnHdv7dL78+47pViE8jsv4Dpi27XT8sxDROyvK2Ax39OPVaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068805; c=relaxed/simple;
	bh=GwDZ3tJH+G4OjBxGw6CP7LA8VJOS/nVNqGMi3tSl4mg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRgiReDdhO8TgYz+XcqcC1afjhjRnadGCFlK0Yzt/EduMuPPJ0eoXwThQ8LmVKKiVYja9ifPo/KFaWzW/2BPCcEL2jCTI45ivdhv0uIUI9JY0YB9Dxr/F9/smkHA02uQZlhxyRAMFISrme2GNXpqsLNX5JOpU6rhlfCLcWU8AIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwktYV9R; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwktYV9R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780068804; x=1811604804;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=GwDZ3tJH+G4OjBxGw6CP7LA8VJOS/nVNqGMi3tSl4mg=;
  b=bwktYV9Rkf6xMZmzQLl58Fw8BzmqI8wNwLTO08q6wl347oeujW6c/qaM
   ulfMyEa/oyt9nAtVLu5/BNxIqvFM9jUbuUf4PdoZmIglxVY3YdRxcumN/
   NCA9HXjzXDxvlMZQ5DzJhmpQcU4pyYKkj8Alxb0sx+4XA7Edsf6SGUDq+
   N7Ztgl6X0Ubp14Nrp/xPlxxCR1sTrk9oq59BUcYOODRqVND9AcnIF4OrZ
   NyR7Lklnk0WuGPX1YR5fG3gARCZFfNcWpNMgYykw34d2jprhQSNmqh7aV
   zAWyKG8QoWGV69iiaP1pHFrprkjlMdj9EbmPcuBsBJs4JYXHEVR6ihc12
   A==;
X-CSE-ConnectionGUID: Sr4zEic5QkW22QY63t//iQ==
X-CSE-MsgGUID: XDnlqDcmR2+aXdDt4FS4tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="92038008"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92038008"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:33:20 -0700
X-CSE-ConnectionGUID: FcPM3AnYQmKwLFjXUUqyvg==
X-CSE-MsgGUID: Y7TtRlDeRuuTXV2TQCWEOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="242734582"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.111.154]) ([10.125.111.154])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:33:20 -0700
Message-ID: <60119eb883057391dc6def200be119e56a6e4fb5.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI: CPPC: Add helper to get effective guaranteed
 performance
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org, lenb@kernel.org, 
	viresh.kumar@linaro.org, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, 	acpica-devel@lists.linux.dev
Date: Fri, 29 May 2026 08:33:19 -0700
In-Reply-To: <20260529081801.29346-1-luoxueqin@kylinos.cn>
References: <20260529081801.29346-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 16:18 +0800, Xueqin Luo wrote:
> According to the ACPI CPPC specification, if the Guaranteed
> Performance register is not implemented, OSPM assumes the
> guaranteed performance is equal to nominal performance.
>=20
> Add cppc_get_effective_guaranteed_perf() helper to provide a
> spec-compliant effective guaranteed performance value while
> preserving the raw values returned by cppc_get_perf_caps().
>=20
Hi Luo,

Are you trying to fix any issue where you have issue with
"base_frequency" display? intel_pstate will revert to native MSR, which
is always present when we are using CPPC.

I worry about some bad nominal perf in some platforms as we will be
dependent on OEM BIOS.

Thanks,
Srinivas


> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
> =C2=A0drivers/acpi/cppc_acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26 +=
+++++++++++++++++++++++++
> =C2=A0drivers/cpufreq/intel_pstate.c | 10 ++++------
> =C2=A0include/acpi/cppc_acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 5 +++++
> =C2=A03 files changed, 35 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f370be8715ae..6dc11030707a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1328,6 +1328,32 @@ int cppc_get_highest_perf(int cpunum, u64
> *highest_perf)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> =C2=A0
> +/**
> + * cppc_get_effective_guaranteed_perf - get effective guaranteed
> performance
> + * @cpunum: CPU number
> + * @guaranteed_perf: Effective guaranteed performance value
> + *
> + * The ACPI CPPC specification states that if the Guaranteed
> + * Performance register is not implemented, OSPM assumes the
> + * guaranteed performance is equal to nominal performance.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int cppc_get_effective_guaranteed_perf(int cpunum, u64
> *guaranteed_perf)
> +{
> +	struct cppc_perf_caps perf_caps;
> +	int ret;
> +
> +	ret =3D cppc_get_perf_caps(cpunum, &perf_caps);
> +	if (ret)
> +		return ret;
> +	*guaranteed_perf =3D perf_caps.guaranteed_perf ?:
> +			=C2=A0=C2=A0 perf_caps.nominal_perf;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_effective_guaranteed_perf);
> +
> =C2=A0/**
> =C2=A0 * cppc_get_epp_perf - Get the epp register value.
> =C2=A0 * @cpunum: CPU from which to get epp preference value.
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 8dc22a65e025..8934e48f71a2 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -404,17 +404,15 @@ static void intel_pstate_set_itmt_prio(int cpu)
> =C2=A0
> =C2=A0static int intel_pstate_get_cppc_guaranteed(int cpu)
> =C2=A0{
> -	struct cppc_perf_caps cppc_perf;
> +	u64 guaranteed_perf;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D cppc_get_perf_caps(cpu, &cppc_perf);
> +	ret =3D cppc_get_effective_guaranteed_perf(cpu,
> &guaranteed_perf);
> +
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	if (cppc_perf.guaranteed_perf)
> -		return cppc_perf.guaranteed_perf;
> -
> -	return cppc_perf.nominal_perf;
> +	return guaranteed_perf;
> =C2=A0}
> =C2=A0
> =C2=A0static int intel_pstate_cppc_get_scaling(int cpu)
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index d1f02ceec4f9..c02f3bc1fc1a 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -155,6 +155,7 @@ struct cppc_cpudata {
> =C2=A0extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
> =C2=A0extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
> =C2=A0extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
> +extern int cppc_get_effective_guaranteed_perf(int cpunum, u64
> *guaranteed_perf);
> =C2=A0extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs
> *perf_fb_ctrs);
> =C2=A0extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls
> *perf_ctrls);
> =C2=A0extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls
> *perf_ctrls);
> @@ -198,6 +199,10 @@ static inline int cppc_get_highest_perf(int
> cpunum, u64 *highest_perf)
> =C2=A0{
> =C2=A0	return -EOPNOTSUPP;
> =C2=A0}
> +static inline int cppc_get_effective_guaranteed_perf(int cpunum, u64
> *guaranteed_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> =C2=A0static inline int cppc_get_perf_ctrs(int cpu, struct
> cppc_perf_fb_ctrs *perf_fb_ctrs)
> =C2=A0{
> =C2=A0	return -EOPNOTSUPP;

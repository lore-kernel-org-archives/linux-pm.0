Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DC46AF04;
	Tue,  4 Aug 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866344; cv=none; b=i51+ZLRGhuvtd2TU//+ynr73cd29kZCgJ6OkCIyhbCUTKkj1ZDyci7EE+NxKgv5tCggySMYkSUikQWu+yAJo7W+GY+Ghd9Flkce1dDhmMmJ5xSzwy8Rcc7oly4g8WUXE71C6KYToABTK2o5Q7XiEqJmL5IkEhn92pGEowVPa3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866344; c=relaxed/simple;
	bh=P+1MBG0jYNktOsgozB0ll/s5VJ6ZZqgmmKDYKQAMA+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUPJo/ckt25Uo50z2L+06ta+IFPWeEuJ+7brQBjMclTKYixGxvvuAgsXQzv8L4EYhosl6Eece9oIN8wkvH92xEv+91dd6iTNR9ZihQJn2bOVlL8gqYSaHh4k9wX671E3behGrQobJkuv2o8Y+TCepXRqc3sozLk28qtmb3CCGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kP8UAPVF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kP8UAPVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785866341; x=1817402341;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=P+1MBG0jYNktOsgozB0ll/s5VJ6ZZqgmmKDYKQAMA+U=;
  b=kP8UAPVFDtq6o46J5SsA8r+FAf+EvzJLjUl3N6WJumea6yrUNnNgzto9
   YhTp1hwcnbDbXkfpAR6uYyJ7fp8dx//YckR7mH/ej+GXePOI/399vkfgU
   5lbXB2blhxZpPmzX04oN+jTBRH8BrO0ajigXdfxzRc49gRhNJE7ctL29c
   //zlVn/oj5O3F+jXC9zL7Emt9YkuXg8ZSiA9XPxRg95BItWL7Z45ZSPS+
   JBW6UML+CaP2VfvoMJ1KmVOVkjGPdILEsIfcikyh5noQZxKz1mEBwGs1c
   uULH44RX4ZNRuY9FE92f7G6zhIyFHALVYE5krpbsaCxFqs/fGZGvLAEef
   g==;
X-CSE-ConnectionGUID: zQcVNnr1QUudlZTZ1Ak1VQ==
X-CSE-MsgGUID: rkwdrfZQQcyG0HMpVo9ZPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86504257"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86504257"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 10:58:58 -0700
X-CSE-ConnectionGUID: GWmKues/TU++TOdSn+BUNA==
X-CSE-MsgGUID: 46bTLAEKTrSSQBtG+dfeJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="260310974"
Received: from spandruv-mobl5.hf.intel.com (HELO [143.181.48.226]) ([143.181.48.226])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 10:58:58 -0700
Message-ID: <98deef347e027ad29431973f6c4e68772effce00.camel@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Avoid using DESIRED_PERF when
 DEC is enabled
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: Doug Smythies <dsmythies@telus.net>, linux-kernel@vger.kernel.org
Date: Tue, 04 Aug 2026 10:58:57 -0700
In-Reply-To: <5091298.GXAFRqVoOG@rafael.j.wysocki>
References: 
	<20260729-bug-intel-pstate-policy-cur-v1-1-51f61e5cbd74@gmail.com>
	 <5091298.GXAFRqVoOG@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 20:15 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> In principle, the desired performance level can be set in
> MSR_HWP_REQUEST
> to indicate to the processor what performance level the OS would like
> the given CPU to run at, but if the Dynamic Efficiency Control (DEC)
> feature is enabled in the processor, doing so may result in confusing
> the processor firmware.=C2=A0 It is then better to let the processor
> firmware
> figure out the most suitable performance level by itself.
>=20
> Accordingly, make intel_pstate always set the desired performance
> level
> to zero (which means "no preference") when running on a platform with
> DEC enabled.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>=20
> Applies on top of linux-next.
>=20
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A0 9 +++++++--
> =C2=A01 file changed, 7 insertions(+), 2 deletions(-)
>=20
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -303,6 +303,7 @@ static bool per_cpu_limits __ro_after_in
> =C2=A0static bool hwp_forced __ro_after_init;
> =C2=A0static bool hwp_boost __read_mostly;
> =C2=A0static bool hwp_is_hybrid;
> +static u32 hwp_desired_mask __read_mostly =3D ~0U;
> =C2=A0
> =C2=A0static struct cpufreq_driver *intel_pstate_driver __read_mostly;
> =C2=A0
> @@ -3150,7 +3151,7 @@ static void intel_cpufreq_hwp_update(str
> =C2=A0	value |=3D HWP_MAX_PERF(max);
> =C2=A0
> =C2=A0	value &=3D ~HWP_DESIRED_PERF(~0L);
> -	value |=3D HWP_DESIRED_PERF(desired);
> +	value |=3D HWP_DESIRED_PERF(desired & hwp_desired_mask);
> =C2=A0
> =C2=A0	if (value =3D=3D prev)
> =C2=A0		return;
> @@ -3787,6 +3788,7 @@ static int __init intel_pstate_init(void
> =C2=A0	id =3D x86_match_cpu(hwp_support_ids);
> =C2=A0	if (id) {
> =C2=A0		bool epp_present =3D hwp_check_epp();
> +		bool dec_present =3D hwp_check_dec();
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * If HWP is enabled already, there is no choice but
> to deal
> @@ -3798,7 +3800,7 @@ static int __init intel_pstate_init(void
> =C2=A0			no_hwp =3D 0;
> =C2=A0		} else if (no_load) {
> =C2=A0			return -ENODEV;
> -		} else if (!epp_present && !hwp_check_dec()) {
> +		} else if (!epp_present && !dec_present) {
> =C2=A0			/*
> =C2=A0			 * Avoid enabling HWP for processors without
> EPP support
> =C2=A0			 * unless the Dynamic Efficiency Control
> (DEC) enable
> @@ -3820,6 +3822,9 @@ static int __init intel_pstate_init(void
> =C2=A0			if (!default_driver)
> =C2=A0				default_driver =3D &intel_pstate;
> =C2=A0
> +			if (dec_present)
> +				hwp_desired_mask =3D 0;
> +
> =C2=A0			if (!id->driver_data)
> =C2=A0				pstate_funcs.get_cpu_scaling =3D
> hwp_get_cpu_scaling;
> =C2=A0
>=20
>=20

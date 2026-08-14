Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1135AC24;
	Fri, 14 Aug 2026 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716058; cv=none; b=VFhuL/6CJ5oB4fo1jCF9q5Mw3scKK/8zxOG1CvORX1IXe7bF2TT7V0c0RRI3QiJDjiPWNMZyI3LG0I95jFMSkeUJxNUkqsXmMqmHZAMVzbmJaYwNRX3yNO1Fp2Af6p2AnKSqO5VOQOAB5rW2uRrG84XfiIijtlAvEtCnSUdOJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716058; c=relaxed/simple;
	bh=K2RiR39bu6WI96bZiLQoPQKdejIm70LNc/yh27gRAZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHmIG6iooWNKPLA/Am4PZe7+uzc1zRrB43ZmbGiEcsIvUPYZDAHG9wrykLuKmAlv1s+CsB7P4bUPTVn8bxR4iVI71E0WsdwOjcjTZvhCjUXgdzLEJNgROp2AE4rgJ+Tfvb9e2RgoM/tu1YT88geRXXyDl908yHCm2nwt5lRtbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRknm/25; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRknm/25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786716056; x=1818252056;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=K2RiR39bu6WI96bZiLQoPQKdejIm70LNc/yh27gRAZg=;
  b=mRknm/25wPvyoLj+8bX2uUzlq9d6fmNkZKk2UDI/A9o/m4Uoj9I5Tuj5
   wMWXPaNgYRej6PJEjE9+ELoXK1GZWGaz7hzEnzl1VYJqMR15UTEmwwqbr
   5zXCUab9ArDrmSjPU/lDN4FkYaCuaX9zlDRprfcZ1TnpwiuEIfdy0D6iR
   CbgFvdV4ZiNspagZ1S+D3R0/9W7Z37YolNRms33hyDlqDf3xK2vYOAr1m
   yeMX5SYfqzW2RCgT9UzFGd8nKSOtn/MdQNhVLGkB474fKF74JzKVKfaMi
   VtaVcBL4b0RGWf5sLHvgHxv8UGhKFBbaoTUdbUANpopoBQfMEnYaLM2hd
   A==;
X-CSE-ConnectionGUID: zVO88Jz6QGmJhvDzE/JOLQ==
X-CSE-MsgGUID: Bv7XSZ3/S6S6fgmOafo7qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="97884834"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97884834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 07:00:54 -0700
X-CSE-ConnectionGUID: uTOEBdi/SzeAUhDQ2KTFxw==
X-CSE-MsgGUID: K1amPFCfRIekPe7j0Pd81A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="302473530"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.111.78]) ([10.125.111.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 07:00:54 -0700
Message-ID: <bdd5f6f67741f102ceae93ff46a351ecc090e72f.camel@linux.intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Sign-extend the PMU delta on
 counter wraparound
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Li Yifan <yifan2.li@intel.com>, rafael@kernel.org, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jianfeng.gao@intel.com, 
	anand.b.jyoti@intel.com, lili.li@intel.com
Date: Fri, 14 Aug 2026 07:00:53 -0700
In-Reply-To: <20260814031008.750911-1-yifan2.li@intel.com>
References: <20260814031008.750911-1-yifan2.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 11:10 +0800, Li Yifan wrote:
> From: "Li, Yifan" <yifan2.li@intel.com>
>=20
> The RAPL PMU misreports energy when the hardware energy counter
> overflows and wraps back to zero.=C2=A0 perf event counts are defined to
> increase monotonically, but a single wraparound makes the PMU event
> count jump backwards by nearly the full counter range, and consumers
> that take the difference of two reads in unsigned arithmetic then
> underflow and report an absurd value.
>=20
> On a Panther Lake system (energy unit 61.035 uJ, counter range
> 262144 J) the package counter wraps every ~2.9 hours at 25 W, and
> turbostat prints one bogus sample per wraparound, per domain:
>=20
> =C2=A0 PkgTmp=C2=A0 PkgWatt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 CorWatt GFXWatt RAMWatt SysWatt
> =C2=A0 44=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24.97=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16.30=C2=A0=C2=A0 3.90=C2=A0=C2=A0=C2=A0 =
1.87=C2=A0=C2=A0=C2=A0 2145386370.35
> =C2=A0 43=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2145240612.10=C2=A0=C2=A0 16.13=
=C2=A0=C2=A0 4.02=C2=A0=C2=A0=C2=A0 1.91=C2=A0=C2=A0=C2=A0 40.46
>=20
> The RAPL energy counters are 32-bit wide on every register interface:
> MSR, MMIO and TPMI all describe ENERGY_COUNTER with a GENMASK(31, 0)
> mask.=C2=A0 rapl_read_data_raw() applies that mask, so
> event_read_counter()
> returns the counter zero-extended in a u64.
>=20
> rapl_event_update() then computes
>=20
> 	delta =3D new_raw_count - prev_raw_count;
>=20
> without reducing the result modulo 2^32.=C2=A0 While the counter does not
> wrap this is correct, but once the hardware counter wraps,
> new_raw_count < prev_raw_count and delta becomes (true_delta - 2^32),
> a large negative value.=C2=A0 Declaring delta as s64 only makes that valu=
e
> representable; it does not correct it.=C2=A0 That bogus delta is scaled
> and
> added to event->count, which is where the backwards jump comes from.
>=20
> Fix it the way arch/x86/events/rapl.c has done since the RAPL PMU was
> first introduced: shift both values up so that the 64-bit subtraction
> reduces modulo 2^32, then shift the difference back down with an
> arithmetic shift to sign-extend it.
>=20
> This is correct as long as at most one wraparound happens between two
> updates, which the existing overflow hrtimer already guarantees: its
> period is half of the counter range at the 200 W reference used in
> rapl_package_add_pmu_locked().
>=20
> The problem has been present since the powercap RAPL PMU was added,
> but
> only affected TPMI RAPL until commit 748d6ba43afd ("powercap:
> intel_rapl: Enable MSR-based RAPL PMU support") routed MSR RAPL
> through
> the same PMU, which exposed it on client platforms such as Panther
> Lake.
>=20
> Fixes: 575024a8aa7c ("powercap: intel_rapl: Introduce APIs for PMU
> support")
> Reported-by: Jyoti, Anand B <anand.b.jyoti@intel.com>
> Signed-off-by: Li, Yifan <yifan2.li@intel.com>
> Signed-off-by: Gao Jianfeng <jianfeng.gao@intel.com>
> Tested-by: Jyoti, Anand B <anand.b.jyoti@intel.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/powercap/intel_rapl_common.c | 11 ++++++++++-
> =C2=A01 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/powercap/intel_rapl_common.c
> b/drivers/powercap/intel_rapl_common.c
> index 1006d183d508..6b7d11a0abc5 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -32,6 +32,9 @@
> =C2=A0
> =C2=A0#define ENERGY_STATUS_MASK		GENMASK(31, 0)
> =C2=A0
> +/* Width of the RAPL energy counters, see the *_ENERGY_STATUS_MASK
> defines */
> +#define RAPL_CNTR_WIDTH			32
> +
> =C2=A0#define POWER_UNIT_OFFSET		0x00
> =C2=A0#define POWER_UNIT_MASK			GENMASK(3, 0)
> =C2=A0
> @@ -1227,6 +1230,7 @@ static u64 rapl_event_update(struct perf_event
> *event)
> =C2=A0	struct rapl_package_pmu_data *data =3D
> event_to_pmu_data(event);
> =C2=A0	u64 prev_raw_count, new_raw_count;
> =C2=A0	s64 delta, sdelta;
> +	int shift =3D 64 - RAPL_CNTR_WIDTH;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Follow the generic code to drain hwc->prev_count.
> @@ -1243,8 +1247,13 @@ static u64 rapl_event_update(struct perf_event
> *event)
> =C2=A0	 * Now we have the new raw value and have updated the prev
> =C2=A0	 * timestamp already. We can now calculate the elapsed delta
> =C2=A0	 * (event-)time and add that to the generic event.
> +	 *
> +	 * Careful, the counter is narrower than u64 and is not
> +	 * sign-extended above its physical width.=C2=A0 Shift both
> values up
> +	 * so that the subtraction wraps, then shift the result back
> down.
> =C2=A0	 */
> -	delta =3D new_raw_count - prev_raw_count;
> +	delta =3D (new_raw_count << shift) - (prev_raw_count <<
> shift);
> +	delta >>=3D shift;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Scale delta to smallest unit (2^-32)
>=20
> base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a

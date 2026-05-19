Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187233AD9C;
	Tue, 19 May 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213409; cv=none; b=DHiypQnIKWbIpFzNXLIQff6rFLZezHmSuCrg+/vT65KBU9nD9kMeE5rN11hk6Hg7iZNy/h86PkpPl8SqCvL6kuGZN4jOzycsWCEGsJxBk7IHRfqfNDYs3CKZfqHovn3J1LNI5YEUWl+pbK3TSMvRAedUEtPpfrKTs2mFq34txmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213409; c=relaxed/simple;
	bh=OFiSDYdS5k0VeQ6U4dsONE+jKyL20p28JWfwIvG5vGc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=uITJSBRrxmrrr6v6FIuhgZeOOj2YP0X5LsiLcjNXW3RpjWGfalWZUs8mc7RiNG6sq0ykwc0OTiS2U/+q9TikDfV8TaCyMHhUzaVK5Lfl5VWaRs284Misb3C38EXsm6pvHXhRhWJwB8HLtEs/PxKRMQRd7Ng9ZmH43Kwutoy3XCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyGY32PQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyGY32PQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779213408; x=1810749408;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   content-transfer-encoding:date:mime-version;
  bh=OFiSDYdS5k0VeQ6U4dsONE+jKyL20p28JWfwIvG5vGc=;
  b=EyGY32PQmL1MkFFlzgwRzknb3JBrq7zTu4ylMQAFu/0M2bbrAY8roGKx
   NwOJfFY+kQlsewWRQF3I8R9HAYJqH+8Uh4APDYxwS1ilYKkCtSyCljVhd
   dEMvp8XX2+Ixp5zSKQKzSx+vhuBJ9R7RhOdSjqXXHRyPztzkRUqmb8X9w
   GnBON244Fq7Fv43cC1duZBinDVK/fcN1A5dlIoZuq7T0JXTRxFi3Fsd0a
   OPIVYjFpMJuzLSkOuk/wYUHW5FcJqghBuASY2JgXaPrcldUXWEkEmxXXw
   lIS1JznxieJ2UfA9lcCfIrgu1DxaaCncRAWUMIcP6s3hUG5BGuT66Q+Xf
   A==;
X-CSE-ConnectionGUID: ioo67g9hT3+lvVY/Q5Gy/A==
X-CSE-MsgGUID: J2yWRPyXQ0OHqy314oW9lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="97669419"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97669419"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:56:46 -0700
X-CSE-ConnectionGUID: zx2h9XBhT7+/H1mP3OjSEw==
X-CSE-MsgGUID: 3LJvjOy1T06GiF1s7JQTyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="236852506"
Received: from unknown (HELO [10.241.243.24]) ([10.241.243.24])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:56:47 -0700
Message-ID: <f9a3a391c5209ff7ffdd06223305b7b302977e51.camel@linux.intel.com>
Subject: Re: [PATCH RESEND] cpufreq: intel_pstate: Sync policy->cur when
 setting min pstate during CPU offline
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Fushuai Wang <fushuai.wang@linux.dev>, lenb@kernel.org,
 rafael@kernel.org, 	viresh.kumar@linaro.org, currojerez@riseup.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wangfushuai@baidu.com
In-Reply-To: <20260519112445.9986-1-fushuai.wang@linux.dev>
References: <20260519112445.9986-1-fushuai.wang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 10:56:22 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 

On Tue, 2026-05-19 at 19:24 +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
>=20
> When a CPU goes offline with HWP disabled,
> intel_pstate_set_min_pstate()
> sets the MSR_IA32_PERF_CTL to minimum frequency to prevent SMT
> siblings
> from being restricted. However, the policy->cur value was not
> updated,
> leaving it at the previous value.
>=20
> When the CPU comes back online, governor->limits() checks if
> target_freq
> equals policy->cur and skips the frequency adjustment if they match.
> Since
> policy->cur still holds the previous value, the governor does not
> call
> cpufreq_driver->target to update MSR_IA32_PERF_CTL.
>=20
> Fix this by synchronizing policy->cur with the hardware state when
> setting
> minimum pstate during CPU offline.
>=20
> Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode
> with HWP enabled")

The patch is fine with some comments below, but this Fixes tag is not
necessary added this. This was implementation from
Commit bb18008f8086283f8f03e8e50fbbf17f213b9ea9
Author: Dirk Brandewie <dirk.j.brandewie@intel.com>
Date:   Wed Mar 19 08:45:54 2014 -0700

    intel_pstate: Set core to min P state during core offline
=20


> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 1292da53e5fc..0bd6388caa9d 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2986,8 +2986,10 @@ static int intel_cpufreq_cpu_offline(struct
> cpufreq_policy *policy)
> =C2=A0	 */
> =C2=A0	if (hwp_active)

{

> =C2=A0		intel_pstate_hwp_offline(cpu);
> -	else
> +	else {

s/else / } else {

> =C2=A0		intel_pstate_set_min_pstate(cpu);
> +		policy->cur =3D cpu->pstate.min_freq;
> +	}

> =C2=A0
> =C2=A0	intel_pstate_exit_perf_limits(policy);
> =C2=A0

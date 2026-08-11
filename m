Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702793FBB7D
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442730; cv=none; b=Aamfak/02lOqY/WPFstPgkU0p0DldWomyuWLVBl6SQULBWkSd47ViJMrslwHjvvvLcZNYFuxyGLwecmg8PIk6MIFSddK+1ToG2V/N3zb2X6cSfnZRsn5IA/0T1brAmXGWJD5H1lvt1AqK405s8dH2qYvMUHXSJhTzSd3/JIZq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442730; c=relaxed/simple;
	bh=XMmn2cgU3cpBbHLRDlWqwyZsNTDxr325FwDNJMkS0Oc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFllu/z9i0Ws3so56IhdTbyfCtDJ43eIiqWERg+TTwoTcDcIrDBALi698dM9bEEIpGlnwtDG6VOCoqs2of0sbHm4Wdjv0UbC+3gqYcUCa/XKnOnOivDKlBhalSu5Xr8v2DuxwOpv5KVxeTEIjk+3Mpbg610kPCsavYuTLmumH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hugIJqIc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hugIJqIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786442727; x=1817978727;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XMmn2cgU3cpBbHLRDlWqwyZsNTDxr325FwDNJMkS0Oc=;
  b=hugIJqIcpiDM9mrA4VY/ScQfDgES3L61fNOgSf1yIXh9V8hbcvxuKEAS
   KP81t479oEc2yUxuUdAVWokjsJnkl3W3wrcfOlyOmW870+rh08Z/ppxNR
   bI3jcWTsyxO9eo3fP6VvkBcfTqzyY0DMdMJCUNvU3sTKrKNjQVlmBONT3
   4SvLMT0OrYZJWc7XqLbxH9esestAgKBlQMqfqvM1WbFuLzxJDFftwbS80
   4tg80dOeZNqkHIH7U/Eth/aWCwnCHFvTxHvEO/s1e56fpjB7GswasQTEt
   nX68LE3okYVbM47Zt4nZxaDO+icZGPxA6HTn5OZq7qLTlhCNHDlnRVkOs
   Q==;
X-CSE-ConnectionGUID: Z3Rd9rriTviUnZ5W/Uccng==
X-CSE-MsgGUID: e6IO/t5MQ3OQ/r6G4MIHEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="109758682"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="109758682"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:05:20 -0700
X-CSE-ConnectionGUID: mQZraBjHRjGVZrEGBbNmGg==
X-CSE-MsgGUID: H0OfiUyLST+jLhGSk1GNTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="266781477"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:05:20 -0700
Received: from [10.245.245.29] (unknown [10.245.245.29])
	by linux.intel.com (Postfix) with ESMTP id 2605520BF398;
	Tue, 11 Aug 2026 03:05:17 -0700 (PDT)
Message-ID: <97cd244dbc5cfa277cae55b4032505c9f0a554af.camel@linux.intel.com>
Subject: Re: [PATCH] intel_idle: Fix C6S and C10 latency values for
 Pantherlake
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rafael@kernel.org, 
	lenb@kernel.org
Cc: linux-pm@vger.kernel.org
Date: Tue, 11 Aug 2026 13:05:16 +0300
In-Reply-To: <20260811081729.186571-1-kaushlendra.kumar@intel.com>
References: <20260811081729.186571-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The current value are based on what I measured using wult/pbe tool.

I think it will be better to explain the problem and how this patch
fixes it, give some details about workload. And ideally, also provided
turbostat output when it runs in parallel with the workload before and
after this patch. Then we have can see CPU frequency and idle profile
of your workload with and without this patch.

Thanks!

On Tue, 2026-08-11 at 13:47 +0530, Kaushlendra Kumar wrote:
> Correct the values using BIOS ACPI _CST characterization data read from
> a Pantherlake device via
> /sys/devices/system/cpu/cpu0/cpuidle/stateN/{latency,residency}:
>=20
>   C6S: exit_latency 300->127, target_residency 300->381
>   C10: exit_latency 370->1048, target_residency 2500->3144
>=20
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/idle/intel_idle.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 651408df9c24..0b5c94c7cd3a 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1010,16 +1010,16 @@ static struct cpuidle_state ptl_cstates[] __initd=
ata =3D {
>  		.name =3D "C6S",
>  		.desc =3D "MWAIT 0x21",
>  		.flags =3D MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED,
> -		.exit_latency =3D 300,
> -		.target_residency =3D 300,
> +		.exit_latency =3D 127,
> +		.target_residency =3D 381,
>  		.enter =3D &intel_idle,
>  		.enter_s2idle =3D intel_idle_s2idle, },
>  	{
>  		.name =3D "C10",
>  		.desc =3D "MWAIT 0x60",
>  		.flags =3D MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
> -		.exit_latency =3D 370,
> -		.target_residency =3D 2500,
> +		.exit_latency =3D 1048,
> +		.target_residency =3D 3144,
>  		.enter =3D &intel_idle,
>  		.enter_s2idle =3D intel_idle_s2idle, },
>  	{

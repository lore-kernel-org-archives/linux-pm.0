Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F91DB92C;
	Sun, 21 Jun 2026 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077942; cv=none; b=CGSjYRdUdmfKcYnZ0PcBqARpSBGJGMjO8zLxn2CoT6dBr2Sq3C3PwRS1wN/85TFKXtUMOf/6/DNCkzwDcxlViAee4ZCbeGbmlbUBGFb61LEhqn2+ln9B1/AadIoqrsWb1VlyLZ5F42q6hfeVHTTwpwA7ckeibNsmxKS0da0B4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077942; c=relaxed/simple;
	bh=19AGkayRHXGw/ZUMIP1TvDM0OCp9hO35Ji8dT4MT7YA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+/WI6eK6wBTszm7kwm5mD4tRbGFqG1YQyfICCy1+ot1c1Y0uwrLA2cyt+1EYnhEmeIqKgJXMd3IMHU+pih+5XM/nfnLUCLXVx6iLlJkOnyPvuU3F5Pyc2nzDeD8kRm698ZHJtjqwKW+artKxB9vV3BKIqSGqYge4AmyLeDuBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRoL7QXq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRoL7QXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782077940; x=1813613940;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=19AGkayRHXGw/ZUMIP1TvDM0OCp9hO35Ji8dT4MT7YA=;
  b=KRoL7QXq3oXV5mz/odeoNyhFBmJb9fc7L+skHpVBMFoKcGkFmD+HLMEz
   HGpkNnZJODOZMF7SrMClsm7yBawmEKhkCOx+gTuD1Etgj36cQDC5RklzU
   n0nekK6pI0uELDL68aEFcsUMetMtDBpdIzRvJHI5AQ+4CR6Cj59TCOUO+
   naKG6TuNOidC3LD0x8KtFoFNunttGL3dSXnB3cT6MYRF+FijzYImHfLqy
   VCUGlwk1IZizn2bkU5yoxgpz9D5AEOObySh6177OGBFF84z+EHMOcThIi
   05nuidGQmsZJyxtEWLxAyQaBDqj2G9sYhq2Ij543ZMB3sRR95sy8vBVOj
   Q==;
X-CSE-ConnectionGUID: 50L+qaGJRqy4rz4cSJQsRw==
X-CSE-MsgGUID: Eko/0i/GQjWL1eKc+KGgbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93407621"
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="93407621"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 14:38:59 -0700
X-CSE-ConnectionGUID: YSs/k/axQTy/6WwZ/cpgjw==
X-CSE-MsgGUID: +6lVMKv5SOe2wdx40TvZSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="252970088"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 14:39:00 -0700
Message-ID: <8ca52415dcb582b821475eb4bd428846b1861054.camel@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Skip HWP_CAP reads in
 Broadwell mode
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, LKML <linux-kernel@vger.kernel.org>
Date: Sun, 21 Jun 2026 14:38:27 -0700
In-Reply-To: <12920597.O9o76ZdvQC@rafael.j.wysocki>
References: <12920597.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 21:24 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> When running in the Broadwell HWP mode, the turbo, max and min
> P-state values are retrieved from MSR_PLATFORM_INFO, so reading
> MSR_HWP_CAPABILITIES in that mode in order to update those values
> is pointless.=C2=A0 Moreover, using the MSR_HWP_CAPABILITIES value for
> updating them in the Broadwell mode may be harmful, so avoid doing
> that altogether.
>=20
> Fixes: de5bcf404ace ("cpufreq: intel_pstate: Clean up frequency
> computations")


Can't apply this patch on the latest Linux master even after applying
prior 6 patches.
What is this based on?

Thanks,
Srinivas

> Link:
> https://sashiko.dev/#/patchset/6005456.DvuYhMxLoT%40rafael.j.wysocki
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: All applicable <stable@vger.kernel.org>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A0 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1197,6 +1197,9 @@ static void intel_pstate_get_hwp_cap(str
> =C2=A0{
> =C2=A0	int scaling =3D cpu->pstate.scaling;
> =C2=A0
> +	if (hwp_mode_bdw)
> +		return;
> +
> =C2=A0	__intel_pstate_get_hwp_cap(cpu);
> =C2=A0
> =C2=A0	cpu->pstate.max_freq =3D cpu->pstate.max_pstate * scaling;
>=20
>=20
>=20

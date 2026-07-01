Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0A38E8B7;
	Wed,  1 Jul 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929337; cv=none; b=bcNsCbrAukdMBWreUmjC5smTKbSzCiJaNQXct+ZqkJPYg+uUv0z4/r06cLm1jYte7rVEga3vOMaHDXIqkbVBxCBZhR9nLAm5p+Qq3goDMV2NgxENV6CqZQlFaYOonMf8DceBT+l+KHhdDBXN68AeHT2+1qbqPmMbjKwM4gljh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929337; c=relaxed/simple;
	bh=+9nwOCjkXRXze47YIt3nqA/SNfcE1fSEaidk6kBPQp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfkEVshMwXEG4qVeAfw68h256zCrKbee6X1Pohsj05vEKDVJd9UeX9zK1I1FWqXW73rPFKURFLiRmtnWVjnQxH9DFcKZLzzAXRiS3czzJyU0bgV7dmFfCjWDuUr5ZPMrjiyUCTkuFFXWjFf+Pc67k7VkR2yXQZ6FrWd+wPg05+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLLr3MHb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLLr3MHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782929336; x=1814465336;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+9nwOCjkXRXze47YIt3nqA/SNfcE1fSEaidk6kBPQp8=;
  b=ZLLr3MHbqUF0pgG08XeE8D5SVRDzMVfFe/mEfp4JFzvSxK7A0+MDSbPd
   /JkXpqzBJctuG37ZH/zyRgsK4dADDacnOJyK9PT6GSpv/Md5BIpywboap
   5cBhSzdmUIddK4b5GozWCfFTBhy2Ke0Mm13id32VBa1b5WDjfVp9RgMz1
   MBPe6jGx6q0yl55Met6iqvxZavXUfEo7ihS06SXWNfVBB/MlFtBjhlj4n
   MIaSuhyyWcowhncAVEblGcwu3asly4pv9291FUavx840hM3m2BJzhirD4
   25O5khvIHsqiO+Wd64uom+u6NGDpLV+rW/1bChzqQ/Nch5XD2ThSWdhof
   w==;
X-CSE-ConnectionGUID: k3CFj0R7QmW+uyPiazJaUQ==
X-CSE-MsgGUID: dLpNDiDHTyOBU+tqz16T+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="109220371"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="109220371"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:08:55 -0700
X-CSE-ConnectionGUID: BulkvdMnQAGjQRsqLXR/Nw==
X-CSE-MsgGUID: OMGEBwImTBa2QEj0vlKF0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="252202662"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:08:55 -0700
Message-ID: <0878786a83120630ce4e8c601f41927e82866b16.camel@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Rearrange checks in
 hybrid_get_cost()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Wed, 01 Jul 2026 11:08:34 -0700
In-Reply-To: <2832945.mvXUDI8C0e@rafael.j.wysocki>
References: <2832945.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-17 at 19:02 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Make the checks in hybrid_get_cost() more straightforward.
>=20

Please do the same for hwp_get_cpu_scaling()=20

if (hybrid_get_cpu_type(cpu) !=3D INTEL_CPU_TYPE_ATOM)
to
if (hybrid_get_cpu_type(cpu) =3D=3D INTEL_CPU_TYPE_CORE)

Thanks,
Srinivas

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A0 8 +++-----
> =C2=A01 file changed, 3 insertions(+), 5 deletions(-)
>=20
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -979,12 +979,10 @@ static int hybrid_get_cost(struct device
> =C2=A0	 * capacity.=C2=A0 Similarly, P-cores start to be populated when
> E-cores are
> =C2=A0	 * utilized above 60% of the capacity.
> =C2=A0	 */
> -	if (hybrid_get_cpu_type(dev->id) =3D=3D INTEL_CPU_TYPE_ATOM) {
> -		if (hybrid_has_l3(dev->id)) /* E-core */
> -			*cost +=3D 1;
> -	} else { /* P-core */
> +	if (hybrid_get_cpu_type(dev->id) =3D=3D INTEL_CPU_TYPE_CORE) /*
> P-core */
> =C2=A0		*cost +=3D 2;
> -	}
> +	else if (hybrid_has_l3(dev->id)) /* E-core */
> +		*cost +=3D 1;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
>=20
>=20
>=20

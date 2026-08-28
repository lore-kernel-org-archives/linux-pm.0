Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658837F30A;
	Fri, 28 Aug 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948454; cv=none; b=E0Lcrz44erO8ctnHaR/T7HP0Vz6KOf11DkRa0i1cVHPHsjaJqnPSwPaWKjvRDdoShxk6r4oK8mDssy10GCH0BPTboy8qF65G3GxgS6WkvG7r7AZtTjUVw3yNMeGeXp6YQqOoJnR4XtDwDmEW1b5TaBoBVasXdepyf+UJbjogfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948454; c=relaxed/simple;
	bh=bazPnGr9CUSpzPBCvbgmJq1C7SIkAJqiKUpqDfueZ0w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvxwC5Myq4sRXpXSvIM63nzSJRZ8R2PWsWYwzUbARYP1IGFkHL+paFRAYiRtY0OAnlOR6PqEDuKJD0Wm0tRiWcmXF1wGK7jbUBozLTjlRTfuC4OK3Ri3HDZePYMRSi7SOSe6UzOkuDT2KSA98JUJA2iuvnBNWTDknxd+sM9Gh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKZqQgtn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKZqQgtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787948452; x=1819484452;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bazPnGr9CUSpzPBCvbgmJq1C7SIkAJqiKUpqDfueZ0w=;
  b=JKZqQgtnzJ3n14n/v1PFKMkMVHZhHXnDX1IBFrbmLuEsJAbBxHTAVJlO
   zrePbtX2L5YJnQcxO827KmLZQoJZUAIyWkVd+Au2aMu1w7iaTxcs5QIIU
   866BAY2tRhmC94Qq5x7o4Rdcs4PU20TFOkYgpSZeLDcJP4KPjKWh9XwBn
   5XAr0up7OkFJxMcpb0+S5iOgNHcsD+EIJNirFH6LTLcme/kmHNW2rrQaN
   +XDWugVGtg8o4DllCBGxrWov0sewrh2l1qAhCDz4tpcnQFvMXXGSkOO6K
   B0ClLnpC6F7T7PPOE+UqH3e1OZszH7fJm9IWDZsOcb4lu+vQbVo6rkXlu
   Q==;
X-CSE-ConnectionGUID: bHZ27yKFTQu0eXNnZvhEIw==
X-CSE-MsgGUID: DYgB61vZT0SgZWk8wjCdWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="87594740"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="87594740"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 13:20:51 -0700
X-CSE-ConnectionGUID: JpPxQgV4QEm1fsqPZwQCRA==
X-CSE-MsgGUID: HhwEg6pKQ3uSTLSSXUWd9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="272463957"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.223.143])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 13:20:51 -0700
Message-ID: <fb91525abdaa6b6955d9af96f3b16f0dbbae8e85.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel: int340x: Fix temperature selection
 around 0 C
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Thorsten Blum <blum@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,  Stanislaw
 Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Aug 2026 13:20:50 -0700
In-Reply-To: <20260826153144.299746-3-blum@kernel.org>
References: <20260826153144.299746-3-blum@kernel.org>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-26 at 17:31 +0200, Thorsten Blum wrote:
> Since commit 7251b9e8a007 ("thermal/intel: Fix intel_tcc_get_temp()
> to
> support negative CPU temperature"), intel_tcc_get_temp() can report
> negative temperatures.
>=20
> proc_thermal_get_zone_temp() still uses *temp as the current maximum
> and
> as an implicit "no reading yet" marker. However, this breaks when a
> CPU
> reports 0 C, because a subsequent negative reading can overwrite it.
>=20
> Use bool temp_valid to track whether a valid temperature has been
> read.
> Initialize *temp with the first valid reading and only update it with
> warmer readings.
>=20
> Fixes: 7251b9e8a007 ("thermal/intel: Fix intel_tcc_get_temp() to
> support negative CPU temperature")
> Cc: stable@vger.kernel.org=C2=A0# 6.3+
> Signed-off-by: Thorsten Blum <blum@kernel.org>

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0.../intel/int340x_thermal/processor_thermal_device.c=C2=A0=C2=A0 | =
10 +++++++-
> --
> =C2=A01 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index f80dbe2ca7e4..b0284c2e2e74 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -179,17 +179,21 @@ static int proc_thermal_get_zone_temp(struct
> thermal_zone_device *zone,
> =C2=A0{
> =C2=A0	int cpu;
> =C2=A0	int curr_temp, ret;
> -
> -	*temp =3D 0;
> +	bool temp_valid =3D false;
> =C2=A0
> =C2=A0	for_each_online_cpu(cpu) {
> =C2=A0		ret =3D intel_tcc_get_temp(cpu, &curr_temp, false);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> -		if (!*temp || curr_temp > *temp)
> +		if (!temp_valid || curr_temp > *temp) {
> =C2=A0			*temp =3D curr_temp;
> +			temp_valid =3D true;
> +		}
> =C2=A0	}
> =C2=A0
> +	if (!temp_valid)
> +		return -ENODATA;
> +
> =C2=A0	*temp *=3D 1000;
> =C2=A0
> =C2=A0	return 0;

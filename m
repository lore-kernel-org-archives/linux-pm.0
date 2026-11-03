Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728134;
	b=EinXI5MYaxN3pNoMUfkxkLcqb/EO5cMF31NYKgcuDqBlaWa+ZI1Uxe+3hbPptcdu/m+v
	 e/UXtkYwXHCSrLn9CrDJB9Kf1/cmrGJ1m50PK2QwCQmjmIwzteGKVHqHMduzWD0q/mZKP
	 Le5Fb7RswMkNC5ZEv7AGKoKZyorrM8eZgqb43IhSFbO/VHmkGv8B5q8gRQbr6ve6DolIS
	 MFfuNnxvcH5bywVlu8+ERIA606mFSf83qdgkRwNv/F1rVufLt+lPl56tDIutA7o8jDyW0
	 krS+Zju5EHLaNA1s36M0QoFoeP5a0ReRjZKWotMOlK07JGLXuBEpMIJPUfX3KyPoJsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728134;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=moo8zejRiQgHgFk628jCEmfEUNJpaJf/xVb51PJQqJc=;
	b=RxRZYLBiX53+vkBwkmI8nIBKTOvenz7JXwXPmOX8cpY4uTk+oaVXnqn/tB1PF7ihTMsh
	 pOfNc/GqtqUzs1C013HJm+Pz9o2eUoxl0KFLTqAeq4SBzx+MgNEpMp5zLIbNyEBoVGgaZ
	 ZHFq7ZSIV256tQ+ZRRacCNihgePstcA4+19aTKUunvAgOR16TXyNeWeE+c7iXjxGV8TL9
	 zsul1enXJxve2lobgzdJcFi+jzItdDO4EVEwfjq25bs3dfzeqkADrpNCOJcFFAL97xiA1
	 yak3eQ3t8Ea8AhRJAstsWKxlSB3R0GWI/GJv35rizsFjRKUdm+bbzKwK8cHnoLYtJqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HiCljkyF;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE90606A329;
	Tue,  3 Nov 2026 17:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE90606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HiCljkyF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793728134; x=1825264134;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=33OAVsDrhiw2qk6RLlmZwPTBrx/Bxa5xsoFfQllbkEQ=;
  b=HiCljkyFDcaDFTjZmsvVFfrsE9ptWxBN0dY3D6vJRkNav6PtZ5cm8tZ9
   wif6PIbhCYflBmgl4JVdbmr8GqFhDiK1HB9k/UNMtXMbGFguMQg7NZ4B+
   AKsX4MrH1FQrzERLVH7MxWhoBOwI/p9qZPH6SAVErylaQhv18HjW8MbLn
   yypaPX0Q06eCKoUR8N36bd9uAUwn+NSuoyBtZg89Rk7Z3yMgeysC8maom
   ALcYyWqND3OL74uLcEYRiXMv0IyTBU7PxidRKx91r1IQBZ1FYbJRlH8Ls
   nSkuK119wfBXicx18d+Gks3V0TD8K0eBvM1um6hfW1ms/8OazxwtPsf0G
   A==;
X-CSE-ConnectionGUID: pclyyO2rQ9aFqJc1881Rrg==
X-CSE-MsgGUID: F9Faf1AxRJqclELCokxp/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2475954"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2475954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:48:53 -0800
X-CSE-ConnectionGUID: oISmjo/SQhi7cHVBZze/2g==
X-CSE-MsgGUID: +NT05mLMRn6jd4P4AUgu9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6637704"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:48:52 -0800
Message-ID: <ff11511f777d1d585ea17cd36e51fc461cc4c928.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: int340x: reject changing ODVP package sizes
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kang Chen <k.chen@smail.nju.edu.cn>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>,  Lukasz Luba <lukasz.luba@arm.com>, Kaushlendra
 Kumar <kaushlendra.kumar@intel.com>, Pengpeng Hou	 <pengpeng@iscas.ac.cn>,
 Matthew Garrett <mjg59@google.com>, 	linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 09:48:52 -0800
In-Reply-To: <20261103114106.74290-1-k.chen@smail.nju.edu.cn>
References: <20261103114106.74290-1-k.chen@smail.nju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-03 at 19:41 +0800, Kang Chen wrote:
> evaluate_odvp() sizes priv->odvp from the package count returned by
> the
> first ODVP evaluation, but it never compares that cached size with
> the
> count of a later evaluation.=C2=A0 The function runs at probe time, on
> INT3400_ODVP_CHANGED notifications, and on thermal mode changes, so a
> firmware that answers with a larger package after the first call
> makes
> the fill loop write past the cached allocation.
>=20

This is not in practice but fine.

> Ignore packages whose count differs from the cached one, and reject
> counts that do not fit in the int that stores priv->odvp_count.=C2=A0 Als=
o
> reject a missing ODVP object instead of dereferencing a NULL pointer
> when the method returns no value.
>=20
Here three potential changes are clubbed together, why not split?


> Fixes: 006f006f1e5c ("thermal/int340x_thermal: Export OEM vendor
> variables")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> ---
> =C2=A0.../intel/int340x_thermal/int3400_thermal.c=C2=A0=C2=A0=C2=A0 | 18
> +++++++++++++++++-
> =C2=A01 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 5d70301d4a3d..eb899f90970e 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -377,12 +377,25 @@ static int evaluate_odvp(struct
> int3400_thermal_priv *priv)
> =C2=A0	}
> =C2=A0
> =C2=A0	obj =3D odvp.pointer;
> -	if (obj->type !=3D ACPI_TYPE_PACKAGE) {
> +	if (!obj || obj->type !=3D ACPI_TYPE_PACKAGE) {
> =C2=A0		ret =3D -EINVAL;
> =C2=A0		goto out_err;
> =C2=A0	}
> =C2=A0
> +	if (priv->odvp && priv->odvp_count !=3D obj->package.count) {
> +		dev_warn_once(&priv->pdev->dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ODVP count changed from %d to %u,
> ignoring\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->odvp_count, obj->package.count);
> +		ret =3D 0;
> +		goto out_free;
> +	}
> +
> =C2=A0	if (priv->odvp =3D=3D NULL) {
> +		if (obj->package.count > INT_MAX) {
> +			ret =3D -EINVAL;
> +			goto out_err;
> +		}
> +
> =C2=A0		priv->odvp_count =3D obj->package.count;
> =C2=A0		priv->odvp =3D kmalloc_objs(int, priv->odvp_count);
> =C2=A0		if (!priv->odvp) {
> @@ -429,6 +442,9 @@ static int evaluate_odvp(struct
> int3400_thermal_priv *priv)
> =C2=A0	kfree(obj);
> =C2=A0	return 0;
> =C2=A0
> +out_free:
> +	kfree(obj);
> +	return ret;

Instead of adding another return if you move out_free later, like
below.

> =C2=A0out_err:
> =C2=A0	cleanup_odvp(priv);

out_free:

> =C2=A0	kfree(obj);

Thanks,
Srinivas

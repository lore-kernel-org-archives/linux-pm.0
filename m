Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D103546C1;
	Mon, 22 Jun 2026 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160216; cv=none; b=JLpRf2cRgKhYrBPwKMob6Xi2btfDODDbbUAi4wYW0LXCchsTCyaBNOkvsXdaC0pem/8enGpEUkpNd9gLQJ3v2mY9zeg9kHpuwUN7p0Xhsu5B98D3Qt3v8ZdYjnRo4x+9Y2cDZELAadONco1yEYleLm4kO8L1BFPDE81A1htDkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160216; c=relaxed/simple;
	bh=EVo3w+MCyLztsp+OKJSS4dn6VYvqlUQJ9v5ad/NQIy8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYBbCX7vixXH0q8aWBbhqJ8ouPcgNIuxLMwB8jBC71SZZQ6nUqSODE+wH4PTdG3q994d+TO9lmacMtkn0+mgBPoYeKSK4LdpLHmsLzwxTrokA2x86jq/E0qsMgZpowXcUZgnWJAvWqQg8qYZ6DbSsK1JbWhX6XhHzouIaz/vaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1517bzh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1517bzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782160215; x=1813696215;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=EVo3w+MCyLztsp+OKJSS4dn6VYvqlUQJ9v5ad/NQIy8=;
  b=h1517bzhw1kBACK0c8pLGDvwUz2OSMI2FPzxMIkmdsYUkIsyi1Pm3dyy
   UrCbXaMiRzUP+4OfpWlXy6dEPK9y8uMzPBr4tkeJmXaxNLZmcMmXajM7Y
   CfHBZCwufoZJCj6olRFWi63KjRao6rs1iN6j75vCA1bdBPqtNQQEi1ZD2
   Uo52huNT3qB4U6MWI+SQWzZ+DMRhPU8zg0ulUDPEpfQIwvuYv2/+Kt58a
   KHXwZxGl8v0pkTaMUafOc6h8MUvtdEB/2cgEsBoP6FAMXrFBR7bKfGc71
   +dObjsGD3T/+nr9y36ZhMy5proPI2tziCe2dKz158dIn3wg38Xqdsgtm3
   g==;
X-CSE-ConnectionGUID: N7aeZUyETbaifCxBJnpFAQ==
X-CSE-MsgGUID: Dgb1iFUcRyyLudUOGSxrXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82902990"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82902990"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 13:30:14 -0700
X-CSE-ConnectionGUID: qulthIr4Q8WhLhWg6TbH+A==
X-CSE-MsgGUID: naxSkq9hRtmDZLmg6z/Q6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="287451984"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.85]) ([10.125.108.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 13:30:14 -0700
Message-ID: <7ff5b6742c28da965eaf0a1175cf031d8786c1aa.camel@linux.intel.com>
Subject: Re: [PATCH v2] thermal: intel: int3400: clean up ODVP files on
 probe failures
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, "Rafael J . Wysocki"
	 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
	 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, Kees Cook
 <kees@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, kernel test robot <lkp@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Jun 2026 13:30:13 -0700
In-Reply-To: <20260622153306.79258-1-pengpeng@iscas.ac.cn>
References: <20260622153306.79258-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Hou,

On Mon, 2026-06-22 at 23:33 +0800, Pengpeng Hou wrote:
> int3400_thermal_probe() creates ODVP sysfs files before several later
> probe steps can still fail.=C2=A0 The late error paths unregister the
> thermal
> zone and remove other sysfs groups, but they do not remove the ODVP
> files
> or free the ODVP attribute storage.

OK, you added a  cleanup_odvp() after thermal_zone_device_unregister().
But it will not cover thermal_tripless_zone_device_register() failure.

You could have moved cleanup_odvp() instead of copy before free_priv:


You are also adding free for data_vault. There is no description of
that. I suggest to add another change for that. Also that needs to be
done for other error case also for example when free_imok.


Thanks,
Srinivas

>=20
> Run the ODVP cleanup from the existing post-ODVP error path, and
> clear
> the saved ODVP pointers after freeing them so the cleanup remains
> safe
> when reached after the later sysfs cleanup path has already removed
> the
> files.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202606152042.8kTVDHYg-lkp@intel.com=
/
> ---
> Changes since v1:
> - Avoid adding new error labels; reuse the existing free_art_trt path
> so
> =C2=A0 W=3D1 builds do not report unused labels.
> - Clear ODVP and data_vault pointers after freeing them.
> - Free data_vault directly when bin-file creation fails.
>=20
> =C2=A0drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 7 +++++++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 66db4b1effb4..5b59634bcc2e 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -357,7 +357,9 @@ static void cleanup_odvp(struct
> int3400_thermal_priv *priv)
> =C2=A0		}
> =C2=A0		kfree(priv->odvp_attrs);
> +		priv->odvp_attrs =3D NULL;
> =C2=A0	}
> =C2=A0	kfree(priv->odvp);
> +	priv->odvp =3D NULL;
> =C2=A0	priv->odvp_count =3D 0;
> =C2=A0}
> =C2=A0
> @@ -620,6 +622,9 @@ static int int3400_thermal_probe(struct
> platform_device *pdev)
> =C2=A0	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
> =C2=A0		result =3D device_create_bin_file(&pdev->dev,
> &bin_attr_data_vault);
> -		if (result)
> +		if (result) {
> +			kfree(priv->data_vault);
> +			priv->data_vault =3D NULL;
> =C2=A0			goto free_uuid;
> +		}
> =C2=A0	}
> =C2=A0
> @@ -651,8 +656,9 @@ static int int3400_thermal_probe(struct
> platform_device *pdev)
> =C2=A0free_sysfs:
> =C2=A0	cleanup_odvp(priv);
> =C2=A0	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
> =C2=A0		device_remove_bin_file(&pdev->dev,
> &bin_attr_data_vault);
> =C2=A0		kfree(priv->data_vault);
> +		priv->data_vault =3D NULL;
> =C2=A0	}
> =C2=A0free_uuid:
> =C2=A0	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
> @@ -667,6 +674,7 @@ static int int3400_thermal_probe(struct
> platform_device *pdev)
> =C2=A0	if (!priv->rel_misc_dev_res)
> =C2=A0		acpi_thermal_rel_misc_device_remove(priv->adev-
> >handle);
> =C2=A0	thermal_zone_device_unregister(priv->thermal);
> +	cleanup_odvp(priv);
> =C2=A0free_art_trt:
> =C2=A0	kfree(priv->trts);
> =C2=A0	kfree(priv->arts);

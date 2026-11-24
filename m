Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540861;
	b=FIE8PXB32QXjeBPu3LmjC9aEhM/y4zWG+eLTCB7cj2axwCQY7TLefPR+/mLtfwpAloaV
	 MUISPRywDyWL+Itq9WLM2LSNZE6FnhH56efMzIU5i4KROhTeVSRqUPJwuvfbwo3t56d7v
	 R8VCrKuKFOflw2+JBq4MmkPC6vEqTcI3CA482JPlMzEM8mf5teLCKDqMxqHzX+27EuTXs
	 m70rKSwcUGsfKS5drb2MJY1xzKwedw3BNkS/lz0gDibuuOuOmhp2fcO2MfucnUtbQiQs/
	 vuf89ZDP/OVTmRKVVJ4H+6ezBBg1/2VtlUUj5tvdQhjair3pEndB8d72vBA1xsuwO+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540861;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=YzT/FHTacvEkqMDxOm911dRdRUZtkBMctKhjGPx65o4=;
	b=UBDxDdtZFemWvf6hnko9Bl800HfGj63uIHNLZz02BIL29g3Ihde0f6uvFeYtxJgecPaT
	 /1X23jXwwU5G99RpgJGQ6D/CDv52M5UZAOZCoQjm3oY8KAv43QnqxAI57zPtHv5spuMKd
	 JygiDE3wD+4GKpIM5rSoD85DIFxl4s+bhbhMfwAux9Vf5AAADt97mpP8Zb2VMzKB7B5dv
	 EXgmqwCE82CF93H3xkGRRw1593csUrdlZ6M9R5OGURIJL+QBjZNgyLb7pK+cDj+4QifFb
	 rVJ+ZfefOtkNl6RAD5uQ25C8Twhq2tqMGIrlgBzGAUl4Q+RblCoHJFrzvvBjc32lB3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JPXjMgvg;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91720606A321;
	Tue, 24 Nov 2026 17:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91720606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JPXjMgvg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795540860; x=1827076860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ClGuJkPW2nCOJuiFwLsWaF4Yv62LEDZ4hVCpn6VlTPk=;
  b=JPXjMgvgau86PgEF9SzhtfUKiD+emmIbKM5NSIVtMSHAzwfwNOyZ1t2b
   E6qKhONAVvJOk7kBLfsKnrRCNX9bXRlG5afn0K9ExB/iPTpnmhm/gtse6
   Rq1gDx6Ye182qRyW98v793HDUG1IBdk2gslQlnX3plzGYZH7q1YUQuuli
   NM2hEpO9G7xD8gucBwVF8/y1ILGezDnbAP9ae+F0Yy7krfv41/VkP6u+O
   5JWuGYXdKt9sTgbkauKtry6dAkIopA+31hFA4dIOFrEbJezEXzKGLTdxC
   FBW7U4zQtCoev7G0RwbJc4qpw+iXkuzHBvmsFmoS7dla5t6qO0cc+yH5u
   g==;
X-CSE-ConnectionGUID: kNMgIxHWQPKnBKZ3xkKv1g==
X-CSE-MsgGUID: gK2a6zm6Qz29uRHXz8jVLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4286960"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4286960"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:16:29 -0800
X-CSE-ConnectionGUID: CJNIMLTFSQSaiIm3fK2kTQ==
X-CSE-MsgGUID: wbKHx/rpS5ij1rpfygGZiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11404453"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:16:14 -0800
Date: Tue, 24 Nov 2026 19:16:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 2/5] ACPI: fan: Stop using driver_data pointer from
 struct acpi_device
Message-ID: <awXGWwlZo0QIFvxA@ashevche-desk.local>
References: <3985766.kQq0lBPeGt@rafael.j.wysocki>
 <6217460.MhkbZ0Pkbq@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6217460.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 04:47:12PM +0100, Rafael J. Wysocki wrote:
> 
> Instead of using the driver_data pointer under struct acpi_device,
> make the ACPI fan driver use the driver data under the dev member of
> struct acpi_device and clean it up properly on driver removal and on
> probe failures.
> 
> While at it, unify the code ordering of acpi_fan_delete_attributes()
> with the rollback path in acpi_fan_create_attributes().

...

>  static ssize_t show_fine_grain_control(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct acpi_device *acpi_dev = container_of(dev, struct acpi_device, dev);
> -	struct acpi_fan *fan = acpi_driver_data(acpi_dev);
> +	struct acpi_fan *fan = dev_get_drvdata(&acpi_dev->dev);

I'm a bit lost. Is 'dev' parameter embedded into struct acpi_device
('acpi_dev') and later we again come to it via dereferencing 'acpi_dev'?

If so, why not use 'dev' directly?

>  	return sysfs_emit(buf, "%d\n", fan->fif.fine_grain_ctrl);
>  }

...

>  void acpi_fan_delete_attributes(struct acpi_fan *fan)
>  {
>  	struct acpi_device *device = fan->adev;
> -	int i;
>  
> -	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> +	if (fan->acpi4) {

> +		int i;
>  

While at it, ...

> -	if (!fan->acpi4)
> -		return;
> +		for (i = 0; i < fan->fps_count; ++i)

...seems the local form can be used

		for (int i = 0; i < fan->fps_count; ++i)

> +			sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
>  
> -	for (i = 0; i < fan->fps_count; ++i)
> -		sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
> +		sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
> +		dev_set_drvdata(&device->dev, NULL);
> +	}
>  
> -	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
> +	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
>  }

-- 
With Best Regards,
Andy Shevchenko



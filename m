Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634955;
	b=fJ/Nt6b/YMexL4mdoVqn44I9qc6rF4OA7Zue7paR/SqPvZfBCw+/jRI6WgfoLkUA81c5
	 yMeGPD+oLEMGP9QerPMmMQCudCnWu2n2fprI4KSvzeNdZRlKnlqAqBUVvfokftIA6au0z
	 oFpZ60i6TYHaq/yxmr2/3GHr/zy+V7+Mc/ZArI2CY5PLnJo++D+zYniwEzKSfUu0NdU+v
	 h04jjoagBYktu0GbDMjoo7/jJtRIUcprBiJhPYMfia03B5XbaetT6sX35qaLzmouE1EuB
	 IJYe3QJ0rgdFX8BXsgGhQEYjYxOl4cyuA9z9HqXGtiMVdXKE6RI9IZjbH1oze+Eszqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634955;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=bG465S78Q8/lW4Mg3tWDIjt+QtTfLwOyKcpJKxn49Tk=;
	b=B9QgFi301cuOpVHGuzmmIdmBxI1WGVUBQ6vunjVO8/7aRqQxeNseAjSpBJHedrDOD/AC
	 pYIIOMDa6SEyb/epmlUWbtqvhkx7dc2KPYvjWz8bbK95DyUVtjAyERKmXG1J6IggqofLU
	 LpcA8ctgD4QaDRd+z2njWs5++O14WvdqYqFkGf3VC3jxyI3f1zJrvTaQ/dqRFAqXBx81b
	 QIp7BjY1URupZAJKHr2Yl8icfmL9DE1/HEJZX6fM2W5tIL1jM7wzLTSYQsE5Np8sDEIUK
	 67jHqYxSSzripeQdPUOH1IhQEgqydPF/FBtQnQ5n8jK0ixq5beNOnkrWpEpkK573SZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TKw+ltOR;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1203606A334;
	Wed, 25 Nov 2026 19:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1203606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TKw+ltOR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795634954; x=1827170954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1nuF2Q2avMqUMu7qmFnKwcjkUrgYZX+fEPQOlV9/Txo=;
  b=TKw+ltOR5gxl2ehwA+Qj7YKqoFcp2ovw5zXyftiUF1AQO/rSl3Qeefrt
   T+W6z0V9mBY1OFmowQ9pAoBf/ZP1GRMfKJ7kbRJ4H+HVzbDmZhqqSNpT6
   H/1ann0Ztqo89tO4ybXjUDXSYlfWJxeng5VfLi4PYr5hR1aV9omfqhgIs
   P+s4Ju/QdrAUwsLEUU4XDdDLnp5W/PkodA6wQERzQi+YuXepqOQO8UYBI
   z0LygJX96ez2tOWtogOClf751vBaZe6Vff1T4CY3r/EU3fpGuKLBfSOUL
   lHThJSycJfDerlLMxmtVfOzr6P2PG2kksnjcaL4u8bjkGrSRqIBHAn0fl
   Q==;
X-CSE-ConnectionGUID: k1s4srUXRYi2oMS5qVmR3g==
X-CSE-MsgGUID: L34hjAsXQT+CS3cXPNxZRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4371189"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4371189"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:19:03 -0800
X-CSE-ConnectionGUID: y8kuCzRRQ0aaG3QenuwSOA==
X-CSE-MsgGUID: LJs0ws3vTK6Ft3mjXOD13Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11910486"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:19:02 -0800
Date: Wed, 25 Nov 2026 19:19:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v2 1/5] ACPI: fan: Pass struct acpi_fan pointers to
 functions
Message-ID: <awcYhE0hvgBQMT6_@ashevche-desk.local>
References: <2859850.mvXUDI8C0e@rafael.j.wysocki>
 <1976174.tdWV9SEqCh@rafael.j.wysocki>
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
In-Reply-To: <1976174.tdWV9SEqCh@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 03:07:24PM +0100, Rafael J. Wysocki wrote:
> 
> Pass a struct acpi_fan pointer as an argument to several functions in
> the ACPI fan driver either instead of or in addition to a struct
> acpi_device or a struct device pointer.
> 
> This allows acpi_driver_data() usage to be reduced and some other
> simplifications to be made.
> 
> No intentional functional impact.

...

> -static int acpi_fan_get_fps(struct device *dev, struct acpi_device *device)
> +static int acpi_fan_get_fps(struct acpi_fan *fan, struct device *dev,
> +			    struct acpi_device *device)

Hmm... Can't we derive 'device' from 'fan' as you done elsewhere?

...

> -static int acpi_fan_dsm_init(struct device *dev)
> +static int acpi_fan_dsm_init(struct acpi_fan *fan, struct device *dev)
>  {

Now 'dev' is used solely for dev_info() call AFAICS. Hence when you move to
acpi_handle_info() this parameter can be killed I assume.

>  	union acpi_object dummy = {
>  		.package = {

>  			.elements = NULL,
>  		},
>  	};
> -	struct acpi_fan *fan = dev_get_drvdata(dev);
>  	acpi_handle fan_handle = fan->adev->handle;

-- 
With Best Regards,
Andy Shevchenko



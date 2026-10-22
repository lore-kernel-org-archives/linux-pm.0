Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651999;
	b=qbeMP3nDHXdBrkzjfj/YlKJHXZcj03pUCMGZHMAZe5J45JrJ6B8P4Jt9Wff8sX8gzOA0
	 Thkm0v+BHiAPo3JjqeUUBvhx4PYbWPjCIwYwMY+QSIY8Z6Yu9qiXJP/I9pQTShxm9jKNi
	 1zjGdX+xwMxnC2IFCIAXo6XaHrjo9pzrLBihzh36burZ3sIZowfr9QWYJVU4SArDPZmT1
	 bbbPu47fZjcxEo+IvSH+eVPnr6nRGLbRUdqdIo7PpJDmj/GmNv2rlDmDYHPV3cfEzfaMb
	 oA6OEdvHjw6LX6AVMPYk35zxglKSFZasv3F9JwDJMlX468EK0g7GpuBLTy4l4A4PCyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651999;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Woi0zVVwD4RBucvIBAI/fMk7ZEVPdtNqK2Lj0ao/leE=;
	b=E3H8nUCI/kvF87EkFLpHNUwscV49xMbpWkTPi1vhFzblmjX07vAHvgVoUNDwZq/ChY5U
	 BV4N1NGjytA0O+jDnyufQkocJD+ckCkhaFQFpmXoPePzmLntU9BhjGHrS+TjVXo3Rz9qk
	 cXoUzCosOEYRyBC+6H9AxWFGKXSrWkyMFpYVtSSVBx4gvgzYr/ahKqVEMx02xriF2wX7f
	 EuzEs3VJ6hHQvG9WK4CAqJ5vN+2rywtfE8hJOShDkytxnSs7cjMJ92yQ4XVOwqkfh+4lb
	 39s3nCE0lxtazd+RTVpPPxA2kxqugi2mSZK25QDykDChJRlcIMs8NDrPPDDCOmOF6Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QNKsPr6o;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D0606A31F;
	Thu, 22 Oct 2026 06:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E2D0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QNKsPr6o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792651998; x=1824187998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RI9d/TzAUe8RKg6whdtcvwhHfogEjQjL8k3I2jZhr3s=;
  b=QNKsPr6o+SDZT7JKbrPOyW5SB6agJ0giQZXVMfWIpiMQQ6gpJjSsHgvc
   TlaBsWDaGaW5/nNHmugdtEcOoPPjfMmNQHN2LZ7AkfPuX4op90vkI+d2o
   yDJsE+NwnX24S6HXUNNCmfAm2ZwKDEFHqU3luPfWtzsJzP/22bFK4Nabi
   ZpwXAqK+eVvyJpdSXvPX0V78WArB6+xo0zz9zu+zqhukt/brVxRqL25e1
   HjdZ2/dA5kCAvASceY64NqwMEj8/tsImlsO3xDLngHyGsNrGeYxvDZ7Yr
   a0rykFYnKZG8+VYddgbqxakUDqVbSu2T9qIIbZx5lGf6FOxYZxKw3ddBD
   w==;
X-CSE-ConnectionGUID: I+1l95HoT/aOJ+r1oTkUzg==
X-CSE-MsgGUID: RkJ1PIWbRWWgTFAUvxQLsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1291354"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1291354"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 23:53:18 -0700
X-CSE-ConnectionGUID: P/dk2juARSeGF8fMNt6Kqg==
X-CSE-MsgGUID: x6X5Hk0cSKKR1uWHfyDRTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3682317"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 23:53:15 -0700
Date: Thu, 22 Oct 2026 09:53:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] iio: accel: fxls8962af: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <atmy2Db_DlLUuOeC@ashevche-desk.local>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <20261021165858.v2.1.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
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
In-Reply-To: <20261021165858.v2.1.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 04:57:02PM -0700, Brian Norris wrote:
> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify this driver to simply discard the
> pm_runtime_put_autosuspend() return value, and inline the
> fxls8962af_power_off/on() helpers to their callsites, as they're even
> more trivial now.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").

...

> static int fxls8962af_get_out(struct fxls8962af_data *data,

>  
>  	is_active = fxls8962af_is_active(data);

>  	if (!is_active) {

Why do we have this check at all?

> -		ret = fxls8962af_power_on(data);
> -		if (ret)
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to power on: %d\n", ret);
>  			return ret;
> +		}
>  	}
>  
>  	ret = regmap_bulk_read(data->regmap, chan->address,
>  			       &raw_val, sizeof(data->lower_thres));
>  
>  	if (!is_active)
> -		fxls8962af_power_off(data);
> +		pm_runtime_put_autosuspend(dev);

If it's active my understanding that runtime PM keeps device already resumed,
so these two will be just a reference counting calls, no?

-- 
With Best Regards,
Andy Shevchenko



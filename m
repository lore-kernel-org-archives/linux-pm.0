Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652357;
	b=2FQy6nuThpDDXbEImZEzinG7ZfO11v4qArrJWeAVD00qdmchO76vNkU6Ky5X88dohGFi
	 6nX5QQRzw1nnqqG13fxYW+1JGEWfrfTh6ESVTywBhMrQHnQfyCGOIS5e2dvALHix5ydC3
	 YJnzFrAw9kU43uuA1I2dpL+SVrOWhrdIEHP5I0ic2lFVH9nhebeMXBkiza9L++PmQm6HB
	 DujLDQYYywMMMHPouWUYh1+I7x+P9DgxIVu+N6Kc1aE3HQwsKDWV8CnTmZbBrOnpUxhYU
	 A/XIYSbkYZQE5m8JIL6w/wehQYnSQSHJSDl8JLKR7H5nvjP/qRz2aismpeh1GnlIxWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652357;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=A2v0UyZLrL0FvCelp3xxh8E2yhouhyinnzcUd/OTtsM=;
	b=ym0Dn9HAumS2DSuwb1l5N3SIVZZA0UAyGxqBIFFqxJ78WZMMLZtUJuZvIemnnTJ71WGk
	 MrUjNWDwqCdZ60GcUi1yvSQXNhEj2hwUQTQdPuwmwfrnFaDmzVZuXP3TaJZtibGrPrhU6
	 BQ4Ih8jzIQSq0O/tz1PrtVCgTzWHM/sGuJ2sNYFasmykBlK2UohroPzEg8FNPrsuigy2n
	 mmphOudwPwm6qHK6ebwuMbiLOnhMGjEYSrQ4qCtMexFdGsteWEvp2oB18Qx8YcbQNjE2Q
	 QZUMFrjR9e/bNi8nZWKV9tW0B7aZgc9MO8n6a+rj1/Qf7K7UmOzzCNp0BAVlT/XXZ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l6Fp6cZc;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E18606A319;
	Thu, 22 Oct 2026 06:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E18606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l6Fp6cZc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792652357; x=1824188357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uaxQzhw7nU91HZ63N2v0J7ZNjT2kjXjlHg0x8yYroP0=;
  b=l6Fp6cZcdhTBRm8f5eO2mhaEp3hvp38OayYWM2Jp09JgqC+FK1mU98rd
   J4OG7xBw9hNR1w5bv/4Na8BI3TfbZiPT/7Q8iIACRN0HVmYEKkZWEVdNL
   sLfM3uLtvnwfX0AbyQBW6fdACTvo+qLwxpePTooeoS24nYZeLWuYeShmZ
   0GVFwhus2srgP5QVKahMuT24D1XvsZ36BAJOe3K61yNuYPexzX2VcBEoB
   zd31efHXT3v5bAJewoeJmgvG07pe8rXc7OsATAvfrOks6T4zA5r9fSi5p
   SOAnTqFSmyNU1xQRjSj9iS6rQ5TZnpQk+gKtV4sjH7Yp3o86jyxN/2Ule
   w==;
X-CSE-ConnectionGUID: 2jUG1UaITV2x6SkH2FVKKg==
X-CSE-MsgGUID: sOphSEG4T3eZvoudpLcrig==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1397782"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1397782"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 23:59:16 -0700
X-CSE-ConnectionGUID: foGnZhXYSiW2zSl4eblvtw==
X-CSE-MsgGUID: T47D7lz+QhGW4Ns1SfpWng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3639674"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 23:59:13 -0700
Date: Thu, 22 Oct 2026 09:59:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/17] iio: accel: mma8452: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <atm0P1iD3e4Qmtv2@ashevche-desk.local>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <20261021165858.v2.3.I0ce530b298f72acf4015d898d8b2aaee89482b8e@changeid>
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
In-Reply-To: <20261021165858.v2.3.I0ce530b298f72acf4015d898d8b2aaee89482b8e@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 04:57:04PM -0700, Brian Norris wrote:
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
> pm_runtime_put_autosuspend() return value, and inline the pm_runtime
> helper, since the behavior is the same with and without CONFIG_PM.
> 
> While I'm at it: I see that mma8452_data_rdy_trigger_set_state() and
> mma8452_write_event_config() mismanage the runtime PM reference count,
> and instead rely on (racy) autosuspend delay for correct ordering.
> Undo this choice, and instead properly drop the reference count only
> after we're done touching the hardware.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").

...

> static int mma8452_read(struct mma8452_data *data, __be16 buf[3])

> -	ret = mma8452_set_runtime_pm_state(data->client, true);
> -	if (ret)
> +	ret = pm_runtime_resume_and_get(&data->client->dev);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "failed to resume: %d\n", ret);
>  		return ret;
> +	}
>  
>  	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
>  					    3 * sizeof(__be16), (u8 *)buf);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, false);
> +	pm_runtime_put_autosuspend(&data->client->dev);
>  
> -	return ret;
> +	return 0;

Now it can use PM_RUNTIME_ACQUIRE*(), no?

>  }

-- 
With Best Regards,
Andy Shevchenko



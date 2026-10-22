Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652290;
	b=G2jS8xpHbpbx/1juNfaSlHGAnKvu/jGaNEJza4bJFbTRNyaeEk6PpoYHIMoRAgNCiMAa
	 4Cy/NFPW9nMgVucuuq8aaS9aVkSGAPDYyi9+jbuoiACe1rWs+C4FZYKBtMOAeFQHkiEmK
	 0Ga+/HxJNbSokrxP1ZhFkS+bp2qIHz97j5NjwHILaqr0GhzLGFKmy2n9fFznYhN34VAka
	 YgImufQh7KI/8VAqp1jbBCuJKz+vqc7TKQOw4276sP9zX7vey5ob/bdkSHewQxPPknPJx
	 LwHfHkM4aawB5iAMW4QPW4wIgAhAcibhSNcKfOuDkLeYbQ+ZfMvhC3DB8QHfll4toJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652290;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RKs0dWzihLAXYEvFhNTTpxNYLKS33Mg7XOKIJRa07ZM=;
	b=IYIk6NLnqae3mOF2rD/ILjIfDoXM4WGbcXsG3J8mMHAx8NoR8ND7BzsZrLvhjFfUJzzQ
	 5EdAwLkjzdokyB6z7s+vsrdi+H+gzwRXx4J0Qhs7BOiNCuXVUHJDww+hlnoMi7JN96P3U
	 p8Z4zQXIHtmhrouZnORBiuQ8H0jOcj2fMTkcxyphWWRRpeE4Grw+nAUHRvK+u8NjyT8CR
	 EaA7Rm0mZkWyFh3AXWsGvSVfzVm+VxI9QC7Zh9T4EuMPi7V6FxLQ2M2/iEKKXMH58xl2Y
	 0hSUn9pSVRH4Cc/nxgyLHNAXmlBHTwCBNf65as6Rav4QezEjTPsCDrcNupktAcrbOFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FPQg3nW4;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E019606A31B;
	Thu, 22 Oct 2026 06:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E019606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FPQg3nW4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792652289; x=1824188289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZdsYx0Ym/cDqcGGx3hBqpWXmCSCDouANqaIanoOkWMI=;
  b=FPQg3nW4etLxTndIIYiT3LYGNN9+xdllJTfhxDGgP/fbhsPDvRuBoUXp
   4qkQdpmPSmRlhRU7JK/RFXr5sB0fJUZwUdbrpFKo+RhE1tGEriMJqezKw
   IfkUnGRK1TxEekPyG5pDnyzRTNQAgPZhZzP/EnOM7+o+ASgC/S+oYqVDf
   K2oGMuEcGERutjpaREfSex352KIsGHitRwVap7B4Hcou1tGj5X0FEq7g7
   7sMtCgUUBqIrYaoQJtBBWi6pz3npTtE2oLnCj4s0CY/N1n4lahTiEh5mL
   9o4Pts/sIyvjzfiHO/hAWwYvvFgWbY6So+hvxgrd1DLOO0VkpazECheg7
   Q==;
X-CSE-ConnectionGUID: z8cQSnRrSsqt8ts6BpRZFQ==
X-CSE-MsgGUID: 2/alkE0YTy+3ibm4ZZ3dXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1278808"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1278808"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 23:58:08 -0700
X-CSE-ConnectionGUID: 98dLheWERcivGOR33UCG+Q==
X-CSE-MsgGUID: V/bZWcSPRGGsDAuKncMXig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3236159"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 23:58:06 -0700
Date: Thu, 22 Oct 2026 09:58:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/17] iio: accel: kxcjk-1013: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <atmz-hnX1-skp7Km@ashevche-desk.local>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <20261021165858.v2.2.I7751f8c9dde6f4a576a17dcfa13a4c729fa748b4@changeid>
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
In-Reply-To: <20261021165858.v2.2.I7751f8c9dde6f4a576a17dcfa13a4c729fa748b4@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 04:57:03PM -0700, Brian Norris wrote:
> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify this driver to discard the
> pm_runtime_put_autosuspend() return value, and inline these pm_runtime
> calls for simplicity.
> 
> While doing this, it becomes obvious that kxcjk1013_write_event_config()
> and kxcjk1013_data_rdy_trigger_set_state() are intentionally mismanaging
> runtime PM reference counts and instead are relying on (racy)
> autosuspend delay for correct ordering. Undo this choice, and instead
> properly drop the reference count only after we're done touching the
> hardware.
> 
> Use guard() for managing the mutex in kxcjk1013_write_event_config(),
> because it helps simplify the above refactoring, making it less
> error-prone.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").

...

> static int kxcjk1013_read_raw(struct iio_dev *indio_dev,

>  		else {
> -			ret = kxcjk1013_set_power_state(data, true);
> +			ret = pm_runtime_resume_and_get(&data->client->dev);
>  			if (ret < 0) {
> +				dev_err(&data->client->dev,
> +					"failed to resume: %d\n", ret);
>  				mutex_unlock(&data->mutex);
>  				return ret;
>  			}
>  			ret = kxcjk1013_get_acc_reg(data, chan->scan_index);
>  			if (ret < 0) {
> -				kxcjk1013_set_power_state(data, false);
> +				pm_runtime_put_autosuspend(&data->client->dev);
>  				mutex_unlock(&data->mutex);
>  				return ret;
>  			}
>  			*val = sign_extend32(ret >> chan->scan_type.shift,
>  					     chan->scan_type.realbits - 1);
> -			ret = kxcjk1013_set_power_state(data, false);
> +			pm_runtime_put_autosuspend(&data->client->dev);

So, now you can use on of PM_RUNTIME_ACQUIRE*() and drop unneeded calls?
And why not using guard()() or scoped_guard() here for mutex lock?

>  		}

...

> +	if (state) {
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "failed to resume: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		ret = kxcjk1013_setup_interrupt(data, true,
> +						data->motion_trig != trig);
> +		if (ret < 0) {
> +			pm_runtime_put_autosuspend(&data->client->dev);
> +			return ret;
> +		}
> +	} else {
> +		ret = kxcjk1013_setup_interrupt(data, false,
> +						data->motion_trig != trig);
> +		if (ret < 0)
> +			return ret;
> +
> +		pm_runtime_put_autosuspend(&data->client->dev);
>  	}

Sounds like a dup code, can't we have PM runtime calls along with
kxcjk1013_setup_interrupt() be provided as two helpers and be called
as necessary?

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA926A1A7;
	Wed, 10 Jun 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101248; cv=none; b=fcvPNedIy55vHFRmSTpHlLteEOMqj+yE0z3bsZb5vdbLVk+5rlSxx4aWcNUYyYaO6FfxPzKfGUmLfPsXVdA2Tib6MHngGDb6F9wlulUzuTxAy3+27uxJ9TaPdj1mnj2vLCvZRc0cTTE/WpZvXfFTCbbeK88/AiWIZjyE36r7Z2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101248; c=relaxed/simple;
	bh=SSfdvGJ95M79HPR7Rt+qyNUmSfnZ+9rC3nohuvkXv/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQPSK4R30vShXf/p0t7x8o7q9wTs/d/p/ZcBcVRfLuqnspC00Xj+wgVxDeoew5VvkPPaNASmrI06BDcVmSX63myfuC5j2q8YAcpcdgy7lALa0yday7Lk0iP9Hnh4PXTR/6tE0iNqZz23llrzSYlJfuy9nihcZB3XwV6aDm9sX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFBlZdnP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFBlZdnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781101247; x=1812637247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SSfdvGJ95M79HPR7Rt+qyNUmSfnZ+9rC3nohuvkXv/U=;
  b=mFBlZdnPuaxg5Nz3LucM29TVsBxRc3lQtrsFw9LOg5ZEWkzzuAbb9QyH
   QVp0Q/q/wPgdsptp5riyF9XMfn3qAWIPB+dQFNlbS377bJXHXp1mVTmGK
   1f1/56lQuYJtwsikp+X7JdH+dGFPlWJCIiCOzUWJGwotfh5fdBGukMIVQ
   ISjsE8366DRTE+WngCJoIbeLrauwiLPMUQALe1a56qaTvhPs7qe3d+qgP
   SZJ+l+JirczLRalcW2LzvdjLSs6dPCUOhf504LwMfhwC/zsfIWeBo8nR9
   Hz7aj2hvltJSo5tRT3siumDxK4WuJ+rrCd1kkmPyrLrRbrPiXgtsZiM0C
   w==;
X-CSE-ConnectionGUID: 3ZAKxBI9TpaMGs+Z9HcGGA==
X-CSE-MsgGUID: P4m3AN50Sqy9EtrhyWMLsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="82004238"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="82004238"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:20:46 -0700
X-CSE-ConnectionGUID: DIH6p4zGTWGAJtG8z8Ek8Q==
X-CSE-MsgGUID: RvpnyJBWQpKGe5LiDKyd+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251095296"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:20:41 -0700
Date: Wed, 10 Jun 2026 17:20:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2 04/16] usb: hub: Return actual error from
 hub_configure() in hub_probe()
Message-ID: <ailytpKQcvYTUH7j@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-5-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610084053.2059858-5-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:40:38PM +0800, Chen-Yu Tsai wrote:
> The addition of power sequencing descriptor handling in the USB hub code
> requires dealing with deferred probing from pwrseq_get(). The power
> sequencing provider may not yet be available when the USB hub probes.
> 
> Return the actual error code from hub_configure() when it fails, so that
> the driver core can notice the deferred probe request.

Makes sense to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One nit-pick, though.

...

> -	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0) {
> +	ret = hub_configure(hub, &desc->endpoint[0].desc);
> +	if (ret >= 0) {
>  		onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
>  
>  		return 0;
>  	}
>  
>  	hub_disconnect(intf);
> -	return -ENODEV;
> +	return ret;

Can we convert to regular pattern, id est checking for errors first?

	ret = hub_configure(hub, &desc->endpoint[0].desc);
	if (ret < 0) {
		hub_disconnect(intf);
		return ret;
	}

	onboard_dev_create_pdevs(hdev, &hub->onboard_devs);

	return 0;

-- 
With Best Regards,
Andy Shevchenko



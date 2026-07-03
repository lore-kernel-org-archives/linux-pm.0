Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47583D332B;
	Fri,  3 Jul 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083437; cv=none; b=eAaYrnN7gakeF8+kCt2wHvRaSm3iUYKsvBoGzyVFKauNWHWbbQKd+eRSdORfTEb9PL+/SjzvC45qpwehK4xL+bJiz+DxDzz+QRwom80iCQ4TSvv/W4yb0ELbraZ7le+s9D1ip4hvjQHv+qG6pDFuh/z0Qvp4xW2xQKgBmyIGsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083437; c=relaxed/simple;
	bh=QqusrYjfaWkybx2fPqLba4i2Sxky75V7VYsL+SP5Rao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMarzJ8otAlwJWSu7K6mqWawb6XKIl/jKNlFyqgWtdi7KBiKewih+Et9X2ewu0XeO7OyQxW9LfavIW2/e/4oWaIAfr4fijubUFI5U9LygA5ht+xNU8bKqD219QpJV9ekaxC8ARzX2UEeuK5cHFDd/h9pXQvRLJpwzWDXMXRfOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9WgF8qB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9WgF8qB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783083436; x=1814619436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QqusrYjfaWkybx2fPqLba4i2Sxky75V7VYsL+SP5Rao=;
  b=C9WgF8qBwimsPgS7RFYacJ7qDIvjYcAumsvwUt2E3dL8C0IR5FrnwO6k
   h3hwEAa8mqtfZV4Yvv56/5VXyzM8DjuWIMN7cLoDUK4Ir4XkPIK986oY4
   0hqYWWdAwqe9hWalreKcx+NDbSXbeyDmjBaPGZI8GdoYRTKQ5SPOCcsZ5
   ziXaChl39+pewhJOE05++GWoK/C0sljwyz6M9AzfaqNvtkJEd+hCBG2tM
   IrajRyUYsr8YXvZLEtWB7mP35lnKblv8OR+trf15CpfRQ6GByeKINfDmD
   TDIw59BK3hZmxqo+iu25y/kWLqoZxLNiduPi3mLkE0U8wqt0iYA0yR73D
   w==;
X-CSE-ConnectionGUID: ciwhOnLJT/aqTZ6nVAgSmQ==
X-CSE-MsgGUID: +OuxMwGXSkG5MkkBgAHf8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83819180"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83819180"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:57:16 -0700
X-CSE-ConnectionGUID: fWi3FGauSZCt5t0+ix7MsA==
X-CSE-MsgGUID: zg506o79Sd21UCgCUHNsyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="277436452"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:57:10 -0700
Date: Fri, 3 Jul 2026 15:57:08 +0300
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
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 10/13] power: sequencing: pcie-m2: support matching on
 remote "port" node
Message-ID: <akexpAPFMD4zNlvx@ashevche-desk.local>
References: <20260703110317.1283411-1-wenst@chromium.org>
 <20260703110317.1283411-11-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703110317.1283411-11-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 07:03:11PM +0800, Chen-Yu Tsai wrote:
> A USB hub can have multiple ports, and this driver needs to
> differentiate which port is being matched to. The USB hub driver now
> associates the "port" node with the usb_port device, so here we can
> use the remote "port" node to check for a match. Then fall back to
> the remote device node for the other connection types.
> 
> Also rewrite the existing "remote == dev_of_node(dev)" with
> device_match_of_node() for consistency.

...

>  	for_each_endpoint_of_node(ctx->of_node, endpoint) {
> +		/* USB port devices are tied to the port nodes. */
> +		struct device_node *remote_port __free(device_node) =
> +				of_graph_get_remote_port(endpoint);
> +
> +		if (remote_port && device_match_of_node(dev, remote_port))

Dup NULL check. _match_of_node() already does that and it seems follows
the same logic here. So dropping it should not change how it functions.

> +			return PWRSEQ_MATCH_OK;
> +
> +		/* Try the remote port parent for other types. */
>  		struct device_node *remote __free(device_node) =
>  				of_graph_get_remote_port_parent(endpoint);
> -		if (remote && (remote == dev_of_node(dev)))
> +
> +		if (remote && device_match_of_node(dev, remote))

Ditto.

>  			return PWRSEQ_MATCH_OK;
>  	}

-- 
With Best Regards,
Andy Shevchenko



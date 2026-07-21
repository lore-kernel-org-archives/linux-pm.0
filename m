Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE147B431;
	Tue, 21 Jul 2026 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629188; cv=none; b=YCBayxRZM8ff96kGaM2M/t2szYBfP2H8CiC1wQTocUeSPHDZLY3/CkHLw6DGAV51+zEEaNKt0u/uNDrk0xdO862j1INrK7SFj0G0VHYebEtoec6sHGhJ4asoPaQHpfKSK4FqLP3HYhXagL3g1XwOcHy06FyqvEBxpe2lTKFvHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629188; c=relaxed/simple;
	bh=F7PPeOpKbYFmNXZJaRImknjDFrLgvv/OQHLCHRkcXGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqES4OPFH5yaYWG9cYuKF9KqvyDUKRHZEY8rSRQkY3zo7zeBDJwuusvoBD3ILRPjaw+l95zzYUnFOZmU99Z66QUejX0cezk1MoTjvMhte+BgRMcqrBGAk21ezjPjIwDFmMKweidb6H/dLt98A2Gd8sYB0Tf1IJwhpeosJ4A0lMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NErrUrnb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NErrUrnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784629186; x=1816165186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F7PPeOpKbYFmNXZJaRImknjDFrLgvv/OQHLCHRkcXGA=;
  b=NErrUrnbjatdw8zM4lZTZ/5v9YPCoES7Umsx0xBXUCqwwYZy0CyX22n0
   wzRBH/tfNykwZMEV2VEUZgBCj/n5UVjEyz7oNtZPWW2sfQBvq3b7PzarI
   Uz+AIBBhZH4w8fPyinkE1nGHEz3BJgqW8xjQ5rhNNhWDeVOE/JE/+qhqN
   kTrqsSpIaI3FRW2OEHBq5/WZuXqqS6IJKtyWyznLUtEAJmfgRjd5kf1Y4
   NlcV5H4BrrdjUj8zoaRq+Ftuw09PI5Deu1KA73O2p8QSgNCy5+7u7RlzK
   Wbs0ufUr9xJnimKXzxzj7ribhYKUAxW+qgj62NiDFRClkl9QZ9uNlhSe5
   w==;
X-CSE-ConnectionGUID: QipOHEB5Qb6eH6Ul7Y9TaQ==
X-CSE-MsgGUID: /KNiHUPvRW2VagIJbFoApw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89049335"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="89049335"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:19:46 -0700
X-CSE-ConnectionGUID: xGIYhQvgTX23d/aVtYp7Mg==
X-CSE-MsgGUID: b3v5AhudQHGxvG0SSyS61A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="255938275"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:19:40 -0700
Date: Tue, 21 Jul 2026 13:19:38 +0300
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
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 10/16] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
Message-ID: <al9Hugh1LrCTn0du@ashevche-desk.local>
References: <20260721065413.2306137-1-wenst@chromium.org>
 <20260721065413.2306137-11-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721065413.2306137-11-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 02:54:05PM +0800, Chen-Yu Tsai wrote:
> The new M.2 E-key connector can have a USB connection. For the USB device
> on this connector to work, its power must be enabled and the W_DISABLE2#
> signal deasserted. The connector driver handles this and provides a
> toggle over the power sequencing API.
> 
> This feature currently only supports a directly connected (no mux in
> between) M.2 E-key connector. Existing USB connector types are not
> covered. The USB A connector was recently added to the onboard devices
> driver. USB B connectors have historically been managed by the USB
> gadget or dual-role device controller drivers. USB C connectors are
> handled by TCPM drivers.
> 
> The power sequencing API does not know whether a power sequence provider
> is not needed or not available yet, so we only request it for connectors
> that we know need it, which at this time is just the E-key connector.
> 
> On the USB side, the port firmware node (if present) is tied to the
> usb_port device. This device is used to acquire the power sequencing
> descriptor. This allows the provider to tell the different ports on one
> hub apart.
> 
> This feature is not implemented in the onboard USB devices driver. The
> power sequencing API expects the consumer device to make the request,
> but there is no device node to instantiate a platform device to tie
> the driver to. The connector is not a child node of the USB host or
> hub, and the graph connection is from a USB port to the connector.
> And the connector itself already has a driver.
> 
> Power sequencing is not directly enabled in the connector driver as
> that would completely decouple the timing of it from the USB subsystem.
> It would not be possible for the USB subsystem to toggle the power
> for a power cycle or to disable the port.
> 
> Sashiko mentions possible use-after-free of hub->ports from the sysfs
> callbacks. This is actually not possible, since the sysfs callbacks
> acquire the hub device and its lock, and then check if it is in the
> process of disconnect / removal. If it is, then the callbacks just
> error out.

...

> static inline bool hub_is_port_power_switchable(struct usb_hub *hub)

>  	if (!hub)
>  		return false;
>  	hcs = hub->descriptor->wHubCharacteristics;
> -	return (le16_to_cpu(hcs) & HUB_CHAR_LPSM) < HUB_CHAR_NO_LPSM;
> +	if ((le16_to_cpu(hcs) & HUB_CHAR_LPSM) < HUB_CHAR_NO_LPSM)
> +		return true;

> +	/* check for controllable external power sequencers */
> +	for (unsigned int i = 0; i < hub->hdev->maxchild; i++)
> +		if (hub->ports[i] && hub->ports[i]->pwrseq)
> +			return true;

Missing {}.

> +	return false;

-- 
With Best Regards,
Andy Shevchenko



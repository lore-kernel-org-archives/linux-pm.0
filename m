Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155232B9A1;
	Wed, 10 Jun 2026 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101925; cv=none; b=kdl2N3Fl1yji3zP41T2TM+/Uuo/hKQd2UewRosZRyGpHWp8GV/nv0w5XhRFHxQMP+P/9Sf+7eV+BhDKyRzSEVD8hKBtsHQKyWbB9/Vv5d6ZPSzXQjWtvb5KZ1yu1nV4tpRCzawjbegyf/JAJcNtxzGtRZXJaDtXGeAw+g6tVI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101925; c=relaxed/simple;
	bh=TE2NBpz4e7/8/JNrsJ+jLCydcPyeueKbxIt/0ak6lWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=st9GBTkEekC5Rd6DkUY/fZxuQnMC+ScQQuXbK1ONZ40PbcuWl2s7DIkLBNJ6b1j7SBsBXO0raD5sOycQmZ4t4UPFS3E/BSv7mCRPu6vNUuAhpmk2POk3j75XybrUt639zSBD+8JHtuP6ubUXXSUgREPqTSk7RFb16JF0s10tNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vp1sREQa; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vp1sREQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781101924; x=1812637924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TE2NBpz4e7/8/JNrsJ+jLCydcPyeueKbxIt/0ak6lWg=;
  b=Vp1sREQaPKQUizyNnzB0K/1sR40n5tyO2uZzxS2mvPvByr7EsPCwntdO
   vvVkm8yRtey7i0Yvx3/7YS/sOZ+7G9zE7Eyg1Qb8MhD9xU/3dBghrCzrK
   4c8NIw0Zm5pwyYAkS7NRUaWSpQsYGH+nhz58la4TZA9tCSBmijzmjUJGM
   VOFxKk7VQikKZCLT4ezWv8QkwkuGj70nZphKDVYPVXAWk/7YVw63ZLpov
   pWB4m42L2yrHmESXabqYlfhvpv/9PKL6uoA6yfKr4Q7Kvy4iQol+8cpHv
   VCG4ChSTOoSxWhC78jKQ+c8eXavNL/l/2WUW1bonSyRQrurSrcp4c9x5B
   w==;
X-CSE-ConnectionGUID: 52+MJ6rwT4aNPAE/Duf+LA==
X-CSE-MsgGUID: I6Fda/K4R2W/i8WCWwJHaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81025831"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81025831"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:32:03 -0700
X-CSE-ConnectionGUID: K9g6FQwnS+qDRNOjV2yavg==
X-CSE-MsgGUID: TgOSRGQ9QAi/6+QvT0ZrdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="269868091"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:31:58 -0700
Date: Wed, 10 Jun 2026 17:31:56 +0300
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
Subject: Re: [PATCH v2 07/16] usb: hub: Power on connected M.2 E-key
 connectors
Message-ID: <ail1XLTIkU7YVvs1@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610084053.2059858-8-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:40:41PM +0800, Chen-Yu Tsai wrote:
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
> This change depends on another change to make the power sequencing
> framework bool instead of tristate. The USB core and hub driver are
> bool, so if the power sequencing framework is built as a module, the
> kernel will fail to link.

>  int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
>  			   int port1, bool set)
>  {
> -	int ret;
> +	struct usb_port *pwrseq_port = hub->ports[port1 - 1];
> +	int ret = 0;

Don't touch ret here. It's easier to maintain when assignment is closer to it's
first user (because it's getting validated there).

> +	/* non-SuperSpeed USB port holds pwrseq descriptor reference. */
> +	if (hub->ports[port1 - 1]->is_superspeed && hub->ports[port1 - 1]->peer)
> +		pwrseq_port = hub->ports[port1 - 1]->peer;

	ret = 0;

> +	if (set && !pwrseq_port->pwrseq_on)
> +		ret = pwrseq_power_on(pwrseq_port->pwrseq);
> +	else if (!set && pwrseq_port->pwrseq_on)
> +		ret = pwrseq_power_off(pwrseq_port->pwrseq);
> +	if (ret)
> +		return ret;
>  
>  	if (set)
>  		ret = set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
>  	else
>  		ret = usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
>  
> -	if (ret)
> +	if (ret) {
> +		if (set && !pwrseq_port->pwrseq_on)
> +			pwrseq_power_off(pwrseq_port->pwrseq);
> +		else if (!set && pwrseq_port->pwrseq_on)
> +			pwrseq_power_on(pwrseq_port->pwrseq);
>  		return ret;

Can we rather have a couple of helpers? It might be hard to follow all this.
In such a case you won't even need the ret assignment here.


> +	}
>  
> -	if (set)
> +	if (set) {
>  		set_bit(port1, hub->power_bits);
> -	else
> +		pwrseq_port->pwrseq_on = 1;
> +	} else {
>  		clear_bit(port1, hub->power_bits);
> +		pwrseq_port->pwrseq_on = 0;
> +	}

Just

	pwrseq_port->pwrseq_on = set; // or explicit comparison
	assign_bit(port1, hub->power_bits, pwrseq_port->pwrseq_on);

>  	return 0;
>  }

...

> +static bool port_pwrseq_is_supported(struct usb_port *port_dev)
> +{
> +	struct device *dev = &port_dev->dev;
> +	struct fwnode_handle *port = dev->fwnode;

+ blank line here, because for RAII we assume the C99 definitions inside
the code, so one can insert the code in between. Doing it before ep validation
may lead to interesting errors in the future.

> +	struct fwnode_handle *ep __free(fwnode_handle) =
> +			fwnode_graph_get_next_port_endpoint(port, NULL);
> +	if (!ep)
> +		return false;
> +
> +	struct fwnode_handle *remote __free(fwnode_handle) =
> +			fwnode_graph_get_remote_port_parent(ep);
> +	if (!remote)
> +		return false;
> +
> +	if (!fwnode_device_is_compatible(remote, "pcie-m2-e-connector")) {
> +		dev_dbg(dev, "remote endpoint %pfw is not a supported connector", remote);
> +		return false;
> +	}
> +
> +	return true;
> +}

...

> +	if (IS_ERR(port_dev->pwrseq)) {
> +		retval = PTR_ERR(port_dev->pwrseq);
> +		dev_err_probe(&port_dev->dev, retval,
> +			      "failed to get power sequencing descriptor\n");

		retval = dev_err_probe(PTR_ERR(...));

> +		goto err_put_kn;
> +	}

...

>  	retval = component_add(&port_dev->dev, &connector_ops);
>  	if (retval) {
>  		dev_warn(&port_dev->dev, "failed to add component\n");

dev_warn_probe() // however it's not in your patch and was before...

> -		goto err_put_kn;
> +		goto err_pwrseq_off;
>  	}

...

> +err_pwrseq_off:
> +	if (port_dev->pwrseq_on)
> +		pwrseq_power_off(port_dev->pwrseq);

Hmm... I would rather see pwrseq framework to provide something like
_is_powered_on().

	if (pwrseq_is_powered_on())
		_power_off();

...

> +	if (port_dev->pwrseq_on)
> +		pwrseq_power_off(port_dev->pwrseq);

Ditto.

And perhaps even _power_off_if_on() that combines the check and the call.

However it seems that is reference counted and this _power_off() calls won't
guarantee actual power off.

-- 
With Best Regards,
Andy Shevchenko



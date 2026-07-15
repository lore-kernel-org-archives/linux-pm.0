Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287BD466B69;
	Wed, 15 Jul 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121932; cv=none; b=dG7BDTaKyDJZu4lH6lX2I8Yfw3whN/RudO/O3uk4HnHUV5tj9Zj8ymR8GiHj1xFpi/mqYDN+yLbk/RGo+y0Jyrd0VWAQBvtbhWcGWQNED+7miG2HaYWN4ZSHYzclW7IVlWZiU8V5i/6kcXmrQtcj4+/Og9jdedYCo3KDV9lMb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121932; c=relaxed/simple;
	bh=FoJio/rVwDwRIkKJBPFy4VQTYHNnMkd8RIsGPHmXYtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llqLdWayjYGjdbbIWjlS4W8NkRrS6lJOifaX0mMIlBDJH4bzYtVN19sUlNwyZQrGpI4N8bHwiyur/5tWCggMVG+oZDYmFUXTzjQ3gCPoRLBgGrS744DtFUpAQZJZ++/6L43uoPn0+NJO/HeJo7vi+l9BborKh5liAldCGR1rVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcZDUBLj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcZDUBLj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784121930; x=1815657930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FoJio/rVwDwRIkKJBPFy4VQTYHNnMkd8RIsGPHmXYtU=;
  b=dcZDUBLjBET2LBgl9MBETb6uRVSr0B1SAZfslxjV1n4Yq/CRbY75+nUG
   DntZv9ryf6K/xzzhKho6CkwYiBTQDqdTKsyBzpcTXUFlMdoy6AFYwcsTe
   gxGPKF4vz7MScLE3e/AIjy4C3xk/tO2u+8rd8SKn3frKK1AYPlrpwDbdo
   zLeI7AwUt0vjUoZ6pnCFT69Sv2qvj9C59RziTdvDcwxt6H4Dsc9dYexPI
   EcE9rTGTRIuAF1nzES9xO2JMUXGZNSkgrmONlPuD2YCgaxA4wGHUx8R+q
   VZOyO8CyNYc9TnWicEhsCoY14JXPaRRlpGqi2t+Rplkb54xHr+GvDvIpO
   w==;
X-CSE-ConnectionGUID: +JV7sRnZTvePQG64/plk/Q==
X-CSE-MsgGUID: KMDB1qPmQ3Cewoz9f8B0cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88661388"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88661388"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:25:28 -0700
X-CSE-ConnectionGUID: 9Wz6tj6iT3aKtxwO1JLjGw==
X-CSE-MsgGUID: 7GiJrNRMTn+eeKAn9h7sFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="258139844"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:25:22 -0700
Date: Wed, 15 Jul 2026 16:25:20 +0300
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
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 10/16] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
Message-ID: <aleKQKH2V-ck-SX6@ashevche-desk.local>
References: <20260715085348.3457359-1-wenst@chromium.org>
 <20260715085348.3457359-11-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715085348.3457359-11-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 04:53:40PM +0800, Chen-Yu Tsai wrote:
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

...

> static void usb_port_device_release(struct device *dev)

>  	fwnode_handle_put(dev_fwnode(dev));
> +	/* usb_hub_create_port_device() could leave an error value */
> +	if (!IS_ERR(port_dev->pwrseq))
> +		pwrseq_put(port_dev->pwrseq);

Hmm... I would rather make pwrseq_put() NULL and error pointer-aware, so
it will be no-op in such cases. But I think Bart has his own opinion about
this.

>  	kfree(port_dev->req);
>  	kfree(port_dev);
>  }

>  		put_device(&port_dev->dev);
> +		hub->ports[port1 - 1] = NULL;
>  		return retval;
>  	}

...

> int usb_hub_create_port_device(struct usb_hub *hub, int port1)

> +	port_dev->pwrseq = usb_hub_port_pwrseq_get(port_dev);
> +	if (IS_ERR(port_dev->pwrseq)) {
> +		retval = dev_err_probe(&port_dev->dev, PTR_ERR(port_dev->pwrseq),
> +				       "failed to get power sequencing descriptor\n");
> +		goto err_put_kn;

OTOH, how pwrseq can be non-NULL and at the same time port be created?

> +	}

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E1C42255D;
	Wed, 15 Jul 2026 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107247; cv=none; b=YYzlX5q5ywq7GVU+tlzRgA0DaB7kDodOQGHlGohnUBXJxC5pUqSdaD/5Sbgvr2z4DB9Flps0LsCV51Eyeop5+vbyEVpOvnTlKsG2Ug8hx4pP66RM/yOWjbJkjchL4pcHBwv2RVNjE8sZRZ2/pwyYGYcsa9NPvT9UjLeixy/SGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107247; c=relaxed/simple;
	bh=GNwWwlwKmSHKcifYCWTeyGH5lZcsn6dd0tzvoKNoxb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGpBewjPGSesUsPk7uOek1UvLW+6c5/qnSA4FIB6akRxKHfsDkWoehqfmzp7bxIMYIcU/x2yrQ7el89I5Gll1FEivoddQMuMbRCJxlWLhqBZRjdYM40keD6pZBr4FYSnASDa7aljuxRBoihAGhUqay239EfGvmg3aBT8sSSS2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8TyQTIY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8TyQTIY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784107246; x=1815643246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GNwWwlwKmSHKcifYCWTeyGH5lZcsn6dd0tzvoKNoxb4=;
  b=E8TyQTIYYYg4cyJUmvc3yuZvV/tST6cuhnR969CBzTbePw/gk78+ioHU
   6t2S45LucpjHSUf5n508TxKDlQ4wvx6G4DKQE/9/ACdDptJ8/9WGw7xL3
   ZOcuA/n8nAppf/wdSYfgEvVI5R449xb20KWwfi+VSM1iXf84SVQBe2c0V
   SyWdVjtDnTGmxSA+GP0rOl08+Pr2BwsG6IFqtBejyF5ApmX/iXqs3BjDq
   CspMyxonqJS02cfPtHxBNh/XHXDMjGpyhyBdUy/SFu2KiEWCcoTAKhh6T
   VGyRR3ofry3nb1kDp907joAnTB8UcyXI+hlalu9GdnlCpdi5uB3hjOMiX
   w==;
X-CSE-ConnectionGUID: 1hVDg6AXT+yg/NPNUnWI2Q==
X-CSE-MsgGUID: mJ/qyjLoQpSzkOvScnorfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84781011"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84781011"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:20:45 -0700
X-CSE-ConnectionGUID: rohPZ6YPTZinj6UTJQYdjw==
X-CSE-MsgGUID: Nj0Y0ejIQuSWjXGPb/1fOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="254379157"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:20:40 -0700
Date: Wed, 15 Jul 2026 12:20:38 +0300
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
Subject: Re: [PATCH v5 06/16] usb: hub: Associate port@ fwnode with USB port
 device
Message-ID: <aldQ5odptfmK5aCw@ashevche-desk.local>
References: <20260715085348.3457359-1-wenst@chromium.org>
 <20260715085348.3457359-7-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715085348.3457359-7-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 04:53:36PM +0800, Chen-Yu Tsai wrote:
> When a USB hub port is connected to a connector in a firmware node
> graph, the port itself has a node in the graph.
> 
> Associate the port's firmware node with the USB port's device,
> usb_port::dev. This is used in later changes for the M.2 slot power
> sequencing provider to match against the requesting port.
> 
> To avoid potential conflicts with ACPI firmware nodes and then causing
> power management issues, only assign the firmware node if the hub's
> firmware node is not an ACPI firmware node.

...

> int usb_hub_create_port_device(struct usb_hub *hub, int port1)

What about adding

	struct fwnode_handle *fwnode = dev_fwnode(&hdev->dev);

to the top of the function, and...

>  	port_dev->dev.driver = &usb_port_driver;
>  	dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->dev),
>  			port1);
> +	/*
> +	 * ACPI FW nodes are associated later when device_register() happens.
> +	 * Skip assigning one here to avoid potential conflicts.
> +	 */
> +	if (!is_acpi_node(dev_fwnode(&hdev->dev)))
> +		device_set_node(&port_dev->dev,
> +				fwnode_graph_get_port_by_id(dev_fwnode(&hdev->dev), port1,
> +							    FWNODE_GRAPH_DEVICE_DISABLED));

...shorten this a bit to

	if (!is_acpi_node(fwnode)) {
		struct fwnode_handle *ep;

		ep = fwnode_graph_get_port_by_id(fwnode, port1, FWNODE_GRAPH_DEVICE_DISABLED);

// Is NULL or error pointer is fine here to be set as fwnode in port device?
// Perhaps add a comment?

		device_set_node(&port_dev->dev, ep);
	}

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CA6280018;
	Wed, 10 Jun 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100538; cv=none; b=sb3NxFeQqoB0J+C5slYl2/aImGE4+bgPPHxnrWSIbGpo1G1o07DJKfrwHDqXh6w9sOVycfOuQMyuS+KX6GEC+PBIG9sjHpZjIXTr44oiOhnFZfIIsKqN4m4xdgyJeFeG5W7s9M0jQkCLvdOlBLysvc7D+zVtqVOy2Sk63HR5xkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100538; c=relaxed/simple;
	bh=QGKcjDdt8a0tH/Hc9o5DwcTP+oPWZPnZGQMex0Xb5Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqA9mMfWDaMNAHShIVKcG7a2qYW/c76vNDb9z7rlk9ISJlliM6dPWBFg7blyYJvqKdcJsJPcb0SlSLbVklhNo1Eed0//JI6SxGaWjVFX4xTG0aFPB5PFXQUe8hbT4gvHfyRVVjp6kUAlsTp1U0WdE3RqOW+/rrinz0RIZ00xe80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iwoij6XD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iwoij6XD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781100537; x=1812636537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QGKcjDdt8a0tH/Hc9o5DwcTP+oPWZPnZGQMex0Xb5Oo=;
  b=Iwoij6XDWstgxX2MuMNM7a7Xej+HWxJVCrwmrNn/9NtHAgiVZ+SLAFFz
   DLM27qbNqFnKcJfD/IrkQyoAmHaRrXqNS5OhzjYEXPcPLMZyJ56TtckSs
   t6y1TOoYVU6tRph6nRz4k7wMMqzVnbj/GCMwO5O3+eyJ9gZ8ynnGJIQf4
   ANUpltL75kTD4VmGRxAZawyeSZ3JUAT/0o9tRMXuY/kIPTAU5pSxUm00F
   VXV5QENZSSi9odnG+1Nnkt57NAs4V3o10q6C3Rs0TdeH2KaNocZOEiyYd
   TiSeiPlbU6z4RHHPdIdUWgm20Klauywg5WR1Nose/Vz3yCpxOYMe17RsI
   w==;
X-CSE-ConnectionGUID: caT0G3k2RlCLv4M0XQ4K4A==
X-CSE-MsgGUID: 4G9uQZv4QzaQEgkeNV8VWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="69433448"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="69433448"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:08:56 -0700
X-CSE-ConnectionGUID: 5PnXmGmkSf+nphIwuCI86Q==
X-CSE-MsgGUID: 8weCnpoUTs+XY1kL6aY/tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246269709"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:08:51 -0700
Date: Wed, 10 Jun 2026 17:08:48 +0300
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
Subject: Re: [PATCH v2 02/16] device property: Add
 fwnode_graph_get_next_port_endpoint()
Message-ID: <ailv8HpnrCH3Zb8C@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610084053.2059858-3-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:40:36PM +0800, Chen-Yu Tsai wrote:
> Due to design constraints of the power sequencing API, the consumer
> must first be sure that the other side is actually a provider, or it
> will continually get -EPROBE_DEFER when requesting the power
> sequencing descriptor.
> 
> In the upcoming USB power sequencing integration, the USB hub driver
> first needs to check whether a graph connection exists, and whether
> the other side of the connection is a supported connector type. The
> USB port is tied to a "port" firmware node, and this new helper will
> be used to get the endpoint under the known "port" firmware node.

...

> +/**
> + * fwnode_graph_get_next_port_endpoint - Get next endpoint firmware node in port
> + * @port: Pointer to the target port firmware node
> + * @prev: Previous endpoint node or %NULL to get the first
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer. Note that this function also puts a reference to @prev
> + * unconditionally.
> + *
> + * Return: an endpoint firmware node pointer or %NULL if no more endpoints
> + * are available.

Yeah, you see, even here is inconsistency with previously added kernel-doc.

> + */
> +struct fwnode_handle *fwnode_graph_get_next_port_endpoint(const struct fwnode_handle *port,
> +							  struct fwnode_handle *prev)
> +{
> +	struct fwnode_handle *ep;

Unused?

> +	while (1) {

This is usually harder to read and follow. It's like "pay much attention on
the code", but here no rocket science, no code to really pay attention to.

> +		prev = fwnode_get_next_child_node(port, prev);
> +		if (!prev)
> +			break;
> +
> +		if (WARN(!fwnode_name_eq(prev, "endpoint"),
> +			 "non endpoint node is used (%pfw)", prev))
> +			continue;
> +
> +		break;
> +	}
> +
> +	return prev;
> +}

So, this can be rewritten as

	ep = prev;
	do {
		ep = fwnode_get_next_child_node(port, ep);
		if (fwnode_name_eq(ep, "endpoint"))
			break;

		WARN_ON(ep, ...);
	} while (ep);

	return ep;

But also big question why? to WARN*(). There is no use in the entire
property.c.

-- 
With Best Regards,
Andy Shevchenko



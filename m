Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E913CFF56;
	Fri,  3 Jul 2026 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084800; cv=none; b=fEPkp9GxnHRlBbigui/pe91y37dHNDEGF+BKwimnb2lN0oSDfO+ASqD9Nbcuw/RXD5/Mcnbz1Dm/xP+lP9EuD7cIKDOkQ3GMgmTxVqN9b75VWPbGeDDeqIydtELzD/0owl4RBUNkYDhAaEcZj7aTYf9oSYLgaSxXPLNtzKOJWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084800; c=relaxed/simple;
	bh=KrlLYeQgAxCXAG/ivbQ5uAlbi+6kKNnyK+xS9eeJRo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnpZioryjWxnG/csLZZlSVtXXpzQFsmmSI6kt9HAteePFTgc4c1dDz+mjHwI48g9NDehPetybXhyq7/3t20ZoDI7SyxvZ0yOs2Ymc0yxl1IUdapryT8L+hl3giOuSUAy4AvhLrDDMxgVtnHzfFYgvkWb+0U+zwzJyqf42yTqpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DF3Bciih; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DF3Bciih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783084799; x=1814620799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KrlLYeQgAxCXAG/ivbQ5uAlbi+6kKNnyK+xS9eeJRo8=;
  b=DF3BciihzxzC6kp79klu/CyeN7u1nhVPW2On1xXda3SeU7AHYFsu4Jsb
   wJDKf/wZmG8TAd7Ka1ssZcQFsSSB5+1U7CxdlEEjc5qMmuG3k/FElDV9F
   6DpY26n9FaMjQFIVX3buPApx01cRot5R+RjGZqNv+7EgACNdmvXLRIN4r
   4bmJsPcqqol7nWaxMt/STa8qydf5aIdsgjPtSQcVjCY1gDc1kQw4JhgM7
   6kQNlBMwcwu/VSt1C5gD9T1/8ojXqy83yjTXl+aoSuMVADKiOfnAEzCJo
   rbTKxPDlQY2R9CW4JcpnT55pPkt46QohwNNB9NRBVA15axscN5cTniIiJ
   A==;
X-CSE-ConnectionGUID: pl381ssBR4GKjtfrUpmhjw==
X-CSE-MsgGUID: fwA9SgPMTpC8bC4309HXvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83703671"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83703671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:19:58 -0700
X-CSE-ConnectionGUID: CBioSAPuS22okVwAFtW7iw==
X-CSE-MsgGUID: t/oGYSA2TvC644qNAISfew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="283200657"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:19:54 -0700
Date: Fri, 3 Jul 2026 16:19:51 +0300
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
Subject: Re: [PATCH v3 08/13] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
Message-ID: <ake296caIUq0XX8K@ashevche-desk.local>
References: <20260703110317.1283411-1-wenst@chromium.org>
 <20260703110317.1283411-9-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703110317.1283411-9-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 07:03:09PM +0800, Chen-Yu Tsai wrote:
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
> Also rewrite the existing set_bit() and clear_bit() branches with
> assign_bit() to make it cleaner.

...

> +static int usb_hub_set_port_pwrseq(struct usb_port *port, bool set)

Not sure 'set' in the name is a good choice as you have also parameter 'set',
can be confusing. So for the other one. I don't know enough about pwrseq to
suggest better naming of these parts, but I would like to see some consistency
and less oddity.

> +{
> +	int ret = 0;

Unneeded assignment.

> +	if (set)
> +		ret = pwrseq_power_on(port->pwrseq);
> +	else
> +		ret = pwrseq_power_off(port->pwrseq);
> +
> +	return ret;

Moreover, for now this can be written as

	if (set)
		return pwrseq_power_on(port->pwrseq);

	return pwrseq_power_off(port->pwrseq);

> +}
> +
> +static int usb_hub_restore_port_pwrseq(struct usb_port *port, bool set)
> +{
> +	int ret = 0;

Ditto.

> +	if (set)
> +		ret = pwrseq_power_off(port->pwrseq);
> +	else
> +		ret = pwrseq_power_on(port->pwrseq);
> +
> +	return ret;
> +}

...

> +	port_dev->pwrseq = usb_hub_port_pwrseq_get(port_dev);
> +	if (IS_ERR(port_dev->pwrseq)) {
> +		retval = PTR_ERR(port_dev->pwrseq);
> +		dev_err_probe(&port_dev->dev, retval,
> +			      "failed to get power sequencing descriptor\n");

		retval = dev_err_probe(&port_dev->dev, PTR_ERR(port_dev->pwrseq),
				       "failed to get power sequencing descriptor\n");

> +		goto err_put_kn;
> +	}

-- 
With Best Regards,
Andy Shevchenko



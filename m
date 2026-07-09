Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04D3FF889;
	Thu,  9 Jul 2026 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594529; cv=none; b=K1G0ZQfOrdVkIvYvm8w5yEJASEHNp2khS+XoPCUPsKB8Yoi/EjfJM66XY7OjpY9oDuNr1fiDtf0BKo332IgDqZN2RRNmDxJ4GIgXZ6BSsafDD2ZhV33G83xrnr2lrPSL3yyyn+zW06obBomRG4ewQy/IVnXwb80xokbIDCE/Mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594529; c=relaxed/simple;
	bh=xFcQQhmhINQD3s4rCXCWmru3qkNnkEH19O9zKAO6j1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0/CcqKdz9YsdpE0JU4goygBfAa2K6XiofJEk0AGz7346Edbh6SE/KDm4tW3nKzCIKP88irJMmVRZkfQLG4/fSqe4kJ41LtBPMCa3dDwPixMhPnRraB3whq9GL/IRWVsYplkf4n5Xracll5BJs2gK2+GakxkgGH/nD5JnT2qM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqEOdHr2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqEOdHr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783594529; x=1815130529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xFcQQhmhINQD3s4rCXCWmru3qkNnkEH19O9zKAO6j1I=;
  b=WqEOdHr2JEjRWCK8g8PlzB2JvLE03QYi0/zbn7nIHKLSxoUgTWlp0Rss
   q3Znnb88Ej0HA7SC/a2hGHWL0I1gf/EAI3XEBaOex28J720YIF547Ok2e
   1u5pmnW+q/k9QXhl4lg1RbBV1O5W5jSN1rEwCDc3on/jNDmaGvyWxzLN3
   5GVyPykHMeWCU+bBIgfz93c80EQCR2Sho20XWyYWrrsX/THCVl2T/HgeQ
   tDenyRlpB6wSfph+qbYesK27o2TDmqPjwdF/YWDXWRk66IFKtj+sSefXM
   fixCZpxCBJiE3hHnh/buyRBfHMfBHfqmb+vnD8pQLsBIqJkz6A8obBjGX
   A==;
X-CSE-ConnectionGUID: zX3dVn6LS82f6uDcC6kK3g==
X-CSE-MsgGUID: 8ZLFcPv/R3OE3WFKc1S4xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95425808"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95425808"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:55:28 -0700
X-CSE-ConnectionGUID: AR6qK3CCSDC7cPGAveNTzQ==
X-CSE-MsgGUID: 7/7aeqFzRVWBEcBauFhSaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255214900"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:55:22 -0700
Date: Thu, 9 Jul 2026 13:55:19 +0300
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
Subject: Re: [PATCH v4 11/14] power: sequencing: pcie-m2: support matching on
 remote "port" node
Message-ID: <ak9-FxumFw-NtQt2@ashevche-desk.local>
References: <20260709095726.704448-1-wenst@chromium.org>
 <20260709095726.704448-12-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709095726.704448-12-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 05:57:16PM +0800, Chen-Yu Tsai wrote:
> A USB hub can have multiple ports, and this driver needs to
> differentiate which port is being matched to. The USB hub driver now
> associates the "port" node with the usb_port device, so here we can
> use the remote "port" node to check for a match. Then fall back to
> the remote device node for the other connection types.
> 
> Also rewrite the existing "remote == dev_of_node(dev)" with
> device_match_of_node() for consistency.

...

> +		/* USB port devices are tied to the port nodes. */
> +		struct device_node *remote_port __free(device_node) =
> +				of_graph_get_remote_port(endpoint);

> +

No blank line here as this one is coupled with the check.

> +		if (device_match_of_node(dev, remote_port))
> +			return PWRSEQ_MATCH_OK;
> +
> +		/* Try the remote port parent for other types. */
>  		struct device_node *remote __free(device_node) =
>  				of_graph_get_remote_port_parent(endpoint);
> -		if (remote && (remote == dev_of_node(dev)))

> +

Ditto.

> +		if (device_match_of_node(dev, remote))
>  			return PWRSEQ_MATCH_OK;
>  	}

-- 
With Best Regards,
Andy Shevchenko



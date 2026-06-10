Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02225A359;
	Wed, 10 Jun 2026 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099838; cv=none; b=nsfgWpb+S4W3PDpWgGjD8TL6MOxwo7mu/VanZxqz8AJcxm6Kv5KS5/0V7wvxrqFv4xX3+Z59XpimIJh2pOAVucGjy4UGwwnO9LQ/IlqpggV8PU3rzowdt2/DGvkW5hfuPJB7ahJOaj1nvUmQTD62nmyxmILDVH3Ew8TreHF1IyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099838; c=relaxed/simple;
	bh=IvtqsN9HqWtrsYzJFpIQXKTW+grvoM/ms7i/bF9Ptxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaCkf3QeN2OpNQDlk0+rJale1VODMLC0dLkD4tWLAR8CFBIlXLqmgul23nDqhO0CQrelGlwwrpfgJLd5+Rl24OIa95Gkgfv50sRE1L4MJWGWcwn//roHvj9GZu6KedLCR0ew3QVxfWMl9FT94m6holaVFuOdrQmLH1xLnbxcWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8PHIpnT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8PHIpnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781099836; x=1812635836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvtqsN9HqWtrsYzJFpIQXKTW+grvoM/ms7i/bF9Ptxg=;
  b=R8PHIpnT/eXIkzF1rQUXBhYcc4+vb5erBjM48RN1zEvLHrbotnjKgqGI
   TuXmWK+dbvMSuc1tvLb4iTxrHiHkiMkcGMOYPNEuE3goxmQPYiqhHKBh/
   OCKgUsc0DCk0gQp8hdorFDR4UvYt714FXLxjLenSCqjwK/Nc3G11GqrBb
   PIQhMGlRKlmtgkDOfgBF7maroVqHCIzqN6CLeY22ji7G8bgUuFsuIII0O
   WkwG7NffVCqpwN3z97RGO1StfIlFECLKAZaVYhmIG8d0OqEt/kgrwLpHd
   FoHHxdm4QI6z7YK7/+nEYBPM/k0r4csmR5NZJwp3xUHsct5uI6Rq13F9r
   A==;
X-CSE-ConnectionGUID: 04HLvZrhS0iMdL0Wl/1P6A==
X-CSE-MsgGUID: 5Cl6x664ST+Bd4skhdc5VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81799392"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81799392"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:57:15 -0700
X-CSE-ConnectionGUID: pIzUFeurTd+gn3kzaSXAbw==
X-CSE-MsgGUID: ZwgnVHecR0qgh6Qv8HV+YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251260733"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:57:09 -0700
Date: Wed, 10 Jun 2026 16:57:07 +0300
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
Subject: Re: [PATCH v2 01/16] device property: Add
 fwnode_graph_get_port_by_id()
Message-ID: <ailtMyYhbkOgaZWw@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610084053.2059858-2-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:40:35PM +0800, Chen-Yu Tsai wrote:
> In some cases the driver needs a reference to the port firmware node.
> Once such case is the upcoming USB power sequencing integration. The
> USB hub port is tied to the corresponding port firmware node if it
> exists.
> 
> Provide a helper for this.

Okay, if it's really needed.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +/**
> + * fwnode_graph_get_port_by_id - get the port matching a given id
> + * @fwnode: parent fwnode_handle containing the graph
> + * @id: id of the port
> + *
> + * Return: A 'port' firmware node pointer with refcount incremented.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.

Note, the Return section must be last one in the kernel-doc. The last paragraph
sounds to me as a better fit for main description. Basically check how other
kernel-doc(s) in this file are organised and follow that pattern.

> + */

-- 
With Best Regards,
Andy Shevchenko



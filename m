Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B62D1907;
	Fri,  3 Jul 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082803; cv=none; b=iNgqdhg6xyRwAbAPcwd55EI0XDrZHqMh4RufY2qFPHQGB6YkwYHcOqDCRZee++LVMv7Ja/XmCr5DsIjasC/gNNM7xxoAebXi/T9KNnLqrZhScSQBMU/6VW3c8/mCT0aWeA+6tbDIJC6sa/jDAedjOsb5CA8H0QKXIssrgv0YbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082803; c=relaxed/simple;
	bh=Bfe56DaBuMolh+4WBApbrq/tC7CCFTxnUcy4jtF9o7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMe0V3WG4qrJELILXun/E5Ekt5q+bW0ZGU9gz8stZZHAqQJIegevAbFK5TP3321gE9wa4l/GXJR05GPhH+hJkjKmuKN9+VBjrieB2QcBqc9ggrPiH2TVRm5AqU8o9WTDyMediL8fr0co7iV3VBaVJuMaDjCbfSxrplWE1VSAJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOKn6/i1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOKn6/i1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783082803; x=1814618803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bfe56DaBuMolh+4WBApbrq/tC7CCFTxnUcy4jtF9o7M=;
  b=FOKn6/i1Db7f2+eXO+hPEI5mq6fNG+hszAk4T9xGnjlkvqRik8lAy5gz
   jmiihNLORcSijQIhoUl7pEVT4eEVCydiZugf66IIKSFRS13waY7Weg6vW
   /r013Q7OTMBp9XHMXem/2ZOouAkOYGklA6EyHV2+6IzXBJVc8tu1Br54E
   JujRq4bVapyE/2Vjkczz8jhG+k1Hjcwj6v2LqmxzmrHuBmDaDg1Uu8BIc
   gSJhVqnZ/O9Vdvyva36By2RqgAA29XR77e8pOAhWdysClGcMRbnEnP6AI
   D6lwGHVhcaPbaE9SW1OCGtmm9c73Z/T6FsrU+duDBVqHZqakD/1M2cZyk
   A==;
X-CSE-ConnectionGUID: uP7oZA+aTbyeiHG4ESqzOA==
X-CSE-MsgGUID: qZwqVvLESwykaYm/KpPDZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83613111"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83613111"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:46:42 -0700
X-CSE-ConnectionGUID: CV+r/4VLRpuQT8//tAUw7Q==
X-CSE-MsgGUID: n+bCD65wSTGlX5/jBvpc2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="249139803"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:46:37 -0700
Date: Fri, 3 Jul 2026 15:46:34 +0300
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
Subject: Re: [PATCH v3 02/13] device property: Add
 fwnode_graph_get_next_port_endpoint()
Message-ID: <akevKiryGPA0_vZx@ashevche-desk.local>
References: <20260703110317.1283411-1-wenst@chromium.org>
 <20260703110317.1283411-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703110317.1283411-3-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 07:03:03PM +0800, Chen-Yu Tsai wrote:
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

This version is good.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



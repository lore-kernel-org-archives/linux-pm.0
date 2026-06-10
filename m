Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B3175A6A;
	Wed, 10 Jun 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100981; cv=none; b=rr0ihNh/eANfoc+sxLLZto64xSnltgL8+gE21zOILrLKPwEsPNwREvLTg3q6N0ntrb9fTh4cFRvyZ863U9xrSnBqm67U7q0B7v+b3mumVbBUq+w0dEbClGTwYgC/oopGTqjebBBTbpIDyRSd/EztgtL8Zcxehqle7iOxOaEKnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100981; c=relaxed/simple;
	bh=uUn9KmX+YV5IrN2SPL9arcCvhPBUW1vzMP5vPumfeKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REKYaJEwTFrlo0XIpClVL+e8kGbeHDIcSm5NyKbpiBLwu9B2MVg7QFDGSv55KnvJntH50YXCYELAOVCGkoUhjExxmCg61Ruz1EyGA3ED2xJLaqVpbEN5Upa97t+TSQHIqDZf5m99Es3j4g19KoirSViI93aGMVZTabofbGYtLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fO9xSCkc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fO9xSCkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781100980; x=1812636980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uUn9KmX+YV5IrN2SPL9arcCvhPBUW1vzMP5vPumfeKU=;
  b=fO9xSCkcCBEiNQ6q+X4O4LF/Bv4uEA3GeYo8aUsV/j9rGI9gz6VEwI9U
   4eGZmCeCHK5MeWfm/KPycXo96ydV4ZqNWi+DkKGRJX/hpGuAHDofhRjU6
   f6vcGhYICeUvQDSJz5Hq9j31qt3PUI8sq50vRjNx+S3R104AoVg/C1qQg
   ouC6EVPAnIAAAhOAj1blhtX8X1iLeQCnrMEzv1dy55+5scy0kSp1FKtTH
   6MwBBH8qSVEJuF0EQvfsgMTf2sK94kdhzQQ0ZD0RXojk8B8Bu/tsAPaTy
   8Zyvl0WLWMHgP5vEh7eR1Boo/ONm61+ywvynonpaH2bY/FdKhgCyG8Ats
   Q==;
X-CSE-ConnectionGUID: EZvhxjDwSkeoBpj592IL4A==
X-CSE-MsgGUID: ZgP08JXnRySWKB9hvNVxeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81801547"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81801547"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:16:19 -0700
X-CSE-ConnectionGUID: ihCtU1ENTqGYOkLDAvncxw==
X-CSE-MsgGUID: pjpObk6LQ1qcu4V0cTf2Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="248050350"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:16:14 -0700
Date: Wed, 10 Jun 2026 17:16:12 +0300
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
Subject: Re: [PATCH v2 05/16] usb: hub: Associate port@ fwnode with USB port
 device
Message-ID: <ailxrP-_9_NL8qnN@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-6-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610084053.2059858-6-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:40:39PM +0800, Chen-Yu Tsai wrote:
> When a USB hub port is connected to a connector in a firmware node
> graph, the port itself has a node in the graph.
> 
> Associate the port's firmware node with the USB port's device,
> usb_port::dev. This is used in later changes for the M.2 slot power
> sequencing provider to match against the requesting port.

Okay, would this affect ACPI-based systems? if so, how?
Can you elaborate on that, please?

-- 
With Best Regards,
Andy Shevchenko



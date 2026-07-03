Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F53A3D411A;
	Fri,  3 Jul 2026 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083727; cv=none; b=ftnQusgL13IrwXVFj3IDaWbvVnIXyslu7Kt7yyNSoh9eEgkvcW2mNm9jeVNYndhMAHdKzQwCcK+6hSHtNXC2wLwsmrAJg32P6fV4aXOf25j3NnnjJglq//KxezDXJrsJ2AyVIjOO9B+uObt5AukrR82Lk8KjYwqHtUdjVL7Cht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083727; c=relaxed/simple;
	bh=go3A92f+qVfLN0BBANEqxhTi+7+zvO5fvzs2fUIzcw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2njvLVRIUObpF5kWKodLd+aP4qfEANloCKF63X1TRP5dychLRwi9hKPdqrpISOIj/o378sb4KGH2U3wRAkB5IXMyFenf+h4D+26/o0yp0wF5cqNwXMEX3lLdDRkVnu10GVSW0xjbM8Pq044vYtUMHI2x3ZoAy/VSAD73UJ41uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuzrB/0g; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuzrB/0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783083726; x=1814619726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=go3A92f+qVfLN0BBANEqxhTi+7+zvO5fvzs2fUIzcw4=;
  b=NuzrB/0gQgSBjssMI1Y5o8NIJwrzbE9E4Ise0k3V+h37YH8vGbm+bvNu
   /ngCGHyXXH86Bbis97tt1Hfs3vdb+naI32hRp6CeSqPNK5UHwUo9XIIiO
   euEN2H5hbkQVZAr092yi+bTMiegC5fxgVMxWA+QkZHEZouBmej3Cz78z2
   cZ3Vx12L2XmkabMSJdTjLZvneSl1JLUTLEzKSK3nXjefZ+tHi0RyTDuTS
   r5voX6G2maILsMdjI69WgdRbc7hbhrOjF0YWuXss+LY5VkA8W3IFYwq1Y
   W4CpTqffgEwg1YmHud1gjciF+QEM99lBMNjtfTikaG7hlVhWwYn2GEPRJ
   A==;
X-CSE-ConnectionGUID: NArLQK8BRcif+tSWouniSw==
X-CSE-MsgGUID: et5YtQUfR2iZKLDz5j+nOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="86386249"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="86386249"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:02:05 -0700
X-CSE-ConnectionGUID: pugGM/gaQTaY9txxcMNEVA==
X-CSE-MsgGUID: mOxugsDkT6C+FxXoN/1dQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="250458340"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:02:00 -0700
Date: Fri, 3 Jul 2026 16:01:58 +0300
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
Subject: Re: [PATCH v3 05/13] usb: hub: Associate port@ fwnode with USB port
 device
Message-ID: <akeyxn390mVmYo83@ashevche-desk.local>
References: <20260703110317.1283411-1-wenst@chromium.org>
 <20260703110317.1283411-6-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703110317.1283411-6-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 07:03:06PM +0800, Chen-Yu Tsai wrote:
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

Now I'm more confident that it does not mess up with ACPI case.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



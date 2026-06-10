Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96C285CB6;
	Wed, 10 Jun 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102175; cv=none; b=MS/LuL/FpsX/ARPw690NHc+S+t+HHqMlhr5kdb2h4rxb++ciEbR+kmR7rIKsLhBrUFKPSVjTUql70Q1M4Awd8jqPDRaapm7DIs4eJoxB9hNqfjv/28rrIIoaPjxUSu+TRnZUCrtmRii289asFd1wFVy/RT+HXdP9DgJ7TtFFx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102175; c=relaxed/simple;
	bh=rjVo3E6bL/gwM4u8huqi79QwAf/xG2SrVmrblO9TUZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx90XV80UiXaqLT9VMOappkZDCB+34fs7dnZG+soe9auYsCvHokKQUAXVF5hBiyUgBPugYfCynBZi76qpFR58FCGc1YUVHjNohYzrevmE9chU3uPUktSighk5Ex82vYxb1ghDhxj8Q6c0CQI4XL6PkEPL66WnFdT/NYkCUXcvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQNTaBiD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQNTaBiD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781102173; x=1812638173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjVo3E6bL/gwM4u8huqi79QwAf/xG2SrVmrblO9TUZc=;
  b=MQNTaBiDVFlHCSFz/jT+LpiqrIjKYComXutJ5kMZ5qpiini/pYmLsRe9
   mle6cz1cSAuR5EsH3YmFzIv0m7RB5bpUEOOzNdbbz9pYSOLqEsasM1i/b
   D4VWJ0lXTrB333RewCeL32wZVh4iQnEbsVWIJ9NZJEOHA+0MXmVkjklRF
   UjRjnTRgplcWycNAws5ePCxJMYfTeaub/qA0HHQZ7OBnLqC9s1jCuDvZe
   o23rMFhjvZDai8GTa5b1DTfOZy9FlU7b5+GQcN5YNuslgaT/oBzU98u+e
   U6Ja4h1FylhgM719aK3NXRD1g53hW8ZsHuFTXNXXdqgWRO+ywmAKkNrrH
   Q==;
X-CSE-ConnectionGUID: dDr+binWTsWG2056uLghIQ==
X-CSE-MsgGUID: 88s/B8h3Qs6jtGi+WYNQ2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84466561"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="84466561"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:36:12 -0700
X-CSE-ConnectionGUID: qQiWu5zvQd6n+fOOpRJieA==
X-CSE-MsgGUID: slS4EcOxQy+lPzGNsfCINg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="250113779"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:36:08 -0700
Date: Wed, 10 Jun 2026 17:36:05 +0300
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
Subject: Re: [PATCH v2 11/16] power: sequencing: pcie-m2: Add usb and sdio
 targets for E-key connector
Message-ID: <ail2VcubjT7HNGUC@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-12-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610084053.2059858-12-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:40:45PM +0800, Chen-Yu Tsai wrote:
> The M.2 E-key connector allows either PCIe or SDIO for WiFi and USB or
> UART for BT. Currently the driver only supports PCIe and UART.
> 
> Add power sequencing targets for SDIO and USB. To avoid adding a
> complicated dependency tree, rename the existing power sequencing units
> "pcie" and "uart" to "wifi" and "bt". The existing target names are left
> untouched. The new "sdio" and "usb" targets just point to the renamed
> "wifi" and "bt" units.

Why can we do that? No breakage? Only internal names? No ABI affected?
Please, clarify all this in the commit message.

-- 
With Best Regards,
Andy Shevchenko



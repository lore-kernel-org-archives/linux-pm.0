Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCB3ECBDA;
	Wed, 15 Jul 2026 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106673; cv=none; b=csgsIBcQPaEfarsblqLOZPu2HHOKIqHyeQd13ZLWYfn/nwiuVsN1JcEx1298v7RC50mYgFkTZUnblPp60tCIanenr8H7DIzQlDhqRbqE7AeMTvNp+sska84yiZ9+G7cyXGB6CTLTtp7KYLI6B5SJT+g+Fmc0kfE3WHT4xaDYfYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106673; c=relaxed/simple;
	bh=jliDADGCLmkXxXJ784OiVvMm1uOKkWyQ+k6fHfNWlms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR+OhJGMBZQxsY0fkZYvhEw8cp/ZnQbQteVSPrkT8DrOlzgvEWvHiRA1vTM0+teJFLMubcyvyWQ9vqT5UaUNzN7irD7OYho7EXgYUObcqj3et7kWAkTDBXapz/koNuRK2V+xHgVC79Y+FkrpsDrRChHh4Fbi1ydyEvX11RqD3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cc5w23vV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cc5w23vV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784106671; x=1815642671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jliDADGCLmkXxXJ784OiVvMm1uOKkWyQ+k6fHfNWlms=;
  b=cc5w23vVUC3e8YykRLOfWYSdu0HwCIBtJxvuXBaX0wHkGE/HQOGAuDGx
   G/U+6Y6kzxNhnmtQutBy9xxBn2+luxgkwaxgfJlB77GKP2tYKgOBhH+Gb
   h8ITkE8qvrOlB4+I7i8idF/GIMz4hrq9CFUnaCZMdZylD2lkqsKsfHu+U
   GhqPWg8y4GtRBsekiNJfc7yjhAlc4UUKl6QOb7VFZuJOer7mb0Tj3M+4y
   LKyZOgnhNH21kzN1aDIjv+KFZnxI7+Azg8rRCS4xMo8pyC0bJmbayH+fZ
   lcnIqxljrG8xlfcWZkQ/7+COoQgfJobwdx9Wms5/b6rzJ358lslx4kgU5
   A==;
X-CSE-ConnectionGUID: y5eIdXIlT+uAcrdIpijmHw==
X-CSE-MsgGUID: RUlpE2XoQxaLPcy7pBMl6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96106101"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="96106101"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:11:10 -0700
X-CSE-ConnectionGUID: HlUvXl7zTAay9OsRhPH9+g==
X-CSE-MsgGUID: mm+NVqUFTFGtw1BU54676A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="255617959"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:11:06 -0700
Date: Wed, 15 Jul 2026 12:11:02 +0300
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 04/16] usb: hub: Use assign_bit() in
 usb_hub_set_port_power()
Message-ID: <aldOpuACh_FAainj@ashevche-desk.local>
References: <20260715085348.3457359-1-wenst@chromium.org>
 <20260715085348.3457359-5-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715085348.3457359-5-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 04:53:34PM +0800, Chen-Yu Tsai wrote:
> usb_hub_set_port_power() open-codes assign_bit(). Just use the
> assign_bit() macro instead. This makes subsequent additions to
> usb_hub_set_port_power() easier to read.
> 
> This change does not introduce any functional changes.

Yes, it's a pure cleanup.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



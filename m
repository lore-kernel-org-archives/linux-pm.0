Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562233D8122;
	Tue, 15 Sep 2026 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459904; cv=none; b=bgr2Ec2wrc/tiRlaR/qFQHVhyMknFEoczS7hYqdcXYDjsRip+kcDkm3GuTaps0H63xTEah2W7POmGLtVCQGKl3lbdXIZLg8wLpSiDI/v7Igz0eFb39Tu0CYsPxUgTnwOfYDh5l2Gyc6gp1TlBmGIOI+sGOqASVGUedDGCNdywy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459904; c=relaxed/simple;
	bh=NIV5i/07/x8Lh1kdJ4pqvn6E+LCPP2Auh0d7O+8uc6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu41o4YzF+qqxSRbofKIg/hunf+myWpuy88inayvPFSL9lWWKKoCiF+V/UB7OToT/ymzO1lF13X3ZdnB9QdGVweP+39to8BT/Rsc11FMTZfy9VCPUBygKGKkDyGxgeRbEU9shmTSFRa8fyVSTr07p/kRxBoVpmghbhx9XX8jWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIdL1ncH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIdL1ncH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789459901; x=1820995901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIV5i/07/x8Lh1kdJ4pqvn6E+LCPP2Auh0d7O+8uc6g=;
  b=gIdL1ncHVCQouOCes9WkeF1MzmKau+sDQs4rAGKUw+OB80+WhwJo6efD
   NrqbuvmWk0TburYHileBdaU38r8Vx895LGqX32d/rFCMMvMTWtH970jiY
   8KywpCgBvXgpJ0Ro7gz4aoaJ8ll3Mp/B5g4bndm/RIHiZGsTEjWRPkZDO
   ERWQ3HUrr6yxPeBdhBC1/U0Td0geQvEA2LjR8xWDhvp1kV2/1T8GsCx/c
   8/qSK79t9dafS+Y4RfSWzXZ/RuKC+aWMPpnL9+7aDRDPn7ZNOS2aGWtui
   a06KUaPUZrQlxPefz6MBGmhcwQECPb+55TUZ6TL/StvG9Vo24odjGVXbD
   w==;
X-CSE-ConnectionGUID: OC12gzrbTwauG1pCpUOKEA==
X-CSE-MsgGUID: RXrn0RZsRiKDKyv7fr6TGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100970539"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100970539"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 01:11:40 -0700
X-CSE-ConnectionGUID: A61ofmMuT1WaatRfRHR9oQ==
X-CSE-MsgGUID: 9FXUUD7fTb+kFjCdl+uAGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269613058"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 01:11:36 -0700
Date: Tue, 15 Sep 2026 11:11:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: rva333@protonmail.com, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v4 2/3] nvmem: add mt6323 PMIC EFUSE driver
Message-ID: <aqj9ttde-cZXPm_Z@ashevche-desk.local>
References: <20260911-mt6323-nvmem-v4-0-626dd17531dc@protonmail.com>
 <20260911-mt6323-nvmem-v4-2-626dd17531dc@protonmail.com>
 <170bcc15-38fc-47cb-89f5-8fe7411111aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170bcc15-38fc-47cb-89f5-8fe7411111aa@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 14, 2026 at 11:08:36PM +0100, Srinivas Kandagatla wrote:
> On 9/11/26 7:33 AM, Roman Vivchar via B4 Relay wrote:

> > Add support for the EFUSE controller found in the Mediatek MT6323 PMIC.
> > The MT6323 EFUSE stores 24 bytes of hardware-related data, such as
> > thermal sensor calibration values.

...

> > +++ b/MAINTAINERS

> >  F:	drivers/iio/adc/mt6323-auxadc.c
> >  F:	include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
> >  
> > +MEDIATEK MT6323 PMIC NVMEM DRIVER
> > +M:	Roman Vivchar <rva333@protonmail.com>
> > +S:	Maintained
> > +F:	drivers/nvmem/mt6323-efuse.c
> 
> placement is in wrong order,

Can you elaborate on this? I do not see the issue.

> same in make file too.

> >  MEDIATEK MT6735 CLOCK & RESET DRIVERS
> >  M:	Yassine Oudjana <y.oudjana@protonmail.com>
> >  L:	linux-clk@vger.kernel.org

...

> > +++ b/drivers/nvmem/Makefile

> > obj-$(CONFIG_NVMEM_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
> >  nvmem-microchip-otpc-y			:= microchip-otpc.o
> >  obj-$(CONFIG_NVMEM_MTK_EFUSE)		+= nvmem_mtk-efuse.o
> >  nvmem_mtk-efuse-y			:= mtk-efuse.o
> > +obj-$(CONFIG_NVMEM_MT6323_EFUSE)		+= nvmem_mt6323-efuse.o
> > +nvmem_mt6323-efuse-y			:= mt6323-efuse.o

Yes, here the digits should be before letters.

> >  obj-$(CONFIG_NVMEM_MXS_OCOTP)		+= nvmem-mxs-ocotp.o
> >  nvmem-mxs-ocotp-y			:= mxs-ocotp.o
> >  obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o

-- 
With Best Regards,
Andy Shevchenko



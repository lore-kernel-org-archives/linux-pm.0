Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9493CB8F0;
	Tue, 12 May 2026 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604975; cv=none; b=aXo5UhuZKW1Ykdu+yT7y+2YjZJ8q1OZ4wdScIPWSN1pzOc1uOgTVKPrRsnPDdWghCTqy9j2rSNsh2aGGlb/PnNmkzfyHk1X4ZqUiXiJhfiLUYt9GKviR0o4ygpZgjLdaMk0DWW5NRophq2C1m/Ng/i/0EKoAf/W8hLEwL6XRTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604975; c=relaxed/simple;
	bh=9JqXkD4oo5STPUWAnq9HH/ZMSx9akBEyLL9pFMj5Eto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFQujBCco3AmmuLv6oulk1u54f97mUINFRZHbtg2CVkwrLAqIESAiA73XDv+ateZLewHn7TJVYS3P56T9XarmNdzeaCLBgjr4YzaJRzQpJSFxT7dhzCpZjcdc9zH2lWRP21ihDLhAPeprgZ2HeAk5fLiLyLDPh77MGmmTPNyOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QI48jTUd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QI48jTUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778604973; x=1810140973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9JqXkD4oo5STPUWAnq9HH/ZMSx9akBEyLL9pFMj5Eto=;
  b=QI48jTUdQ9Q1Um6zI5NuslioLuEvKsGvRe/SNiTQkQQe8NAAGci/rEX8
   Nzhxy0ccR3E6amSSsnDdWhHlK/LpLriNTPWlClk4kisf8k1i5/hQAArUO
   +tq05PIQRlbe4WLJ/ODvUiCoR72AbLpPViwFhZPwjGukoOfizD2UuJ+qD
   82S1w0ordcqj92RCNgMFnL2jLl8q57YV5BRet6cUhVVMSxQv1VSRMEgTi
   ZqVb69vha+YWmcWd80Q2zsQP91srEoOVbTRrIWoI0M381zWoOHlCliEbc
   ZQSGpuznstiuG2RDNBj2eNGwc+ndvEh4Vgdk8TvFWKq6fiUSS9dl+Y3uj
   A==;
X-CSE-ConnectionGUID: y6uImMCiTGO4uqkp5116Zg==
X-CSE-MsgGUID: Rjq8FOldRuGIHEagPUI8Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="97090232"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="97090232"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:56:11 -0700
X-CSE-ConnectionGUID: eE/ZxnqvT+CkeJ6UrkNkkQ==
X-CSE-MsgGUID: AtasLK9fTAie+dOmlPczyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242171405"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:56:05 -0700
Date: Tue, 12 May 2026 19:56:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 05/16] iio: adc: mediatek: add mt6323 PMIC AUXADC
 driver
Message-ID: <agNbo39p6uACvQHd@ashevche-desk.local>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
 <20260512-mt6323-v2-5-3efcba579e88@protonmail.com>
 <20260512142932.5c6801d1@jic23-huawei>
 <gWxamwTKyUeOF4QCsiIsrnh7DSWzIKFaY0h83qKq_0vg786xv1uFYhypix7BVO_ruG_vw3DrIsRhIKv5NAzl8hK72rjzPAjwAGU-rhkMgeA=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gWxamwTKyUeOF4QCsiIsrnh7DSWzIKFaY0h83qKq_0vg786xv1uFYhypix7BVO_ruG_vw3DrIsRhIKv5NAzl8hK72rjzPAjwAGU-rhkMgeA=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 02:34:55PM +0000, Roman Vivchar wrote:
> On Tuesday, May 12th, 2026 at 4:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 12 May 2026 08:18:19 +0300
> > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

...

> > > +#define VOLTAGE_FULL_RANGE	1800
> > Probably better to have this inline - however if you do keep it
> > prefix t he define  VOLTAGE_FULL_RANGE sounds too generic!
> > 
> > > +#define AUXADC_PRECISE		32768
> > I'd put that inline.  Little benefit it in having it up here...
> 
> There was a mention about magic values in the v1 for the thermal patch [1].
> Andy, would it be better to use an inline style or a #define here?
> If the former, I'll rename the first constant to something like
> AUXADC_VOLTAGE_FULL_RANGE.

If you use it inline, add a comment to explain the magic.
It will be a good compromise.

> [1]: https://lore.kernel.org/linux-mediatek/afmnUG8dG0N0HpV6@ashevche-desk.local/

-- 
With Best Regards,
Andy Shevchenko



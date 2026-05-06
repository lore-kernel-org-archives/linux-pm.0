Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20439B486;
	Wed,  6 May 2026 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052627; cv=none; b=Jf11oChW7BQ9ID5pEPCe4DzQxpbvcRQw9LcmpmVhA721xKAbBLvwvEg6pzDUYTXmBkv7vzto2XoRgfI1bua+/SpQuRgiOezbPHubyvdbn/FxJw7wpVaBOquXLmD9dVwPxNB5AEEbE+4W9sdU0nMkIgQZDgOji8IK2QldGoc385M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052627; c=relaxed/simple;
	bh=vCLaey9OpjFpEdYt8M8cmjBiqJz+wr5dw2RBMYVEuTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+H3KNxxj1401sWZac/A3k11iUUviTLadBQQmDSSS0dRHFUz4Zzno2wG2oQ3qTOn8Z7+nTs1ifO5KP46fxwWROwlzlEaG38iQLm9SABFsL74efFbbip3ZcQ7J7aQ48NfH2RZYcYCExF8dpTOsBuCdvHyotEmqw3zQ1r05OvFAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7srsGs8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7srsGs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778052626; x=1809588626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vCLaey9OpjFpEdYt8M8cmjBiqJz+wr5dw2RBMYVEuTg=;
  b=I7srsGs8RLHoCtJpn+n9OOUkjpelb4q5GnpX4wCYOyhwoL3YmA5uKXaE
   u4WOfxYRot38zz6nmz8ckNMwcwCphLMGewA/TxKw0hlMRH5D7E2Judzwp
   RCLLeHnMsXZMlrUoVP9RXchWyXjA1LH7FLDyHQtLBJ6GUzIp1fLucILt9
   GCcAkHTLb2HDJtGF7PKYjnem0bj17+y36ElR5OU5x2+d2SX/e1C7OQnI8
   P7bbi9b25bDmBNVMIwa+A9CumTiIrNhq7HAlfWDmHqMqXUrfknt4PF3jj
   8KaONpQh/JzpNMtygD/q1h12UvBJU3oLry0EtuHTjAGA6f0Jt3ze4bMd+
   g==;
X-CSE-ConnectionGUID: YBGhiCMyTAiUkAlTqqFD1w==
X-CSE-MsgGUID: ctYfomJNQtu0ne4/cYA17A==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="81538829"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="81538829"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:30:26 -0700
X-CSE-ConnectionGUID: ZorZsCONRaOy1EKm4bJdsA==
X-CSE-MsgGUID: EE77A/rMTuCutPrAFu7/Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="241044287"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:30:21 -0700
Date: Wed, 6 May 2026 10:30:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 05/13] nvmem: add mt6323 PMIC EFUSE driver
Message-ID: <afruCjvTluKgI-tV@ashevche-desk.local>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
 <20260504-mt6323-v1-5-799b58b355ff@protonmail.com>
 <afmjfWtt7Vii6xfH@ashevche-desk.local>
 <Bn1O24yJ2aBvKUTpiFUzxnqbuuybRirR73G7R38ghYtwhFvQqWJb3HPgcikEa1otDw6n07nX_g8khZUHXJ_QRA--LrV5yj5Mcg1QzrWt6vA=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Bn1O24yJ2aBvKUTpiFUzxnqbuuybRirR73G7R38ghYtwhFvQqWJb3HPgcikEa1otDw6n07nX_g8khZUHXJ_QRA--LrV5yj5Mcg1QzrWt6vA=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 04:24:41PM +0000, Roman Vivchar wrote:
> On Tuesday, May 5th, 2026 at 11:00 AM, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, May 04, 2026 at 09:24:57PM +0300, Roman Vivchar via B4 Relay wrote:

First of all, please drop the pieces you are agree with or not going to comment
on (for whatever reason). It makes easier not miss anything important and saves
reviewer's time on doing that for you.

...

> > 	for (size_t i = 0; i < bytes; i += sizeof(*buf)) {
> > 
> > > +		ret = regmap_read(efuse->regmap,
> > > +				  MT6323_EFUSE_DOUT_BASE + offset + i, &tmp);
> > > +		if (ret)
> > > +			return ret;
> > > +		buf[i / 2] = tmp;
> > > +	}
> > 
> > + blank line.
> > 
> > Isn't this reimplementation of bulk read? Why the latter may not be used?
> 
> Yes, but the PWRAP (the regmap which the driver uses) doesn't support read
> callback, only reg_read is implemented in the driver.
> It hits the map->cache_type == REGCACHE_NONE in the regmap_read_raw, and falls
> for the !map->read check, so regmap_bulk_read neither the regmap_read_raw
> can be used.
> 
> Technically the PMIC is not continuous address space, but rather non-MMIO FSM,
> so it makes sense to not implement the read callback. I guess the custom
> implementation is fine then?

No objections from me, but please make sure the summary of this is mentioned
in the comment in the code and/or in the commit message.

-- 
With Best Regards,
Andy Shevchenko



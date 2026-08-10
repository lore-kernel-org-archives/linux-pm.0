Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980843553C;
	Mon, 10 Aug 2026 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385014; cv=none; b=V7MS58RD0YoFafWWgYUTf0UTR8ZuyfZLWm1XQDgDyhRPz9Oa85SYUzZS4SFsH5zGYE4NNs6/jnLIup7u5a/aJ7waxgEnuZb/TFDNfehNqXQJrJ4Z13l1dkBFVHDWcNfHJt88d+NBZFGJZwitewx4A7UY+mOHqLuYuaMjM+axAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385014; c=relaxed/simple;
	bh=9j2cXTMr33B3CluqB5kVZiijY9sixvHdaGdO1LZY3Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbTQi/YVgjXt7G4R5xPcBxVzFtjlw85n5SFpPi31hZ+ItgkwG+gwpoH8yX+CCrGtQZM8L0y/8Acbg2XRpws7XKPvXp0Ex5qRNwvH9JoaASn2EAUT5QMkcDZqozvAyz9pU7kMQSH52L7THXrS9b+ZxPL1V+i9VMpkYo4DVis2hQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nexYiE2w; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nexYiE2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786385009; x=1817921009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9j2cXTMr33B3CluqB5kVZiijY9sixvHdaGdO1LZY3Lo=;
  b=nexYiE2wCiNoAjF1qvdAL8DgOTvM4kz/kW+rx7xavQEoGbOOaCMuuffb
   6Dt1S5BEiodIn3qPtkcjCpnuoAEr/YT/G/QFqYrzW1loa8v9K1ByzNFeH
   TN7dxeTJTUUnSVCi1Kb5d8zPX+KeQQPqKotgKLvwU+orCt/8t4NLKsYHn
   e3Yvwm2H9Q4J+jW7rEpW+ipSMSd5tAYL/vIanE/PgFeie0clWcdtn2kus
   d4P1nuVL6kXkSd7GeHiycY7OdR6An7tKk0tOkxqYdeAVm+QaeYCDBYbJs
   d+roOAuhN6cb5z2klzoD8/npSAe2T8nX4Jq4fAdghM4FDAn5tAqbJy5Vw
   w==;
X-CSE-ConnectionGUID: jKzN7UlwQ3mGvr7XNT6BsQ==
X-CSE-MsgGUID: opoINpNEQIu39k+KrVvaLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86028797"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86028797"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:03:28 -0700
X-CSE-ConnectionGUID: L148/2C9QWmXPL0WkLAPiQ==
X-CSE-MsgGUID: Sq2SIAJeR6i887N5G5oR1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="293031839"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:03:25 -0700
Date: Mon, 10 Aug 2026 21:03:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Andreas Kemnade <andreas@kemnade.info>,
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>,
	Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
	Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: Re: [PATCH 5/5] power: supply: bd99954: Drop bad register fields
Message-ID: <anoSamyqNwUzo5ad@ashevche-desk.local>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
 <758fd430d02286a6f18603a8aecfe443f5ddeb8e.1786356145.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <758fd430d02286a6f18603a8aecfe443f5ddeb8e.1786356145.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 01:10:03PM +0300, Matti Vaittinen wrote:

> The bd99954 driver creates regmap fields for all the registers. All the
> fields for VBUS_UCD_FCTRL_SET (extended command 0x33) are accidentally
> created for VCC_UCD_FCTRL_SET (extended command 0x2b), causing all
> reads/writes for the fields to access wrong register. Luckily the fields
> for VBUS_UCD_FCTRL_SET are unused.
> 
> Taking a look at the data-sheet:
> https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/battery_management/bd99954xxx-e.pdf

Make it a Link or Datasheet tag.

> all the fields in the VBUS_UCD_FCTRL_SET are marked as:
> "In normal operation, please don’t set these registers" with not much of
> additional documentation. As the fields are wrong and because there seems
> to be no users of the fields - it is better to just drop them. This will
> also decrease the memory footprint.
> 
> Drop incorrect VBUS_UCD_FCTRL_SET fields.

-- 
With Best Regards,
Andy Shevchenko



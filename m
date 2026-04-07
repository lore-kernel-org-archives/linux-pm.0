Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB93AA516;
	Tue,  7 Apr 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564736; cv=none; b=UKA1SC+FeUyOOYN5tr3dxRH/LfKeUKboLgN8x/q0CwdYnKlGPkEJzoNwkR1qLwouHrWWVEarffRkn1F6hryrCgHw6xZuGdaEDDE6sTalPx4cukpmlis+mnDZAbZNr/Oi/xVKXPFLcRP8nROc61iw0/m54MMTSKxePWRwB2T+eeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564736; c=relaxed/simple;
	bh=WnUj41HY436U/PRRPWD3UEcJnw1euxhOP0IoV/BAZZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMe4LysZ9/lpR0YdLxfwB1Ww+CPYlElnSggduKXf7cX0Ch/Jl0uIsK4SHyhH1g+fCqg1kN6NSlfZsMD8bR0m/vZVqLYsqKzrOTPCENL0AB0H+ogsMkqmHQV8vcSO26neswXpXaAiIGm2mtVCfi+f5oCyPZedRUqVKtJ1tymT23E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTeuxXTH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTeuxXTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775564735; x=1807100735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WnUj41HY436U/PRRPWD3UEcJnw1euxhOP0IoV/BAZZI=;
  b=lTeuxXTHjWuQ8dzBpV3x6oi8ds9hm/Nx6OX/mVCBfVR40ln6YKsUF5tg
   Yy8Ya838o7qd4NFDwHN9N4OY9bnh4wbc/IxnfAdja1z/1HF3Ed9O/3aMj
   R3tl8TGzrBCiv59cuM2DNfNSp717/15169QVGnneb6Lp0xhTsue59MU6Z
   AQ5ZdPf7l0LvNIKC3NsdRkZfad3cAsRpgYyXEEGxI1LuTBVJKMcnUUIab
   Uldt9zPJGo0S1ILJQWK1XB9oGtTnLDnK4eTY4GN8xDAObUoOgAic3sny5
   K/1NTLRJn4u5qevPseTIqzHH3lfMjF5Nqrv1k5Gq5+chUT27FiwDtVukK
   Q==;
X-CSE-ConnectionGUID: 4D+9sY+eTquFoRzuUqdw5g==
X-CSE-MsgGUID: fqyEj6xOQASGLGyZbXkCug==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="99153069"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="99153069"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:25:35 -0700
X-CSE-ConnectionGUID: Kru5kzBKQKa8am7+6ZIQUw==
X-CSE-MsgGUID: ikCDASAQRvSVrMMGtgyLbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="227158213"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 07 Apr 2026 05:25:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 12E7295; Tue, 07 Apr 2026 14:25:29 +0200 (CEST)
Date: Tue, 7 Apr 2026 15:24:39 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jagan Sridharan <badhri@google.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v10 6/6] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
Message-ID: <adT3h8ZEQh_mFi5j@kuha>
References: <20260331-max77759-charger-v10-0-76f59233c369@google.com>
 <20260331-max77759-charger-v10-6-76f59233c369@google.com>
 <ac5-OzwQkczTWtMg@kuha>
 <017b8552-87e2-4409-ae34-9a3ab7365a68@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017b8552-87e2-4409-ae34-9a3ab7365a68@google.com>

Hi Amit,

On Thu, Apr 02, 2026 at 11:47:30AM -0700, Amit Sunil Dhamne wrote:
> Hi Heikki,
> 
> On 4/2/26 7:33 AM, Heikki Krogerus wrote:
> > Hi Amit,
> > 
> > > +static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
> > > +{
> > > +	if (IS_ERR_OR_NULL(chip->vbus_reg)) {
> > > +		chip->vbus_reg = devm_regulator_get_exclusive(chip->dev,
> > > +							      "vbus");
> > Sorry to go back to this, but why can't you just get the regulator in
> > max_tcpci_probe()?
> 
> Thanks for calling this out. This was an intentional design decision to
> break a circular dependency.
> 
> The charger driver is guaranteed to probe after the TCPC driver due to a
> power supply dependency (the TCPC is a supplier of power for the Battery
> Charger). However, the charger driver is also the regulator provider for
> VBUS out (when Type-C goes into source mode).
> 
> Because of this, the regulator handle will not be available during the TCPC
> driver's probe. If we tried to fetch it in max_tcpci_probe() and returned
> -EPROBE_DEFER, it would create a probe deadlock, as the charger would then
> never probe. Therefore, I made the decision to get the regulator handle
> lazily and on-demand.

Got it. Thanks for the explanation!

-- 
heikki


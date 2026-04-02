Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F553264F5;
	Thu,  2 Apr 2026 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140466; cv=none; b=nhf9fZrGarPhYRAx8ljXWKsk1uK9L6sdXArzNKEu0uUCDIKf2ff9wbS0xPfIoPsG2LBmTa7pNxHPLr20kT4PRAMqxU21FE01AbLHZ7xTdD8jJ+Zzj+3/eKg77AgKX52m3WEaPIN8opEA8sFVjawMKYclgbv/LAfMa/ZSiO3fLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140466; c=relaxed/simple;
	bh=x8FTCBu1ZLI3XgysCKTdvPU6t29kanGzc/hDoIDWGbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0jJ6d2LXXzMrBh3WCb1yQN0bwWgtTWDOpQv/esTcJiLgRf2eiRCCyj29EtLMtMNKiUWGvuf1GgeQI6knnNrk1BoJfPgIOmhDakomR1ZQkxBpSJiEHaEPK4y/wcI6PRRM0UaX/2NO9bBiDycltzjfsOI4SCIXfWYtuQ/so3r3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjIY+mhc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjIY+mhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775140465; x=1806676465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x8FTCBu1ZLI3XgysCKTdvPU6t29kanGzc/hDoIDWGbY=;
  b=EjIY+mhcI75LgVxPYHgJ2V4TP+l49VgS2LfFxavGz2DHhnDQ5i0v57gg
   /O64Uzk/SYCg07Mb6jjlCj44aN+LERXhlY0fnwKfAxbC6ZIyxD58rPkcs
   FhpdLuceIH4Y3vxzWarNvs7bSsiqJYst8hYlzZpDf3jVqiO/1GvGTHjCS
   qkLj4CbaItlXDLSPKN2D5pCsIFOV4HPdrcFxsgLeVkWHTn2As8R31SFMm
   5R8W5cVwU2nYHdvuZ9rcFd04E2qKTX8IH3iZuZ2cGeL5tku1S4En85ksa
   WQf+4ooR9cB6ggU5AsTS3E2PT9X3z3I4pelULqT2Ju7txO2cxmiPOvyPr
   Q==;
X-CSE-ConnectionGUID: vz1A3FZ2SZuwwmTum+/nJg==
X-CSE-MsgGUID: ht2ZhEF8RUW9vf2xXSG7yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75919745"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75919745"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 07:34:24 -0700
X-CSE-ConnectionGUID: IRj/dYM7SrK+dXdHhMcULw==
X-CSE-MsgGUID: r//BrWwvSb+p2ltV6o1Cnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="227258049"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 02 Apr 2026 07:34:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id CF25D95; Thu, 02 Apr 2026 16:34:17 +0200 (CEST)
Date: Thu, 2 Apr 2026 17:33:31 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
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
Message-ID: <ac5-OzwQkczTWtMg@kuha>
References: <20260331-max77759-charger-v10-0-76f59233c369@google.com>
 <20260331-max77759-charger-v10-6-76f59233c369@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-max77759-charger-v10-6-76f59233c369@google.com>

Hi Amit,

> +static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
> +{
> +	if (IS_ERR_OR_NULL(chip->vbus_reg)) {
> +		chip->vbus_reg = devm_regulator_get_exclusive(chip->dev,
> +							      "vbus");

Sorry to go back to this, but why can't you just get the regulator in
max_tcpci_probe()?

thanks,

> +		if (IS_ERR_OR_NULL(chip->vbus_reg)) {
> +			dev_err(chip->dev,
> +				"Failed to get vbus regulator handle\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +}

-- 
heikki

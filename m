Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C5404BDD;
	Thu,  9 Jul 2026 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593236; cv=none; b=GbWNjPwE6wZ9H0/y+k1QHU7JC60FrjZQXFoEi2AFyvUgOmlXWTfHHt470xbLQo1oUTFWFRvPPj8xGYxkapR5VVcRzCZqkqK/mAGJnb4PdPPwZ07fLWz26m7e4uD7JeeQMEDMhvWBnJZ1zfhusQfHjKfIA/O778ucf+Hvt1VxZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593236; c=relaxed/simple;
	bh=bWHIEdjL2dr+L3lteYYp6oLrvxioUMyONYbfmyggoc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7eu/pcBsQ65uyOuPejZAeDY2Vv7oFZcFuDi7DHbdWmJmbjQx6EShhEb4H3WgsyNl6D7E0WPeN3vvIM5mJokv57XW+AmTyHAfYWK5fD2kLSIinz5aMS9+QGZ0wvAkZvHEa7MQud/gPVYy79AAWAauI/iXDlJS5TFm2enkAugEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WotwiPXS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WotwiPXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783593235; x=1815129235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bWHIEdjL2dr+L3lteYYp6oLrvxioUMyONYbfmyggoc0=;
  b=WotwiPXS8CRPgaqjmIHLojPyqOn9ovWnJ+fO3Nb1ctEhWXYaHou5pQ4O
   lQMfpoFt9bcWBvGpfU1dvnirHopGT37l3sOHya5PODLKzs5s9dMbV1Vcc
   EBDypSwNwmb4Hx1x3jUvh8SQP4+JRujh0Ko/H+DGXOhFWFYuhsbz47/sj
   9U8dQFP9AmUPbm5ezTFmyGKJd80T65WohdUXlDlDNxHOFuuUaiJfX5Siv
   ebOEyE38o6ttsYTLLoSUXUMe5WcUW/BwJgHwItkjFUg/OlnSqjEBqn8r+
   Wru3rTvPPgo5AtQbt2oRuQthF+NlPY5Gj8lnGw7wMIWxHv3XjDfB2nzD9
   A==;
X-CSE-ConnectionGUID: aIczG6sXSrS7NX9ztCrjuw==
X-CSE-MsgGUID: 8mZ8FKxwS+ymNQK9KeOg+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94623163"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94623163"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:33:55 -0700
X-CSE-ConnectionGUID: oJJpjx0aQmOy2HToIrIdLA==
X-CSE-MsgGUID: F/+fAyoiRoqqeb7dacv0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252799922"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:33:49 -0700
Date: Thu, 9 Jul 2026 13:33:47 +0300
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
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 03/14] power: sequencing: Add pwrseq_power_is_on()
Message-ID: <ak95C4HVnFn4UEo8@ashevche-desk.local>
References: <20260709095726.704448-1-wenst@chromium.org>
 <20260709095726.704448-4-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709095726.704448-4-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 05:57:08PM +0800, Chen-Yu Tsai wrote:
> The power sequencing consumer API already does power on state tracking
> internally. Expose the state to consumers through pwrseq_power_is_on()
> so that they don't have to reimplement it locally.

...

> Side question: I wonder if making the !POWER_SEQUENCING return success
> would make developers' lives better? At least that is what the clk and

"the clk... mistakenly do."

> regulator consumer APIs do.

When the clock is optional, that is justified, but for non-optional cases it
makes life actually harder (see for IS_ERR_OR_NULL() checks against
devm_clk_*() cases, which Krzysztof targets this cycle to eliminate).

That said, if the pwrseq desc can be NULL and the API tolerates that,
then it might make sense, otherwise it has to return an error.

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21D361643;
	Mon, 23 Feb 2026 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846153; cv=none; b=VULDWEPJrARM4R5jdtFjF5mjj17bH6rFMgj6i7TaVofj5ZHJ4f8o9VBYKiaZpJCeJ37HuaCc/W0qNsrerC9fsYSJeDT1TGA2zOe0N+tTTU44DIOzXIrJ5QW6/TfnwJsmIoHKa6hvAJe5EuCePE8te/tLKQOcFLsMY2jhF2nrXcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846153; c=relaxed/simple;
	bh=fEP1EqpU5pWdSqvz/h+F1omgn6WyLNssApYypg0Qt4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArjmXwCN4jJuzta9t3CnbyJGaxpepgMSmj5rXADzgDenC0O9M1J2v5yjCIMCYW2ALACUbx/nUkTIza/ORkqJCTgWzJARDZK/ntLaQDoj4U1KcZQqN4e1IYrZtMV4kruLpVJHzXpMDykMcG0xIHQUGM9f73SMio43Hf0MqIf4L8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIaDl4MU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIaDl4MU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771846151; x=1803382151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fEP1EqpU5pWdSqvz/h+F1omgn6WyLNssApYypg0Qt4Y=;
  b=nIaDl4MUnZSH+9aHmx7a1H1PStBtMOMYwEDuRzUvA8SP/qczofMkTM2d
   af0J3+uZaEvl303nRAFXDQUp1XUioA30GfjEfSELULm1rAW6FYGl5yjKG
   x85zoKpmjFg/s4IUZmTvBK+2XEM2P177UZgO+C1rB5k3AdnDbl3RSEHI5
   yDKpiTe2QmsyAmNhlRJgdxd3ScptriO7zVYFWfxTn3oc1zz0/Z7S59UW7
   X785rb0gt4UA3bxkaLwtpmhDaFoh8luRTqBB0uH3rdjJ4nWxJQlGgWo82
   Hf+JM3K8sVnfWpuvU+EFdeOYrbzUwqcXTuygvg/BDIDnbZnGIWr5396mC
   g==;
X-CSE-ConnectionGUID: BzXrbkqIQoWZJt/wPkZxrg==
X-CSE-MsgGUID: 4tiyjPyCQVGdoJyWZeXLCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72877447"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72877447"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:29:11 -0800
X-CSE-ConnectionGUID: hD9iXHfERW+iK52sDEl2XQ==
X-CSE-MsgGUID: vl4NaUoVTxiGaBJ/ElX4hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="253256215"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:29:06 -0800
Date: Mon, 23 Feb 2026 13:29:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, driver-core@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH 3/9] power: supply: max77705: Free allocated workqueue
 and fix removal order
Message-ID: <aZw5_66M3jV30c1l@smile.fi.intel.com>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
 <20260223-workqueue-devm-v1-3-10b3a6087586@oss.qualcomm.com>
 <aZwWl57oJln1xH5m@smile.fi.intel.com>
 <388e52a2-4537-46f0-84d9-eb7a1f3b1660@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388e52a2-4537-46f0-84d9-eb7a1f3b1660@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 11:19:13AM +0100, Krzysztof Kozlowski wrote:
> On 23/02/2026 09:57, Andy Shevchenko wrote:
> > On Mon, Feb 23, 2026 at 08:27:31AM +0100, Krzysztof Kozlowski wrote:

...

> >>  	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_CHGIN_I),
> >>  					NULL, max77705_chgin_irq,
> >>  					IRQF_TRIGGER_NONE,
> >>  					"chgin-irq", chg);
> >> -	if (ret) {
> >> -		dev_err_probe(dev, ret, "Failed to Request chgin IRQ\n");
> >> -		goto destroy_wq;
> >> -	}
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Failed to Request chgin IRQ\n");
> > 
> > This should be just
> > 
> > 		return ret;
> > 
> > 
> > devm_*_irq() prints the message. No need to repeat this in the caller(s).
> > 
> 
> I guess separate commit then.

WFM!

-- 
With Best Regards,
Andy Shevchenko



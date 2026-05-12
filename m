Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424F254B18;
	Tue, 12 May 2026 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583781; cv=none; b=R2K5cSIwNRyQwvGMsMWzoijDH1EH9eC+74WQwiANRMgkkHSd1CVOQ5aIIijTqRfCEf7xFxisXD/hrLFAO3oDnlebI01WEayLmIvh+BT9ei+cdjzGV97FL1uRtVPBObhfFrrKgz47ZxiAkOXl8c2OEaR5Wd/JUZ/OmR73hF6AURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583781; c=relaxed/simple;
	bh=211a2Vxapw/LkkPIC3ja7VhK866mFfc0k18gWRdnhG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue3stFRxU+09dwcQJIruQhMJuGMgrmkcm3N2VpcLPEKuZ3ciOElY3INjTz7DXSLWYXLIjpbcu8uhFfVeCEXS1SLFRGwO5hWiSq5vBq9/8sAFf5ja+xmHRjLr9EVLsDMJGWTOqgcELXIf8Z/I3pSs4t5ygdEG4wrCxWi+Il/GjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9TIXKWa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9TIXKWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778583781; x=1810119781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=211a2Vxapw/LkkPIC3ja7VhK866mFfc0k18gWRdnhG4=;
  b=U9TIXKWan48rS+/jlkVbDtacCkw9JNd4CV6mfktT2t4yhSRxKeZy7YD7
   1vrGjklSqDpnB35K89Bqec2Faa9Dp0T7RMieIPahe7rntrXBiuPMePvaw
   I/liu7Q46NNe17fC20J/43hP6RxzSmGoOin5V3VJaeKp/OwX3/yHDHXo0
   kYnQeUFRzVN9+l2F9xg8QuMuc1XwRxdWr7ccsWoFSbMnX/w3Ley7K0uRg
   vIu5MmR8lPkIv+tOgc0++SYInWmhdvCqa4Di5YU6srSPdKR7kti9QlyMc
   /4kWb8dq5MDqhjJxEwCJJM0l9Ye1gI3IHfOLEGKHuwJPW8tWIc0AsCy+k
   w==;
X-CSE-ConnectionGUID: 9YNLjYVTTHWS8eIkd7+FJw==
X-CSE-MsgGUID: zo9fbd7GREmy+LS5SDz1uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79472977"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79472977"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:03:00 -0700
X-CSE-ConnectionGUID: W3uW7XpITSGWtGxlCqug2g==
X-CSE-MsgGUID: o+ExLhcIQcmFTXdW7A7Y+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="242733224"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:02:54 -0700
Date: Tue, 12 May 2026 14:02:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 07/16] thermal: mediatek: add PMIC thermal support
Message-ID: <agMI2phk0AQF6QP9@ashevche-desk.local>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
 <20260512-mt6323-v2-7-3efcba579e88@protonmail.com>
 <CAHp75VfgrbEDLavMKFp2maFCH08RBUxF2wYhh56GG1HCq4ogmA@mail.gmail.com>
 <j2uhavC9edilBoD6VJnlz8cCmMPhE9rQavh1epqLk61zrlZ3k1rqlyj8fVYWnkddIY1fEfPk1DfcW09i39hd-Q7I9Y8Vxd0w8C2eCjVGLc4=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <j2uhavC9edilBoD6VJnlz8cCmMPhE9rQavh1epqLk61zrlZ3k1rqlyj8fVYWnkddIY1fEfPk1DfcW09i39hd-Q7I9Y8Vxd0w8C2eCjVGLc4=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 08:55:44AM +0000, Roman Vivchar wrote:
> On Tuesday, May 12th, 2026 at 10:05 AM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, May 12, 2026 at 8:21 AM Roman Vivchar via B4 Relay
> > <devnull+rva333.protonmail.com@kernel.org> wrote:

...

> > > +#include <linux/kernel.h>
> >
> > No way the driver(s) nowadays use this header. Please, drop it and add
> > the ones that are really in use (there are missing ones).
> 
> Is there a tool or script that can check for IWYU?

The `iwyu` tool with customised configuration is the closest what we have
(but quite far from ideal), you can read this thread [2].

> For example,
> the u32 and s32 types are defined in the asm-generic/int-ll64.h, which
> is not used by any device driver. Instead, types.h should be used.
> It's difficult to guess which header to use for a given type/function.

I know. I got this knowledge because:
- I do a lot of reviews and patches and gathered it from the experience
- I am the one who reshuffled *some* of the headers

> I've tried include-what-you-use [1], but it gives bad results like
> "add #include <asm-generic/int-ll64.h> // for u32".

See above.

> > > +#include <linux/module.h>
> > > +#include <linux/nvmem-consumer.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/property.h>
> > > +#include <linux/regmap.h>
> >
> > > +#include <linux/slab.h>
> >
> > Is it used?
> 
> Yes, without slab.h the __free would complain about missing __free_kfree,
> which is DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T)).

Ah, indeed. I forgot that this is not the part of cleanup.h.

...

> 1: https://github.com/include-what-you-use/include-what-you-use
[2]: https://lore.kernel.org/all/20260512073505.1310-1-joshua.crofts1@gmail.com/

-- 
With Best Regards,
Andy Shevchenko



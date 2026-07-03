Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FD371056;
	Fri,  3 Jul 2026 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085597; cv=none; b=EGUIF4vSlqSOzI42bk38olpp4bWJXFFumBsDkGLVZx0lCr+CqVePfLRNKaL808JwoyUpuRgfyYqENcO92GdqP7XhhASHsqIqCbXsmOTSrc0rdzxzuVkBGbjyxtCARLxaKbOdeDO0bap+ULQm/3uFNfJfYZJb14YTJ1pwaQ9hepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085597; c=relaxed/simple;
	bh=5lQMIgp/+YLQE+iCJ6k4UQOQ5oRotS7kaMpyjTjYKPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz8a02g9o8lJ7PddFB2fJkMF2gDoS5Bvawb8Cs5KWrmsi2XpFicAv/usdIdR/GjdAfRR4FV16DOHAa8RwcA2Gp4dSCn+HvJshjahYiSgbLKmqk9ZdlapJsq3mzUTZdcE7yz8eDjYaNSRshft6Obl59YrIWk1yUDkR5dap3BHrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRHs5NNR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRHs5NNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783085597; x=1814621597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5lQMIgp/+YLQE+iCJ6k4UQOQ5oRotS7kaMpyjTjYKPI=;
  b=IRHs5NNRS/SsSgY5AVVYA71TXSsgCYmizw13HhOyXbJIzbsZ4dDS63jS
   EHtgmvrt14SlQjgC0YCnRl4S32n7RaseROPfVCROQ1YkqQU4a0gUQbrfw
   tvd1O1FB3dIqU5KeBVD4GutuIYMfDdBVypJGqEgnwfxMUxprkVPq5TWbC
   1FJExmzFGl2heUdTDh/vpXinAYmNOd1nQU0c9ft4rCpvZug8NipBhQW3Y
   V9R1/qJs0igeKSJlLZPmwxGBGbbei67KhZIAfj1SzJM5ujyOedJ9dXjq5
   itUAdmggJeS5t8aPvqdYvCfPtiJavoeYwesjPIxHSapG9jlMPN8oSDUu0
   w==;
X-CSE-ConnectionGUID: 1Ne5GxcfSdSFg0PF+UFR1w==
X-CSE-MsgGUID: 3NBGSkStS/qlu8mL/aMrHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="86388923"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="86388923"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:33:16 -0700
X-CSE-ConnectionGUID: U3qX0QxHQa6ijso6F6Apgg==
X-CSE-MsgGUID: 1Fo2kkbCS/OM0FqlPZExfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="248667297"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:33:10 -0700
Date: Fri, 3 Jul 2026 16:33:08 +0300
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
Subject: Re: [PATCH v3 06/13] usb: hub: Pass |struct usb_port*| to
 usb_port_is_power_on()
Message-ID: <ake6FNy83LLtCs3b@ashevche-desk.local>
References: <20260703110317.1283411-1-wenst@chromium.org>
 <20260703110317.1283411-7-wenst@chromium.org>
 <ake09vk4fEv1D9QC@ashevche-desk.local>
 <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 09:17:16PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jul 3, 2026 at 9:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:
> > > usb_port_is_power_on() currently takes |struct usb_hub*|, but only needs
> > > it to tell if the hub/port is SuperSpeed or not.
> > >
> > > In a subsequent change, usb_port_is_power_on() needs access to a pwrseq
> > > state tracking field in |struct usb_port|. Either structure can be used
> > > to identify whether a port/hub is SuperSpeed or not, as the field in
> > > |struct usb_port| is inherited from the hub:
> > >
> > >     port->is_superspeed = hub_is_superspeed(hub)
> > >
> > > Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
> > > |struct usb_port*| so a subsequent change can use it.
> >
> > At a brief look this will be the only function that takes usb_port
> > instead of usb_hub in the entire hub.h (I don't count container_of()
> > as a function). With that being said I would rather see it to be moved
> > to port.c altogether (yes, it's more invasive change, but looks more
> > consistent).  I would even dare to move struct usb_port (and container_of()
> > accompanied with that) and this function to port.h. This might require
> > a separate patch, though.
> 
> I agree with the reasoning, especially given the function name. However
> I wonder if it would cause problems given the linking order. I'll give
> it a try nevertheless and report back.

Thanks!

In case it won't fly (but I still think it's better to split), can you at least
group usb_port APIs and struct? Means moving the proto closer to that struct
usb_port followed by container_of().

> > Perhaps something like: 1) "move struct usb_port and associated APIs to port.h";
> > 2) "...this patch...".

-- 
With Best Regards,
Andy Shevchenko



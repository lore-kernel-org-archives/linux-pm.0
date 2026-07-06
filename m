Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B23F6C4F;
	Mon,  6 Jul 2026 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353660; cv=none; b=j1WBbY86atO8GC5tQ3EdLmCIZSk3DwH/ABrJrWpTjTnS2BIVLWRHM4MhB0MoK6hT/ZWpH/LHHj0+dOIAxY/JRhURpjZGD+bWnI2OXeMnwxnRZcjwbisaj7hRxnCy+PeNQWO/Eb8hML2MJ9Pt2tKh+XL9J6isHetMs3wIL+Ws04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353660; c=relaxed/simple;
	bh=CNeXdCq4YUYr/jn29WXp0/HYvFmsD6R6iES7V1e2kXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIFfLOBp2AZabJk3TQQVwmI/CG7L1zPiynmwNDeyyiwyAvS8mHxVge7uJFhc/tT8CVs8DK0uwAImVGsUzvh01i5MTRNY7MVEvwgJIa5E132RWR3rxzT4h69TNltw5EfE+7Wj0IlpTAkOspXlm7104gCk8PwSaBneZWu2tpb7C2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbIegzf4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbIegzf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783353659; x=1814889659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CNeXdCq4YUYr/jn29WXp0/HYvFmsD6R6iES7V1e2kXU=;
  b=bbIegzf4MGsxr9qRTE6ii1PNH7LpAdrOiLg2dNgpBfZ49GOVcXGLsLLz
   fJVtvR6LW6dQBSsRBsG+IEanPUWIvezt1ntUPlkmRlqrJeQ7agbBbpMla
   DXga+wuNuw6gA8yPMydm9lTj1+KMNgSbgBZe+7fEqp7+3SbLDAiWtG/VB
   nMTF6pzkLtA3ySEbznXpjEyHQVsYlZFr2hu1JmxFKtb0RtshvIWhjye07
   GNHuUzI/9ngxym3DbM9Knf0zQ/k6OLCnrWelxzxRoMOn6lBbB0sO+Tbd+
   l2N6xtPfg8Yjl1ECV8lZuLiWPRC3iL2+XYEe0KAff209dd1xsPZhxDG4P
   Q==;
X-CSE-ConnectionGUID: ltA6oE6/TuaOL3y4o5xIrg==
X-CSE-MsgGUID: iiWqcV4iSpWT/wpn4b8Pcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95370638"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="95370638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:00:57 -0700
X-CSE-ConnectionGUID: W+MT9vknQx+rEQ4fdWnATQ==
X-CSE-MsgGUID: kJ90HQUOT+izFt8uG3wJzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="250408991"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:00:52 -0700
Date: Mon, 6 Jul 2026 19:00:49 +0300
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
Message-ID: <akvRMcGnUPxE3sxR@ashevche-desk.local>
References: <20260703110317.1283411-1-wenst@chromium.org>
 <20260703110317.1283411-7-wenst@chromium.org>
 <ake09vk4fEv1D9QC@ashevche-desk.local>
 <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
 <ake6FNy83LLtCs3b@ashevche-desk.local>
 <CAGXv+5EgpizA3Pc8ScNuChPhvFKWd5F6dxB-wT4-7EwabE-9dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EgpizA3Pc8ScNuChPhvFKWd5F6dxB-wT4-7EwabE-9dQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 07:08:07PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jul 3, 2026 at 9:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Jul 03, 2026 at 09:17:16PM +0800, Chen-Yu Tsai wrote:
> > > On Fri, Jul 3, 2026 at 9:11 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:

...

> > > > At a brief look this will be the only function that takes usb_port
> > > > instead of usb_hub in the entire hub.h (I don't count container_of()
> > > > as a function). With that being said I would rather see it to be moved
> > > > to port.c altogether (yes, it's more invasive change, but looks more
> > > > consistent).  I would even dare to move struct usb_port (and container_of()
> > > > accompanied with that) and this function to port.h. This might require
> > > > a separate patch, though.
> > >
> > > I agree with the reasoning, especially given the function name. However
> > > I wonder if it would cause problems given the linking order. I'll give
> > > it a try nevertheless and report back.
> >
> > Thanks!
> >
> > In case it won't fly (but I still think it's better to split), can you at least
> > group usb_port APIs and struct? Means moving the proto closer to that struct
> > usb_port followed by container_of().
> 
> Looks like it works out fine. port.o is linked in after hub.o, so moving
> the function from the latter to the former doesn't cause issues. One might
> even say that it is the correct thing to do.

That's what I say! :-)

> > > > Perhaps something like: 1) "move struct usb_port and associated APIs to port.h";
> > > > 2) "...this patch...".
> 
> There are still some left in hub.c:
> 
> static void usb_lock_port(struct usb_port *port_dev)
> static void usb_unlock_port(struct usb_port *port_dev)
> static void port_over_current_notify(struct usb_port *port_dev)

> static void hub_usb3_port_prepare_disable(struct usb_hub *hub,
>                                           struct usb_port *port_dev)

This one takes hub as well.

> These are used only in hub.c and moving them probably makes things
> messier?

Perhaps better naming to each (kinda moving to usb hub namespace)?

> OOTH, the following bits are in port.c but declared in hub.h:
> 
> int usb_hub_create_port_device(struct usb_hub *hub,
>          int port1);
> void usb_hub_remove_port_device(struct usb_hub *hub,
>          int port1);
> 
> Any preferences for these while we're reorganizing the code?

These ones would be good to be in hub.c if there is no circular dependencies or
alike.


-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4E390C94;
	Tue,  7 Jul 2026 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415127; cv=none; b=cpsAvuI/uY+U4EvbjFd0VQqwqRhvELIvvK088AEuUj2kc/lgkjSY031NsIf3hmn1JqLkOzGe+QfHnAzW6kPtyd8ZJi4cO2LbAiSvtlSvE4OJo/RmLc4c6TLPxUn3r1aJ7GXo9XR3hlUrej+vCa2ZYGQtuDWfBgR2EsvEtr2Wlu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415127; c=relaxed/simple;
	bh=gKXaUE1a/lj7ODJJG8Iu0vM/NcsyBp3SmPPenh/MKEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxFj7lDAyALU307oTe0LTKzFL/iB8xT5OXCDfqVE5ocDY4EjS4bN01JvVY9xmGWRAdsImK79pee98pYbALC015KY4zQJLnYjFUTVplzW8fc41xdjsxYh0e5lUdtqy404tuaI8x+rxU5rdQ/0Zw+yatJ7YmSn4tfw+mkCNtDJJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkvJ4zQ/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkvJ4zQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783415126; x=1814951126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gKXaUE1a/lj7ODJJG8Iu0vM/NcsyBp3SmPPenh/MKEY=;
  b=CkvJ4zQ/LcA+tTb0HfvPc+BOfNVOqoYcsgECytX//YdH8D/g9Zk3okYh
   0doN4ne67erXR23J33wrge8OfHIzWueDYHcPWXuoikM6CwwKo5IDlhcNi
   kjCQj3/FEwFCX364v/sk5Rjq+wK9rCtAD1UfksTSPIWqUxidM9rG03FEC
   pp3iYucNrZzaqJ5+vhQjfNGnbfqSQjXojHQoaa9aOZNIBSM0zgAAv87CG
   mHTVjE293t5ddjq1euhsxPmNyCtVjn5GNEZaR+wYkN58gz44Ar/bD9E0u
   2FwlAYr+dRpKxYiiEmosdVclhuOPlQb5HQACionzKW4Ul/xMKcyEyelGl
   g==;
X-CSE-ConnectionGUID: mLmplZFXSXm0N/erZowTQA==
X-CSE-MsgGUID: 5PmLlCFHQE+LyO1VDOxc7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="95211606"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95211606"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:05:26 -0700
X-CSE-ConnectionGUID: IE34WxJFSwa0yBGRxtVjhw==
X-CSE-MsgGUID: 5Hee06dDRh+ykBUiAm1gtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="251274968"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.178])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:05:20 -0700
Date: Tue, 7 Jul 2026 12:05:18 +0300
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
Message-ID: <akzBTumMCGFU-zAJ@ashevche-desk.local>
References: <20260703110317.1283411-1-wenst@chromium.org>
 <20260703110317.1283411-7-wenst@chromium.org>
 <ake09vk4fEv1D9QC@ashevche-desk.local>
 <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
 <ake6FNy83LLtCs3b@ashevche-desk.local>
 <CAGXv+5EgpizA3Pc8ScNuChPhvFKWd5F6dxB-wT4-7EwabE-9dQ@mail.gmail.com>
 <akvRMcGnUPxE3sxR@ashevche-desk.local>
 <CAGXv+5EqsDbzTg9eDMGK3Ph6Pe3_uDoSrjVL4q23cy6jZCk2tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EqsDbzTg9eDMGK3Ph6Pe3_uDoSrjVL4q23cy6jZCk2tw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 12:29:05PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jul 7, 2026 at 12:01 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Jul 06, 2026 at 07:08:07PM +0800, Chen-Yu Tsai wrote:
> > > On Fri, Jul 3, 2026 at 9:33 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Jul 03, 2026 at 09:17:16PM +0800, Chen-Yu Tsai wrote:
> > > > > On Fri, Jul 3, 2026 at 9:11 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:

...

> > > > > > At a brief look this will be the only function that takes usb_port
> > > > > > instead of usb_hub in the entire hub.h (I don't count container_of()
> > > > > > as a function). With that being said I would rather see it to be moved
> > > > > > to port.c altogether (yes, it's more invasive change, but looks more
> > > > > > consistent).  I would even dare to move struct usb_port (and container_of()
> > > > > > accompanied with that) and this function to port.h. This might require
> > > > > > a separate patch, though.
> > > > >
> > > > > I agree with the reasoning, especially given the function name. However
> > > > > I wonder if it would cause problems given the linking order. I'll give
> > > > > it a try nevertheless and report back.
> > > >
> > > > Thanks!
> > > >
> > > > In case it won't fly (but I still think it's better to split), can you at least
> > > > group usb_port APIs and struct? Means moving the proto closer to that struct
> > > > usb_port followed by container_of().
> > >
> > > Looks like it works out fine. port.o is linked in after hub.o, so moving
> > > the function from the latter to the former doesn't cause issues. One might
> > > even say that it is the correct thing to do.
> >
> > That's what I say! :-)
> >
> > > > > > Perhaps something like: 1) "move struct usb_port and associated APIs to port.h";
> > > > > > 2) "...this patch...".
> > >
> > > There are still some left in hub.c:
> > >
> > > static void usb_lock_port(struct usb_port *port_dev)
> > > static void usb_unlock_port(struct usb_port *port_dev)
> 
> These are only used internally in hub.c as a wrapper for the port mutex.
> 
> > > static void port_over_current_notify(struct usb_port *port_dev)
> 
> This is only used by the hub's overcurrent event handler.
> 
> > > static void hub_usb3_port_prepare_disable(struct usb_hub *hub,
> > >                                           struct usb_port *port_dev)
> >
> > This one takes hub as well.
> >
> > > These are used only in hub.c and moving them probably makes things
> > > messier?
> >
> > Perhaps better naming to each (kinda moving to usb hub namespace)?
> >
> > > OOTH, the following bits are in port.c but declared in hub.h:
> > >
> > > int usb_hub_create_port_device(struct usb_hub *hub,
> > >          int port1);
> > > void usb_hub_remove_port_device(struct usb_hub *hub,
> > >          int port1);
> > >
> > > Any preferences for these while we're reorganizing the code?
> >
> > These ones would be good to be in hub.c if there is no circular dependencies or
> > alike.
> 
> Those two, along with all the static functions they call, ends up being
> half of port.c. That doesn't help the size of hub.c, which is already
> over 6000 lines. I think I'll leave this one as is.

For now, perhaps at some point in the future we can reconsider and refactor
it more.

> Both this part and the remaining bits in hub.c I mentioned above are
> outside the scope of this series. We can discuss whether they really
> need to be moved or renamed.

Sure.

-- 
With Best Regards,
Andy Shevchenko



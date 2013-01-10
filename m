From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/9] Thermal: Make PER_ZONE values configurable
Date: Thu, 10 Jan 2013 06:27:38 -0800
Message-ID: <20130110142738.GA15787@kroah.com>
References: <1357542806-20449-1-git-send-email-durgadoss.r@intel.com>
 <1357542806-20449-8-git-send-email-durgadoss.r@intel.com>
 <20130107192414.GC4465@kroah.com>
 <4D68720C2E767A4AA6A8796D42C8EB59257F01@BGSMSX101.gar.corp.intel.com>
 <20130109170023.GA7068@kroah.com>
 <4D68720C2E767A4AA6A8796D42C8EB59258F12@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:62344 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab3AJO1E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jan 2013 09:27:04 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so386192pad.17
        for <linux-pm@vger.kernel.org>; Thu, 10 Jan 2013 06:27:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59258F12@BGSMSX101.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

On Thu, Jan 10, 2013 at 12:43:16PM +0000, R, Durgadoss wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Wednesday, January 09, 2013 10:30 PM
> > To: R, Durgadoss
> > Cc: Zhang, Rui; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > eduardo.valentin@ti.com; hongbo.zhang@linaro.org; wni@nvidia.com
> > Subject: Re: [PATCH 7/9] Thermal: Make PER_ZONE values configurable
> > 
> > On Wed, Jan 09, 2013 at 09:12:29AM +0000, R, Durgadoss wrote:
> > > Hi Greg,
> > >
> > > > -----Original Message-----
> > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > Sent: Tuesday, January 08, 2013 12:54 AM
> > > > To: R, Durgadoss
> > > > Cc: Zhang, Rui; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > eduardo.valentin@ti.com; hongbo.zhang@linaro.org; wni@nvidia.com
> > > > Subject: Re: [PATCH 7/9] Thermal: Make PER_ZONE values configurable
> > > >
> > > > On Mon, Jan 07, 2013 at 12:43:24PM +0530, Durgadoss R wrote:
> > > > > This patch makes MAX_SENSORS_PER_ZONE and
> > > > > MAX_CDEVS_PER_ZONE values configurable. The
> > > > > default value is 1, and range is 1-12.
> > > >
> > > > Why would we ever want to change this?  Why make this configurable at
> > > > all, how is a distro supposed to set this value?
> > > >
> > > > Shouldn't it be specified from the driver itself?
> > >
> > > These are platform level parameters, that can differ for various platforms.
> > > (Mostly due to board design and thermistor layouts). Stand-alone thermal
> > > sensor drivers are not (need not be) aware of these values.
> > 
> > Ok, and how does anyone know how to set them properly?
> > 
> > > That's why these values are made configurable.
> > 
> > Pushing work onto other people, without telling them what they need to
> > do, isn't nice.  Please, either make it auto-configurable, or don't make
> > it configurable at all.  As it is, this is useless for a distro, or any
> > "normal" user, right?
> 
> These values are for OEM's to configure according to their platform design.
> So, not making them configurable won't be good IMHO.

Ok, but you are guaranteeing that the same kernel can not work on
multiple platforms, which is something that people have been working
very hard to solve.

So again, please make this a platform data field, or autoconfigurable,
and not a kernel build time configuration option, that isn't acceptable
anymore.

thanks,

greg k-h

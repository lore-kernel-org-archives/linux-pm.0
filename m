From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 7/9] Thermal: Make PER_ZONE values configurable
Date: Wed, 9 Jan 2013 09:12:29 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59257F01@BGSMSX101.gar.corp.intel.com>
References: <1357542806-20449-1-git-send-email-durgadoss.r@intel.com>
 <1357542806-20449-8-git-send-email-durgadoss.r@intel.com>
 <20130107192414.GC4465@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:40127 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756879Ab3AIJMd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jan 2013 04:12:33 -0500
In-Reply-To: <20130107192414.GC4465@kroah.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

Hi Greg,

> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Tuesday, January 08, 2013 12:54 AM
> To: R, Durgadoss
> Cc: Zhang, Rui; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> eduardo.valentin@ti.com; hongbo.zhang@linaro.org; wni@nvidia.com
> Subject: Re: [PATCH 7/9] Thermal: Make PER_ZONE values configurable
> 
> On Mon, Jan 07, 2013 at 12:43:24PM +0530, Durgadoss R wrote:
> > This patch makes MAX_SENSORS_PER_ZONE and
> > MAX_CDEVS_PER_ZONE values configurable. The
> > default value is 1, and range is 1-12.
> 
> Why would we ever want to change this?  Why make this configurable at
> all, how is a distro supposed to set this value?
> 
> Shouldn't it be specified from the driver itself?

These are platform level parameters, that can differ for various platforms.
(Mostly due to board design and thermistor layouts). Stand-alone thermal
sensor drivers are not (need not be) aware of these values.
That's why these values are made configurable.

Thanks,
Durga

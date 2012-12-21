From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 0/8] Thermal Framework Enhancements
Date: Fri, 21 Dec 2012 08:30:50 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5924D729@BGSMSX101.gar.corp.intel.com>
References: <1355822977-4804-1-git-send-email-durgadoss.r@intel.com>
 <50D41860.7040406@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2418 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab2LUIb2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Dec 2012 03:31:28 -0500
In-Reply-To: <50D41860.7040406@nvidia.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>

Hi Ni,

> -----Original Message-----
> From: Wei Ni [mailto:wni@nvidia.com]
> Sent: Friday, December 21, 2012 1:36 PM
> To: R, Durgadoss
> Cc: Zhang, Rui; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> hongbo.zhang@linaro.org
> Subject: Re: [PATCH 0/8] Thermal Framework Enhancements
> 
> On 12/18/2012 05:29 PM, Durgadoss R wrote:
> > This patch is a v1 based on the RFC submitted here:
> > https://patchwork.kernel.org/patch/1758921/
> >
> > This patch set is based on Rui's -thermal tree, and is
> > tested on a Core-i5 and an Atom netbook.
> >
> > This series contains 8 patches:
> > Patch 1/8: Creates new sensor level APIs
> > Patch 2/8: Creates new zone level APIs. The existing tzd structure is
> >            kept as such for clarity and compatibility purposes.
> > Patch 3/8: Creates functions to add/remove a cdev to/from a zone. The
> >            existing tcd structure need not be modified.
> > Patch 4/8: Adds a thermal_trip sysfs node, which exposes various trip
> >            points for all sensors present in a zone.
> > Patch 5/8: Adds a thermal_map sysfs node. It is a compact representation
> >            of the binding relationship between a sensor and a cdev,
> >            within a zone.
> > Patch 6/8: Creates Documentation for the new APIs. A new file is
> >            created for clarity. Final goal is to merge with the existing
> >            file or refactor the files, as whatever seems appropriate.
> > Patch 7/8: Make PER ZONE values configurable through Kconfig
> > Patch 8/8: A dummy driver that can be used for testing. This is not for
> merge.
> 
> I read these patches, they create new APIs and sysfs, but it seems they
> didn't use the thermal_zone to handle the thermal_throttle issue,
> something like update thermal_zone, update temperature, handle
> governors
> when cross the trip temp. So will you send out next serial patches for
> these implementation?

Yes, once these get into Rui's tree, we will start migrating the existing drivers/
and governors, to get things working.

Thanks,
Durga

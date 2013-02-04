From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCHv2 0/9] Thermal Framework Enhancements
Date: Mon, 4 Feb 2013 06:37:27 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59275C20@BGSMSX101.gar.corp.intel.com>
References: <1357542806-20449-1-git-send-email-durgadoss.r@intel.com>
 <510F49A2.4080701@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <510F49A2.4080701@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Wei,

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Wei Ni
> Sent: Monday, February 04, 2013 11:10 AM
> To: R, Durgadoss
> Cc: Zhang, Rui; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> eduardo.valentin@ti.com; hongbo.zhang@linaro.org
> Subject: Re: [PATCHv2 0/9] Thermal Framework Enhancements
> 
> On 01/07/2013 03:13 PM, Durgadoss R wrote:
> > This patch set is a v2 of the previous versions submitted here:
> > [v1]:  https://lkml.org/lkml/2012/12/18/108
> > [RFC]: https://patchwork.kernel.org/patch/1758921/
> >
> > This patch set is based on Rui's -thermal tree, and is
> > tested on a Core-i5 and an Atom netbook.
> >
> > Changes Since v1:
> >  * Removed kobject creation for thermal_trip and thermal_map
> >    nodes as per Greg-KH's comments.
> >  * Added ABI Documentation under 'testing'.
> >  * Modified the GET_INDEX macro to be more linux-like, thanks
> >    to Joe Perches.
> >  * Added get_[sensor/cdev]_by_name APIs to thermal.h
> 
> Hi, Durgadoss and Rui
> Will these patches be merged to next branch? or will you send out next
> version?

Yes, I have to send the v3, with some small changes on the patch 5/9
(map sysfs node..) and others won't have any changes.

> I wish to use this new framework, could I send out patches for RFC based
> on this serial patches?

So, if your patch set does not need 5/9, you can send your RFC.

Thanks,
Durga

> 
> Thanks.
> Wei.
> 
> >
> > This series contains 9 patches:
> > Patch 1/9: Creates new sensor level APIs
> > Patch 2/9: Creates new zone level APIs. The existing tzd structure is
> >            kept as such for clarity and compatibility purposes.
> > Patch 3/9: Creates functions to add/remove a cdev to/from a zone. The
> >            existing tcd structure need not be modified.
> > Patch 4/9: Adds sensorX_trip_[active/passive/hot/critical] sysfs nodes,
> > 	   under /sys/class/thermal/zoneY/. This exposes various trip
> >            points for sensorX present in zoneY.
> > Patch 5/9: Adds mapX sysfs node. It is a compact representation
> >            of the binding relationship between a sensor and a cdev,
> >            within a zone.
> > Patch 6/9: Creates Documentation for the new APIs. A new file is
> >            created for clarity. Final goal is to merge with the existing
> >            file or refactor the files, as whatever seems appropriate.
> > Patch 7/9: Make PER ZONE values configurable through Kconfig
> > Patch 8/9: Add ABI documentation for sysfs interfaces introduced in this
> patch.
> > Patch 9/9: A dummy driver that can be used for testing. This is not for
> merge.
> >
> > Thanks to Greg-KH, Hongbo Zhang and Joe Perches for their comments on
> v1.
> >
> > Durgadoss R (9):
> >   Thermal: Create sensor level APIs
> >   Thermal: Create zone level APIs
> >   Thermal: Add APIs to bind cdev to new zone structure
> >   Thermal: Add trip point sysfs nodes for sensor
> >   Thermal: Create 'mapX' sysfs node for a zone
> >   Thermal: Add Documentation to new APIs
> >   Thermal: Make PER_ZONE values configurable
> >   Thermal: Add ABI Documentation for sysfs interfaces
> >   Thermal: Dummy driver used for testing
> >
> >  Documentation/ABI/testing/sysfs-class-thermal |   93 +++
> >  Documentation/thermal/sysfs-api2.txt          |  248 +++++++
> >  drivers/thermal/Kconfig                       |   19 +
> >  drivers/thermal/Makefile                      |    3 +
> >  drivers/thermal/thermal_sys.c                 |  881
> +++++++++++++++++++++++++
> >  drivers/thermal/thermal_test.c                |  315 +++++++++
> >  include/linux/thermal.h                       |  117 +++-
> >  7 files changed, 1675 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-thermal
> >  create mode 100644 Documentation/thermal/sysfs-api2.txt
> >  create mode 100644 drivers/thermal/thermal_test.c
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

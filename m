From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: [RFC PATCH 0/7] Support for Multiple sensors per zone
Date: Mon, 3 Dec 2012 17:01:19 +0800
Message-ID: <CAJLyvQxn_cfYeJZ+XFaM8HZBq6mNRh5R-VtX2vN92Dp+S_9Mgw@mail.gmail.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:38449 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab2LCJBU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Dec 2012 04:01:20 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so1980596iay.19
        for <linux-pm@vger.kernel.org>; Mon, 03 Dec 2012 01:01:20 -0800 (PST)
In-Reply-To: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, wni@nvidia.com, eduardo.valentin@ti.com, amit.kachhap@linaro.org, sachin.kamat@linaro.org

On 17 November 2012 18:45, Durgadoss R <durgadoss.r@intel.com> wrote:
> This patch series attempts to add support for multiple
> sensors per zone. The work is based on the Thermal discussion
> happened in plumbers conference 2012, here:
> http://www.linuxplumbersconf.org/2012/schedule/
> Title: "Enhancing the Thermal Management Infrastructure in Linux"
>
> The intention is to make it easy for generic sensor drivers
> to register with the framework, and let them participate in
> platform thermal management. Another goal is to expose the
> binding information in a consistent way so that user space
> can consume the information and potentially manage platform thermals.
>
> This series contains 7 patches:
> Patch 1/7: Creates new sensor level APIs
> Patch 2/7: Creates new zone level APIs. The existing tzd structure is
>            kept as such for clarity and compatibility purposes.
> Patch 3/7: Creates functions to add/remove a cdev to/from a zone. The
>            existing tcd structure need not be modified.
> Patch 4/7: Adds a thermal_trip sysfs node, which exposes various trip
>            points for all sensors present in a zone.
> Patch 5/7: Adds a thermal_map sysfs node. It is a compact representation
>            of the binding relationship between a sensor and a cdev,
>            within a zone.
> Patch 6/7: Creates Documentation for the new APIs. A new file is
>            created for clarity. Final goal is to merge with the existing
>            file or refactor the files, as whatever seems appropriate.
> Patch 7/7: A dummy driver that can be used for testing. This is not for merge.
>
> Next steps:
Do you have milestone?
Because new thermal driver writers are wondering if to use the old
framework or can wait the new one.
>  1. Move all the existing drivers to the new implementation model.
>     Help welcomed from individual driver authors/maintainers for this.
>  2. Make the thermal governors work with this new model.
>  3. Remove old/unused code from thermal_sys.c.
>  4. Add more detailed documentation
>
>  I didn't want to submit patches for all these in one-go, since it
>  might end-up being difficult to comprehend, besides delaying the
>  review process. The other obvious reason being I cannot test all
>  the changes on various drivers for 1.
>
>  All these patches have been tested on a Core-i5 desktop running
>  ubuntu 12.04 and an atom notebook running ubuntu 11.10.
>  Kindly help review.
>
> Durgadoss R (7):
>   Thermal: Create sensor level APIs
>   Thermal: Create zone level APIs
>   Thermal: Add APIs to bind cdev to new zone structure
>   Thermal: Add Thermal_trip sysfs node
>   Thermal: Add 'thermal_map' sysfs node
>   Thermal: Add Documentation to new APIs
>   Thermal: Dummy driver used for testing
>
>  Documentation/thermal/sysfs-api2.txt |  213 ++++++++
>  drivers/thermal/Kconfig              |    5 +
>  drivers/thermal/Makefile             |    3 +
>  drivers/thermal/thermal_sys.c        |  915 ++++++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_test.c       |  321 ++++++++++++
>  include/linux/thermal.h              |  118 +++++
>  6 files changed, 1575 insertions(+)
>  create mode 100644 Documentation/thermal/sysfs-api2.txt
>  create mode 100644 drivers/thermal/thermal_test.c
>
> --
> 1.7.9.5
>

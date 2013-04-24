From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCHv2 0/9] thermal: clean ups on thermal code base
Date: Wed, 24 Apr 2013 16:54:42 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092632CA11C@SHSMSX101.ccr.corp.intel.com>
References: <1366753700-1412-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33287 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978Ab3DXQyq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2013 12:54:46 -0400
In-Reply-To: <1366753700-1412-1-git-send-email-eduardo.valentin@ti.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Eduardo,

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> Sent: Wednesday, April 24, 2013 5:48 AM
> To: Zhang, Rui
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Eduardo
> Valentin
> Subject: [PATCHv2 0/9] thermal: clean ups on thermal code base
> Importance: High
> 
> Hello Rui,
> 
> This is v2 of this series. I have worked on the comments you sent on
> these patches. For your reference, v1 has been reviewed at [1].
> 
All the patches in this series has been applied.

Thanks,
rui

> Summary of changelog:
> - Added your acked-by on those patches you granted.
> - Fixed the comments regarding functions that are not going to be
> exported.
> - Removed patches that are touching functions that are not going to be
> exported.
> 
> Also available, as usual, here:
> git@gitorious.org:thermal-framework/thermal-framework.git
> thermal_work/thermal_core/coding_style
> https://git.gitorious.org/thermal-framework/thermal-framework.git
> thermal_work/thermal_core/coding_style
> 
> The above branches are based on linux-next/master.
> 
> All best,
> 
> [1] - https://lkml.org/lkml/2013/4/8/471
> 
> Eduardo Valentin (9):
>   thermal: use strlcpy instead of strcpy
>   thermal: update driver license
>   thermal: rename notify_thermal_framework to thermal_notify_framework
>   thermal: use EXPORT_SYMBOL_GPL
>   thermal: update kernel-doc for thermal_zone_bind_cooling_device
>   thermal: update kernel-doc for thermal_zone_unbind_cooling_device
>   thermal: update kernel-doc for thermal_cooling_device_register
>   thermal: update kernel-doc for create_trip_attrs
>   thermal: update kernel-doc for thermal_zone_device_register
> 
>  Documentation/thermal/sysfs-api.txt |  2 +-
>  drivers/thermal/thermal_core.c      | 80 ++++++++++++++++++++++++++---
> --------
>  include/linux/thermal.h             |  2 +-
>  3 files changed, 59 insertions(+), 25 deletions(-)
> 
> --
> 1.8.2.1.342.gfa7285d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html

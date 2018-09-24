From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 01/17] thermal: add thermal_zone_device_toggle() helper
Date: Mon, 24 Sep 2018 09:46:53 -0700
Message-ID: <20180924164651.GC4988@localhost.localdomain>
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180410124248epcas1p453f74df4e183f9d68de255847c093d4e@epcas1p4.samsung.com>
 <1523364131-31059-2-git-send-email-b.zolnierkie@samsung.com>
 <20180910171605.GA4196@localhost.localdomain>
 <0495124b-9ae8-3b4b-5f0c-208d2e06e5a5@samsung.com>
 <20180917093401eucas1p1f1e0de762a88b1327ba229971996e5da~VJjFwrEK11702417024eucas1p1m@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917093401eucas1p1f1e0de762a88b1327ba229971996e5da~VJjFwrEK11702417024eucas1p1m@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On Mon, Sep 17, 2018 at 11:33:59AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 09/14/2018 01:40 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> [...]
> 
> >>> --- a/include/linux/thermal.h
> >>> +++ b/include/linux/thermal.h
> >>> @@ -467,6 +467,7 @@ struct thermal_cooling_device *
> >>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
> >>>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
> >>>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
> >>> +int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on);
> >>>  
> >>
> >> You missed the #else section of the #if IS_ENABLED(CONFIG_THERMAL),
> >> didn't you?
> > 
> > No, this function shouldn't be used outside of CONFIG_THERMAL.
> 
> Please disregard my previous comment. I see now that the CONFIG_THERMAL=n
> stub is needed and I will add it in the next patch revision.

Thanks Bartolomiej for keeping this up.

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

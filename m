From: Manu Gautam <mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3 2/3] usb: phy: Add USB charger support
Date: Tue, 25 Jul 2017 16:49:31 +0530
Message-ID: <a4cdd6e0-83a2-7946-9ca3-986f9ff13315@codeaurora.org>
References: <cover.1500968744.git.baolin.wang@linaro.org>
 <0bfc4d3534a7cc735ef213da8d280a4a79629c0d.1500968745.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0bfc4d3534a7cc735ef213da8d280a4a79629c0d.1500968745.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: jun.li-3arQi8VN3Tc@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, neilb-IBi9RG/b67k@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,


On 7/25/2017 1:30 PM, Baolin Wang wrote:
> This patch introduces the usb charger support based on usb phy that
> makes an enhancement to a power driver. The basic conception of the
> usb charger is that, when one usb charger is added or removed by
> reporting from the extcon device state change, the usb charger will
> report to power user to set the current limitation.
>
> Power user can register a notifiee on the usb phy by issuing
> usb_register_notifier() to get notified by charger status changes
> or charger current changes.

Why can't we use power_supply framework for this?
Power user can register usb power_supply and USB PHY driver
can update charging current using - power_supply_set_property().



> we can notify what current to be drawn to power user according to
> different charger type, and now we have 2 methods to get charger type.
> One is get charger type from extcon subsystem, which also means the
> charger state changes. Another is we can get the charger type from
> USB controller detecting or PMIC detecting, and the charger state
> changes should be told by issuing usb_phy_set_charger_state().
>
> Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/usb/phy/phy.c   |  272 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb/phy.h |   49 +++++++++

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

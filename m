From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] extcon: Split out extcon header file for consumer
 and provider device
Date: Mon, 23 Oct 2017 14:31:51 +0900
Message-ID: <59ED7EC7.3030204@samsung.com>
References: <CGME20171010101758epcas2p3b3f379076f5be5e81edee2bd00354c28@epcas2p3.samsung.com>
        <1507630671-23536-1-git-send-email-cw00.choi@samsung.com>
        <59DEE429.2000608@samsung.com> <59E6B90F.8000808@samsung.com>
        <fc19204f-c3a8-eccc-98df-e08aa27934fe@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-reply-to: <fc19204f-c3a8-eccc-98df-e08aa27934fe@ti.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, balbi@kernel.org, sre@kernel.org, lee.jones@linaro.org, heiko@sntech.de, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, wens@csie.org
Cc: gregkh@linuxfoundation.org, krzk@kernel.org, b.zolnierkie@samsung.com, chanwoo@kernel.org, myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dear all,

I got the reviews from all maintainers related to this patch.
So, I make the immutable branch on extcon.git and then send
the pull request in order to prevent the possible merge conflict.

Best Regards,
Chanwoo Choi
Samsung Electronics


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git ib-extcon-v4.15

for you to fetch changes up to 176aa36012135d172394a928a03fb03dfecd83f9:

  extcon: Split out extcon header file for consumer and provider device (2017-10-23 14:07:58 +0900)

----------------------------------------------------------------
Chanwoo Choi (1):
      extcon: Split out extcon header file for consumer and provider device

 drivers/extcon/extcon-adc-jack.c              |   2 +-
 drivers/extcon/extcon-arizona.c               |   2 +-
 drivers/extcon/extcon-axp288.c                |   2 +-
 drivers/extcon/extcon-gpio.c                  |   2 +-
 drivers/extcon/extcon-intel-cht-wc.c          |   2 +-
 drivers/extcon/extcon-intel-int3496.c         |   2 +-
 drivers/extcon/extcon-max14577.c              |   2 +-
 drivers/extcon/extcon-max3355.c               |   2 +-
 drivers/extcon/extcon-max77693.c              |   2 +-
 drivers/extcon/extcon-max77843.c              |   2 +-
 drivers/extcon/extcon-max8997.c               |   2 +-
 drivers/extcon/extcon-qcom-spmi-misc.c        |   2 +-
 drivers/extcon/extcon-rt8973a.c               |   2 +-
 drivers/extcon/extcon-sm5502.c                |   2 +-
 drivers/extcon/extcon-usb-gpio.c              |   2 +-
 drivers/extcon/extcon-usbc-cros-ec.c          |   2 +-
 drivers/extcon/extcon.h                       |   2 +-
 drivers/phy/allwinner/phy-sun4i-usb.c         |   2 +-
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c     |   2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |   2 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   2 +-
 drivers/power/supply/qcom_smbb.c              |   2 +-
 drivers/usb/gadget/udc/renesas_usb3.c         |   2 +-
 drivers/usb/phy/phy-tahvo.c                   |   2 +-
 include/linux/extcon-provider.h               | 142 ++++++++++++++++++++++++++
 include/linux/extcon.h                        | 109 +-------------------
 include/linux/mfd/palmas.h                    |   2 +-
 27 files changed, 172 insertions(+), 129 deletions(-)
 create mode 100644 include/linux/extcon-provider.h


On 2017년 10월 23일 14:05, Kishon Vijay Abraham I wrote:
> 
> 
> On Wednesday 18 October 2017 07:44 AM, Chanwoo Choi wrote:
>> Gently Ping.
>>
>> Dear Kishon,
>>
>> Could you please review this patch for 'drivers/phy/*'?
> 
> sorry for the delay.. here it is
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Regards,
>> Chanwoo Choi
>>
>> On 2017년 10월 12일 12:40, Chanwoo Choi wrote:
>>> Dear Kishon,
>>>
>>> Could you please review this patch?
>>> After that, I'll make the immutable brand and then send the pull request
>>> for power_supply, mfd, phy, usb and extcon framework.
>>>
>>> On 2017년 10월 10일 19:17, Chanwoo Choi wrote:
>>>> The extcon has two type of extcon devices as following.
>>>> - 'extcon provider deivce' adds new extcon device and detect the
>>>>    state/properties of external connector. Also, it notifies the
>>>>    state/properties to the extcon consumer device.
>>>> - 'extcon consumer device' gets the change state/properties
>>>>    from extcon provider device.
>>>> Prior to that, include/linux/extcon.h contains all exported API for
>>>> both provider and consumer device driver. To clarify the meaning of
>>>> header file and to remove the wrong use-case on consumer device,
>>>> this patch separates into extcon.h and extcon-provider.h.
>>>>
>>>> [Description for include/linux/{extcon.h|extcon-provider.h}]
>>>> - extcon.h includes the extcon API and data structure for extcon consumer
>>>>   device driver. This header file contains the following APIs:
>>>>   : Register/unregister the notifier to catch the change of extcon device
>>>>   : Get the extcon device instance
>>>>   : Get the extcon device name
>>>>   : Get the state of each external connector
>>>>   : Get the property value of each external connector
>>>>   : Get the property capability of each external connector
>>>>
>>>> - extcon-provider.h includes the extcon API and data structure for extcon
>>>>   provider device driver. This header file contains the following APIs:
>>>>   : Include 'include/linux/extcon.h'
>>>>   : Allocate the memory for extcon device instance
>>>>   : Register/unregister extcon device
>>>>   : Set the state of each external connector
>>>>   : Set the property value of each external connector
>>>>   : Set the property capability of each external connector
>>>>
>>>> Cc: Felipe Balbi <balbi@kernel.org>
>>>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>>>> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>> Changes from v1:
>>>> - Don't touch drivers/usb/renesas_usbhs/common.h.
>>>> - Add acked-by from Sebastian Reichel (for drivers/power/supply/)
>>>> - Add acked-by from Chen-Yu Tsai (for phy-sun4i-usb.c & extcon-axp288.c)
>>>> - Add acked-by from Charles Keepax (for drivers/extcon/extcon-arizona.c)
>>>> - Add acked-by from Lee Jones (fo include/linux/mfd/palmas.h)
>>>>
>>>>  drivers/extcon/extcon-adc-jack.c              |   2 +-
>>>>  drivers/extcon/extcon-arizona.c               |   2 +-
>>>>  drivers/extcon/extcon-axp288.c                |   2 +-
>>>>  drivers/extcon/extcon-gpio.c                  |   2 +-
>>>>  drivers/extcon/extcon-intel-cht-wc.c          |   2 +-
>>>>  drivers/extcon/extcon-intel-int3496.c         |   2 +-
>>>>  drivers/extcon/extcon-max14577.c              |   2 +-
>>>>  drivers/extcon/extcon-max3355.c               |   2 +-
>>>>  drivers/extcon/extcon-max77693.c              |   2 +-
>>>>  drivers/extcon/extcon-max77843.c              |   2 +-
>>>>  drivers/extcon/extcon-max8997.c               |   2 +-
>>>>  drivers/extcon/extcon-qcom-spmi-misc.c        |   2 +-
>>>>  drivers/extcon/extcon-rt8973a.c               |   2 +-
>>>>  drivers/extcon/extcon-sm5502.c                |   2 +-
>>>>  drivers/extcon/extcon-usb-gpio.c              |   2 +-
>>>>  drivers/extcon/extcon-usbc-cros-ec.c          |   2 +-
>>>>  drivers/extcon/extcon.h                       |   2 +-
>>>>  drivers/phy/allwinner/phy-sun4i-usb.c         |   2 +-
>>>>  drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c     |   2 +-
>>>>  drivers/phy/renesas/phy-rcar-gen3-usb2.c      |   2 +-
>>>>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   2 +-
>>>>  drivers/power/supply/qcom_smbb.c              |   2 +-
>>>>  drivers/usb/gadget/udc/renesas_usb3.c         |   2 +-
>>>>  drivers/usb/phy/phy-tahvo.c                   |   2 +-
>>>>  include/linux/extcon-provider.h               | 142 ++++++++++++++++++++++++++
>>>>  include/linux/extcon.h                        | 109 +-------------------
>>>>  include/linux/mfd/palmas.h                    |   2 +-
>>>>  27 files changed, 172 insertions(+), 129 deletions(-)
>>>>  create mode 100644 include/linux/extcon-provider.h

[snip]

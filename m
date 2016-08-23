From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/6] power: add power sequence library
Date: Tue, 23 Aug 2016 15:52:57 +0530
Message-ID: <887e1002-40f3-8ed6-a2d7-79d13fb64c22@linaro.org>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468375610-18625-1-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On Wednesday 13 July 2016 07:36 AM, Peter Chen wrote:
> Hi all,
>
> This is a follow-up for my last power sequence framework patch set [1].
> According to Rob Herring and Ulf Hansson's comments[2], I use a generic
> power sequence library for parsing the power sequence elements on DT,
> and implement generic power sequence on library. The host driver
> can allocate power sequence instance, and calls pwrseq APIs accordingly.
>
> In future, if there are special power sequence requirements, the special
> power sequence library can be created.
>
> This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> two hot-plug devices to simulate this use case, the related binding
> change is updated at patch[1/6], The udoo board changes were tested
> using my last power sequence patch set.[3]
>
> Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> need to power on itself before it can be found by ULPI bus.

Sorry being so late in the discussion...

If I am not missing anything, then I am afraid to say that the generic 
library
implementation in this patch series is not going to solve many of the custom
requirement of power on, off, etc...
I know you mentioned about adding another library when we come
across such platforms, but should we not keep provision (or easy hooks/path)
to enable that ?

Let me bring in the use case I am dealing with,


                               Host
                                  ||
                                  V
                            USB port
------------------------------------------------------------
                                  ||
                                  V
                       USB HUB device (May need custom on/off seq)
                                  ||
                                  V
               ==================
              ||                                              ||
              V                                              V
         Device-1                                Device-2
(Needs special power               (Needs special power
  on/off sequence.                       on/off sequence.
Also may need custom              Also, may need custom
sequence for                             sequence for
suspend/resume)                      suspend/resume).


Note: Both Devices are connected to HUB via HSIC and may differ
           in terms of functionality, features they support.

In the above case, both Device-1 and Device-2, need separate
power on/off sequence. So generic library currently we have in this
patch series is not going to satisfy the need here.

I looked at all 6 revisions of this patch-series, went through the
review comments, and looked at MMC power sequence code;
what I can say here is, we need something similar to
MMC power sequence here, where every device can have its own
power sequence (if needed).

I know Rob is not in favor of creating platform device for
this, and I understand his comment.
If not platform device, but atleast we need mechanism to
connect each device back to its of_node and its respective
driver/library fns. For example, the Devices may support different
boot modes, and platform driver needs to make sure that
the right sequence is followed for booting.

Peter, My apologies for taking you back again on this series.
I am OK, if you wish to address this in incremental addition,
but my point is, we know that the current generic way is not
enough for us, so I think we should try to fix it in initial phase only.


Thanks,
Vaibhav

> [1] http://www.spinics.net/lists/linux-usb/msg142755.html
> [2] http://www.spinics.net/lists/linux-usb/msg143106.html
> [3] http://www.spinics.net/lists/linux-usb/msg142815.html
>
> Changes for v2:
> - Delete "pwrseq" prefix and clock-names for properties at dt binding
> - Should use structure not but its pointer for kzalloc
> - Since chipidea core has no of_node, let core's of_node equals glue
>    layer's at core's probe
>
>
> Peter Chen (6):
>    binding-doc: power: pwrseq-generic: add binding doc for generic power
>      sequence library
>    power: add power sequence library
>    binding-doc: usb: usb-device: add optional properties for power
>      sequence
>    usb: core: add power sequence handling for USB devices
>    usb: chipidea: let chipidea core device of_node equal's glue layer
>      device of_node
>    ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property
>
>   .../bindings/power/pwrseq/pwrseq-generic.txt       |  53 ++++++++
>   .../devicetree/bindings/usb/usb-device.txt         |   9 ++
>   arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  27 +++--
>   drivers/power/Kconfig                              |   1 +
>   drivers/power/Makefile                             |   1 +
>   drivers/power/pwrseq/Kconfig                       |  20 +++
>   drivers/power/pwrseq/Makefile                      |   2 +
>   drivers/power/pwrseq/core.c                        |  79 ++++++++++++
>   drivers/power/pwrseq/pwrseq_generic.c              | 134 +++++++++++++++++++++
>   drivers/usb/chipidea/core.c                        |  10 ++
>   drivers/usb/core/Makefile                          |   1 +
>   drivers/usb/core/hub.c                             |  12 +-
>   drivers/usb/core/hub.h                             |  12 ++
>   drivers/usb/core/pwrseq.c                          | 102 ++++++++++++++++
>   include/linux/power/pwrseq.h                       |  55 +++++++++
>   15 files changed, 502 insertions(+), 16 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>   create mode 100644 drivers/power/pwrseq/Kconfig
>   create mode 100644 drivers/power/pwrseq/Makefile
>   create mode 100644 drivers/power/pwrseq/core.c
>   create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
>   create mode 100644 drivers/usb/core/pwrseq.c
>   create mode 100644 include/linux/power/pwrseq.h
>

-- 
Thanks,
Vaibhav

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

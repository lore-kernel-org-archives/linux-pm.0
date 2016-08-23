From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH v6 0/8] power: add power sequence library
Date: Tue, 23 Aug 2016 16:02:48 +0530
Message-ID: <b1848eb2-9298-9089-ee4d-5356998c6c08@linaro.org>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, k.kozlowski@samsung.com, linux-usb@vger.kernel.org, oscar@naiandei.net, pawel.moll@arm.com, arnd@arndb.de, linux-pm@vger.kernel.org, festevam@gmail.com, s.hauer@pengutronix.de, stephen.boyd@linaro.org, linux-kernel@vger.kernel.org, troy.kisky@boundarydevices.com, stillcompiling@gmail.com, p.zabel@pengutronix.de, mail@maciej.szmigiero.name, mka@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On Monday 15 August 2016 02:43 PM, Peter Chen wrote:
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
> change is updated at patch [1/6], The udoo board changes were tested
> using my last power sequence patch set.[3]
>
> Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> need to power on itself before it can be found by ULPI bus.
>
> [1] http://www.spinics.net/lists/linux-usb/msg142755.html
> [2] http://www.spinics.net/lists/linux-usb/msg143106.html
> [3] http://www.spinics.net/lists/linux-usb/msg142815.html
(Please ignore my response on V2)

Sorry being so late in the discussion...

If I am not missing anything, then I am afraid to say that the generic 
library
implementation in this patch series is not going to solve many of the 
custom
requirement of power on, off, etc...
I know you mentioned about adding another library when we come
across such platforms, but should we not keep provision (or easy 
hooks/path)
to enable that ?

Let me bring in the use case I am dealing with,


                               Host
                                |
                                V
                            USB port
------------------------------------------------------------
                                |
                                V
                       USB HUB device (May need custom on/off seq)
                                |
                                V
               =============================
              |                             |
              V                             V
          Device-1                       Device-2
(Needs special power               (Needs special power
  on/off sequence.                   on/off sequence.
  Also may need custom               Also, may need custom
  sequence for                       sequence for
  suspend/resume)                    suspend/resume)


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



> Changes for v6:
> - Add Matthias Kaehlcke's Reviewed-by and Tested-by. (patch [2/6])
> - Change chipidea core of_node assignment for coming user. (patch [5/6])
> - Applies Joshua Clayton's three dts changes for two boards,
>    the USB device's reg has only #address-cells, but without #size-cells.
>
> Changes for v5:
> - Delete pwrseq_register/pwrseq_unregister, which is useless currently
> - Fix the linker error when the pwrseq user is compiled as module
>
> Changes for v4:
> - Create the patch on next-20160722
> - Fix the of_node is not NULL after chipidea driver is unbinded [Patch 5/6]
> - Using more friendly wait method for reset gpio [Patch 2/6]
> - Support multiple input clocks [Patch 2/6]
> - Add Rob Herring's ack for DT changes
> - Add Joshua Clayton's Tested-by
>
> Changes for v3:
> - Delete "power-sequence" property at binding-doc, and change related code
>    at both library and user code.
> - Change binding-doc example node name with Rob's comments
> - of_get_named_gpio_flags only gets the gpio, but without setting gpio flags,
>    add additional code request gpio with proper gpio flags
> - Add Philipp Zabel's Ack and MAINTAINER's entry
>
> Changes for v2:
> - Delete "pwrseq" prefix and clock-names for properties at dt binding
> - Should use structure not but its pointer for kzalloc
> - Since chipidea core has no of_node, let core's of_node equals glue
>    layer's at core's probe
>
> Joshua Clayton (2):
>    ARM: dts: imx6qdl: Enable usb node children with <reg>
>    ARM: dts: imx6q-evi: Fix onboard hub reset line
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
>   .../bindings/power/pwrseq/pwrseq-generic.txt       |  48 ++++++
>   .../devicetree/bindings/usb/usb-device.txt         |  10 +-
>   MAINTAINERS                                        |   9 ++
>   arch/arm/boot/dts/imx6q-evi.dts                    |  25 +--
>   arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  26 ++--
>   arch/arm/boot/dts/imx6qdl.dtsi                     |   6 +
>   drivers/power/Kconfig                              |   1 +
>   drivers/power/Makefile                             |   1 +
>   drivers/power/pwrseq/Kconfig                       |  20 +++
>   drivers/power/pwrseq/Makefile                      |   2 +
>   drivers/power/pwrseq/core.c                        |  62 ++++++++
>   drivers/power/pwrseq/pwrseq_generic.c              | 168 +++++++++++++++++++++
>   drivers/usb/chipidea/core.c                        |  27 +++-
>   drivers/usb/core/Makefile                          |   1 +
>   drivers/usb/core/hub.c                             |  12 +-
>   drivers/usb/core/hub.h                             |  12 ++
>   drivers/usb/core/pwrseq.c                          | 100 ++++++++++++
>   include/linux/power/pwrseq.h                       |  47 ++++++
>   18 files changed, 536 insertions(+), 41 deletions(-)
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

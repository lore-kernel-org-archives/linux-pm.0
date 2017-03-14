From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 14 Mar 2017 18:39:20 +0800
Message-ID: <CAMz4kuLVtY-rEgDv7RWDP55DEt8bVa99He39DRmGzQeUYZkukA@mail.gmail.com>
References: <cover.1487578977.git.baolin.wang@linaro.org> <20170314095729.cmbzdhikdtjoqrmp@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170314095729.cmbzdhikdtjoqrmp@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, NeilBrown <neilb@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 14 March 2017 at 17:57, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 20 Feb 2017, Baolin Wang wrote:
>
> [...]
>
>>  drivers/power/supply/wm831x_power.c |   63 +++
>>  drivers/usb/gadget/Kconfig          |    8 +
>>  drivers/usb/gadget/udc/Makefile     |    1 +
>>  drivers/usb/gadget/udc/charger.c    |  865 +++++++++++++++++++++++++++++++++++
>>  drivers/usb/gadget/udc/core.c       |   19 +-
>>  include/linux/usb/charger.h         |  176 +++++++
>>  include/linux/usb/gadget.h          |    3 +
>>  include/uapi/linux/usb/charger.h    |   31 ++
>>  8 files changed, 1165 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/usb/gadget/udc/charger.c
>>  create mode 100644 include/linux/usb/charger.h
>>  create mode 100644 include/uapi/linux/usb/charger.h
>
> Why have you sent this set to me?

Since you have one ack on patch 4, I think I need CC you. But If you
are not interested in this patchset, I will not CC you next time.
Sorry.

[PATCH v19 4/4] power: wm831x_power: Support USB charger current limit
management

Integrate with the newly added USB charger interface to limit the current
we draw from the USB input based on the input device configuration
identified by the USB stack, allowing us to charge more quickly from high
current inputs without drawing more current than specified from others.

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Peter Chen <peter.chen@freescale.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
.......

-- 
Baolin.wang
Best Regards

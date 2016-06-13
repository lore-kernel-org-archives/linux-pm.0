From: Jun Li <jun.li@nxp.com>
Subject: RE: [RESEND PATCH v11 2/4] gadget: Support for the usb charger
 framework
Date: Mon, 13 Jun 2016 15:15:09 +0000
Message-ID: <AM4PR04MB21305FB56492FC547F52E73589530@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <cover.1465807514.git.baolin.wang@linaro.org>
 <0f69a3bb3451dd850a7c2de30d17266b98ff337d.1465807514.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f69a3bb3451dd850a7c2de30d17266b98ff337d.1465807514.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
Cc: "robh@kernel.org" <robh@kernel.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "ruslan.bilovol@gmail.com" <ruslan.bilovol@gmail.com>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vge>
List-Id: linux-pm@vger.kernel.org

Hi

> -----Original Message-----
> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
> owner@vger.kernel.org] On Behalf Of Baolin Wang
> Sent: Monday, June 13, 2016 4:47 PM
> To: balbi@kernel.org; gregkh@linuxfoundation.org; sre@kernel.org;
> dbaryshkov@gmail.com; dwmw2@infradead.org
> Cc: robh@kernel.org; m.szyprowski@samsung.com; ruslan.bilovol@gmail.com;
> peter.chen@freescale.com; stern@rowland.harvard.edu; r.baldyga@samsung.com;
> yoshihiro.shimoda.uh@renesas.com; lee.jones@linaro.org; broonie@kernel.org;
> ckeepax@opensource.wolfsonmicro.com; patches@opensource.wolfsonmicro.com;
> baolin.wang@linaro.org; linux-pm@vger.kernel.org; linux-
> usb@vger.kernel.org; device-mainlining@lists.linuxfoundation.org; linux-
> kernel@vger.kernel.org
> Subject: [RESEND PATCH v11 2/4] gadget: Support for the usb charger
> framework
> 
> For supporting the usb charger, it adds the usb_charger_init() and
> usb_charger_exit() functions for usb charger initialization and exit.
> 
> It will report to the usb charger when the gadget state is changed, then
> the usb charger can do the power things.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Reviewed-by: Li Jun <jun.li@nxp.com>
Tested-by: Li Jun <jun.li@nxp.com>

> ---
>  drivers/usb/gadget/udc/udc-core.c |   11 +++++++++++
>  include/linux/usb/gadget.h        |   11 +++++++++++
>  2 files changed, 22 insertions(+)

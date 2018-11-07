From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V9 0/5] soc: imx: add scu power domain driver
Date: Wed, 7 Nov 2018 03:05:51 +0000
Message-ID: <AM0PR04MB421199044A8EFA6B643FD68080C40@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1541085298-375-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1541085298-375-1-git-send-email-aisheng.dong@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Shawn,

> -----Original Message-----
> From: A.s. Dong
> Sent: Thursday, November 1, 2018 11:20 PM
[...]
> Subject: [PATCH V9 0/5] soc: imx: add scu power domain driver
> 
> This patch set adds the scu based power domain driver.
> It depends on SCU driver.
> 

Do you have a chance to help look at and take this series?

Regards
Dong Aisheng

> Change Log:
> v8->v9:
>  * add comment at the top of scu-pd.c file about how to convert
>    to "single global domain".
> v7->v8:
>  * update to #power-domain-cells 1 binding
> v6->v7:
>  * keep "fsl,scu-pd" as fall back compatible string
> v5->v6:
>  * only compatible string name updated from fsl,scu-pd to fsl,imx8qxp-scu-pd
>    accordingly
> v4->v5:
>  * some minor improvements according to Sascha's suggestion
>    Note: did not use dev_* print functions due to we already have proper
>          prefix by redefining pr_fmt. So it seems not quite neccesary
> 	 to pass in a struct device * pointer for debug purpose only in
> 	 each functions.
> v3->v4:
>  * only scu headfile path update
> 
> v2->v3:
>  * structure and enums name update
>  * api usage update
> 
> 
> Dong Aisheng (5):
>   dt-bindings: imx: add scu resource id headfile
>   firmware: imx: remove resource id enums
>   dt-bindings: fsl: scu: update power domain binding
>   firmware: imx: add pm svc headfile
>   firmware: imx: add SCU power domain driver
> 
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  37 +-
>  drivers/firmware/imx/Kconfig                       |   6 +
>  drivers/firmware/imx/Makefile                      |   3 +-
>  drivers/firmware/imx/scu-pd.c                      | 339
> +++++++++++++
>  include/dt-bindings/firmware/imx/rsrc.h            | 559
> +++++++++++++++++++++
>  include/linux/firmware/imx/sci.h                   |   1 +
>  include/linux/firmware/imx/svc/pm.h                |  85 ++++
>  include/linux/firmware/imx/types.h                 | 552 --------------------
>  8 files changed, 1000 insertions(+), 582 deletions(-)  create mode 100644
> drivers/firmware/imx/scu-pd.c  create mode 100644
> include/dt-bindings/firmware/imx/rsrc.h
>  create mode 100644 include/linux/firmware/imx/svc/pm.h
> 
> --
> 2.7.4

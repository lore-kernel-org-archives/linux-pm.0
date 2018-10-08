From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V4 0/2] soc: imx: add scu power domain driver
Date: Mon, 8 Oct 2018 10:45:33 +0000
Message-ID: <AM0PR04MB421164390B8F71165532E50E80E60@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1538917807-1921-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1538917807-1921-1-git-send-email-aisheng.dong@nxp.com>
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
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pm@vger.kernel.org

Hi Shawn,

Would you take this as well?

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Sunday, October 7, 2018 9:10 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: dongas86@gmail.com; kernel@pengutronix.de; shawnguo@kernel.org;
> Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> rjw@rjwysocki.net; ulf.hansson@linaro.org; khilman@kernel.org;
> linux-pm@vger.kernel.org; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH V4 0/2] soc: imx: add scu power domain driver
> 
> This patch set adds the scu based power domain driver.
> It depends on SCU driver.
> 
> Change Log:
> v3->v4:
>  * only scu headfile path update
> 
> v2->v3:
>  * structure and enums name update
>  * api usage update
> 
> Dong Aisheng (2):
>   firmware: imx: add pm svc headfile
>   firmware: imx: add SCU power domain driver
> 
>  drivers/firmware/imx/Kconfig        |   6 ++
>  drivers/firmware/imx/Makefile       |   3 +-
>  drivers/firmware/imx/scu-pd.c       | 167
> ++++++++++++++++++++++++++++++++++++
>  include/linux/firmware/imx/sci.h    |   1 +
>  include/linux/firmware/imx/svc/pm.h |  85 ++++++++++++++++++
>  5 files changed, 261 insertions(+), 1 deletion(-)  create mode 100644
> drivers/firmware/imx/scu-pd.c  create mode 100644
> include/linux/firmware/imx/svc/pm.h
> 
> --
> 2.7.4

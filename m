From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 0/3] firmware: imx: scu-pd: generalize the implementation
Date: Wed, 6 Mar 2019 13:43:11 +0000
Message-ID: <AM0PR04MB42115A4F92866794A7AF902380730@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
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
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Gently Ping.

> -----Original Message-----
> From: Aisheng Dong
> Sent: Wednesday, February 20, 2019 10:38 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: dongas86@gmail.com; kernel@pengutronix.de; shawnguo@kernel.org;
> Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> rjw@rjwysocki.net; ulf.hansson@linaro.org; khilman@kernel.org;
> linux-pm@vger.kernel.org; Aisheng Dong <aisheng.dong@nxp.com>
> Subject: [PATCH 0/3] firmware: imx: scu-pd: generalize the implementation
> 
> This patch series used to further generalize the driver implementation for
> better adding new SCU based platforms. e.g. imx8qm which is mostly the same
> as imx8qxp except a minor SS name and resource avaliability difference.
> e.g.
> QXP has ADMA SS while QM has DMA and Audio SS separately.
> So we decouple the SS information from domain names.
> 
> Dong Aisheng (3):
>   firmware: imx: scu-pd: use bool to set postfix
>   firmware: imx: scu-pd: add specifying the base of domain name index
>     support
>   firmware: imx: scu-pd: decouple the SS information from domain names
> 
>  drivers/firmware/imx/scu-pd.c | 121
> ++++++++++++++++++++++--------------------
>  1 file changed, 64 insertions(+), 57 deletions(-)
> 
> --
> 2.7.4

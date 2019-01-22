From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: Linux Kernel Regression in Commit
 3f7cceeab895fcc17ac8db0d9a5e8ca2954b4661 on i.MX6QP
Date: Tue, 22 Jan 2019 08:08:11 +0100
Message-ID: <20190122070811.js5ooncqzqab63d4@pengutronix.de>
References: <87r2d5yepy.fsf@mntmn.com> <87o989ydc3.fsf@mntmn.com>
 <87lg3dycku.fsf@mntmn.com>
 <VI1PR04MB55336678BA82D08DA1D1D5F8EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB55336678BA82D08DA1D1D5F8EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, Richard Zhu <hongxing.zhu@nxp.com>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, "Lukas F.Hartmann" <lukas@mntmn.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

[Cc +=3D generice power domain maintainers and linux-pm@vger.k.o]

Hello,

On Mon, Jan 21, 2019 at 09:12:45PM +0000, Leonard Crestez wrote:
> On 1/21/2019 10:34 PM, Lukas F.Hartmann wrote:
> > Removing the return(ret) line after the imx6_pcie_attach_pd(dev) call
> > fixes the problems for me. I am under the impression that the
> > imx6_add_pcie_port still should be called even if there was an error
> > attaching the power domain?
> =

> The intent was that imx6_pcie_attach_pd does nothing if no PD is defined =

> in DT but it returns an error instead and causes a probe failure.
> =

> Can you please try the following:
> =

> --- drivers/pci/controller/dwc/pci-imx6.c
> +++ drivers/pci/controller/dwc/pci-imx6.c
> @@ -310,6 +310,9 @@ static int imx6_pcie_attach_pd(struct device *dev)
>          imx6_pcie->pd_pcie =3D dev_pm_domain_attach_by_name(dev, "pcie");
>          if (IS_ERR(imx6_pcie->pd_pcie))
>                  return PTR_ERR(imx6_pcie->pd_pcie);
> +       /* Do nothing when power domain missing */
> +       if (!imx6_pcie->pd_pcie)
> +               return 0;

I wonder if it would make more sense to change
dev_pm_domain_attach_by_name et al. to not return NULL and error
pointers. Such functions tend to be used wrongly as can be seen here.
(Unless NULL is a dummy value that in the following shouldn't result in
problems that need catching, but it seems that is not the case.)

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
Date: Fri, 20 Jul 2018 10:38:18 -0300
Message-ID: <CAOMZO5BQjxeGOUE3jwbA_sRuYWQkHTJo3AeywXXpm-9kVdsYfw@mail.gmail.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com> <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-pm@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Leonard,

On Fri, Jul 20, 2018 at 9:47 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> +static int imx6_pcie_resume_noirq(struct device *dev)
> +{
> +       int ret = 0;

There is no need for initializing 'ret' here.

> +       struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +       struct pcie_port *pp = &imx6_pcie->pci->pp;
> +
> +       if (imx6_pcie->variant != IMX7D)
> +               return 0;
> +
> +       imx6_pcie_assert_core_reset(imx6_pcie);
> +       imx6_pcie_init_phy(imx6_pcie);
> +       imx6_pcie_deassert_core_reset(imx6_pcie);
> +       dw_pcie_setup_rc(pp);
> +
> +       ret = imx6_pcie_establish_link(imx6_pcie);
> +       if (ret < 0)
> +               pr_err("pcie link is down after resume.\n");

Shouldn't the error be propagated?

Also, dev_err() is preferred instead of pr_err().

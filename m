From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
Date: Fri, 20 Jul 2018 08:33:58 -0700
Message-ID: <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com> <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Joao.Pinto@synopsys.com, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 20, 2018 at 5:48 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
>
> That commit followed the reference manual but unfortunately the imx7d
> manual is incorrect.
>

I'd also add similar comment to DT file to prevent people from trying
to "fix" this in the future.

Also, this change is going to break QEMU's mapping found here:

https://git.qemu.org/?p=qemu.git;a=blob;f=hw/arm/fsl-imx7.c;h=d5e26855a552e2d52b91f0435a607fae2f88456b;hb=HEAD#l464

any change you are planning to make the change there as well?

Thanks,
Andrey Smirnov

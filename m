From: =?windows-1252?Q?S=E9bastien_SZYMANSKI?=
 <sebastien.szymanski@armadeus.com>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Thu, 22 Jan 2015 10:37:33 +0100
Message-ID: <54C0C4DD.2040302@armadeus.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54C0AFE4.3020701@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Sebastian Reichel <sre@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On 01/22/2015 09:08 AM, Stefan Wahren wrote:
> =

> In the meantime i made some bugfixes on these patches. Now i think it
> would be better to integrate the on-chip regulator driver into the patch
> series. That would clarify the function of the power driver.
> =


I was about to resend this series with a poweroff driver for the imx28
SoCs. Should I wait this series get merged?

I thought adding a poweroff child node like this:

power: power@80044000 {
	...
	poweroff: poweroff@80044100 {
		compatible =3D "fsl,imx28-poweroff";
		reg =3D <0x80044100 0x10>;
	};
	...
};

Here is the driver:

/*
 * MXS SoCs reset code.
 *
 * Copyright (c) 2015 Armadeus Systems.
 *
 * Author: S=E9bastien Szymanski <sebastien.szymanski@armadeus.com>
 *
 * based on imx-snvs-poweroff.c
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 and
 * only version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#include <linux/err.h>
#include <linux/init.h>
#include <linux/io.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/of_address.h>
#include <linux/platform_device.h>

#define MXS_SET_ADDR                    0x4

#define POWER_RESET_UNLOCK__KEY         (0x3E77 << 16)
#define POWER_RESET_PWD                 0x1

static void __iomem *power_reset;

static void do_mxs_poweroff(void)
{
        writel(POWER_RESET_UNLOCK__KEY | POWER_RESET_PWD,
               power_reset + MXS_SET_ADDR);
}

static int mxs_poweroff_probe(struct platform_device *pdev)
{
        power_reset =3D of_iomap(pdev->dev.of_node, 0);
        if (!power_reset) {
                dev_err(&pdev->dev, "failed to get memory\n");
                return -ENODEV;
        }

        pm_power_off =3D do_mxs_poweroff;

        dev_info(&pdev->dev, "power off function set!\n");

        return 0;
}

static const struct of_device_id of_mxs_poweroff_match[] =3D {
        { .compatible =3D "fsl,imx28-poweroff", },
        {},
};
MODULE_DEVICE_TABLE(of, of_mxs_poweroff_match);

static struct platform_driver mxs_poweroff_driver =3D {
        .probe =3D mxs_poweroff_probe,
        .driver =3D {
                .name =3D "mxs-poweroff",
                .of_match_table =3D of_match_ptr(of_mxs_poweroff_match),
        },
};

static int __init mxs_poweroff_init(void)
{
        return platform_driver_register(&mxs_poweroff_driver);
}
device_initcall(mxs_poweroff_init);

Best Regards,

-- =

S=E9bastien SZYMANSKI
Software Engineer
Armadeus Systems - A new vision of the embedded world
sebastien.szymanski@armadeus.com
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26

From: Michel Pollet <michel.pollet@bp.renesas.com>
Subject: RE: [PATCH v3 4/8] reset: Renesas RZ/N1 reboot driver
Date: Thu, 29 Mar 2018 11:12:45 +0000
Message-ID: <OSBPR01MB205430EB7EE4F338829135EDD2A20@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-5-git-send-email-michel.pollet@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522309629-10152-5-git-send-email-michel.pollet@bp.renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Pollet <michel.pollet@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, Michel Pollet <buserror+upstream@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On 29 March 2018 08:47, I messed up:
[snip]
>
> The Renesas RZ/N1 Family (Part #R9A06G0xx) needs a small driver to reboot
> the Cortex-A7 cores. This driver is a sub driver of the sysctrl MFD.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  drivers/power/reset/Kconfig       |   7 +++
>  drivers/power/reset/Makefile      |   1 +
>  drivers/power/reset/rzn1-reboot.c | 105
[snip]
> +
> +parent =3D pdev->dev.parent;
> +if (!parent || !parent->of_node)

Not sure what went on when I had all the patches loaded in the editor befor=
e sending, but I've deleted a brace here. Will be fixed in v4... :/

Michel


> +dev_err(&pdev->dev, "couldn't find sysctrl node\n");
> +return -ENODEV;
> +}
> +sysctrl =3D syscon_node_to_regmap(parent->of_node);
> +if (IS_ERR(sysctrl)) {
> +dev_err(&pdev->dev, "couldn't find find regmap\n");
> +return PTR_ERR(sysctrl);
> +}
> +err =3D register_restart_handler(&rzn1_reboot_nb);
> +if (err) {
> +dev_err(&pdev->dev, "register restart handler
> failed(err=3D%d)\n",
> +err);
> +}
> +
> +return err;
> +}
> +
> +static const struct of_device_id rzn1_reboot_of_match[] =3D {
> +{ .compatible =3D "renesas,rzn1-reboot" },
> +{}
> +};
> +MODULE_DEVICE_TABLE(of, rzn1_reboot_of_match);
> +
> +static struct platform_driver rzn1_reboot_driver =3D {
> +.probe =3D rzn1_reboot_probe,
> +.driver =3D {
> +.name =3D "rzn1-reboot",
> +.of_match_table =3D rzn1_reboot_of_match,
> +},
> +};
> +module_platform_driver(rzn1_reboot_driver);
> +
> +MODULE_DESCRIPTION("RZ/N1 reboot driver");
> MODULE_AUTHOR("Michel Pollet
> +<michel.pollet@bp.renesas.com>, <buserror@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.

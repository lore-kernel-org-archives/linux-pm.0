From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: add 696MHz operating point
Date: Tue, 2 Jan 2018 13:32:02 -0200
Message-ID: <CAOMZO5BGmnNzv7YobtB+KOi0PM+qzyYi97q_NZtT1PU_e+Bcbg@mail.gmail.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5C-qgyCJPBHYwjD9zjHqu4eoGDfoB5-BcFdnvSy01MKiQ@mail.gmail.com> <E5B0DB53-D0E5-430B-BBCC-EF3899C70DAE@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E5B0DB53-D0E5-430B-BBCC-EF3899C70DAE@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "A.s. Dong" <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, viresh kumar <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 2, 2018 at 1:12 PM, Anson Huang <anson.huang@nxp.com> wrote:

> There is a comment in VDD_ARM, VDD_SOC must NOT lower than VDD_ARM.
>
> Output voltage must be set to the following rules:
> =E2=80=A2 VDD_ARM_CAP <=3D VDD_SOC_CAP
> =E2=80=A2 VDD_SOC_CAP - VDD_ARM_CAP < 330 mV

Thanks for the clarifcation.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

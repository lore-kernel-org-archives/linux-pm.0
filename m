From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 1/5] mfd: max77843: Add max77843 MFD driver core driver
Date: Mon, 2 Mar 2015 10:20:39 +0000
Message-ID: <20150302102039.GC32347@x1>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-2-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425291038-18269-2-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 02 Mar 2015, Jaewon Kim wrote:

> This patch adds MAX77843 core/irq driver to support PMIC,
> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
> LED and Haptic device.
>=20
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  drivers/mfd/Kconfig                  |   14 ++
>  drivers/mfd/Makefile                 |    1 +
>  drivers/mfd/max77843.c               |  243 ++++++++++++++++++
>  include/linux/mfd/max77843-private.h |  454 ++++++++++++++++++++++++=
++++++++++
>  4 files changed, 712 insertions(+)
>  create mode 100644 drivers/mfd/max77843.c
>  create mode 100644 include/linux/mfd/max77843-private.h

If you have dealt with my previous review comments:

Acked-by: Lee Jones <lee.jones@linaro.org>

Which other Acks are you waiting for?=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

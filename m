From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 1/4] mfd: rt5033: Add Richtek RT5033 driver core.
Date: Wed, 10 Dec 2014 15:16:59 +0000
Message-ID: <20141210151659.GE23481@x1>
References: <1418126634-4781-1-git-send-email-beomho.seo@samsung.com>
 <1418126634-4781-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:58586 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757293AbaLJPRK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 10:17:10 -0500
Received: by mail-qg0-f43.google.com with SMTP id i50so2228153qgf.16
        for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2014 07:17:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1418126634-4781-2-git-send-email-beomho.seo@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sameo@linux.intel.com, lee.jone@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, cw00.choi@samsung.com, geunsik.lim@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com

On Tue, 09 Dec 2014, Beomho Seo wrote:

> This patch adds a new driver for Richtek RT5033 driver.
> RT5033 is a Multifunction device which includes battery charger, fuel=
 gauge,
> flash LED current source, LDO and synchronous Buck converter. It is i=
nterfaced
> to host controller using I2C interface.
>=20
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jone@linaro.org>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes in v8
> - Add description of hardware.
> - Move structure.
>=20
> Changes in v7
> - Use small description.
> - Change some names for a variable.
> - Revise of_device_id struct style.
>=20
> Changes in v6
> - Fix white space issue in mfd cell struct.
>=20
> Changes in v5
> - Change possible built as a module.
> - Revise rt5033_dev mfd cell entry.
> - Fix incorrect typo.
> - Add module alias.
>=20
> Changes in v4
> - none.
>=20
> Changes in v3
> - Correct sentence errors.
> - Add author information the top of each drivers.
> - Remove unnecessary pre-initialise, struct member(rt5033->i2c) and b=
link.
> - Change some return check.
> - Use bool and of_match_ptr().
>=20
> Changes in v2
> - Remove volatile_reg callback. Because this driver not in use regmap=
 cache.
> - Revmoe unnecessary subnode of_compatible.
> - Add define for set_high impedance mode of charger.
> ---
>  drivers/mfd/Kconfig                |   12 ++
>  drivers/mfd/Makefile               |    1 +
>  drivers/mfd/rt5033.c               |  142 ++++++++++++++++++++
>  include/linux/mfd/rt5033-private.h |  260 ++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/rt5033.h         |   62 +++++++++
>  5 files changed, 477 insertions(+)
>  create mode 100644 drivers/mfd/rt5033.c
>  create mode 100644 include/linux/mfd/rt5033-private.h
>  create mode 100644 include/linux/mfd/rt5033.h

Applied for v3.20, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

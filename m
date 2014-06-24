From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH 0/6] thermal: sti: Add new Thermal driver
Date: Tue, 24 Jun 2014 10:23:09 +0100
Message-ID: <20140624092309.GD13803@lee--X1>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:58916 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaFXJXQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jun 2014 05:23:16 -0400
Received: by mail-ie0-f169.google.com with SMTP id at1so10180iec.14
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2014 02:23:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, ajitpal.singh@st.com, edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com

> I'm re-sending this set, as one of the maintainers' email addresses
> is incorrect in the MAINTAINERS file.
>=20
> This patchset adds full support for 2 types of Thermal Controllers
> produced by STMicroelectronics.  One is a more traditional memory
> mapped variant, the other is controlled solely by system configuratio=
n
> registers.

Any thing from the Thermal guys? Has this set fallen through the gaps?

>  Documentation/devicetree/bindings/thermal/st-thermal.txt |  42 +++++=
+++++++++++
>  arch/arm/boot/dts/stih416.dtsi                           |  18 +++++=
++
>  arch/arm/configs/multi_v7_defconfig                      |   2 +
>  drivers/thermal/Kconfig                                  |   5 ++
>  drivers/thermal/Makefile                                 |   1 +
>  drivers/thermal/st/Kconfig                               |  12 +++++
>  drivers/thermal/st/Makefile                              |   3 ++
>  drivers/thermal/st/st_thermal.c                          | 313 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> ++++++++++++++++++++++++++++
>  drivers/thermal/st/st_thermal.h                          | 104 +++++=
+++++++++++++++++++++++++++++++++
>  drivers/thermal/st/st_thermal_memmap.c                   | 209 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/st/st_thermal_syscfg.c                   | 179 +++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 888 insertions(+)
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

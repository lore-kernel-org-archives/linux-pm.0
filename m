From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH 0/6] thermal: sti: Add new Thermal driver
Date: Wed, 9 Jul 2014 13:08:23 +0100
Message-ID: <20140709120823.GA32573@lee--X1>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
 <20140624092309.GD13803@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140624092309.GD13803@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, ajitpal.singh@st.com, edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com
List-Id: linux-pm@vger.kernel.org

On Tue, 24 Jun 2014, Lee Jones wrote:

> > I'm re-sending this set, as one of the maintainers' email addresses
> > is incorrect in the MAINTAINERS file.
> >=20
> > This patchset adds full support for 2 types of Thermal Controllers
> > produced by STMicroelectronics.  One is a more traditional memory
> > mapped variant, the other is controlled solely by system configurat=
ion
> > registers.
>=20
> Any thing from the Thermal guys? Has this set fallen through the gaps=
?

Anything at all?  It's been well over a month now.

> >  Documentation/devicetree/bindings/thermal/st-thermal.txt |  42 +++=
+++++++++++++
> >  arch/arm/boot/dts/stih416.dtsi                           |  18 +++=
++++
> >  arch/arm/configs/multi_v7_defconfig                      |   2 +
> >  drivers/thermal/Kconfig                                  |   5 ++
> >  drivers/thermal/Makefile                                 |   1 +
> >  drivers/thermal/st/Kconfig                               |  12 +++=
++
> >  drivers/thermal/st/Makefile                              |   3 ++
> >  drivers/thermal/st/st_thermal.c                          | 313 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> > ++++++++++++++++++++++++++++
> >  drivers/thermal/st/st_thermal.h                          | 104 +++=
+++++++++++++++++++++++++++++++++++
> >  drivers/thermal/st/st_thermal_memmap.c                   | 209 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> >  drivers/thermal/st/st_thermal_syscfg.c                   | 179 +++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  11 files changed, 888 insertions(+)
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

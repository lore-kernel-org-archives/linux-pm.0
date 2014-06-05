From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 1/6] thermal: sti: Supply Device Tree
 documentation
Date: Thu, 5 Jun 2014 13:25:07 +0100
Message-ID: <20140605122507.GA24240@lee--X1>
References: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
 <1401442715-6350-2-git-send-email-lee.jones@linaro.org>
 <20140605120147.GA7446@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:55547 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaFEMZP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jun 2014 08:25:15 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so7461235igb.14
        for <linux-pm@vger.kernel.org>; Thu, 05 Jun 2014 05:25:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140605120147.GA7446@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@stlinux.com, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com

On Thu, 05 Jun 2014, Peter Griffin wrote:

> Hi Lee,
>=20
> > +Example:
> > +
> > +	temp1@fdfe8000 {
> > +		compatible	=3D "st,stih416-mpe-thermal";
> > +		reg		=3D <0xfdfe8000 0x10>;
> > +		clock-names	=3D "thermal";
> > +		clocks		=3D <&CLK_M_MPETHSENS>;
> > +		interrupts	=3D <GIC_SPI 23 IRQ_TYPE_NONE>;
> > +	};
>=20
> With the renaming of the STI device tree from upper to lower
> case. The clock name in this example also needs updating.

You're right.  Will rebase and fix.

> Once fixed: -
>  Acked-by: Peter Griffin <peter.griffin@linaro.org>
>=20
> Regards,
>=20
> Peter

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

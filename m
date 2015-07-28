From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 7/8] dmaengine: add a driver for Intel integrated DMA
 64-bit
Date: Tue, 28 Jul 2015 08:53:29 +0100
Message-ID: <20150728075329.GW21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1438009443-55317-8-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150728074829.GU21114@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37114 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbG1Hxd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 03:53:33 -0400
Received: by wibud3 with SMTP id ud3so146930589wib.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 00:53:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150728074829.GU21114@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org

=46AO Vinod,

On Tue, 28 Jul 2015, Lee Jones wrote:
> On Mon, 27 Jul 2015, Andy Shevchenko wrote:
>=20
> > Intel integrated DMA (iDMA) 64-bit is a specific IP that is used as=
 a part of
> > LPSS devices such as HSUART or SPI. The iDMA IP is attached for pri=
vate
> > usage on each host controller independently.
> >=20
> > While it has similarities with Synopsys DesignWare DMA, the followi=
ng
> > distinctions doesn't allow to use the existing driver:
> > - 64-bit mode with corresponding changes in Hardware Linked List da=
ta structure
> > - many slight differences in the channel registers
> >=20
> > Moreover this driver is based on the DMA virtual channels framework=
 that helps
> > to make the driver cleaner and easy to understand.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/dma/Kconfig  |   8 +
> >  drivers/dma/Makefile |   1 +
> >  drivers/dma/idma64.c | 710 +++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  drivers/dma/idma64.h | 233 +++++++++++++++++
> >  4 files changed, 952 insertions(+)
> >  create mode 100644 drivers/dma/idma64.c
> >  create mode 100644 drivers/dma/idma64.h
>=20
> Applied, thanks.  Pull request to follow.

Will send out a pull request when I have Vinod's Ack.

[...]

Patches will still be applied to -next for soak testing though.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

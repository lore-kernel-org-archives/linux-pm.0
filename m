From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 0/6] Add support for DA9150 Fuel-Gauge
Date: Tue, 22 Sep 2015 18:10:32 +0100
Message-ID: <20150922171032.GH11284@x1>
References: <cover.1441964153.git.Adam.Thomson.Opensource@diasemi.com>
 <20150922160405.GC4235@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36664 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756350AbbIVRKm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 13:10:42 -0400
Received: by pacgz1 with SMTP id gz1so11712265pac.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2015 10:10:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150922160405.GC4235@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

On Tue, 22 Sep 2015, Sebastian Reichel wrote:
> On Fri, Sep 11, 2015 at 11:05:21AM +0100, Adam Thomson wrote:
> > This patch set adds support for the Dialog DA9150 Fuel-Gauge.
> >
> > [...]
> >=20
> > Adam Thomson (6):
> >   mfd: da9150: Add support for Fuel-Gauge
> >   mfd: da9150: Update DT bindings for Fuel-Gauge support
> >   power: Add support for DA9150 Fuel-Gauge
> >   power: da9150: Add DT bindings documentation for Fuel-Gauge
> >   mfd: da9150: Use relative paths in DT bindings document
> >   mfd: da9150: Use DEFINE_RES_IRQ_NAMED() help macro for IRQ resour=
ce
> >=20
> >  Documentation/devicetree/bindings/mfd/da9150.txt   |  33 +-
> >  .../devicetree/bindings/power/da9150-fg.txt        |  23 +
> >  drivers/mfd/da9150-core.c                          | 191 +++++--
> >  drivers/power/Kconfig                              |  10 +
> >  drivers/power/Makefile                             |   1 +
> >  drivers/power/da9150-fg.c                          | 578 +++++++++=
++++++++++++
> >  include/linux/mfd/da9150/core.h                    |  19 +-
> >  7 files changed, 810 insertions(+), 45 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/power/da9150-=
fg.txt
> >  create mode 100644 drivers/power/da9150-fg.c
>=20
> I suggest, that you take the whole patchset via the mfd tree.

That's fine, but I'm still missing an Ack for patch 4.



--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

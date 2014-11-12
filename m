From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/3] add power off driver for i.mx6
Date: Wed, 12 Nov 2014 12:26:03 +0100
Message-ID: <8538337.xAQUHpampk@wuerfel>
References: <1415780439-29728-1-git-send-email-b38343@freescale.com> <20141112105620.GM2704@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141112105620.GM2704@dragon>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Robin Gong <b38343@freescale.com>, kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, smoch@web.de
List-Id: linux-pm@vger.kernel.org

On Wednesday 12 November 2014 18:56:22 Shawn Guo wrote:
> On Wed, Nov 12, 2014 at 04:20:36PM +0800, Robin Gong wrote:
> > Resend the patchset  with the latest MAINTAINERS
> > Add simple power off driver for i.mx6, including:
> > - add basic imx-snvs-poweroff driver in drivers/power/reset
> > - add device node in all dts files of i.mx6.
> > - enable in config file
> > 
> > Change from v3:
> > - disable poweroff driver in soc level dts and enable it in board level dts
> > - replace 'EIO' with 'ENODEV' while of_iomap fail.
> > Change from v2:
> > - remove useless included head files
> > - split device binding doc from dts patch
> > - add description for the case that PMIC_ON_REQ not used as external power
> >   control
> > 
> > Robin Gong (3):
> >   ARM: dts: imx6: add pm_power_off support for i.mx6 chips
> >   power: reset: imx-snvs-poweroff: add power off driver for i.mx6
> >   ARM: configs: imx_v6_v7_defconfig: add power off driver
> 
> I'm fine with the series.  But before I take the patches, I need an ACK
> from DT folks on the bindings.

Looks ok to me. Using a syscon for fsl,sec-v4.0-mon might have been nicer
than making it a simple-bus, but that decision has been made already,
so this version is a logical extension of what we have already.

	Arnd

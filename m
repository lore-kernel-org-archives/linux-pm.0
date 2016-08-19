From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v5 00/11] Add HW throttle for Tegra soctherm
Date: Fri, 19 Aug 2016 15:15:24 +0800
Message-ID: <1471590924.2691.34.camel@intel.com>
References: <1462962026-19653-1-git-send-email-wni@nvidia.com>
         <5746C4FD.9070909@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5746C4FD.9070909@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Ni <wni@nvidia.com>, edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 四, 2016-05-26 at 17:42 +0800, Wei Ni wrote:
> Hi,
> Does there have any comments on this series?
> Let me know if someone has suggestions.
> 
I have no objections to this patch set.
As 10 patches out of 11, in this patch series, contain changes out of
thermal scope, if you prefer this patch set go through thermal tree, I
still need ACKs for the changes out of thermal scope.

thanks,
rui

> Thanks.
> Wei.
> 
> On 05/11/2016 06:20 PM, Wei Ni wrote:
> > 
> > This series add following functions for Tegra soctherm:
> > 1. add HW throttle function.
> > 2. enable soctherm node for Tegra124, Tegra132, Tegra210, and
> > set "critical", "hot" trips for them.
> > 
> > Main changes from v4:
> > 1. drop the "nvidia" prefix from the node name, per Rob's comments.
> > 
> > Main changes from v3:
> > 1. change some properties'name and descriptions, per Rob's
> > comments.
> > 2. change the corresponding driver codes.
> > 
> > Main changes from v2:
> > 1. improve the of-binding, per Eduardo's comments, and
> > change the corresponding driver codes.
> > 2. move two setting critical trip patches in this series,
> > 3. fix some bugs in dts changes.
> > 
> > Main changes from v1:
> > 1. use readl/writel instead of __raw_readl/__raw_writel.
> > 2. rebase on the linux-next.
> > 
> > The v1 series is in:
> > https://lkml.org/lkml/2016/3/31/230
> > 
> > The v2 series is in:
> > https://lkml.org/lkml/2016/4/26/1577
> > 
> > The v3 series is in:
> > https://lkml.org/lkml/2016/5/3/274
> > 
> > The v4 series is in:
> > https://lkml.org/lkml/2016/5/9/45
> > 
> > Wei Ni (11):
> >   of: Add bindings of hw throttle for Tegra soctherm
> >   thermal: tegra: add hw-throttle function
> >   thermal: tegra: add hw-throttle for Tegra132
> >   arm: tegra: set critical trips for Tegra124
> >   arm: tegra: set hot trips for Tegra124
> >   arm64: tegra: use tegra132-soctherm for Tegra132
> >   arm64: tegra: set critical trips for Tegra132
> >   arm64: tegra: set hot trips for Tegra132
> >   arm64: tegra: add soctherm node for Tegra210
> >   arm64: tegra: set critical trips for Tegra210
> >   arm64: tegra: set hot trips for Tegra210
> > 
> >  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 121 ++-
> >  arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  18 +-
> >  arch/arm/boot/dts/tegra124.dtsi                    |  83 +-
> >  arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 119 ++-
> >  arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 127 ++++
> >  drivers/thermal/tegra/soctherm.c                   | 842
> > ++++++++++++++++++++-
> >  drivers/thermal/tegra/soctherm.h                   |  10 +
> >  drivers/thermal/tegra/tegra124-soctherm.c          |  18 +
> >  drivers/thermal/tegra/tegra132-soctherm.c          |  18 +
> >  drivers/thermal/tegra/tegra210-soctherm.c          |  18 +
> >  include/dt-bindings/thermal/tegra124-soctherm.h    |   5 +
> >  11 files changed, 1344 insertions(+), 35 deletions(-)
> > 

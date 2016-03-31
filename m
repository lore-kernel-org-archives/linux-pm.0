From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH 0/9] Add HW throttle for Tegra soctherm
Date: Thu, 31 Mar 2016 16:50:50 +0800
Message-ID: <56FCE4EA.40509@nvidia.com>
References: <1459413848-5405-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459413848-5405-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patchset is based on my previous series:
[PATCH V9 RESEND 00/14] Add T210 support in Tegra soctherm
https://lkml.org/lkml/2016/3/29/293, which were taken by Eduardo.

Thanks.
Wei.

On 2016=E5=B9=B403=E6=9C=8831=E6=97=A5 16:43, Wei Ni wrote:
> This series add following functions for Tegra soctherm:
> 1. add Tegra132 support.
> 2. add HW throttle function.
> 3. set hot trip temperatures which can trigger the HW throttle.
>=20
> Wei Ni (9):
>   thermal: tegra: add Tegra132 specific SOC_THERM driver
>   arm64: tegra: use tegra132-soctherm for Tegra132
>   arm64: tegra: set critical trips for Tegra132
>   of: Add bindings of hw throttle for soctherm
>   thermal: tegra: add hw-throttle function
>   thermal: tegra: add hw-throttle for Tegra132
>   arm64: tegra: set hot trips for Tegra210
>   arm64: tegra: set hot trips for Tegra132
>   arm: tegra: set hot trips for Tegra124
>=20
>  .../devicetree/bindings/thermal/tegra-soctherm.txt |  89 ++-
>  arch/arm/boot/dts/tegra124.dtsi                    |  39 +-
>  arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 119 ++-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  41 +-
>  drivers/thermal/tegra/Makefile                     |   1 +
>  drivers/thermal/tegra/soctherm.c                   | 834 +++++++++++=
+++++++++-
>  drivers/thermal/tegra/soctherm.h                   |  14 +
>  drivers/thermal/tegra/tegra124-soctherm.c          |  18 +
>  drivers/thermal/tegra/tegra132-soctherm.c          | 214 ++++++
>  drivers/thermal/tegra/tegra210-soctherm.c          |  18 +
>  include/dt-bindings/thermal/tegra124-soctherm.h    |   5 +
>  11 files changed, 1355 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/thermal/tegra/tegra132-soctherm.c
>=20

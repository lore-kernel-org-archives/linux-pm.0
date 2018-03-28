From: Michel Pollet <michel.pollet@bp.renesas.com>
Subject: RE: [PATCH v2 0/8] arm: Base support for Renesas RZN1D-DB Board
Date: Wed, 28 Mar 2018 08:00:10 +0000
Message-ID: <OSBPR01MB2054B502FE0D0777386C636BD2A30@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Pollet <michel.pollet@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Replying to myself here, more or less to reflect further discussion on IRC =
related to where the
bindings goes. Also, to publicly acknowledge and thank Geert for tons of ad=
vice and comments
outside the email chain...

So, after further discussion on IRC, that's what I've been trying to do
[hope outlook doesn't mangle this]:
+---------------------------------+     +----------------------------------=
--+     +--------------------------------+
|          r9a06g0xx.dtsi         |     |         r9a06g032.dtsi           =
  |     |     r9a06g032-rzn1d-db.dts     |
|                                 |     |                                  =
  |     |                                |
|   compatible=3D                   |     |  compatible=3D                 =
      |     | compatible=3D                    |
|         "renesas,rzn1";         |     |        "renesas,r9a06g032",      =
  |     |       "renesas,rzn1d-db",      |
|                                 +----->        "renesas,rzn1";           =
  +----->       "renesas,r9a06g032",     |
|   ...                           |     |  ...                             =
  |     |       "renesas,rzn1";          |
|   compatible=3D                   |     |  compatible=3D                 =
      |     |                                |
|         "renesas,rzn1-reset";   |     |        "renesas,r9a06g032-reset",=
  |     |                                |
|                                 |     |        "renesas,rzn1-reset";     =
  |     |                                |
|                                 |     |                                  =
  |     |                                |
+---------------------------------+     +----------------------------------=
--+     +--------------------------------+
      Family File, "rzn1" only                  Future, potential SoC      =
                    Board File
                                                Specific override file

The idea is that the 1D and 1S share /everything/ apart from one extra QSPI=
, no DDR, one less CPU
and a few other bits and bobs. So the r9a06g0xx.dtsi will contain 98% of bo=
th SoC bindings. *Perhaps*
later I could add a r9a06g03[23].dtsi for SoC specific bindings, but curren=
tly that is not necessary, so we
Won't need that file.

If everyone happy with this? I've got a v3 simmering on the fire, but I'd r=
eally like everyone to be
happy with the proposed solution...

Cheers,
Michel

On 22 March 2018 11:45, I wrote:
> This series adds the plain basic support for booting a bare kernel on the
> RZ/N1D-DB Board. It's been trimmed to the strict minimum as a 'base',
> further patches that will add the rest of the support, pinctrl, clock
> architecture and quite a few others.
>
> Thanks for the comments on the previous version!
>
> v2:
>  + Fixes for suggestions by Simon Horman  + Fixes for suggestions by Rob
> Herring  + Fixes for suggestions by Geert Uytterhoeven  + Removed the
> mach file  + Added a MFD base for the sysctrl block  + Added a regmap bas=
ed
> sub driver for the reboot handler  + Renamed the files to match shmobile
> conventions  + Adapted the compatible=3D strings to reflect 'family' vs '=
part'
>    distinction.
>  + Removed the sysctrl.h file entirelly.
>  + Fixed every warnings from the DTC compiler on W=3D12 mode.
>  + Split the device-tree patches from the code.
>
> Michel Pollet (8):
>   DT: mfd: renesas,rzn1-sysctrl: document RZ/N1 sysctrl node
>   DT: reset: renesas,rzn1-reboot: document RZ/N1 reboot driver
>   DT: arm: renesas,r9a06g032: add the RZ/N1 bindings
>   reset: Renesas RZ/N1 reboot driver
>   arm: rzn1: Add the RZ/N1 arch to the shmobile Kconfig
>   DT: arm: Add Renesas RZ/N1 SoC base device tree file
>   DT: arm: Add Renesas RZN1D-DB Board base file
>   DT: arm: Add the RZN1D-DB Board to Renesas Makefile target
>
>  Documentation/devicetree/bindings/arm/shmobile.txt |   5 +-
>  .../bindings/mfd/renesas,rzn1-sysctrl.txt          |  22 +++++
>  .../bindings/power/renesas,rzn1-reboot.txt         |  22 +++++
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts        |  26 +++++
>  arch/arm/boot/dts/r9a06g0xx.dtsi                   |  96 +++++++++++++++=
+++
>  arch/arm/mach-shmobile/Kconfig                     |   5 +
>  drivers/power/reset/Kconfig                        |   7 ++
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/rzn1-reboot.c                  | 109
> +++++++++++++++++++++
>  10 files changed, 293 insertions(+), 1 deletion(-)  create mode 100644
> Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
>  create mode 100644
> Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
>  create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
>  create mode 100644 arch/arm/boot/dts/r9a06g0xx.dtsi  create mode 100644
> drivers/power/reset/rzn1-reboot.c
>
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.

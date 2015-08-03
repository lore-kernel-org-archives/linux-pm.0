From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v6 0/8] ARM64: juno: add SCPI mailbox protocol, clock and
 CPUFreq support
Date: Mon, 3 Aug 2015 11:18:45 +0100
Message-ID: <20150803101845.GU20890@e106497-lin.cambridge.arm.com>
References: <1438364591-1144-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:50634 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752612AbbHCKSu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Aug 2015 06:18:50 -0400
In-Reply-To: <1438364591-1144-1-git-send-email-sudeep.holla@arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "arm@kernel.org" <arm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Jul 31, 2015 at 06:43:03PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC guys,
>=20
> It has been on the list for a while and have got all the necessary AC=
Ks.
> Can you please pull this series for v4.3 ?
>=20
> Regards,
> Sudeep
>=20
> This patch series adds support for:
>   1. SCPI(System Control and Power Interface) mailbox protocol driver=
=2E
>      It uses ARM MHU mailbox controller driver on Juno but can work w=
ith
>      any mailbox controllers using standard mailbox APIs
>   2. Add support for clocks provided by SCP firmware through the SCPI
>      interface
>   3. Using the existing arm_big_little cpufreq driver and the newly
>      added SCPI clock driver, it also adds support for CPU DVFS on
>      ARM64 JUNO development platforms.

Hi Sudeep,

Is there a branch where I can pull this series from?

Best regards,
Liviu

>=20
> The SCPI protocol document is available @[1],[2]
>=20
> Changes v5->v6:
> 	- Minor review comments on clock bindings and clock driver
> 	- Added all the ACKs necessary
>=20
> Changes v4->v5:
> 	- Updated the SCPI clock bindings to correct the clock specifier
> 	  usage and other minor updates as per review feedback
> 	- Updated clock driver to use SCPI specifier clock specifier
> 	  decode function
> 	- Minor reshuffling in Juno DTS files, no functionality change
>=20
> Changes v3->v4:
> 	- Updated the SCPI binding based on MarkR's feedback
> 	- Updated SCPI clock driver to incorporate Stephen Boyd's review
> 	  comments + used clk_set_rate_range to limit the clock range
> 	- Since no major changes are expected in SCPI DT, updated the
> 	  Juno DTS to support SCPI and dependent device nodes.
>=20
> Changes v2->v3:
> 	- Minor fix in SCPI driver and added Tixy's reviewed-by tag
> 	- Updated scpi clock driver to incorporate all the comments from
> 	  Stephen
> 	- Added Viresh's ack
>=20
> Changes v1->v2:
> 	- Updated the token handling in scpi driver as per Tixy's
> 	  suggestion along with other review comments
> 	- Removed multiple drivers in scpi clock as Lorenzo suggested
> 	- Added free_opp_table in scpi-cpufreq as Viresh suggested
> 	- Separated the DT binding document
> 	- Moved SCPI protocol driver to drivers/firmware
>=20
> [1] http://community.arm.com/servlet/JiveServlet/download/8401-45-183=
26/DUI0922B_scp_message_interface.pdf
> [2] https://wiki.linaro.org/ARM/Juno?action=3DAttachFile&do=3Dget&tar=
get=3DDUI0922B_scp_message_interface.pdf
> v1: https://lkml.org/lkml/2015/4/27/232
> v2: https://lkml.org/lkml/2015/5/14/470
> v3: https://lkml.org/lkml/2015/5/27/220
> v4: https://lkml.org/lkml/2015/6/8/178
> v5: https://lkml.org/lkml/2015/7/23/270
>=20
> Cc: devicetree@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>=20
> Sudeep Holla (8):
>   Documentation: add DT binding for ARM System Control and Power
>     Interface(SCPI) protocol
>   firmware: add support for ARM System Control and Power Interface(SC=
PI)
>     protocol
>   clk: add support for clocks provided by SCP(System Control Processo=
r)
>   clk: scpi: add support for cpufreq virtual device
>   cpufreq: arm_big_little: add SCPI interface driver
>   arm64: dts: add SRAM, MHU mailbox and SCPI support on Juno
>   arm64: dts: add CPU topology on Juno
>   arm64: dts: add clock support for all the cpus
>=20
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 150 +++++
>  MAINTAINERS                                        |  10 +
>  arch/arm64/boot/dts/arm/juno-base.dtsi             |  54 ++
>  arch/arm64/boot/dts/arm/juno-r1.dts                |  32 +
>  arch/arm64/boot/dts/arm/juno.dts                   |  32 +
>  drivers/clk/Kconfig                                |  10 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/clk-scpi.c                             | 325 ++++++++++
>  drivers/cpufreq/Kconfig.arm                        |   9 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/scpi-cpufreq.c                     | 124 ++++
>  drivers/firmware/Kconfig                           |  19 +
>  drivers/firmware/Makefile                          |   1 +
>  drivers/firmware/arm_scpi.c                        | 711 +++++++++++=
++++++++++
>  include/linux/scpi_protocol.h                      |  61 ++
>  15 files changed, 1540 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.tx=
t
>  create mode 100644 drivers/clk/clk-scpi.c
>  create mode 100644 drivers/cpufreq/scpi-cpufreq.c
>  create mode 100644 drivers/firmware/arm_scpi.c
>  create mode 100644 include/linux/scpi_protocol.h
>=20
> --=20
> 1.9.1
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF


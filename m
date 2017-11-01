From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal SoC management updates for v4.15-rc1 #1
Date: Tue, 31 Oct 2017 19:34:22 -0700
Message-ID: <20171101023420.GA24685@localhost.localdomain>
References: <20171030143003.GA1938@localhost.localdomain>
 <1509503386.3080.72.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:49816 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932210AbdKACeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2017 22:34:25 -0400
Content-Disposition: inline
In-Reply-To: <1509503386.3080.72.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hey,

On Wed, Nov 01, 2017 at 10:29:46AM +0800, Zhang Rui wrote:
> On Mon, 2017-10-30 at 07:30 -0700, Eduardo Valentin wrote:
> > Hello Rui,
> >=20
> > Please pull the changes for thermal-soc for the coming v4.15-rc1.
> > Changelog:
> > - New drivers: Rockchip RV1108 and Broadcom AVS tmon.
> > - Major rework on HISI driver plus additional support of hisi3660.
> > - Several fixes on diverse drivers and few in core.
> >=20
> > BR,
> >=20
> > The following changes since commit
> > 569dbb88e80deb68974ef6fdd6a13edb9d686261:
> >=20
> > =A0 Linux 4.13 (2017-09-03 13:56:17 -0700)
> >=20
> please rebase it on top of v4.14-rc1 to avoid conflict, as we have a
> couple of thermal soc changes merged in 4.14-rc1.

sure, let me see what I can do. I will send a refresh of the pull
in short. The rebase has no interesting conflict.

>=20
> thanks,
> rui
>=20
> > are available in the git repository at:
> >=20
> > =A0
> >=20
> > for you to fetch changes up to
> > 877a9aa9dadc7291b0069fb2ccdf2bbc1e3e6a6e:
> >=20
> > =A0 thermal: cpu_cooling: pr_err() strings should end with newlines
> > (2017-10-26 11:33:32 -0700)
> >=20
> > ----------------------------------------------------------------
> > Allen Wild (1):
> > =A0=A0=A0=A0=A0=A0thermal: enable broadcom menu for arm64 bcm2835
> >=20
> > Arvind Yadav (1):
> > =A0=A0=A0=A0=A0=A0thermal: cpu_cooling: pr_err() strings should end wit=
h newlines
> >=20
> > Baruch Siach (1):
> > =A0=A0=A0=A0=A0=A0thermal: armada: fix formula documentation comment
> >=20
> > Brian Norris (2):
> > =A0=A0=A0=A0=A0=A0Documentation: devicetree: add binding for Broadcom S=
TB AVS
> > TMON
> > =A0=A0=A0=A0=A0=A0thermal: add brcmstb AVS TMON driver
> >=20
> > Daniel Lezcano (16):
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Fix missing interrupt enablement
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Remove the multiple sensors sup=
port
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Fix kernel panic on alarm inter=
rupt
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Simplify the temperature/step c=
omputation
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Fix multiple alarm interrupts f=
iring
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Remove pointless lock
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Encapsulate register writes int=
o helpers
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Fix configuration register sett=
ing
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Remove costly sensor inspection
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Rename and remove unused field
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Convert long to int
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Remove thermal data back pointer
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Remove mutex_lock in the code
> > =A0=A0=A0=A0=A0=A0thermal/drivers/step_wise: Fix temperature regulation
> > misbehavior
> > =A0=A0=A0=A0=A0=A0thermal/drivers/generic-iio-adc: Switch tz request to=
 devm
> > version
> > =A0=A0=A0=A0=A0=A0thermal/drivers/qcom-spmi: Use devm_iio_channel_get
> >=20
> > Kevin Wangtao (6):
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Move the clk setup in the corre=
sponding
> > functions
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Use round up step value
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Put platform code together
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Add platform prefix to function=
 name
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Prepare to add support for othe=
r hisi
> > platforms
> > =A0=A0=A0=A0=A0=A0thermal/drivers/hisi: Add support for hi3660 SoC
> >=20
> > Nicolin Chen (1):
> > =A0=A0=A0=A0=A0=A0thermal: tegra: remove null check for dev pointer
> >=20
> > Niklas S=F6derlund (1):
> > =A0=A0=A0=A0=A0=A0thermal: rcar_gen3_thermal: fix initialization sequen=
ce for H3
> > ES2.0
> >=20
> > Rocky Hao (2):
> > =A0=A0=A0=A0=A0=A0dt-bindings: rockchip-thermal: Support the RV1108 SoC
> > compatible
> > =A0=A0=A0=A0=A0=A0thermal: rockchip: Support the RV1108 SoC in thermal =
driver
> >=20
> > Tony Lindgren (1):
> > =A0=A0=A0=A0=A0=A0thermal: ti-soc-thermal: Fix ti_thermal_unregister_cp=
u_cooling
> > NULL pointer on unload
> >=20
> > =A0.../devicetree/bindings/thermal/brcm,avs-tmon.txt=A0=A0|=A0=A020 +
> > =A0.../bindings/thermal/rockchip-thermal.txt=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0|=A0=A0=A01 +
> > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A08 +
> > =A0drivers/thermal/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A02 +-
> > =A0drivers/thermal/armada_thermal.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A02 +-
> > =A0drivers/thermal/broadcom/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A07 +
> > =A0drivers/thermal/broadcom/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A01 +
> > =A0drivers/thermal/broadcom/brcmstb_thermal.c=A0=A0=A0=A0=A0=A0=A0=A0=
=A0| 387
> > +++++++++++++
> > =A0drivers/thermal/cpu_cooling.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A02 +-
> > =A0drivers/thermal/hisi_thermal.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0| 612
> > ++++++++++++++-------
> > =A0drivers/thermal/qcom-spmi-temp-alarm.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0|=A0=A043 +-
> > =A0drivers/thermal/rcar_gen3_thermal.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0|=A0=A034 +-
> > =A0drivers/thermal/rockchip_thermal.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0|=A0=A067 +++
> > =A0drivers/thermal/step_wise.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A011 +-
> > =A0drivers/thermal/tegra/soctherm.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A02 +-
> > =A0drivers/thermal/thermal-generic-adc.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0|=A0=A024 +-
> > =A0drivers/thermal/ti-soc-thermal/ti-thermal-common.c |=A0=A0=A03 +-
> > =A017 files changed, 940 insertions(+), 286 deletions(-)
> > =A0create mode 100644
> > Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
> > =A0create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c

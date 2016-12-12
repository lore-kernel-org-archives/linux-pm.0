From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Subject: [PATCHv5 0/5] thermal: add driver for R-Car Gen3
Date: Mon, 12 Dec 2016 15:18:00 +0100
Message-ID: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:52446 "EHLO
        smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbcLLOUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 09:20:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Hi all,

The series adds thermal support to Renesas R-Car Gen3 SoCs. It's tested 
on Salvator-X H3 and M3-W SoC.

Wolfram asked me to have a look at the comments for v4 and to try and 
rework the temperature formulas to work with only ints and if it worked 
out resend the series. I have reworked code in 2/5 but kept Wolfram as 
the author and added my SoB, hope this is OK.

Reworking the formulas involved moving from s64 to int as the data type 
used to store coefficients used in decimal scaled fixed point 
calculations. By examining the largest values which could be produced in 
these calculations a factor of 100 is the maximum scaling which is 
possible and still fit inside an int, previously with s64 the scaling 
was 1000.

Reducing the decimal scaling also reduces the accuracy of the 
calculations. In my tests this was hardly noticeable as the granularity 
of the reported temperature to user-space is 0.5C, comparing the value 
reported in the s64 vs int implementation only differ very slightly when 
it rounded the value to the next 0.5C level.

However the formulas used to calculate the coefficients are not 
documented and none obvious (at lest not to me) so given different 
initial values to calculate the coefficients the error might become 
larger. Therefore I would like to ask Morimoto-san and/or Khiem to 
provide or proxy testing of this less accurate formula and feedback if 
it's OK, let me know if there is anything I can do to help out.

Changes since v4:
- Use only 32 bit ints to convert from register value to temperature.
- Merge and simplify temp calculation functions.
- Document what I known about the temprature conversion formulas.
- Add new patch 5/5 which fixes a waring printout caused by trying to get 
  temp before hardware is ready on r8a7795.
- Fixed a few checkpatch warnings.

Niklas Söderlund (1):
  thermal: rcar_gen3_thermal: Add delay in .thermal_init on r8a7795

Wolfram Sang (4):
  thermal: rcar_gen3_thermal: Document the R-Car Gen3
  thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver
  arm64: dts: r8a7795: Add R-Car Gen3 thermal support
  arm64: dts: r8a7796: Add R-Car Gen3 thermal support

 .../bindings/thermal/rcar-gen3-thermal.txt         |  56 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  58 ++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  58 ++++
 drivers/thermal/Kconfig                            |   9 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/rcar_gen3_thermal.c                | 330 +++++++++++++++++++++
 6 files changed, 512 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c

-- 
2.10.2


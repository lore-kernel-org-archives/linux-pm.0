From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv6 0/4] thermal: add driver for R-Car Gen3
Date: Thu, 22 Dec 2016 11:38:19 +0100
Message-ID: <20161222103823.8300-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

Hi all,

The series adds thermal support to Renesas R-Car Gen3 SoCs. It's tested
on Salvator-X H3 and M3-W SoC.

Wolfram asked me to have a look at the comments for v4 and to try and
rework the temperature formulas to work with only ints and if it worked
out resend the series. I have reworked code in 2/4 but kept Wolfram as
the author and added my SoB, hope this is OK.

Reworking the formulas involved moving from s64 to int as the data type
used to store coefficients used in binary scaled fixed point
calculations. By examining the largest values which could be produced in
these calculations a shift of 7 is the maximum scaling which is
possible and still fit inside an int, previously with s64 the decimal scaling
was 1000.

Changing the decimal scaling also reduces the accuracy of the
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

Changes since v5
- Switch fixpoint scaling from decimal with a factor 100 to binary with 
  a shift of 7 bits to increase accuracy. In v5 decimal scaling was used 
  since it closest resembled the v4 implementation of a decimal scaling 
  with 1000 as a factor. The big change in v5 was to fit all  
  calculations inside a int instead of s64.

  After discussions with Geert and Wolfram it became apparent that 
  disregarding what scaling method used the change in scaling to fit 
  inside a int needs to be reverified by Morimoto-san or Khiem so we 
  might as well have as much accuracy as possible.

- Dropped macro for fixed point multiplication. All uses where between a 
  scaled variable and a none scaled constant so upscaling the constant 
  just to then downscale the product where unneeded and the product 
  could overflow before it was downscaled.

- Change calculation of one constant (tj_2) to not be upscaled before 
  it's divided. This is how it's done in the BSP and it could overflow 
  if done with upscaled numbers. As a good side effect the final 
  temperature value more closely match the BSP value. This should never 
  have been changed to work with upscaled variables in v5.

- Rename fixed point calculation macros prefix from SCALE_ to FIXPT_

- Use DIV_ROUND_CLOSEST in FIXPT_DIV macro. In theory when PTAT and 
  THCODE values are read from hardware (not available yet) 
  DIV_ROUND_CLOSEST could be called with a negative divisor which 
  currently is not supported by DIV_ROUND_CLOSEST. I have submitted a 
  patch to fix DIV_ROUND_CLOSEST to support this '[RFC/PATCH] 
  linux/kernel.h: Fix DIV_ROUND_CLOSEST to support negative'. If that 
  patch is rejected something similar needs to be added as local code 
  here before PTAT and THCODE values can be read from registers.

- Add spaces between all operands in FIXPT_ macros

- Squashed patch 5/5 into 2/5.

Changes since v4:
- Use only 32 bit ints to convert from register value to temperature.
- Merge and simplify temp calculation functions.
- Document what I known about the temprature conversion formulas.
- Add new patch 5/5 which fixes a waring printout caused by trying to get
  temp before hardware is ready on r8a7795.
- Fixed a few checkpatch warnings.


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
 drivers/thermal/rcar_gen3_thermal.c                | 335 +++++++++++++++++++++
 6 files changed, 517 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c

-- 
2.11.0

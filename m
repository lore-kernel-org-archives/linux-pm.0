From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/2] arm64: dts: r8a7795: r8a7796: add thermal cooling management
Date: Wed, 13 Sep 2017 12:59:07 +0200
Message-ID: <20170913105909.13230-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

Hi,

This series adds support for for using CPUFreq as a cooling device for 
the A57 CUP:s on Renesas H3 and M3-W SoC:s. It depends on Simon Horman's 
topic/rcar-gen3-cpufreq branch [1] and is tested on-top the latest 
renesas-drivers on H3 and M3-W. For test results and test procedure 
please see:

   http://elinux.org/R-Car/Tests:rcar_gen3_thermal

Few notes on the specific values used in this series and why they might 
need to be changed.

- The trip point temperature of 95000 used is the most conservative one 
  from the BSP and maybe should be set at 110000 which is the most 
  aggressive one in the BSP.

- The cooling states described in all cooling-maps nodes might be 
  subject to change depending on the out-come of the ongoing review 
  process of Simon's work. It should use the highest possible cooling 
  state so if the number of states change due review of his work this 
  should be reflected in this series.

1.  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

Niklas Söderlund (2):
  arm64: dts: r8a7795: add thermal cooling management
  arm64: dts: r8a7796: add thermal cooling management

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 40 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 38 ++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

-- 
2.14.1

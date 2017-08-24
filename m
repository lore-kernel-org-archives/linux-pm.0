From: <cl@rock-chips.com>
Subject: [PATCH v1 0/3] Enable some devices for rk3328 evaluation board
Date: Thu, 24 Aug 2017 10:37:00 +0800
Message-ID: <1503542223-21044-1-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rjw@rjwysocki.net, catalin.marinas@arm.com, shawn.lin@rock-chips.com, linux-pm@vger.kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, Liang Chen <cl@rock-chips.com>, viresh.kumar@linaro.org, fabio.estevam@nxp.com, rocky.hao@rock-chips.com, shawnguo@kernel.org, afaerber@suse.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

1. enalbe sdio/sdmmc/emmc.
2. enable cpufreq.

change in v2:

1. remove useless properties in mmc nodes.

Liang Chen (3):
  arm64: dts: rockchip: add mmc nodes for rk3328 evaluation board
  cpufreq: rockchip: add support for rk3328 soc
  arm64: dts: rockchip: add cpu regulator for rk3328 evaluation board

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 70 +++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |  1 +
 2 files changed, 71 insertions(+)

-- 
1.9.1

From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v1 0/4] arm64: dts: NXP: add basic dts file for LX2160A SoC
Date: Tue, 26 Feb 2019 10:10:46 +0000
Message-ID: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, will.deacon@a
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Vabhav Sharma <vabhav.sharma@nxp.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>
List-Id: linux-pm@vger.kernel.org

These patches were reviewed and acked but dropped during merge window.
Patchwork link was https://lore.kernel.org/patchwork/cover/1004155/

Changes for v1:
- Updated lx2160a clockgen in alphabetical order

Vabhav Sharma (2):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add definition for LX2160A

Yogesh Gaur (2):
  clk: qoriq: increase array size of cmux_to_group
  clk: qoriq: Add clockgen support for lx2160a

 .../bindings/arm/freescale/fsl,layerscape-dcfg.txt       |  2 +-
 Documentation/devicetree/bindings/arm/fsl.txt            | 12 ++++++++++++
 Documentation/devicetree/bindings/clock/qoriq-clock.txt  |  1 +
 drivers/clk/clk-qoriq.c                                  | 16 ++++++++++++++--
 drivers/cpufreq/qoriq-cpufreq.c                          |  1 +
 drivers/soc/fsl/guts.c                                   |  6 ++++++
 6 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.7.4

From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 0/4] Introduce OPP bandwidth bindings
Date: Wed, 13 Mar 2019 11:00:06 +0200
Message-ID: <20190313090010.20534-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc: jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Here is a proposal to extend the OPP bindings with bandwidth based on
a previous discussion [1].

Every functional block on a SoC can contribute to the system power
efficiency by expressing its own bandwidth needs (to memory or other SoC
modules). This will allow the system to save power when high throughput
is not required (and also provide maximum throughput when needed).

There are at least three ways for a device to determine its bandwidth
needs:
	1. The device can dynamically calculate the needed bandwidth
based on some known variable. For example: UART (baud rate), I2C (fast
mode, high-speed mode, etc), USB (specification version, data transfer
type), SDHC (SD standard, clock rate, bus-width), Video Encoder/Decoder
(video format, resolution, frame-rate)

	2. There is a hardware specific value. For example: hardware
specific constant value (e.g. for PRNG) or use-case specific value that
is hard-coded.

	3. Predefined SoC/board specific bandwidth values. For example:
CPU or GPU bandwidth is related to the current core frequency and both
bandwidth and frequency are scaled together.

This patchset is trying to address point 3 above by extending the OPP
bindings to support predefined SoC/board bandwidth values and adds
support in cpufreq-dt to scale the interconnect between the CPU and the
DDR together with frequency and voltage.

[1] https://patchwork.kernel.org/patch/10577315/

Georgi Djakov (4):
  dt-bindings: opp: Introduce opp-bw-MBs bindings
  OPP: Add support for parsing the interconnect bandwidth
  OPP: Update the bandwidth on OPP frequency changes
  cpufreq: dt: Add support for interconnect bandwidth scaling

 Documentation/devicetree/bindings/opp/opp.txt | 45 ++++++++++++
 drivers/cpufreq/cpufreq-dt.c                  | 27 ++++++-
 drivers/opp/core.c                            | 71 +++++++++++++++++++
 drivers/opp/of.c                              | 44 ++++++++++++
 drivers/opp/opp.h                             |  6 ++
 include/linux/pm_opp.h                        | 14 ++++
 6 files changed, 206 insertions(+), 1 deletion(-)

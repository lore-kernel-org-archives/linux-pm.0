From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v4 0/6] thermal: tsens: Refactoring for TSENSv2 IP
Date: Mon,  2 Jul 2018 18:14:03 +0530
Message-ID: <cover.1530533998.git.amit.kucheria@linaro.org>
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
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, rnayak@codeaurora.org, Kees Cook <keescook@chromium.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, smohanad@codeaurora.org, bjorn.andersson@linaro.org, edubezval@gmail.com, vivek.gautam@codeaurora.org, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This series is a mixed bag:
- Some code moves to allow code sharing between various v2.x.y versions of
  the TSENS IP,
- new qcom,tsens-v2.4.0 DT property for SDM845 and a generic qcom,tsens-v2
  property as a fallback compatible for all v2.x.y platforms,
- new platform support (sdm845)
- a cleanup patch and
- a DT change to have a common way to deal with the SROT and TM registers
  despite slightly different features across the IP family and different
  register offsets.

Rob mentioned offline that we should expose the full version string of the
TSENS IP (x.y.z) and have a fallback compatible. I hope patch 4 does what
you were looking for.

Regards,
Amit

Amit Kucheria (6):
  thermal: tsens: Get rid of unused fields in structure
  dt: qcom: 8996: thermal: Move to DT initialisation
  thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
  thermal: tsens: Add support for SDM845
  thermal: tsens: Check if we have valid data before reading
  arm64: dts: sdm845: Add tsens nodes

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  2 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 ++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 39 ++++++++++++----------
 drivers/thermal/qcom/tsens.c                       |  6 ++++
 drivers/thermal/qcom/tsens.h                       |  7 ++--
 7 files changed, 62 insertions(+), 22 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)

-- 
2.7.4

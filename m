From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 0/6] thermal: tsens: Refactoring for TSENSv2 IP
Date: Mon, 2 Jul 2018 10:53:57 -0700
Message-ID: <20180702175357.GA28713@localhost.localdomain>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 02, 2018 at 06:14:03PM +0530, Amit Kucheria wrote:
> This series is a mixed bag:
> - Some code moves to allow code sharing between various v2.x.y versions of
>   the TSENS IP,
> - new qcom,tsens-v2.4.0 DT property for SDM845 and a generic qcom,tsens-v2
>   property as a fallback compatible for all v2.x.y platforms,
> - new platform support (sdm845)
> - a cleanup patch and
> - a DT change to have a common way to deal with the SROT and TM registers
>   despite slightly different features across the IP family and different
>   register offsets.
> 
> Rob mentioned offline that we should expose the full version string of the
> TSENS IP (x.y.z) and have a fallback compatible. I hope patch 4 does what
> you were looking for.

Applied patches 1, 3, and 4. Patch 5 needs a description. Patches 2 and
6 go via your arch tree.

> 
> Regards,
> Amit
> 
> Amit Kucheria (6):
>   thermal: tsens: Get rid of unused fields in structure
>   dt: qcom: 8996: thermal: Move to DT initialisation
>   thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
>   thermal: tsens: Add support for SDM845
>   thermal: tsens: Check if we have valid data before reading
>   arm64: dts: sdm845: Add tsens nodes
> 
>  .../devicetree/bindings/thermal/qcom-tsens.txt     |  2 ++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 ++++++-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++
>  drivers/thermal/qcom/Makefile                      |  2 +-
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 39 ++++++++++++----------
>  drivers/thermal/qcom/tsens.c                       |  6 ++++
>  drivers/thermal/qcom/tsens.h                       |  7 ++--
>  7 files changed, 62 insertions(+), 22 deletions(-)
>  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)
> 
> -- 
> 2.7.4
> 

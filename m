From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/5] thermal: tsens: Add support for SDM845
Date: Tue, 12 Jun 2018 13:28:59 -0600
Message-ID: <20180612192859.GA14933@rob-hp-laptop>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 01:54:56PM +0300, Amit Kucheria wrote:
> SDM845 uses the TSENS v2 IP block
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/thermal/qcom/Makefile                            |  2 +-
>  drivers/thermal/qcom/tsens-sdm845.c                      | 15 +++++++++++++++
>  drivers/thermal/qcom/tsens.c                             |  3 +++
>  drivers/thermal/qcom/tsens.h                             |  5 ++++-
>  5 files changed, 24 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/thermal/qcom/tsens-sdm845.c

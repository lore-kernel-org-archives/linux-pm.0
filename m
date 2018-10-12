From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: power: Add Spreadtrum SC27XX fuel
 gauge unit documentation
Date: Fri, 12 Oct 2018 09:36:42 -0500
Message-ID: <20181012143642.GA9323@bogus>
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
 <f87afb701f33f46928c682361235083db8d3d2fc.1538033078.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f87afb701f33f46928c682361235083db8d3d2fc.1538033078.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Sep 2018 15:26:56 +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
> fuel gauge unit device, which is used to calculate the battery capacity.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v2:
>  - Add reviewed tag from Linus.
> 
> Changes from v1:
>  - Renamed GPIO property.
>  - Use standand battery properties instead of 'sprd,inner-resist' and
>    'sprd,ocv-cap-table'.
>  - Remove battery node's description.
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   52 ++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

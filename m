From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 3/6] dt-bindings: power: Introduce properties to
 present the battery OCV capacity table
Date: Mon, 22 Oct 2018 17:10:31 -0500
Message-ID: <20181022221031.GA31167@bogus>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1540189330.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1540189330.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Oct 2018 15:43:59 +0800, Baolin Wang wrote:
> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsius.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values.
> 
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v5:
>  - None.
> 
> Changes from v4:
>  - Improve the description of ocv-capacity-table-n to make the order clear.
> 
> Changes from v3:
>  - Split binding into one separate patch.
>  - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
>  - Add some words to specify the OCV's unit.
> 
> Changes from v2:
>  - Use type __be32 to calculate the table length.
>  - Update error messages.
>  - Add some helper functions.
> 
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

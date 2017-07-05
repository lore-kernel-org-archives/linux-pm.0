From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: cpufreq: enhance MediaTek cpufreq
 dt-binding document
Date: Wed, 5 Jul 2017 09:52:12 +0530
Message-ID: <20170705042212.GK3532@vireshk-i7>
References: <cover.1499194061.git.sean.wang@mediatek.com>
 <ce40386c0ae1e574d8d03354aa665bf9de6b0bbc.1499194061.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ce40386c0ae1e574d8d03354aa665bf9de6b0bbc.1499194061.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05-07-17, 02:55, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Update binding document with adding operating-points-v2 as the required
> property and the cooling level as the optional properties and adding more
> examples guiding people how to use MediaTek cpufreq driver for MediaTek
> SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek.txt          | 170 ++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> index 52b457c..e919ca7 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> @@ -1,4 +1,5 @@
> -Device Tree Clock bindins for CPU DVFS of Mediatek MT8173 SoC
> +Binding for MediaTek's CPUFreq driver
> +=====================================
>  
>  Required properties:
>  - clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
> @@ -9,6 +10,8 @@ Required properties:
>  			  transition and not stable yet.
>  	Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
>  	generic clock consumer properties.
> +- operating-points-v2: Pleaser refer to Documentation/devicetree/bindings/opp/opp.txt

s/Pleaser/Please

-- 
viresh

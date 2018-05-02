From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 01/12] dt-bindings: cpufreq: mediatek: use - instead of
 _ in examples
Date: Wed, 2 May 2018 10:59:09 +0200
Message-ID: <1da10bfb-5d96-5a69-252e-2efacf120fdf@gmail.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
 <1b9604aa3d3c68be68caf8af32fa4130f57743d6.1523434758.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1b9604aa3d3c68be68caf8af32fa4130f57743d6.1523434758.git.sean.wang@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 04/11/2018 10:53 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> It should be good that no use "_" is in examples. Consequently,
> those nodes in certain files which have an inappropriate name containing
> "_" are all being replaced with "-".
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Rafael, will you take this through your tree?

Regards,
Matthias

> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> index d36f07e..38cfbb5 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> @@ -26,7 +26,7 @@ Optional properties:
>  
>  Example 1 (MT7623 SoC):
>  
> -	cpu_opp_table: opp_table {
> +	cpu_opp_table: opp-table {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -86,7 +86,7 @@ Example 1 (MT7623 SoC):
>  	};
>  
>  Example 2 (MT8173 SoC):
> -	cpu_opp_table_a: opp_table_a {
> +	cpu_opp_table_a: opp-table-a {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -131,7 +131,7 @@ Example 2 (MT8173 SoC):
>  		};
>  	};
>  
> -	cpu_opp_table_b: opp_table_b {
> +	cpu_opp_table_b: opp-table-b {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> 

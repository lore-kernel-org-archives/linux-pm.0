From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 02/20] PM / devfreq: exynos: Add documentation for
 generic exynos bus frequency driver
Date: Mon, 11 Apr 2016 10:40:13 -0500
Message-ID: <20160411154012.GA24665@rob-hp-laptop>
References: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
 <1460089509-16260-3-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460089509-16260-3-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, rjw@rjwysocki.net, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 08, 2016 at 01:24:51PM +0900, Chanwoo Choi wrote:
> This patch adds the documentation for generic exynos bus frequency
> driver.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> new file mode 100644
> index 000000000000..78171b918e3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -0,0 +1,95 @@
> +* Generic Exynos Bus frequency device
> +
> +The Samsung Exynos SoC has many buses for data transfer between DRAM
> +and sub-blocks in SoC. Most Exynos SoCs share the common architecture
> +for buses. Generally, each bus of Exynos SoC includes a source clock
> +and a power line, which are able to change the clock frequency
> +of the bus in runtime. To monitor the usage of each bus in runtime,
> +the driver uses the PPMU (Platform Performance Monitoring Unit), which
> +is able to measure the current load of sub-blocks.
> +
> +There are a little different composition among Exynos SoC because each Exynos
> +SoC has different sub-blocks. Therefore, shch difference should be specified
> +in devicetree file instead of each device driver. In result, this driver
> +is able to support the bus frequency for all Exynos SoCs.

I still have issues with this whole series. The DT hierarchy represents 
buses. You are describing buses here and control of them. I would expect 
to see some hierarchy, but there is none. What this looks like is you 
are adding nodes based on what fits the current driver.

Rob

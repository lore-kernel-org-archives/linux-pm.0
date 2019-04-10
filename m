From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: cpufreq: Document
 operating-points-v2-sunxi-cpu
Date: Wed, 10 Apr 2019 08:56:08 +0530
Message-ID: <20190410032608.fqxahvys6rysvayy@vireshk-i7>
References: <20190409172558.18778-1-tiny.windzz@gmail.com>
 <20190409172558.18778-3-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190409172558.18778-3-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-04-19, 13:25, Yangtao Li wrote:
> Allwinner Process Voltage Scaling Tables defines the voltage and
> frequency value  based on the speedbin blown in the efuse combination.
> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each
> OPP of operating-points-v2 table when it is parsed by the OPP framework.
> 
> The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-microvolt-<name>: voltage in micro Volts.
>   At runtime, the platform can pick a <name> and matching
>   opp-microvolt-<name> property
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt

LGTM.

-- 
viresh

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/4] mvebu: Dove: Add clocks and DFS interrupt to cpu node in DT.
Date: Thu, 31 Oct 2013 23:26:29 +0100
Message-ID: <1429743.Nz1AUEe5Hi@vostro.rjw.lan>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch> <1383247111-26834-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51802 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751761Ab3JaWOU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2013 18:14:20 -0400
In-Reply-To: <1383247111-26834-4-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Thursday, October 31, 2013 08:18:31 PM Andrew Lunn wrote:
> The dove-cpufreq driver needs access to the DDR and CPU clock.  There
> is also an interrupt generated when the DFS hardware completes a
> change of frequencey. Add these to the cpu node in DT.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

I need someone with DT bindings knowledge to ACK this for me.

Thanks!

> ---
>  arch/arm/boot/dts/dove.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 1fd615d27532..e96d7a6a2fb8 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -19,6 +19,10 @@
>  			device_type = "cpu";
>  			next-level-cache = <&l2>;
>  			reg = <0>;
> +			clocks = <&core_clk 1>, <&core_clk 3>;
> +			clock-names = "cpu_clk", "ddrclk";
> +			interrupt-parent = <&pmu_intc>;
> +			interrupts = <0>;
>  		};
>  	};
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

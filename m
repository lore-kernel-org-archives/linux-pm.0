From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] ARM: dts: uniphier: add CPU clocks and OPP table for
 Pro5 SoC
Date: Thu, 27 Oct 2016 08:57:31 +0530
Message-ID: <20161027032731.GP9162@vireshk-i7>
References: <1477499859-12415-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477499859-12415-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 27-10-16, 01:37, Masahiro Yamada wrote:
> Add a CPU clock to every CPU node and a CPU OPP table to use the
> generic cpufreq driver.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/boot/dts/uniphier-pro5.dtsi | 74 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)

For both patches.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

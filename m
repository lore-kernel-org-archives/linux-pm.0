From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal zone node
Date: Fri, 10 May 2019 11:13:36 +0800
Message-ID: <20190510031335.GD15856@dragon>
References: <20190423022507.34969-1-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423022507.34969-1-andy.tang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuantian Tang <andy.tang@nxp.com>
Cc: leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 23, 2019 at 10:25:07AM +0800, Yuantian Tang wrote:
> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core cluster
> sensor is used to monitor the temperature of core and SoC platform is for
> platform. The current dts only support the first sensor.
> This patch adds the second sensor node to dts to enable it.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v6:
>         - add cooling device map to cpu0-7 in platform node.

@Daniel, are you fine with this version?

Shawn

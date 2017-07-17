From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] thermal: imx: Add nvmem-cells alternate binding
 for OCOTP access
Date: Mon, 17 Jul 2017 13:57:34 -0500
Message-ID: <20170717185734.r6vmeherekkhacoh@rob-hp-laptop>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
 <79ad86fbce37b169342704c397f0a1dbae0cfb75.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79ad86fbce37b169342704c397f0a1dbae0cfb75.1500041281.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 14, 2017 at 05:11:06PM +0300, Leonard Crestez wrote:
> On newer imx SOCs accessing OCOTP directly is wrong because the ocotp
> clock needs to be enabled first. Add a binding for accessing the same
> values through the imx-ocotp nvmem driver using nvmem-cells. This is
> similar to other thermal drivers.
> 
> The old binding is preserved for compatibility and because it still
> works fine on imx6qdl series chips.
> 
> In theory this problem could be solved by adding a reference to the
> OCOTP clock instead but it is better to hide such details in a specific
> nvmem driver.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  Documentation/devicetree/bindings/thermal/imx-thermal.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

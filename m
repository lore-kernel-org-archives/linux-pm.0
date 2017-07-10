From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] thermal: imx: Add nvmem-cells alternate binding for
 OCOTP access
Date: Mon, 10 Jul 2017 08:29:27 -0500
Message-ID: <20170710132927.6brgagaymv5atiak@rob-hp-laptop>
References: <cover.1499347157.git.leonard.crestez@nxp.com>
 <1bd07f44515f05d936a3c166217e844253a85d2d.1499347157.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35084 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbdGJN33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 09:29:29 -0400
Content-Disposition: inline
In-Reply-To: <1bd07f44515f05d936a3c166217e844253a85d2d.1499347157.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 06, 2017 at 04:20:41PM +0300, Leonard Crestez wrote:
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
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 3c67bd5..2842a05 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -7,9 +7,16 @@ Required properties:
>    is higher than panic threshold, system will auto reboot by SRC module.
>  - fsl,tempmon : phandle pointer to system controller that contains TEMPMON
>    control registers, e.g. ANATOP on imx6q.
> +
> +Properties for OCOTP access:
>  - fsl,tempmon-data : phandle pointer to fuse controller that contains TEMPMON
>    calibration data, e.g. OCOTP on imx6q.  The details about calibration data
>    can be found in SoC Reference Manual.
> +Alternatively:

Just put these under required props and put the deprecated one under a 
deprecated section. IOW, make it easy to remove the deprecated part.

> +- nvmem-cells: A phandle to the calibration cells provided by ocotp.
> +- nvmem-cell-names: Should be "calib", "temp_grade".
> +
> +Direct access to OCOTP is deprecated, please use nvmem cells instead.
>  
>  Optional properties:
>  - clocks : thermal sensor's clock source.
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

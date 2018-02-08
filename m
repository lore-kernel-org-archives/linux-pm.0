From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/2] thermal: imx: add i.MX7 thermal sensor support
Date: Thu, 8 Feb 2018 14:21:36 -0600
Message-ID: <20180208202136.rpghc2dpcd42zqvn@rob-hp-laptop>
References: <1517818347-7436-1-git-send-email-Anson.Huang@nxp.com>
 <1517818347-7436-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1517818347-7436-2-git-send-email-Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-imx-3arQi8VN3Tc@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 05, 2018 at 04:12:27PM +0800, Anson Huang wrote:
> This patch adds i.MX7 thermal sensor support, most
> of the i.MX7 thermal sensor functions are same with
> i.MX6 except the registers offset/layout, so we move
> those registers offset/layout definitions to soc data
> structure.
> 
> i.MX7 uses single calibration data @25C, the calibration
> data is located at OCOTP offset 0x4F0, bit[17:9], the
> formula is as below:
> 
> Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> 
> Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>
> ---
> changes since V2:
> 	Add bindind doc changes in this patch according to review comments.
>  .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/thermal/imx_thermal.c                      | 314 ++++++++++++++++-----
>  2 files changed, 254 insertions(+), 69 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

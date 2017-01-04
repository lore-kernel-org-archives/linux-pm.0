From: Scott Wood <oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 1/3] dt-bindings: Update QorIQ TMU thermal bindings
Date: Wed, 04 Jan 2017 04:37:54 -0600
Message-ID: <1483526274.17813.1.camel@buserror.net>
References: <1483520271-3838-1-git-send-email-hongtao.jia@nxp.com>
         <1483520271-3838-2-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483520271-3838-2-git-send-email-hongtao.jia-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jia Hongtao <hongtao.jia-3arQi8VN3Tc@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yuantian.tang-3arQi8VN3Tc@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-01-04 at 16:57 +0800, Jia Hongtao wrote:
> For different types of SoC the sensor id and endianness may vary.
> "#thermal-sensor-cells" is used to provide sensor id information.
> "little-endian" property is to tell the endianness of TMU.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia-3arQi8VN3Tc@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> index 66223d5..20ca4ef 100644
> --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> @@ -17,6 +17,12 @@ Required properties:
>  	calibration data, as specified by the SoC reference manual.
>  	The first cell of each pair is the value to be written to TTCFGR,
>  	and the second is the value to be written to TSCFGR.
> +- #thermal-sensor-cells : Must be 1. The sensor specifier is the monitoring
> +	site ID, and represents the "n" in TRITSRn and TRATSRn.

I assume the driver will continue to work with existing device trees where
this information is absent?  If so, ACK for the whole series.

-Scott

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

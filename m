From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: rockchip-thermal: fix the misleading
 description
Date: Tue, 18 Oct 2016 07:41:20 -0500
Message-ID: <20161018124120.vgbamfjsgvf6ntxg@rob-hp-laptop>
References: <1476151655-18415-1-git-send-email-shawn.lin@rock-chips.com>
 <1476151655-18415-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476151655-18415-2-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 11, 2016 at 10:07:35AM +0800, Shawn Lin wrote:
> "rockchip,hw-tshut-temp", "rockchip,hw-tshut-mode" and
> "rockchip,hw-tshut-polarity" are not a required properties
> actually as the code could also work by loading the default
> settings there. So it is apprently misleading, although we
> prefer to get these from DT. And it seems we miss the 'rockchip,grf'
> here which should also be an optional property.
> 
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

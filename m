From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 1/2] thermal: max77620: Add DT binding doc for thermal
 driver
Date: Wed, 8 Jun 2016 15:08:34 -0500
Message-ID: <20160608200834.GA14813@rob-hp-laptop>
References: <1465296754-13186-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1465296754-13186-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Keerthy <a0393675-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 07, 2016 at 04:22:33PM +0530, Laxman Dewangan wrote:
> Maxim Semiconductor MAX77620 supports alarm interrupts when
> its die temperature crosses 120C and 140C. These threshold
> temperatures are not configurable.
> 
> Add DT binding document to details out the DT property related
> to MAX77620 thermal functionality.
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> ---
> Changes from V3:
> Added example node for the critical trips also as critical.
> Also change the warning as "hot" type.
> 
>  .../bindings/thermal/thermal-max77620.txt          | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-max77620.txt

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

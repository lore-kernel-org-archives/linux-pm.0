From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] power: reset: remove unused imx-snvs-poweroff driver
Date: Tue, 26 Dec 2017 15:57:15 -0600
Message-ID: <20171226215715.ph5vjvmkvchvrnsd@rob-hp-laptop>
References: <1513938539-20873-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1513938539-20873-1-git-send-email-aisheng.dong-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yibin.gong-3arQi8VN3Tc@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 22, 2017 at 06:28:59PM +0800, Dong Aisheng wrote:
> There's no user of it in kernel now and it basically functions the same
> as the generic syscon-poweroff.c to which we have already switched.
> So let's remove it.
> 
> Cc: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
> Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
> ---
>  .../bindings/power/reset/imx-snvs-poweroff.txt     | 23 --------

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/power/reset/Kconfig                        |  9 ---
>  drivers/power/reset/Makefile                       |  1 -
>  drivers/power/reset/imx-snvs-poweroff.c            | 66 ----------------------
>  4 files changed, 99 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt
>  delete mode 100644 drivers/power/reset/imx-snvs-poweroff.c
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

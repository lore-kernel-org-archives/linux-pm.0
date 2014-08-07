From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3] Thermal: imx: add i.mx6sx thermal support
Date: Thu, 7 Aug 2014 16:50:26 +0800
Message-ID: <20140807085024.GE27051@dragon>
References: <1407309129-5562-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407309129-5562-1-git-send-email-b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anson Huang <b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 06, 2014 at 03:12:09PM +0800, Anson Huang wrote:
> i.MX6SX has some new features of thermal interrupt function,
> there are LOW, HIGH and PANIC irq for thermal sensor, so add
> platform data to separate different thermal version;
> 
> The reset value of LOW ALARM is 0 which means the highest
> temp, so the LOW ALARM will be triggered once irq is enabled,
> so we need to correct it before enabling thermal irq;
> 
> Enable PANIC ALARM as critical trip point, it will trigger
> system reset via SRC module once PANIC IRQ is triggered, it
> is pure hardware function, so use it instead of software
> reset by cooling device.
> 
> Signed-off-by: Anson Huang <b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Tested-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

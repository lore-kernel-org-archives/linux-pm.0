From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for i.mx6ul
Date: Tue, 2 Jan 2018 13:13:29 -0200
Message-ID: <CAOMZO5DvKi4nXfoSBWbe6qedoWO7RiSP5CvJEkBAVUioyVBN=Q@mail.gmail.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
 <1514912859-17691-2-git-send-email-Anson.Huang@nxp.com> <CAOMZO5Do-tyR0ruqfSeJm2FDP7_chNeroFStTF85GnSt_2g5Uw@mail.gmail.com>
 <A2F3BA8B-361A-4809-83FE-4067CD868D5B@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A2F3BA8B-361A-4809-83FE-4067CD868D5B-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anson Huang <anson.huang-3arQi8VN3Tc@public.gmane.org>
Cc: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "A.s. Dong" <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Jacky Bai <ping.bai-3arQi8VN3Tc@public.gmane.org>, viresh kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Anson,

On Tue, Jan 2, 2018 at 1:05 PM, Anson Huang <anson.huang-3arQi8VN3Tc@public.gmane.org> wrote:

> This change is to support 696MHz operating point, both the speed grading
> check and pll rate change are necessary for 696MHz support, do you think
> they should be in different patch?

I thought  this could also change the behaviour for mx6q/dl/qp.

Are the others SoCs safe with this change?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

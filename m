From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
Date: Thu, 13 Apr 2017 23:46:15 +0300
Message-ID: <1492116375.17723.15.camel@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
         <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
         <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
         <1490704781.3546.57.camel@nxp.com>
         <20170328164754.z2c2ttovs3sxbcos@sirena.org.uk>
         <1490730595.15830.1.camel@nxp.com>
         <20170406185202.uixxcv3dgucrddgc@sirena.org.uk>
         <1491562312.9365.41.camel@nxp.com>
         <20170407112212.gzv3p7ldkh62657m@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170407112212.gzv3p7ldkh62657m-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-04-07 at 12:22 +0100, Mark Brown wrote:
> On Fri, Apr 07, 2017 at 01:51:52PM +0300, Leonard Crestez wrote:

> > It currently seems to work how I expect but from your statement it's
> > not clear if it's entirely intentional.

> The current behaviour of bypassed regulators is intentional.

I did not mean to imply that there is something wrong with bypassed
regulators. I just wanted more information about how regulators (non-
bypassed) pick their voltage when consumers allow a range.

After some more reading through the code it seems that the driver
itself receives the range (either through set_voltage or map_voltage)
and gets to make the choice.

So it seems fine for my concerns, sorry to bother you.

--
Regards,
Leonard
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

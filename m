From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [RFC 3/8] cpufreq: imx6q: Set max suspend_freq to avoid changes
 during suspend
Date: Tue, 28 Mar 2017 23:03:51 +0300
Message-ID: <1490731431.15830.9.camel@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
         <f2126423e233757eb113f115e0be562ea0902a7a.1490199005.git.leonard.crestez@nxp.com>
         <20170323043427.GE12094@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170323043427.GE12094@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-03-23 at 10:04 +0530, Viresh Kumar wrote:
> On 22-03-17, 18:53, Leonard Crestez wrote:
> > If the cpufreq driver tries to modify voltage/freq during suspend/resume
> > it might need to control an external PMIC via I2C or SPI but those
> > devices might be already suspended.
> > 
> > To avoid this scenario we just increase cpufreq to highest setpoint
> > before suspend. This issue can easily be triggered by ldo-bypass but in
> > theory any regulator set_voltage call can end up having to modify
> > external supply voltages.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The first couple of patches are obvious fixes despite being marked as
RFC. It would be great if you could apply them to your tree separately
from the rest of the series but I'm not sure what the process is here.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

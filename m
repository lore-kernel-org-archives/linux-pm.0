From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 2/8] cpufreq: imx6q: Fix handling EPROBE_DEFER from
 regulator
Date: Thu, 23 Mar 2017 10:03:34 +0530
Message-ID: <20170323043334.GD12094@vireshk-i7>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <7f2618363d43b30db29f5f8ae822df413392f99d.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7f2618363d43b30db29f5f8ae822df413392f99d.1490199005.git.leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 22-03-17, 18:53, Leonard Crestez wrote:
> From: Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>
> 
> If there are any errors in getting the cpu0 regulators, the driver returns
> -ENOENT. In case the regulators are not yet available, the devm_regulator_get
> calls will return -EPROBE_DEFER, so that the driver can be probed later.
> If we return -ENOENT, the driver will fail its initialization and will
> not try to probe again (when the regulators become available).
> 
> Return the actual error received from regulator_get in probe. Print a
> differentiated message in case we need to probe the device later and
> in case we actually failed. Also add a message to inform when the
> driver has been successfully registered.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

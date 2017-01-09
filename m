From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 3/3] thermal: zx2967: add thermal driver for ZTE's
 zx2967 family
Date: Mon, 9 Jan 2017 16:42:56 +0800
Message-ID: <20170109084254.GL20956@dragon>
References: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
 <1483767488-19778-3-git-send-email-baoyou.xie@linaro.org>
 <843c634a-c624-e7db-99f6-8efdc19d7243@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <843c634a-c624-e7db-99f6-8efdc19d7243-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, wang.qiang01-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 09, 2017 at 11:00:38AM +0800, Jun Nie wrote:
> >+static int zx2967_thermal_resume(struct device *dev)
> >+{
> >+	struct platform_device *pdev = to_platform_device(dev);
> >+	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> >+	int error;
> >+
> >+	error = clk_prepare_enable(priv->clk_gate);
> >+	if (error)
> Use IS_ERR(ret) to check error.

No.  IS_ERR() checks on pointer, while clk_prepare_enable() returns
integer.

Shawn

> >+		return error;
> >+
> >+	error = clk_prepare_enable(priv->pclk);
> >+	if (error)
> Ditto.
> >+		return error;
> >+
> >+	dev_info(dev, "resumed\n");
> >+
> >+	return 0;
> >+}
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: cpuidle: Document the code
Date: Tue, 24 Mar 2015 19:04:05 +0000
Message-ID: <20150324190405.GC27311@red-moon>
References: <20150323225828.GC15435@e102568-lin.cambridge.arm.com>
 <1427190842-30675-1-git-send-email-daniel.lezcano@linaro.org>
 <1427190842-30675-2-git-send-email-daniel.lezcano@linaro.org>
 <20150324185144.GB27311@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150324185144.GB27311@red-moon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 24, 2015 at 06:51:44PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Mar 24, 2015 at 09:54:02AM +0000, Daniel Lezcano wrote:

[...]

> > +/*
> > + * arm_cpuidle_init() - Initialize cpuidle_ops for a specific cpu
> > + * @cpu: the cpu to be initialized
> > + *
> > + * Initialize the cpuidle ops with the device for the cpu and then call
> > + * the cpu's idle initialization callback. This may fail if the underlying HW
> > + * is not operational.
> > + *
> > + * Returns:
> > + *  0 on success,
> > + *  -ENODEV if it fails to find the cpu node in the device tree,
> > + *  -EOPNOTSUPP if it does not find a registered cpuidle_ops for this cpu,
> > + *  -ENOENT if it fails to find a enabled-method property,
> 
> Ultra-nit: "an enabled-method"

Bah, I cannot see the wood for the trees anymore. "an enable-method".

Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

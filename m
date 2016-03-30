From: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/4] thermal: hisilicon: enable power allocator for
 Hi6220
Date: Wed, 30 Mar 2016 10:53:53 +0800
Message-ID: <20160330025353.GA28401@leoy-linaro>
References: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
 <20160329154548.GE1855@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160329154548.GE1855-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 29, 2016 at 08:45:59AM -0700, Eduardo Valentin wrote:
> On Tue, Mar 29, 2016 at 07:27:11PM +0800, Leo Yan wrote:
> > Hi6220 has octa-core so it has quite high power consumption when run
> > benchmark and introduces high temperature for SoC. So need enable
> > thermal governor to control temperature and also cannot hurt much for
> > performance after impose cooling operations on CPU.
> > 
> > This patch series is to enable power allocator for Hi6220. Patch 1 is to
> > change "hysteresis" as optional property for trip points, so when enable
> > power allocator governor we can ignore this property.
> > 
> > During profiling also found two issues for thermal sensor's driver. The
> > power allocator just uses only one sensor, so patch 2 is to fix sensor
> > driver to let it can initialize driver successfully with only enabling
> > one sensor; patch 3 is to dismiss warning of IRQ imbalance enabling.
> > 
> > After profiling on Hikey, the power model has been simplized with only
> > dynamic coefficient, and now it's convienence to pass it from CPU node.
> > So patch 4 and 5 bind sensor and pass power model parameters.
> > 
> > This patch series have been tested on 96boards Hikey.
> 
> Applied patches 1 and 2 in my fixes branch. Patches 3 and 4 need to go
> via the hisi platform tree. You may add my
> 
> Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> on patches 3 and 4 if you want.

Thanks, Eduardo.

Hi Wei,

Could you help pick up patches 3/4 for enabling thermal in dts?

Thanks,
Leo Yan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

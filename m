From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v1 09/16] rtc: mediatek: convert to use device managed
 functions
Date: Tue, 27 Mar 2018 17:07:51 +0200
Message-ID: <20180327150751.GC22441@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
 <fbfb1852838820c198d55bc74940a74f1d0b53ed.1521794177.git.sean.wang@mediatek.com>
 <20180323105017.GI3417@piout.net>
 <1522037265.18424.14.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1522037265.18424.14.camel@mtkswgap22>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 26/03/2018 at 12:07:45 +0800, Sean Wang wrote:
> > > -	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> > > -					   &mtk_rtc_ops, THIS_MODULE);
> > > +	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, "mt6397-rtc",
> > > +						&mtk_rtc_ops, THIS_MODULE);
> > 
> > You should probably switch to devm_rtc_allocate_device() and
> > rtc_register_device instead of devm_rtc_device_register.
> > 
> 
> Just would like to know something details
> 
> It seems you just encourage me to switch into the new registration
> method and currently devm_rtc_device_register I used for the driver
> shouldn't cause any harm. right?
> 

It will work but it will have to be converted to rtc_register_device
later anyway.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

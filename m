From: Liberman Igal <Igal.Liberman-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC PATCH 8/8] powerpc/fsl: Use new clockgen binding
Date: Thu, 30 Jul 2015 15:32:32 +0000
Message-ID: <DM2PR03MB50986F3471DF3DD74494002E68B0@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
 <1434682158-7243-9-git-send-email-scottwood@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434682158-7243-9-git-send-email-scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Yuantian Tang <Yuantian.Tang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Madalin-Cristian Bucur <madalin.bucur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


Regards,
Igal Liberman.

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, June 19, 2015 5:49 AM
> To: Mike Turquette; Tang Yuantian-B29983
> Cc: Rafael J. Wysocki; Liberman Igal-B31950; Bucur Madalin-Cristian-B32716;
> linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-B07421
> Subject: [RFC PATCH 8/8] powerpc/fsl: Use new clockgen binding
> 
> The driver retains compatibility with old device trees, but we don't want the
> old nodes lying around to be copied, or used as a reference (some of the
> mux options are incorrect), or even just being clutter.
> 
> We will also need the #clock-cells in the clockgen node in order to add fman
> nodes.
> 
> Signed-off-by: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---

Tested on: several e500mc, e5500 and e6500 platforms.

Tested-by: Igal Liberman <Igal.Liberman-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

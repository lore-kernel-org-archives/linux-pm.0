From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 0/8] power: add power sequence library
Date: Wed, 28 Sep 2016 07:53:42 +0800
Message-ID: <20160927235342.GA6165@b29397-desktop>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
 <57EB0109.4070000@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57EB0109.4070000-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Maciej S. Szmigiero" <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, dwmw3-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 28, 2016 at 01:30:17AM +0200, Maciej S. Szmigiero wrote:
> On 20.09.2016 05:36, Peter Chen wrote:
> > Hi all,
> > 
> > This is a follow-up for my last power sequence framework patch set [1].
> > According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
> > power sequence instances will be added at postcore_initcall, the match
> > criteria is compatible string first, if the compatible string is not
> > matched between dts and library, it will try to use generic power sequence.
> > 	 
> > The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > if only one power sequence instance is needed, for more power sequences
> > are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).
> > 
> > In future, if there are special power sequence requirements, the special
> > power sequence library can be created.
> > 
> > This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> > two hot-plug devices to simulate this use case, the related binding
> > change is updated at patch [1/6], The udoo board changes were tested
> > using my last power sequence patch set.[3]
> > 
> > Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> > need to power on itself before it can be found by ULPI bus.
> > 
> > [1] http://www.spinics.net/lists/linux-usb/msg142755.html
> > [2] http://www.spinics.net/lists/linux-usb/msg143106.html
> > [3] http://www.spinics.net/lists/linux-usb/msg142815.html
> 
> Just tested this patch set on UDOO board again to make sure that it still
> works after all changes done since it was last tested there and can confirm
> that it does work correctly.
> 

Thanks, Maciej.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

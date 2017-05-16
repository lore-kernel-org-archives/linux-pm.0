From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v13 00/12] power: add power sequence library
Date: Tue, 16 May 2017 19:28:55 +0200
Message-ID: <20170516172855.hzshlqjvqe2oqb6e@kozik-lap>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
 <f34acc40-41e2-a7ea-a2aa-6cf604086182@ti.com>
 <20170215013808.GB6579@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170215013808.GB6579@b29397-desktop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, p.zabel
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 15, 2017 at 09:38:09AM +0800, Peter Chen wrote:
> On Tue, Feb 14, 2017 at 12:21:48PM +0200, Roger Quadros wrote:
> > Peter,
> > 
> > On 11/02/17 03:27, Peter Chen wrote:
> > > Hi all,
> > > 
> > > This is a follow-up for my last power sequence framework patch set [1].
> > > According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
> > > power sequence instances will be added at postcore_initcall, the match
> > > criteria is compatible string first, if the compatible string is not
> > > matched between dts and library, it will try to use generic power sequence.
> > > 	 
> > > The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > > if only one power sequence instance is needed, for more power sequences
> > > are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).
> > > 
> > > In future, if there are special power sequence requirements, the special
> > > power sequence library can be created.
> > > 
> > > This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> > > two hot-plug devices to simulate this use case, the related binding
> > > change is updated at patch [1/6], The udoo board changes were tested
> > > using my last power sequence patch set.[3]
> > > 
> > > Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> > > need to power on itself before it can be found by ULPI bus.
> > 
> > Can patches 3-7 can be sent independently of the power related patches?
> > 
> 
> Yes, I had planned to submit patches 3-7 for v4.11-rc1 today first, but it
> seems you still have comments for patch 6, let's wait a conclusion first.

Hi Peter and others,

What is the status of this patchset? I looked recently and it seemd
not-merged. Are there any issues not dealt with?

Just to reminder, this patchset solves not only Peter's problem but few others
as well, e.g. Odroid U3 USB hub/lan power sequence.

Best regards,
Krzysztof

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

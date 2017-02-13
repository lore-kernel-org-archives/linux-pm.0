From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v13 00/12] power: add power sequence library
Date: Mon, 13 Feb 2017 13:22:23 +0100
Message-ID: <16530165.MCAOCP1KgW@aspire.rjw.lan>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486776443-2280-1-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org, jun.li-3arQi8VN3Tc@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Saturday, February 11, 2017 09:27:11 AM Peter Chen wrote:
> Hi all,
> 
> This is a follow-up for my last power sequence framework patch set [1].
> According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
> power sequence instances will be added at postcore_initcall, the match
> criteria is compatible string first, if the compatible string is not
> matched between dts and library, it will try to use generic power sequence.
> 	 
> The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence instance is needed, for more power sequences
> are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).
> 
> In future, if there are special power sequence requirements, the special
> power sequence library can be created.
> 
> This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> two hot-plug devices to simulate this use case, the related binding
> change is updated at patch [1/6], The udoo board changes were tested
> using my last power sequence patch set.[3]
> 
> Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> need to power on itself before it can be found by ULPI bus.
> 
> Changes for v13:
> - Add more design descriptions at design doc and fix one build error
>   introduced by v12 wrongly [Patch 2/12]
> - Add the last three dts patches which were forgotten at last series
> - Move the comment for usb_create_shared_hcd to correct place [Patch 3/12]
> - Add sysdev for shared hcd too for xhci-plat.c [Patch 6/12]
> 
> Rafael, if the first two power sequence patches are ok for you, would you consider
> accept these first, the other USB patches can go through USB tree at v4.12-rc1?

OK, I'll look at the [1-2/12] in the first place, but please give me some time
and stop sending new versions of the whole patchset continuously for the time
being.

Also I'm not going to take anything from this series without the Greg's consent,
just to be clear.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

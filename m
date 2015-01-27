From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] Fix reboot issue on Odroid boards with eMMC card
Date: Tue, 27 Jan 2015 14:29:08 +0100
Message-ID: <54C792A4.3040302@samsung.com>
References: <1422346289-9348-1-git-send-email-m.szyprowski@samsung.com>
 <1422348967.10070.26.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1422348967.10070.26.camel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tobias Jakobi <Liquid.Acid-hi6Y0CQ0nG0@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On 2015-01-27 09:56, Sjoerd Simons wrote:
> On Tue, 2015-01-27 at 09:11 +0100, Marek Szyprowski wrote:
>> This patchset fixes reboot hang issue on Hardkernel's Odroid boards with
>> eMMC card. Those boards are designed in such a way, that the eMMC nreset
>> signal is routed to SoC GPIO line instead of the board reset logic. To
>> properly restard system, one need to set this line to zero before
>> performing reboot.
>>
>> The initial patches consisted of a complete reset/power off driver, but
>> after further analysis, it turned out that only eMMC nreset line control
>> logic is specific for those boards. Everything else can be done by
>> generic Exynos code, so the code has been moved to Exynos DW MMC driver.
> This seems a general board design quirk, rather then an exynos specific
> one. Potentially better to have this in the mmc core so it can be
> re-used by non-exynos boards?
>
> A very quick peek at the schematic for the hardkernel C1 (amlogic
> based), shows that for that board the eMMC reset line is hooked up to an
> SoC gpio line as well. (Although ofcourse, it may not need to be reset
> before a warm restart depending on what the amlogic rom code does).
>
>
> Random side-note, at least the samsung peach chromebooks are also hooked
> up this way. But don't run into this issue as they load their initial
> stages from flash rather then the eMMC.

Okay, I will try to move all the code to mmc core. I've also noticed that
sdhci-pci driver already implements hw_reset feature with gpio line, 
although
I cannot find any user of it (I cannot find any platform data provider for
sdhci-pci driver).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

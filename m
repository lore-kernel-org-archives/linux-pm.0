From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
Date: Tue, 24 Mar 2015 07:45:39 +0100
Message-ID: <55110813.7010708@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com> <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com> <20150323060706.GB4946@pengutronix.de> <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de> <20150323183740.GI14954@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150323183740.GI14954-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Mark,

Am 23.03.2015 um 19:37 schrieb Mark Brown:
> On Mon, Mar 23, 2015 at 06:54:34PM +0100, Stefan Wahren wrote:
>>> Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> hat am 23. M=E4rz 2015 um 07:=
07
>>> It is very unusual to describe the regulators of a device on a regi=
ster
>>> level like this and to iomemap each register individually. I think =
you
>>> should drop the registers here and put this knowledge into the driv=
er
>>> like (nearly?) all others do.
>> do mean dropping the base address of the regulator, too?
>> How would you implement it (bare register address or regmap or sysco=
n), since
>> there
>> are overlapping register regions for different driver?
>> @Mark: What's your opinion?
> This might be the sort of thing normally handled by a system controll=
er,
> I have to say I had assumed this had all been discussed in the previo=
us
> iterations of this seriee.

sorry, but i missed this important fact.

If you speak of system controller, do you mean the usage of
drivers/mfd/syscon.c ?

Stefan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

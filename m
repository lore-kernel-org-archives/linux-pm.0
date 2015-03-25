From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 7/7] ARM: dts: add OPPs for i.MX23/i.MX28
Date: Wed, 25 Mar 2015 21:20:00 +0100 (CET)
Message-ID: <295486259.670501.1427314800804.JavaMail.open-xchange@oxbaltgw09.schlund.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com> <1426984203-9133-8-git-send-email-stefan.wahren@i2se.com> <201503242145.26370.juergen@kreuzholzen.de>
Reply-To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201503242145.26370.juergen-vozXLyro3r7AVMDmWPUVSw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Juergen Borleis <juergen-vozXLyro3r7AVMDmWPUVSw@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Juergen,

> Juergen Borleis <juergen-vozXLyro3r7AVMDmWPUVSw@public.gmane.org> hat am 24. M=C3=A4rz 2015 um=
 21:45
> geschrieben:
>
>
> Stefan Wahren wrote:
> > [...]
>=20
> Maybe you should take into account not to reduce VDD below 1.55 V if =
the SDRAM
> controller runs above 196 MHz. The i.MX28 datasheet[1] lists these
> restrictions. VDD powers the SDRAM controller as well. From the datas=
heet the
> table "Frequency versus Voltage for EMICLK" shows:
>
> EMICLK Fmax (MHz)
> VDDD (V) DDR2 mDDR
> --------------------------------
> 1.550 205.71 205.71
> 1.450 196.36 196.36
> 1.350 196.36 196.36
>
> jbe
>
> [1]
> i.MX28 Applications
> Processors for Consumer
> Products
> Silicon Version 1.2
>
> Document Number: IMX28CEC
> Rev. 3, 07/2012

thanks for pointing out. I will take care of it.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

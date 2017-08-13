From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/4] thermal: add brcmstb AVS TMON driver
Date: Sat, 12 Aug 2017 21:57:44 -0700
Message-ID: <F4FCB786-8A5F-49DA-B101-9493EC6D4C4C@gmail.com>
References: <20170809220257.4234-1-code@mmayer.net> <1502429756.2470.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502429756.2470.9.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Doug Berger <opendmb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On August 10, 2017 10:35:56 PM PDT, Zhang Rui <rui=2Ezhang@intel=2Ecom> wro=
te:
>On Wed, 2017-08-09 at 15:02 -0700, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom=2Ecom>
>>=20
>> This series adds the brcmstb AVS TMON driver=2E
>>=20
>> The driver was originally written by Brian Norris=2E
>>=20
>> This series is also available at
>> https://github=2Ecom/mmayer/linux/tree/brcmstb-thermal-4=2E13-v4=2E
>>=20
>> v1 of this series can be found at https://lkml=2Eorg/lkml/2017/6/5/921
>> v2 of this series can be found at https://lkml=2Eorg/lkml/2017/7/21/585
>> v3 of this series can be found at https://lkml=2Eorg/lkml/2017/7/31/710
>>=20
>> Changes since v3:
>> - Rebased on v4=2E13-rc3 to resolve conflicts in the MAINTAINERS file
>>=20
>thanks, will apply this if we have ACK for patch 3 and 4=2E

You can take patches 1-2 through your tree and I can take patches 3-4 thou=
ght the Broadcom ARM/ARM64 pull requests if that works for you, or FWIW:

Acked-by: Florian Fainelli <f=2Efainelli@gmail=2Ecom>

Thanks!

--=20
Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

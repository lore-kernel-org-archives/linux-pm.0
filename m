From: Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v4 2/4] thermal: add brcmstb AVS TMON driver
Date: Tue, 26 Sep 2017 14:36:58 -0700
Message-ID: <CANEuBv6jxe1kn2ttNAVWhqszw_qi+0bEe+GA4AwaBi2dOukPOw@mail.gmail.com>
References: <20170809220257.4234-1-code@mmayer.net> <20170809220257.4234-3-code@mmayer.net>
 <1502777298.2591.1.camel@intel.com> <95da51df3cadbb05f721f2e5b8d59f8d@milecki.pl>
 <1502779721.2591.4.camel@intel.com> <4ec0715e-fcd7-3aec-3589-96426575c373@gmail.com>
 <744357E9AAD1214791ACBA4B0B9092636BE1FB55@SHSMSX101.ccr.corp.intel.com>
 <1e23383c-7c63-04fc-0f07-21b0e418e3de@gmail.com> <744357E9AAD1214791ACBA4B0B9092636BE1FEEB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092636BE1FEEB-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafal Milecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>, Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Doug Berger <opendmb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>Linux Kernel Mailing List <linu>
List-Id: linux-pm@vger.kernel.org

On 25 September 2017 at 23:17, Zhang, Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Hi, Florian,
>
>> -----Original Message-----
>> From: Florian Fainelli [mailto:f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>> Sent: Tuesday, September 26, 2017 12:14 PM
>> To: Zhang, Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Rafal Milecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
>> Cc: Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>; Eduardo Valentin
>> <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Mark Rutland
>> <mark.rutland-5wv7dgnIgG8@public.gmane.org>; Doug Berger <opendmb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Brian
>> Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Gregory Fong
>> <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>; Catalin
>> Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>; Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>;
>> Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>; Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>;
>> Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>; Power
>> Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Device Tree List
>> <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; ARM Kernel List <linux-arm-
>> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>; Linux Kernel Mailing List <linux-
>> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Subject: Re: [PATCH v4 2/4] thermal: add brcmstb AVS TMON driver
>> Importance: High
>>
>> On 09/25/2017 08:02 PM, Zhang, Rui wrote:
>> > Hi, Florian,
>> >
>> > This patch set was dropped in the last minute because of this
>> > discussion https://patchwork.kernel.org/patch/9936325/
>> > as I don=E2=80=99t want to rebase the patch before sending the pull re=
quest.
>>
>> Ah, you wanted to squash that patch into the initial submission?
>>
>> >
>> > I don=E2=80=99t think we can make it for 4.14.
>> > Eduardo will be back and pick the soc patches for 4.15.
>>
>> I assume you would want to get that particular patch squashed into a cle=
an
>> submission targeting 4.15 now, right?
>>
> Yes. As the patch in this thread has not been in upstream yet, I'd prefer=
 the
> fix/cleanup meld into the original patch before sending upstream.

I sent out v5 a few minutes ago. See https://lkml.org/lkml/2017/9/26/746.

Regards,
-Markus

> Thanks,
> Rui
>
>> Thanks
>>
>> >
>> > Thanks,
>> > rui
>> >
>> >
>> >
>> > -----Original Message-----
>> > From: Florian Fainelli [mailto:f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>> > Sent: Monday, September 25, 2017 5:11 AM
>> > To: Zhang, Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Rafa=C5=82 Mi=C5=82ecki <rafal@m=
ilecki.pl>
>> > Cc: Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>; Eduardo Valentin
>> > <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Mark
>> Rutland
>> > <mark.rutland-5wv7dgnIgG8@public.gmane.org>; Doug Berger <opendmb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Brian
>> Norris
>> > <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Gregory Fong
>> <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>;
>> > Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>; Catalin Marinas
>> > <catalin.marinas-5wv7dgnIgG8@public.gmane.org>; Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>; Arnd
>> > Bergmann <arnd-r2nGTMty4D4@public.gmane.org>; Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>;
>> Broadcom
>> > Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>; Power
>> Management
>> > List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Device Tree List
>> > <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; ARM Kernel List
>> > <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>; Linux Kernel Mailing List
>> > <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> > Subject: Re: [PATCH v4 2/4] thermal: add brcmstb AVS TMON driver
>> > Importance: High
>> >
>> > Le 08/14/17 =C3=A0 23:48, Zhang Rui a =C3=A9crit :
>> >> On Tue, 2017-08-15 at 08:42 +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
>> >>> On 2017-08-15 08:08, Zhang Rui wrote:
>> >>>>
>> >>>>>
>> >>>>> diff --git a/drivers/thermal/broadcom/Kconfig
>> >>>>> b/drivers/thermal/broadcom/Kconfig
>> >>>>> index 42c098e..c106a15 100644
>> >>>>> --- a/drivers/thermal/broadcom/Kconfig
>> >>>>> +++ b/drivers/thermal/broadcom/Kconfig
>> >>>>> @@ -6,6 +6,13 @@ config BCM2835_THERMAL
>> >>>>>         help
>> >>>>>           Support for thermal sensors on Broadcom bcm2835 SoCs.
>> >>>>>
>> >>>>> +config BRCMSTB_THERMAL
>> >>>>> +       tristate "Broadcom STB AVS TMON thermal driver"
>> >>>>> +       depends on ARCH_BRCMSTB || COMPILE_TEST
>> >>>>> +       help
>> >>>>> +         Enable this driver if you have a Broadcom STB SoC and
>> >>>>> would like
>> >>>>> +         thermal framework support.
>> >>>>> +
>> >>>> I don't understand why I got the following checkpatch warning
>> >>>>
>> >>>> WARNING: please write a paragraph that describes the config symbol
>> >>>> fully
>> >>>> #73: FILE: drivers/thermal/broadcom/Kconfig:9:
>> >>>> +config BRCMSTB_THERMAL
>> >>>>
>> >>>> I didn't see this for other Kconfig changes.
>> >>> It's because your help message is only 2 lines long (instead of 3).
>> >>>
>> >>> Some (many?) maintainers aren't pedantic about that, a common sense
>> >>> should be applied ;)
>> >>
>> >> thanks for explaining.
>> >> Patch 1 and 2 queued for next merge window.
>> >
>> > Humm, I don't see this driver in your latest 4.14 pull request to Linu=
s, so
>> what happened here exactly? Can we expect this driver to be submitted fo=
r
>> 4.14 or we just happened to have missed this window now?
>> > --
>> > Florian
>> >
>>
>> --
>> Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

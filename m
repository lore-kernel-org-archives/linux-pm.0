From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Fri, 18 Dec 2015 09:43:34 +0900
Message-ID: <567356B6.5030403@samsung.com>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
 <1450075104-13705-2-git-send-email-cw00.choi@samsung.com>
 <566F8BF2.20606@samsung.com> <56735486.8020609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <56735486.8020609-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 18=EC=9D=BC 09:34, Chanwoo Choi wrote:
> Hi,
>=20
> On 2015=EB=85=84 12=EC=9B=94 15=EC=9D=BC 12:41, Krzysztof Kozlowski w=
rote:
>> On 14.12.2015 15:38, Chanwoo Choi wrote:
>>> This patch adds the generic exynos bus frequency driver for AMBA AX=
I bus
>>> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Exy=
nos SoC
>>> have the common architecture for bus between DRAM and sub-blocks in=
 SoC.
>>> This driver can support the generic bus frequency driver for Exynos=
 SoCs.
>>>
>>> In devicetree, Each bus block has a bus clock, regulator, operation=
-point
>>> and devfreq-event devices which measure the utilization of each bus=
 block.
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>> [linux.amoon: Tested on Odroid U3]
>>> Tested-by: Anand Moon <linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/devfreq/Kconfig             |  15 ++
>>>  drivers/devfreq/Makefile            |   1 +
>>>  drivers/devfreq/exynos/Makefile     |   1 +
>>>  drivers/devfreq/exynos/exynos-bus.c | 449 ++++++++++++++++++++++++=
++++++++++++
>>>  4 files changed, 466 insertions(+)
>>>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index 64281bb2f650..55ec774f794c 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -66,6 +66,21 @@ config DEVFREQ_GOV_USERSPACE
>>> =20
>>>  comment "DEVFREQ Drivers"
>>> =20
>>> +config ARM_EXYNOS_BUS_DEVFREQ
>>> +	bool "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
>>> +	depends on ARCH_EXYNOS
>>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>>> +	select DEVFREQ_EVENT_EXYNOS_PPMU
>>> +	select PM_DEVFREQ_EVENT
>>> +	select PM_OPP
>>> +	help
>>> +	  This adds the common DEVFREQ driver for Exynos Memory bus. Exyn=
os
>>> +	  Memory bus has one more group of memory bus (e.g, MIF and INT b=
lock).
>>> +	  Each memory bus group could contain many memoby bus block. It r=
eads
>>> +	  PPMU counters of memory controllers by using DEVFREQ-event devi=
ce
>>> +	  and adjusts the operating frequencies and voltages with OPP sup=
port.
>>> +	  This does not yet operate with optimal voltages.
>>> +
>>>  config ARM_EXYNOS4_BUS_DEVFREQ
>>>  	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
>>>  	depends on (CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412) &=
& !ARCH_MULTIPLATFORM
>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>>> index 5134f9ee983d..375ebbb4fcfb 100644
>>> --- a/drivers/devfreq/Makefile
>>> +++ b/drivers/devfreq/Makefile
>>> @@ -6,6 +6,7 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+=3D governor_p=
owersave.o
>>>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor_userspace.o
>>> =20
>>>  # DEVFREQ Drivers
>>> +obj-$(CONFIG_ARCH_EXYNOS)		+=3D exynos/
>>
>> Why limiting it to ARCH_EXYNOS? Are there real dependencies on exyno=
s
>> mach code? Or on ARM code?
>=20
> There is no dependency.
>=20
>>
>> If not, then this probably should be obj-y to allow compile testing.
>> Particular objects would be selected by ARM_EXYNOS_BUS_DEVFREQ.
>=20
> OK. I'll alter it as obj-y.

As you commented, CONFIG_ARM_EXYNOS_BUS_DEVFREQ is more appropriate
without exynos/ directory as following:

+obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)   +=3D exynos-bus.o

Best Regards,
Chanwoo Choi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v4 0/22] On-demand device probing
Date: Wed, 9 Sep 2015 11:40:17 +0200
Message-ID: <CAAObsKBu+Y5ad1ghCAdZ3GHbCtw14bLLHhUK37rk18SNtc2k4g@mail.gmail.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+E31JaPcp5ELS_ztSqgSrK7U4OzB9xNcNz01Ayrrm+Yg@mail.gmail.com>
 <CAAObsKDUzk-9H2_VrVmbc=ZeRaknGcjTMY3Mauh3JVZxLz4CiA@mail.gmail.com> <55EF8C65.4030706@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55EF8C65.4030706-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jingo
List-Id: linux-pm@vger.kernel.org

On 9 September 2015 at 03:33, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On 09/08/2015 02:30 AM, Tomeu Vizoso wrote:
>> On 7 September 2015 at 22:50, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
>>> On Mon, Sep 7, 2015 at 7:23 AM, Tomeu Vizoso <tomeu.vizoso@collabor=
a.com> wrote:
>>>> Hello,
>>>>
>>>> I have a problem with the panel on my Tegra Chromebook taking long=
er
>>>> than expected to be ready during boot (St=C3=A9phane Marchesin rep=
orted what
>>>> is basically the same issue in [0]), and have looked into ordered
>>>> probing as a better way of solving this than moving nodes around i=
n the
>>>> DT or playing with initcall levels and linking order.
>>>>
>>>> While reading the thread [1] that Alexander Holler started with hi=
s
>>>> series to make probing order deterministic, it occurred to me that=
 it
>>>> should be possible to achieve the same by probing devices as they =
are
>>>> referenced by other devices.
>>>>
>>>> This basically reuses the information that is already implicit in =
the
>>>> probe() implementations, saving us from refactoring existing drive=
rs or
>>>> adding information to DTBs.
>>>>
>>>> During review of v1 of this series Linus Walleij suggested that it
>>>> should be the device driver core to make sure that dependencies ar=
e
>>>> ready before probing a device. I gave this idea a try [2] but Mark=
 Brown
>>>> pointed out to the logic duplication between the resource acquisit=
ion
>>>> and dependency discovery code paths (though I think it's fairly mi=
nor).
>>>>
>>>> To address that code duplication I experimented with Arnd's devm_p=
robe
>>>> [3] concept of having drivers declare their dependencies instead o=
f
>>>> acquiring them during probe, and while it worked [4], I don't thin=
k we
>>>> end up winning anything when compared to just probing devices on-d=
emand
>>>> from resource getters.
>>>>
>>>> One remaining objection is to the "sprinkling" of calls to
>>>> of_device_probe() in the resource getters of each subsystem, but I=
 think
>>>> it's the right thing to do given that the storage of resources is
>>>> currently subsystem-specific.
>>>>
>>>> We could avoid the above by moving resource storage into the core,=
 but I
>>>> don't think there's a compelling case for that.
>>>>
>>>> I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip a=
nd
>>>> OMAP SoCs, and these patches were enough to eliminate all the defe=
rred
>>>> probes (except one in PandaBoard because omap_dma_system doesn't h=
ave a
>>>> firmware node as of yet).
>>>>
>>>> Have submitted a branch [5] with only these patches on top of thur=
sday's
>>>> linux-next to kernelci.org and I don't see any issues that could b=
e
>>>> caused by them. For some reason it currently has more passes than =
the
>>>> version of -next it's based on!
>>>>
>>>> With this series I get the kernel to output to the panel in 0.5s,
>>>> instead of 2.8s.
>>>>
>>>> Regards,
>>>>
>>>> Tomeu
>>>>
>>>> [0] http://lists.freedesktop.org/archives/dri-devel/2014-August/06=
6527.html
>>>>
>>>> [1] https://lkml.org/lkml/2014/5/12/452
>>>>
>>>> [2] https://lkml.org/lkml/2015/6/17/305
>>>>
>>>> [3] http://article.gmane.org/gmane.linux.ports.arm.kernel/277689
>>>>
>>>> [4] https://lkml.org/lkml/2015/7/21/441a
>>>>
>>>> [5] https://git.collabora.com/cgit/user/tomeu/linux.git/log/?h=3Do=
n-demand-probes-v6
>>>>
>>>> [6] http://kernelci.org/boot/all/job/collabora/kernel/v4.2-11902-g=
25d80c927f8b/
>>>>
>>>> [7] http://kernelci.org/boot/all/job/next/kernel/next-20150903/
>>>>
>>>> Changes in v4:
>>>> - Added bus.pre_probe callback so the probes of Primecell devices =
can be
>>>>   deferred if their device IDs cannot be yet read because of the c=
lock
>>>>   driver not having probed when they are registered. Maybe this go=
es
>>>>   overboard and the matching information should be in the DT if th=
ere is
>>>>   one.
>>>
>>> Seems overboard to me or at least a separate problem.
>>
>> It's a separate problem but this was preventing the series from
>> working on a few boards.
>
> What is the failure? Not booting? Fixing not working would certainly =
not
> be overboard.

On the device I was testing on (qemu's vexpress-a15 machine) the
machine booted and I was able to open a ssh session, but serial was
broken among other AMBA devices:

/memory-controller@2b0a0000
/memory-controller@7ffd0000
/dma@7ffb0000
/smb/motherboard/iofpga@3,00000000/sysctl@020000
/smb/motherboard/iofpga@3,00000000/aaci@040000
/smb/motherboard/iofpga@3,00000000/mmci@050000
/smb/motherboard/iofpga@3,00000000/kmi@060000
/smb/motherboard/iofpga@3,00000000/kmi@070000
/smb/motherboard/iofpga@3,00000000/uart@090000
/smb/motherboard/iofpga@3,00000000/uart@0a0000
/smb/motherboard/iofpga@3,00000000/uart@0b0000
/smb/motherboard/iofpga@3,00000000/uart@0c0000
/smb/motherboard/iofpga@3,00000000/wdt@0f0000
/smb/motherboard/iofpga@3,00000000/timer@110000
/smb/motherboard/iofpga@3,00000000/timer@120000
/smb/motherboard/iofpga@3,00000000/rtc@170000
/smb/motherboard/iofpga@3,00000000/clcd@1f0000

Another way of avoiding this particular problem would be not delaying
the probe of devices in the configuration bus, by doing something like
this:

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-confi=
g.c
index 6575c0fe6a4e..eda293869cd3 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -181,7 +181,7 @@ static int vexpress_config_populate(struct
device_node *node)
        if (WARN_ON(!parent))
                return -ENODEV;

-       return of_platform_populate(node, NULL, NULL, parent);
+       return of_platform_populate_early(node, NULL, NULL, parent);
 }

 static int __init vexpress_config_init(void)

But I think this would be papering over the underlying issue and it
would be better to have proper explicit dependencies.

Regards,

Tomeu

>>> Most clocks have
>>> to be setup before the driver model simply because timers depend on
>>> clocks usually.
>>
>> Yes, but in this case the apb clocks for the primecell devices are
>> implemented in a normal platform driver (vexpress_osc_driver), inste=
ad
>> of using CLK_OF_DECLARE.
>
> Okay.
>
> Rob
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

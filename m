From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v4 0/22] On-demand device probing
Date: Tue, 8 Sep 2015 09:30:41 +0200
Message-ID: <CAAObsKDUzk-9H2_VrVmbc=ZeRaknGcjTMY3Mauh3JVZxLz4CiA@mail.gmail.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com> <CAL_Jsq+E31JaPcp5ELS_ztSqgSrK7U4OzB9xNcNz01Ayrrm+Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+E31JaPcp5ELS_ztSqgSrK7U4OzB9xNcNz01Ayrrm+Yg@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux PWM List <linux-pwm@vger.kernel.org>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 7 September 2015 at 22:50, Rob Herring <robherring2@gmail.com> wrote=
:
> On Mon, Sep 7, 2015 at 7:23 AM, Tomeu Vizoso <tomeu.vizoso@collabora.=
com> wrote:
>> Hello,
>>
>> I have a problem with the panel on my Tegra Chromebook taking longer
>> than expected to be ready during boot (St=C3=A9phane Marchesin repor=
ted what
>> is basically the same issue in [0]), and have looked into ordered
>> probing as a better way of solving this than moving nodes around in =
the
>> DT or playing with initcall levels and linking order.
>>
>> While reading the thread [1] that Alexander Holler started with his
>> series to make probing order deterministic, it occurred to me that i=
t
>> should be possible to achieve the same by probing devices as they ar=
e
>> referenced by other devices.
>>
>> This basically reuses the information that is already implicit in th=
e
>> probe() implementations, saving us from refactoring existing drivers=
 or
>> adding information to DTBs.
>>
>> During review of v1 of this series Linus Walleij suggested that it
>> should be the device driver core to make sure that dependencies are
>> ready before probing a device. I gave this idea a try [2] but Mark B=
rown
>> pointed out to the logic duplication between the resource acquisitio=
n
>> and dependency discovery code paths (though I think it's fairly mino=
r).
>>
>> To address that code duplication I experimented with Arnd's devm_pro=
be
>> [3] concept of having drivers declare their dependencies instead of
>> acquiring them during probe, and while it worked [4], I don't think =
we
>> end up winning anything when compared to just probing devices on-dem=
and
>> from resource getters.
>>
>> One remaining objection is to the "sprinkling" of calls to
>> of_device_probe() in the resource getters of each subsystem, but I t=
hink
>> it's the right thing to do given that the storage of resources is
>> currently subsystem-specific.
>>
>> We could avoid the above by moving resource storage into the core, b=
ut I
>> don't think there's a compelling case for that.
>>
>> I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip and
>> OMAP SoCs, and these patches were enough to eliminate all the deferr=
ed
>> probes (except one in PandaBoard because omap_dma_system doesn't hav=
e a
>> firmware node as of yet).
>>
>> Have submitted a branch [5] with only these patches on top of thursd=
ay's
>> linux-next to kernelci.org and I don't see any issues that could be
>> caused by them. For some reason it currently has more passes than th=
e
>> version of -next it's based on!
>>
>> With this series I get the kernel to output to the panel in 0.5s,
>> instead of 2.8s.
>>
>> Regards,
>>
>> Tomeu
>>
>> [0] http://lists.freedesktop.org/archives/dri-devel/2014-August/0665=
27.html
>>
>> [1] https://lkml.org/lkml/2014/5/12/452
>>
>> [2] https://lkml.org/lkml/2015/6/17/305
>>
>> [3] http://article.gmane.org/gmane.linux.ports.arm.kernel/277689
>>
>> [4] https://lkml.org/lkml/2015/7/21/441a
>>
>> [5] https://git.collabora.com/cgit/user/tomeu/linux.git/log/?h=3Don-=
demand-probes-v6
>>
>> [6] http://kernelci.org/boot/all/job/collabora/kernel/v4.2-11902-g25=
d80c927f8b/
>>
>> [7] http://kernelci.org/boot/all/job/next/kernel/next-20150903/
>>
>> Changes in v4:
>> - Added bus.pre_probe callback so the probes of Primecell devices ca=
n be
>>   deferred if their device IDs cannot be yet read because of the clo=
ck
>>   driver not having probed when they are registered. Maybe this goes
>>   overboard and the matching information should be in the DT if ther=
e is
>>   one.
>
> Seems overboard to me or at least a separate problem.

It's a separate problem but this was preventing the series from
working on a few boards.

> Most clocks have
> to be setup before the driver model simply because timers depend on
> clocks usually.

Yes, but in this case the apb clocks for the primecell devices are
implemented in a normal platform driver (vexpress_osc_driver), instead
of using CLK_OF_DECLARE.

Regards,

Tomeu

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

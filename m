From: Chander Kashyap <k.chander@samsung.com>
Subject: Re: [PATCH] arm64: dts: exynos7: add support for cpuidle core power down
Date: Wed, 5 Nov 2014 15:31:02 +0530
Message-ID: <CADWw7OiD8TdN75G0zecowAL9GniSU9hKLN0_H6UQL85LX1E9Xw@mail.gmail.com>
References: <1413354920-20165-1-git-send-email-k.chander@samsung.com>
	<20141015090047.GA26484@red-moon>
	<CADWw7Ojgttk3cjaac=GGL1D9pejCJw8sJB2JvPFWtyBh3JHYKA@mail.gmail.com>
	<20141021163341.GB17610@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141021163341.GB17610@e102568-lin.cambridge.arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Chander Kashyap <k.chander@samsung.com>, Mark Rutland <Mark.Rutland@arm.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Sorry for very late response. As i was on vacation so couldn=E2=80=99t =
reply.

On Tue, Oct 21, 2014 at 10:03 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Oct 17, 2014 at 10:43:59AM +0100, Chander Kashyap wrote:
>> Hi Lorenzo,
>>
>> On Wed, Oct 15, 2014 at 2:30 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > On Wed, Oct 15, 2014 at 07:35:20AM +0100, Chander Kashyap wrote:
>> >> Exynos7 has core power down state where cores can be powered off =
independently.
>> >> This patch adds support for this state.
>> >
>> > Please tell us more about the idle-state values you are adding, in=
 particular
>> > entry, exit latencies and min-residency values.
>>
>> Entry latency: This value is calculated as follows:
>>
>> On entry to arm64_enter_idle_state:
>> timestamp1 =3D ktimeget();
>>
>> after returning from cpu_suspend()
>>
>> timestamp2 =3D ktimeget();
>>
>> latency =3D timestamp2-timestamp1;
>>
>> Cpu is not allowed to enter core powerdown by skipping wfi instructi=
on at end.
> This may not be the worst case (because the worst case depends on the=
 state
> of the cache in the core unless the latency is power down command dom=
inated,
> so at the cost of being pedantic, please make sure that's what you ar=
e
> measuring and document it in the commit log).
>

If i understood correctly you are referring to cache flush time.
The measured entry latency time is averaged time for 100000
transactions with varying load.
I will document entry latency calculation in the commit message.

>> Hence calculated time contains entry time + failure exit time.
>>
>>
>> Regarding
>> exit-latency and target-residency time, got these values from HW tea=
m.
>>
>> I am using these as initial values and I will be working on optimizi=
ng
>> these values with further experiments.
>> If you could suggest any formal method of deriving these values, i c=
an
>> try those methods as well.
>
> Well, you have to set the core/cluster in worst case scenario and
> compute the break-even residency against wfi (since you have two
> states); it certainly has a dependency on PSCI implementation too amo=
ng
> other things.
>
> exit-latency should come from HW design even though there is a cache
> refill factor to be considered too and should be factored in.

Exit and target residency are provided by HW team.

I will post the V3 with changed commit message.
>
> Lorenzo
>
>>
>> >
>> >> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
>> >> ---
>> >> This patch has following dependencies:
>> >>       - [PATCH v5 0/8] arch: arm64: Enable support for Samsung Ex=
ynos7 SoC
>> >>               http://www.spinics.net/lists/linux-samsung-soc/msg3=
7047.html
>> >>       - [PATCH v9 0/8] ARM generic idle states
>> >>               http://permalink.gmane.org/gmane.linux.power-manage=
ment.general/49224
>> >
>> > Series above was merged, so dependency is stale.
>>
>> i will remove this
>>
>> >
>> >>  arch/arm64/boot/dts/exynos/exynos7.dtsi |   18 +++++++++++++++++=
+
>> >>  1 file changed, 18 insertions(+)dont
>> >>
>> >> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64=
/boot/dts/exynos/exynos7.dtsi
>> >> index ce221ac..8e0a034 100644
>> >> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
>> >> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>> >> @@ -36,6 +36,7 @@
>> >>                       device_type =3D "cpu";
>> >>                       compatible =3D "arm,cortex-a57", "arm,armv8=
";
>> >>                       enable-method =3D "psci";
>> >> +                     cpu-idle-states =3D <&CPU_SLEEP>;
>> >
>> > I would add cpu-idle-states phandle after the reg property, as def=
ined
>> > in the idle states bindings.
>>
>> i will move this after reg property.
>>
>> >
>> >>                       reg =3D <0x0>;
>> >>               };
>> >>
>> >> @@ -43,6 +44,7 @@
>> >>                       device_type =3D "cpu";
>> >>                       compatible =3D "arm,cortex-a57", "arm,armv8=
";
>> >>                       enable-method =3D "psci";
>> >> +                     cpu-idle-states =3D <&CPU_SLEEP>;
>> >>                       reg =3D <0x1>;
>> >>               };
>> >>
>> >> @@ -50,6 +52,7 @@
>> >>                       device_type =3D "cpu";
>> >>                       compatible =3D "arm,cortex-a57", "arm,armv8=
";
>> >>                       enable-method =3D "psci";
>> >> +                     cpu-idle-states =3D <&CPU_SLEEP>;
>> >>                       reg =3D <0x2>;
>> >>               };
>> >>
>> >> @@ -57,8 +60,23 @@
>> >>                       device_type =3D "cpu";
>> >>                       compatible =3D "arm,cortex-a57", "arm,armv8=
";
>> >>                       enable-method =3D "psci";
>> >> +                     cpu-idle-states =3D <&CPU_SLEEP>;
>> >>                       reg =3D <0x3>;
>> >>               };
>> >> +
>> >> +             idle-states {
>> >> +                     entry-method =3D "arm,psci";
>> >> +
>> >> +                     CPU_SLEEP: cpu-sleep {
>> >> +                             compatible =3D "arm,idle-state";
>> >> +                             local-timer-stop;
>> >> +                             arm,psci-suspend-param =3D <0x00100=
00>;
>> >> +                             entry-latency-us =3D <20>;
>> >> +                             exit-latency-us =3D <150>;
>> >> +                             min-residency-us =3D <2100>;
>> >> +                             status =3D "enabled";
>> >
>> > status ? This is not a documented property. If you need it please =
explain
>> > why, define its bindings and we can see how to accommodate it.
>>
>> I will add okay for status property. As per the bindings posted by y=
ou.
>>
>> regards,
>> >
>> > Thank you,
>> > Lorenzo
>> >
>> >> +                     };
>> >> +             };
>> >>       };
>> >>
>> >>       psci {
>> >> --
>> >> 1.7.9.5
>> >>
>> >>
>> >
>> >
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

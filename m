From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: RFC on cpufreq implementation
Date: Fri, 16 Jan 2015 12:43:15 +0100
Message-ID: <1421408595.7058.8.camel@AMDC1943>
References: <54B7F7CD.7030903@free.fr> <1421399293.11224.7.camel@AMDC1943>
 <54B8F19F.8060108@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <54B8F19F.8060108@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On pi=C4=85, 2015-01-16 at 12:10 +0100, Mason wrote:
> On 16/01/2015 10:08, Krzysztof Kozlowski wrote:
>=20
> > On 2015-01-15 at 18:24 +0100, Mason wrote:
> > =20
> >> This is a follow-up to my previous thread.
> >> "How many frequencies would cpufreq optimally like to manage?"
> >> http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669
> >>
> >> As I originally wrote, I'm running 3.14 on an ARM Cortex-A9
> >> based SoC (namely Tango4 from Sigma Designs). I'd like to get
> >> some feedback on the cpufreq driver I wrote for that platform.
> >>
> >> I decided to expose only a small subset of frequencies (namely
> >> {999,500,333,111} MHz) because, in my tests, the ondemand gov
> >> chose mostly min and max, and the intermediate frequencies not
> >> so much; so I figured "2 intermediate freqs" is good enough.
> >> (I'm ready to hear otherwise.)
>=20
> I'll take a closer look at other drivers, but I'd like to hear
> opinions on the subject.
>=20
> >> I tried to use as much generic framework as possible, but I've
> >> read about the clk framework, and it looks to be an even greater
> >> generalization. Are new platforms encouraged to use that, rather
> >> than provide a cpufreq driver? Does it work when voltage scaling
> >> comes in play? (This SoC doesn't have it, but the next will.)
> >
> > The clock framework generalizes clocks, not cpufreq. Ideally you sh=
ould
> > use clock framework in cpufreq driver. So instead manually setting
> > divider just do something like:
> >
> > ret =3D clk_set_rate(cpu_clk, freq_exact);
> > if (ret) {
> > 	dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> > 	return ret;
> > }
>=20
> I will give clk a closer look.
>=20
> > For voltage scaling you should use regulator framework.
>=20
> OK. I'm also interested in frequency-throttling when temperatures
> rise beyond specific thresholds. What subsystem ties sensors and
> cpufreq together?

I believe thermal.

>=20
> > Actually I think existing cpufreq-dt could serve your purpose. Why =
don't
> > you try it? Or look at it and use as an example.
>=20
> Will do. I've heard of device tree, but know nothing about it.

Indeed it is driver meant to be used with Device Tree but beside DT cod=
e
it nicely shows how to scale the frequency CPU. If you don't use DT the=
n
you can use only the set_target() as starting point.

On 3.14 the "cpufreq-dt" could be called "cpufreq-cpu0".

>=20
> >> I'm also wondering how cpufreq and cpuidle interact? Is one a
> >> subset of the other? Are they orthogonal?
> >
> > cpuidle and cpufreq are different subsystems. They don't interact, =
yet.
> > There are efforts to combine scheduler, cpufreq and cpuidle but thi=
s is
> > future. If your SoC has some deeper low power states than developin=
g
> > cpuidle driver makes sense. If not - WFI will be used.
>=20
> AFAIU, there are no deeper power states on the Cortex-A9.
>=20
> I didn't find where WFI is called :-(
>=20
> In kernel/cpu/idle.c (file seems to have been removed in 3.15)
> cpu_idle_loop() calls arch_cpu_idle()
> http://lxr.free-electrons.com/source/kernel/cpu/idle.c?v=3D3.14#L98
>=20
> In arch/kernel/process.c
> http://lxr.free-electrons.com/source/arch/arm/kernel/process.c?v=3D3.=
14#L173
> /*
>   * Called from the core idle loop.
>   */
> void arch_cpu_idle(void)
> {
> 	if (cpuidle_idle_call())
> 		default_idle();
> }
>=20
> default_idle calls cpu_do_idle (by default), a macro for cpu_v7_do_id=
le
> which executes dsb+wfi, BUT...
>=20
> ifndef CONFIG_CPU_IDLE then
> static inline int cpuidle_idle_call(void) { return -ENODEV; }
>=20
> Does that mean I MUST define CONFIG_CPU_IDLE if I want the idle
> loop to call wfi (to save power), even if I don't have a cpuidle
> driver?

On current kernels you don't have to. But on 3.14... seems yes.

Best regards,
Krzysztof
>=20
> Regards.


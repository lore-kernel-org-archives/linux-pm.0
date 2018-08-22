From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] dt-binding: arm/cpus.txt: fix dynamic-power-coefficient unit
Date: Wed, 22 Aug 2018 16:32:39 +0200
Message-ID: <CAKfTPtBGJf3tPgUXwVGbQBxgCwuW4TKhLtyeXYp5SZZxmyXEsg@mail.gmail.com>
References: <1534869685-22221-1-git-send-email-vincent.guittot@linaro.org> <87ftz6ww1h.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ftz6ww1h.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Amit,

On Wed, 22 Aug 2018 at 12:11, Punit Agrawal <punit.agrawal@arm.com> wrote:
>
> Hi Vincent,
>
> Thanks for the patch. One comment about the choice of units below.
>
> Vincent Guittot <vincent.guittot@linaro.org> writes:
>
> > The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
> > its usage in the code assumes that unit is mW/GHz/V^2
>
> Instead of choosing GHz as the base, I'd prefer to use uW/MHz/V^2. It'll
> avoid introducing fractional GHz value for frequency calculations.

I don't understand your concern about fractional Ghz value for
frequency calculation ?
I mean, why it's a problem for frequency with Ghz vs Mhz but not a
problem for voltage with V vs mV ?
Don't we have the same "problem" in both case ?

>
> > In drivers/thermal/cpu_cooling.c, the code is :
> >
> > power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> > do_div(power, 1000000000);
> >
> > which can be summarized as :
> > power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2
>
> Which would then translate to -
>
> power (mW) = power (uW) / 1000 = capacitance * freq_mhz * (voltage_mv/1000)^2

Not sure that the equation above is correct. If we consider uW/MHz/V^2
for the unit, the equation becomes :
power (mW) = power (uW) / 1000 = capacitance * freq_mhz *
(voltage_mv/1000)^2 / 1000
which can be rearranged as
power (mW) = power (uW) / 1000 = capacitance * freq_mhz/ 1000 *
(voltage_mv/1000)^2

TBH, I don't really mind between  mW/GHz/V^2 or uW/MHz/V^2 as they are
the same at the end
but I don't catch your reasoning

Regards,
Vincent

>
> Thanks,
> Punit
>
> >
> > Furthermore, if we test basic values like :
> > voltage_mv = 1000mV = 1V
> > freq_mhz = 1000Mhz = 1Ghz
> >
> > The minimum possible power, when dynamic-power-coefficient equals 1, will
> > be :
> > min power = 1 * 1000  * (1000000)^2 = 10^15 mW
> > which is not realistic
> >
> > With the unit used by the code, the min power is
> > min power =  1 * 1 * 1^2 = 1mW which is far more realistic
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> > index 29e1dc5..0148d7d 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -274,7 +274,7 @@ described below.
> >               Usage: optional
> >               Value type: <prop-encoded-array>
> >               Definition: A u32 value that represents the running time dynamic
> > -                         power coefficient in units of mW/MHz/uV^2. The
> > +                         power coefficient in units of mW/GHz/V^2. The
> >                           coefficient can either be calculated from power
> >                           measurements or derived by analysis.
> >
> > @@ -285,7 +285,7 @@ described below.
> >
> >                           Pdyn = dynamic-power-coefficient * V^2 * f
> >
> > -                         where voltage is in uV, frequency is in MHz.
> > +                         where voltage is in V, frequency is in GHz.
> >
> >  Example 1 (dual-cluster big.LITTLE system 32-bit):

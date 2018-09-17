From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: max8998: Add charger subnode binding
Date: Mon, 17 Sep 2018 13:49:39 +0200
Message-ID: <CAJKOXPeYt2EWcSpVbCZtoWA_bmF8egHW1EaUFe=YaboxLHbJvA@mail.gmail.com>
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531843509-3533-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <20180807175741.GA30886@rob-hp-laptop> <24790346.rcfynqLzho@acerlaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <24790346.rcfynqLzho@acerlaptop>
Sender: linux-kernel-owner@vger.kernel.org
To: pawel.mikolaj.chmiel@gmail.com
Cc: robh@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Sep 2018 at 16:56, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> On Tuesday, August 7, 2018 11:57:42 AM CEST Rob Herring wrote:
> > On Tue, Jul 17, 2018 at 06:05:09PM +0200, Pawe=C5=82 Chmiel wrote:
> > > This patch adds devicetree bindings documentation for
> > > battery charging controller as the subnode of MAX8998 PMIC.
> > >
> > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > ---
> > > Changes from v2:
> > >   - Make charge-restart-level-microvolt optional.
> > >   - Make charge-timeout-hours optional.
> > >
> > > Changes from v1:
> > >   - Removed unneeded Fixes tag
> > >   - Correct description of all charger values
> > >   - Added missing property unit
> > > ---
> > >  Documentation/devicetree/bindings/mfd/max8998.txt | 25 +++++++++++++=
++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Docu=
mentation/devicetree/bindings/mfd/max8998.txt
> > > index 23a3650ff2a2..264040f4ad15 100644
> > > --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> > > @@ -50,6 +50,24 @@ Additional properties required if max8998,pmic-buc=
k2-dvs-gpio is defined:
> > >  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in mi=
crovolts
> > >    for buck2 regulator that can be selected using dvs gpio.
> > >
> > > +Charger: Configuration for battery charging controller should be add=
ed
> > > +inside a child node named 'charger'.
> > > +  Required properties:
> > > +  - max8998,charge-eoc-percent: Setup End of Charge Level.
> >
> > This should have a vendor prefix and max8998 is not a vendor. Don't
> > continue that pattern even if we already have some properties like that=
.
> >
> > These seem like perhaps they should be common charger properties.
> Where i could find such properties (or any other driver which is using th=
ose as an example) ?
> Looking at few existing drivers, most of them have custom properties (tha=
t's why i've followed the same pattern for max8998).

The common properties are now here:
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bin=
dings/power/supply/battery.txt

The property "max8998,charge-eoc-percent" seems unusual - what does
"percent" mean in such case? Usually EOC should happen at 100% of
charge so what is the point to set it as 45%?

Have in mind that current driver is platform data only so you do not
have to maintain any backwards compatibility. If the driver now has
weird meaning of "eoc" in pdata, then you can change it. Also you do
not have to map the bindings one-to-one to existing platform data. If
needed you can translate them from something meaningful in DT to
values expected by driver.

Best regards,
Krzysztof

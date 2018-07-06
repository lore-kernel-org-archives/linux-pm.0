From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 18/23] dt-bindings: thermal: armada: add reference to
 new bindings
Date: Fri, 6 Jul 2018 11:56:12 -0600
Message-ID: <CAL_JsqLG6vDmyH3X7aHUUMRC+BN3orC5T8iHYUHHZVsQ6rM0Tg@mail.gmail.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-19-miquel.raynal@bootlin.com>
 <20180703213011.GA13190@rob-hp-laptop>
 <20180705120528.4b923e16@xps13>
 <CAL_JsqL9h4RExZtm5cER-5kNvMpDzH-4MwcmY7VOLXB9-uEYYA@mail.gmail.com>
 <20180706094904.22275b10@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180706094904.22275b10@xps13>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 6, 2018 at 1:49 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Rob,
>
> [...]
>
> > > > > for AP806 and CP110 compatibles. Add a reference to these files from the
> > > > > original documentation.
> > > > >
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > > index e0d013a2e66d..f3b441100890 100644
> > > > > --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > > +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > > @@ -10,6 +10,11 @@ Required properties:
> > > > >      * marvell,armada-ap806-thermal
> > > > >      * marvell,armada-cp110-thermal
> > > >
> > > > Really you should not be using the same compatible for both. Now you
> > > > have 2 drivers matching to same compatibles.
> > > >
> > > > Can't you make this a child of the syscon without breaking the binding?
> > >
> > > We are talking about only 1 driver here, so I'm not sure how I should
> > > understand your last sentence. Do you want me to add a second
> > > compatible (for the same piece of hardware) for thermal node declared
> > > as a child of the syscon?
> >
> > I don't know what I'm suggesting. Your changes look like they break
> > compatibility to me.
>
> There is code in the driver to handle the legacy non-syscon-ish thermal
> node ("armada_thermal_probe_legacy()"). An old DT with a new kernel
> would work fine.

Okay, that's good.

> > What happens if you use this new binding without any kernel change?
>
> I suppose you mean "during the merge window"? In this case the driver
> of the thermal IP will not probe (and spawn an error in the dmesg) with
> ap806/cp110 IPs. As the support is pretty new for them, this is maybe
> not a huge issue. Also, before the DT changes adding thermal zones,
> just retrieving the temperature might be pretty useless. However, it
> is always possible to merge the driver changes in 4.19 and the DT
> changes in 4.20.

Not the merge window, but distros (SUSE at least) want to be able to
boot with current DTs and their distro (old) kernel. Maybe for this
platform you don't care.

Rob

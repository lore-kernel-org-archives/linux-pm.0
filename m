From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 0/6] Add hw overheat IRQ support to Marvell thermal
 driver
Date: Sat, 15 Dec 2018 09:25:01 -0800
Message-ID: <20181215172501.GC10311@localhost.localdomain>
References: <20181212093645.14752-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181212093645.14752-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Marc Zyngier <marc.zyngier@arm.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 12, 2018 at 10:36:39AM +0100, Miquel Raynal wrote:
> Hello,
> =


I added the series in my -linus branch. You can also add my =


Acked-by: Eduardo Valentin <edubezval@gmail.com>

in your DTS patches (4 and 6).

> This is the last batch of patches about the thermal driver that was
> suspended, waiting for the ICU/SEI series to be merged. Now that
> everything is ready in mainline, let's add hardware overheat interrupt
> support to this driver.
> =

> Bindings and DT are updated accordingly. The interrupt will only be
> triggered if the platform goes above ~102=B0C (threshold set to 100=B0C,
> hysteresis to > 2=B0C). The interrupt property is of course not
> mandatory.
> =

> In the mean time, I add myself to the MAINTAINERS file to receive and
> review possible fixes/new features.
> =

> Thanks,
> Miqu=E8l
> =

> Changes since v3:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Added Rob's Reviewed-by on cp110 bindings.
> * Addressed Rob comment on ap806 bindings by removing the reference to
>   the interrupt parent.
> =

> Changes since v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Remove useless goto statement.
> * Move the hysteresis array out of the function using it and declare
>   the array statically instead that doing so on the stack.
> * Remove unnecessary cast.
> * On error, avoid returning a value not compatible with irqreturn_t in
>   the IRQ handler (and when doing so, re-enable interrupts
>   first). This is simply handled with a goto statement.
> * 0 is not a valid interrupt, take this into account during variables
>   validation.
> =

> Changes *not* addressed since v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> * Overheat interrupt configuration has certain limitations on which
>   Marc asked questions. I don't know if/what I need to change so
>   keeping it like this for this version.
> * Eduardo pointed that once a critical level has been reached, there
>   is no way back, the system will shutdown. I designed the handler to
>   recover from that and to enable the IRQ again if needed, but maybe
>   this is useless and should be removed. While waiting for his answer,
>   I am sending another version and will correct in a v4 if needed.
> =

> Changes since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Use a threaded IRQ handler to avoid a potential lock depency when
>   notifying the core of an overheat situation.
> =

> =

> Miquel Raynal (6):
>   thermal: armada: add overheat interrupt support
>   MAINTAINERS: thermal: add entry for Marvell MVEBU thermal driver
>   dt-bindings: ap806: document the thermal interrupt capabilities
>   dt-bindings: cp110: document the thermal interrupt capabilities
>   arm64: dts: marvell: add interrupt support to ap806 thermal node
>   arm64: dts: marvell: add interrupt support to cp110 thermal node
> =

>  .../arm/marvell/ap806-system-controller.txt   |   7 +
>  .../arm/marvell/cp110-system-controller.txt   |   9 +
>  MAINTAINERS                                   |   5 +
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi |  18 +-
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi |  15 +-
>  drivers/thermal/armada_thermal.c              | 270 +++++++++++++++++-
>  6 files changed, 317 insertions(+), 7 deletions(-)
> =

> -- =

> 2.19.1
> =

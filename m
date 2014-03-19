From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2 01/11] base: power: Add generic OF-based power domain
 look-up
Date: Wed, 19 Mar 2014 16:13:41 -0700
Message-ID: <7e54f23f-1e11-4e17-ad29-13b497d7055a@TX2EHSMHS041.ehs.local>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Len Brown <len.brown@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Pavel Machek <pavel@ucw.cz>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Kumar
List-Id: linux-pm@vger.kernel.org

On Mon, 2014-03-03 at 05:02PM +0100, Tomasz Figa wrote:
> This patch introduces generic code to perform power domain look-up us=
ing
> device tree and automatically bind devices to their power domains.
> Generic device tree binding is introduced to specify power domains of
> devices in their device tree nodes.
>=20
> Backwards compatibility with legacy Samsung-specific power domain
> bindings is provided, but for now the new code is not compiled when
> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. T=
his
> will change as soon as Exynos power domain code gets converted to use
> the generic framework in further patch.
>=20
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  .../devicetree/bindings/power/power_domain.txt     |  51 ++++
>  drivers/base/power/domain.c                        | 298 +++++++++++=
++++++++++
>  include/linux/pm_domain.h                          |  46 ++++
>  kernel/power/Kconfig                               |   4 +
>  4 files changed, 399 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/power_dom=
ain.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt=
 b/Documentation/devicetree/bindings/power/power_domain.txt
> new file mode 100644
> index 0000000..93be5d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -0,0 +1,51 @@
> +* Generic power domains
> +
> +System on chip designs are often divided into multiple power domains=
 that
> +can be used for power gating of selected IP blocks for power saving =
by
> +reduced leakage current.
> +
> +This device tree binding can be used to bind power domain consumer d=
evices
> +with their power domains provided by power domain providers. A power=
 domain
> +provider can be represented by any node in the device tree and can p=
rovide
> +one or more power domains. A consumer node can refer to the provider=
 by
> +a phandle and a set of phandle arguments (so called power domain spe=
cifier)
> +of length specified by #power-domain-cells property in the power dom=
ain
> +provider node.
> +
> +=3D=3DPower domain providers=3D=3D
> +
> +Required properties:
> + - #power-domain-cells : Number of cells in a power domain specifier=
;
> +   Typically 0 for nodes representing a single power domain and 1 fo=
r nodes
> +   providing multiple power domains (e.g. power controllers), but ca=
n be
> +   any value as specified by device tree binding documentation of pa=
rticular
> +   provider.
> +
> +Example:
> +
> +	power: power-controller@12340000 {
> +		compatible =3D "foo,power-controller";
> +		reg =3D <0x12340000 0x1000>;
> +		#power-domain-cells =3D <1>;
> +	};
> +
> +The node above defines a power controller that is a power domain pro=
vider
> +and expects one cell as its phandle argument.
> +
> +=3D=3DPower domain consumers=3D=3D
> +
> +Required properties:
> + - power-domain : A phandle and power domain specifier as defined by=
 bindings
> +                  of power controller specified by phandle.
> +
> +Example:
> +
> +	leaky-device@12350000 {
> +		compatible =3D "foo,i-leak-current";
> +		reg =3D <0x12350000 0x1000>;
> +		power-domain =3D <&power 0>;
> +	};
> +
> +The node above defines a typical power domain consumer device, which=
 is located
> +inside power domain with index 0 of power controller represented by =
node with
> +label "power".

Does this allow nesting of power domains? E.g. you have a PD which is
represented by some programmable power supply, and within this domain
smaller islands/domains that can be gated independently.

	Thanks,
	S=C3=B6ren

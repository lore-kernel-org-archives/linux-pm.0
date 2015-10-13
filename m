From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 4/6] power: da9150: Add DT bindings documentation for
 Fuel-Gauge
Date: Tue, 13 Oct 2015 10:26:31 +0100
Message-ID: <20151013092631.GV32409@x1>
References: <cover.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
 <fa8d93537bc2303ed4e93a4e850b9b40433dbac6.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa8d93537bc2303ed4e93a4e850b9b40433dbac6.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 07 Oct 2015, Adam Thomson wrote:

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
>=20
> Changes in v6:
>  - Rebase to v4.3-rc4
>=20
> Changes in v5:
>  - Rebase to v4.2
>=20
> Changes in v4:
>  - Update compatible string of fuel-gauge to "dlg,da9150-fuel-gauge".
>  - Changed example node name to "fuel-gauge".
>=20
>  .../devicetree/bindings/power/da9150-fg.txt        | 23 ++++++++++++=
++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/da9150-fg=
=2Etxt

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/power/da9150-fg.txt b/=
Documentation/devicetree/bindings/power/da9150-fg.txt
> new file mode 100644
> index 0000000..00236fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/da9150-fg.txt
> @@ -0,0 +1,23 @@
> +Dialog Semiconductor DA9150 Fuel-Gauge Power Supply bindings
> +
> +Required properties:
> +- compatible: "dlg,da9150-fuel-gauge" for DA9150 Fuel-Gauge Power Su=
pply
> +
> +Optional properties:
> +- dlg,update-interval: Interval time (milliseconds) between battery =
level checks.
> +- dlg,warn-soc-level: Battery discharge level (%) where warning even=
t raised.
> +      [1 - 100]
> +- dlg,crit-soc-level: Battery discharge level (%) where critical eve=
nt raised.
> +  This value should be lower than the warning level.
> +      [1 - 100]
> +
> +
> +Example:
> +
> +	fuel-gauge {
> +		compatible =3D "dlg,da9150-fuel-gauge";
> +
> +		dlg,update-interval =3D <10000>;
> +		dlg,warn-soc-level =3D /bits/ 8 <15>;
> +		dlg,crit-soc-level =3D /bits/ 8 <5>;
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

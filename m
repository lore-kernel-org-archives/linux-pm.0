From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v4 7/8] arm64: dts: add CPU topology on Juno
Date: Wed, 22 Jul 2015 14:31:36 +0100
Message-ID: <20150722133136.GH14923@e106497-lin.cambridge.arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-8-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433760002-24120-8-git-send-email-sudeep.holla@arm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 08, 2015 at 11:40:01AM +0100, Sudeep Holla wrote:
> This patch adds CPU topology on Juno. It will be useful for ther othe=
r
> IP blocks depending on this topology.
>=20
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-r1.dts | 26 ++++++++++++++++++++++++++
>  arch/arm64/boot/dts/arm/juno.dts    | 26 ++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dt=
s/arm/juno-r1.dts
> index c62751153a4f..69130840c6cd 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -34,6 +34,32 @@
>  		#address-cells =3D <2>;
>  		#size-cells =3D <0>;
> =20
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu =3D <&A57_0>;
> +				};
> +				core1 {
> +					cpu =3D <&A57_1>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu =3D <&A53_0>;
> +				};
> +				core1 {
> +					cpu =3D <&A53_1>;
> +				};
> +				core2 {
> +					cpu =3D <&A53_2>;
> +				};
> +				core3 {
> +					cpu =3D <&A53_3>;
> +				};
> +			};
> +		};
> +
>  		A57_0: cpu@0 {
>  			compatible =3D "arm,cortex-a57","arm,armv8";
>  			reg =3D <0x0 0x0>;
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/a=
rm/juno.dts
> index d7cbdd482a61..ce1128a54c8d 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -34,6 +34,32 @@
>  		#address-cells =3D <2>;
>  		#size-cells =3D <0>;
> =20
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu =3D <&A57_0>;
> +				};
> +				core1 {
> +					cpu =3D <&A57_1>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu =3D <&A53_0>;
> +				};
> +				core1 {
> +					cpu =3D <&A53_1>;
> +				};
> +				core2 {
> +					cpu =3D <&A53_2>;
> +				};
> +				core3 {
> +					cpu =3D <&A53_3>;
> +				};
> +			};
> +		};
> +

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

>  		A57_0: cpu@0 {
>  			compatible =3D "arm,cortex-a57","arm,armv8";
>  			reg =3D <0x0 0x0>;
> --=20
> 1.9.1
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF

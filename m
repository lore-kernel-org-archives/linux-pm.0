From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 9 Sep 2015 08:59:30 +0100
Message-ID: <20150909075930.GB3260@x1>
References: <20150811115425.GE18282@x1>
 <20150811120124.GH5509@linux>
 <20150811132756.GG18282@x1>
 <20150811142812.GJ5509@linux>
 <20150811151736.GO18282@x1>
 <20150812110841.GC20238@linux>
 <20150826120628.GZ19409@x1>
 <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150909062722.GA5266@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 09 Sep 2015, Viresh Kumar wrote:
> On 02-09-15, 13:58, Rob Herring wrote:
> > What do you expect here? It is your job to close it. Ultimately, th=
is
> > will be your problem to deal with. If you have 10 different vendors
> > doing selection of OPPs in 10 different ways you will not be able t=
o
> > change that easily later. Maybe if you can't come up with something
> > common, then this should just not go into DT. You can always look a=
t
> > how to do this in a common way and move from the kernel to DT later=
=2E
>=20
> After getting ranted a bit, here is an real attempt to solve the
> problem in a generic way. I hope this can take care of the complexity
> of both Qualcomm and ST Microelectronics SoCs.
>=20
> @Lee and Stephen: Lemme know if this still wouldn't work :(

Thanks for doing this Viresh.  I appreciate your efforts.

> -------------------------8<-------------------------
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Wed, 9 Sep 2015 11:47:37 +0530
> Subject: [PATCH] PM / OPP: Add "opp-cuts" and "opp-supply-version" bi=
ndings
>=20
> For many platforms it is unknown until runtime, about which OPPs shou=
ld
> be used or if used what should be voltage range for the supplies for =
a
> particular frequency. And this mostly depends on the version of the
> device or hardware, for which the OPPs are getting used.
>=20
> This patch adds two new OPP bindings to get this solved.
>=20
> 1. "opp-cuts": The purpose of this binding is to allow the platform t=
o
>    identify the valid OPPs based on the different levels of versions
>    with which the hardware is identified.

"cuts" is a very specific name for such a generic property.

You are using the format I suggested weeks ago, which I like.

So how about:

opp-hw-version:
	User defined array containing a hierarchy of version numbers.

E.g: Taking kernel version v2.6.19 for instance:
	<2, 6, 19>;

E.g: Representing Major 2 Minor 0, Cuts ALL and Substrate 5:
	<2, 0, 0xffffffff, 5>;

> 2. "opp-supply-name": The purpose of this binding is to allow the
>    platform to select the voltage range of the power supplies, for a
>    valid OPP.

Did you mean 'opp-supply-version', like in the example below?

I suggest '-name' would be better than '-version'.

I guess this is a Qcom specific feature.  I'll let Stephen comment.

> Both of these can be used together, as well as independently.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 90 +++++++++++++++++=
++++++++++
>  1 file changed, 90 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Document=
ation/devicetree/bindings/opp/opp.txt
> index c56a6b1a44ef..def75f7a3614 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -98,6 +98,13 @@ This describes the OPPs belonging to a device. Thi=
s node can have following
>    information. But for multiple power-supplies, this must be set to =
pass
>    triplet style values.
> =20
> +- opp-supply-version: One or more strings describing version of the =
supplies on

What kind of supplies?  Supplies to me means regulator supplies, which
I fear would be too easily confused with the regulator '*-supply'
property.

> +  the platform. This is useful for the cases, where the platform wan=
ts to select
> +  the voltage range for supplies at runtime, based on the specific v=
ersion of
> +  the hardware. There should be one entry in opp-microvolt array, fo=
r each
> +  string present here. OPPs for the device must be configured, only =
for a single
> +  version of the supplies.
> +
>  - status: Marks the OPP table enabled/disabled.
> =20
> =20
> @@ -144,6 +151,16 @@ properties.
>  - opp-suspend: Marks the OPP to be used during device suspend. Only =
one OPP in
>    the table should have this.
> =20
> +- opp-cuts: Variable length field that contains versions/cuts/substr=
ate of the

I'd remove any mention of cuts and substrate versions here.

> +  hardware for which the OPP is supported. Should contain entry per =
level of
> +  version type. For example: a platform with three levels of version=
s (cuts
> +  substrate pcode), this field should be like <X Y Z>, where X corre=
sponds to
> +  different cuts, Y corresponds to different substrates and Z corres=
ponds to
> +  different pcodes the OPP supports. Each bit of the value correspon=
ds to a

s/bit/cell/

> +  particular version of the level, and so we can have maximum 32 dif=
ferent
> +  values of any level. A value of 0xFFFFFFFF means that all the vers=
ions of the
> +  level are supported.

See my comments above.

>  - status: Marks the node enabled/disabled.
> =20
>  Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS state=
s together.
> @@ -491,3 +508,76 @@ Example 5: Multiple OPP tables
>  		};
>  	};
>  };
> +
> +Example 6: OPP selection based on hardware version
> +(example: three levels of versions: cuts, substrate and pcode)
> +
> +/ {
> +	cpus {
> +		cpu@0 {
> +			compatible =3D "arm,cortex-a7";
> +			...
> +
> +			cpu-supply =3D <&cpu_supply>
> +			operating-points-v2 =3D <&cpu0_opp_table_slow>;
> +		};
> +	};
> +
> +	opp_table {
> +		compatible =3D "operating-points-v2";
> +		status =3D "okay";
> +		opp-shared;
> +
> +		opp00 {
> +			/*
> +			 * Supports all substrate and pcode versions for 0xf
> +			 * cuts, i.e. only first four cuts.
> +			 */
> +			opp-cuts =3D <0xf 0xffffffff 0xffffffff>

This does not avoid our issue, as it insists we have an OPP node per
permutation.  That's (pcodes * cuts * substrate) nodes, which if we
support 16 pcodes, 4 cuts and 5 substrates is </me takes shoes and
socks off to count> 320 nodes.  This IMHO is too many to write/
maintain and is the nucleus of our issue.

If we could index into opp-microvolt however (please see below), this
would reduce down to (cuts * substrates) nodes, which if taking the
example above would only result in a more manageable 20 nodes.

> +			opp-hz =3D /bits/ 64 <600000000>;
> +			...

It's still worth putting the opp-microvolt property in these nodes.

> +		};
> +
> +		opp01 {
> +			/*
> +			 * Supports all substrate and pcode versions for 0x20
> +			 * cuts, i.e. only the 6th cut.
> +			 */

Not sure what you mean by 6th cut?

> +			opp-cuts =3D <0x20 0xffffffff 0xffffffff>
> +			opp-hz =3D /bits/ 64 <800000000>;
> +			...
> +		};
> +	};
> +};
> +
> +Example 7: Multiple voltage-ranges (opp-supply-version) per supply
> +(example: device with 2 supplies: vcc0 and vcc1, with two possible r=
anges of
> +voltages: slow and fast)
> +
> +/ {
> +	cpus {
> +		cpu@0 {
> +			compatible =3D "arm,cortex-a7";
> +			...
> +
> +			vcc0-supply =3D <&cpu_supply0>;
> +			vcc1-supply =3D <&cpu_supply1>;
> +			operating-points-v2 =3D <&cpu0_opp_table>;
> +		};
> +	};
> +
> +	cpu0_opp_table: opp_table0 {
> +		compatible =3D "operating-points-v2";
> +		supply-names =3D "vcc0", "vcc1";
> +		opp-supply-version =3D "slow", "fast";

You've broken your own convention.  In the explanation above you say,
"There should be one entry in opp-microvolt array, for each string
present here."  However, you seem to have 4 arrays of values in
opp-microvolt below.  I guess (supply-names * opp-supply-version)
gives you the 4 in your example, but the docs bear no mention of
this.

Then each of those 4 entries are actually arrays?  What are they?  Are
they user defined?  If so, then that's great.  In our driver we can
choose to index by 'pcode', then our node count gets reduced
dramatically and our problems are solved. \o/

> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz =3D /bits/ 64 <1000000000>;
> +			opp-microvolt =3D <900000 915000 925000>, /* Supply vcc0: slow */
> +					<910000 925000 935000>, /* Supply vcc1: slow */
> +					<970000 975000 985000>, /* Supply vcc0: fast */
> +					<960000 965000 975000>; /* Supply vcc1: fast */
> +		};
> +	};
> +};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

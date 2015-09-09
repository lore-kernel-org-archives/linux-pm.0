From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 9 Sep 2015 14:39:30 +0100
Message-ID: <20150909133930.GE3260@x1>
References: <20150811132756.GG18282@x1>
 <20150811142812.GJ5509@linux>
 <20150811151736.GO18282@x1>
 <20150812110841.GC20238@linux>
 <20150826120628.GZ19409@x1>
 <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux>
 <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150909083031.GB5266@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 09 Sep 2015, Viresh Kumar wrote:
> On 09-09-15, 08:59, Lee Jones wrote:
> > Thanks for doing this Viresh.  I appreciate your efforts.
>=20
> I wanted to get this sorted out, before we meet face to face :)
>=20
> > > -------------------------8<-------------------------
> > > From: Viresh Kumar <viresh.kumar@linaro.org>
> > > Date: Wed, 9 Sep 2015 11:47:37 +0530
> > > Subject: [PATCH] PM / OPP: Add "opp-cuts" and "opp-supply-version=
" bindings
> > >=20
> > > For many platforms it is unknown until runtime, about which OPPs =
should
> > > be used or if used what should be voltage range for the supplies =
for a
> > > particular frequency. And this mostly depends on the version of t=
he
> > > device or hardware, for which the OPPs are getting used.
> > >=20
> > > This patch adds two new OPP bindings to get this solved.
> > >=20
> > > 1. "opp-cuts": The purpose of this binding is to allow the platfo=
rm to
> > >    identify the valid OPPs based on the different levels of versi=
ons
> > >    with which the hardware is identified.
> >=20
> > "cuts" is a very specific name for such a generic property.
>=20
> I agree... I wasn't concerned much about naming on the first try and
> so just wrote it quickly enough to get an overall idea ..
>=20
> > You are using the format I suggested weeks ago, which I like.
>=20
> I must have missed that :(
>=20
> > So how about:
> >=20
> > opp-hw-version:
> > 	User defined array containing a hierarchy of version numbers.
> >=20
> > E.g: Taking kernel version v2.6.19 for instance:
> > 	<2, 6, 19>;
> >=20
> > E.g: Representing Major 2 Minor 0, Cuts ALL and Substrate 5:
> > 	<2, 0, 0xffffffff, 5>;
>=20
> At least what I suggested in my attempt here is a bit different than
> what you might be thinking. For example, consider a case with single
> level of hierarchy, say cuts. And that the SoC has got 10 different
> cuts, and we name them 0-9. So, the values I was looking to fill to
> the opp-hw-version field is like: (1 << version_num). So, if an OPP
> supports version 2, 5 and 7, the value will be 0x000000A4. i.e. with
> the respective bit positions set. And by this way only 0xffffffff can
> mean all versions ..

Okay, I see what you mean.  Sound fine, although only allows up to 31
versions.  Not an issue for us I don't think, but could be for other
vendors.  Taking a recent example, the kernel recently went up to
v2.6.39 and some of the stable releases have gone up to v3.4.108.
Depends what you wish to support.

> > > 2. "opp-supply-name": The purpose of this binding is to allow the
> > >    platform to select the voltage range of the power supplies, fo=
r a
> > >    valid OPP.
> >=20
> > Did you mean 'opp-supply-version', like in the example below?
>=20
> Urg. Yeah.
>=20
> > I suggest '-name' would be better than '-version'.
>=20
> So, its not name of the supply really, but a virtual name given to th=
e
> voltage-range which we need to pick based on the hardware version.

We usually call these 'names'; reg-names, clock-names, pinctrl-names,
phy-names, dma-names, etc.

> > I guess this is a Qcom specific feature.  I'll let Stephen comment.
>=20
> No. So, my plan was to use this instead of the st,avs & pcode thing
> you have got in your bindings. So, instead of 'slow' and 'fast' from
> my example, it will have the corresponding strings for pcode numbers.
> And at runtime the platform will pass a string to the OPP library, to
> activate/add OPPs only for a specific opp-supply-version.

So you're using it to index into a 2 dimensional array of opp-hz's.

Eek!

> Maybe we can name it 'opp-supply-range-name'..
>=20
> > > Both of these can be used together, as well as independently.
> > >=20
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/opp/opp.txt | 90 +++++++++++++=
++++++++++++++
> > >  1 file changed, 90 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Docu=
mentation/devicetree/bindings/opp/opp.txt
> > > index c56a6b1a44ef..def75f7a3614 100644
> > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > @@ -98,6 +98,13 @@ This describes the OPPs belonging to a device.=
 This node can have following
> > >    information. But for multiple power-supplies, this must be set=
 to pass
> > >    triplet style values.
> > > =20
> > > +- opp-supply-version: One or more strings describing version of =
the supplies on
> >=20
> > What kind of supplies?  Supplies to me means regulator supplies, wh=
ich
> > I fear would be too easily confused with the regulator '*-supply'
> > property.
>=20
> Yeah, its more like opp-supply-range-names ..
>=20
> > > +  the platform. This is useful for the cases, where the platform=
 wants to select
> > > +  the voltage range for supplies at runtime, based on the specif=
ic version of
> > > +  the hardware. There should be one entry in opp-microvolt array=
, for each
> > > +  string present here. OPPs for the device must be configured, o=
nly for a single
> > > +  version of the supplies.
> > > +
> > >  - status: Marks the OPP table enabled/disabled.
> > > =20
> > > =20
> > > @@ -144,6 +151,16 @@ properties.
> > >  - opp-suspend: Marks the OPP to be used during device suspend. O=
nly one OPP in
> > >    the table should have this.
> > > =20
> > > +- opp-cuts: Variable length field that contains versions/cuts/su=
bstrate of the
> >=20
> > I'd remove any mention of cuts and substrate versions here.
>=20
> I agree, but probably keep the same in example code to make it simple
> to understand.
>=20
> > > +  hardware for which the OPP is supported. Should contain entry =
per level of
> > > +  version type. For example: a platform with three levels of ver=
sions (cuts
> > > +  substrate pcode), this field should be like <X Y Z>, where X c=
orresponds to
> > > +  different cuts, Y corresponds to different substrates and Z co=
rresponds to
> > > +  different pcodes the OPP supports. Each bit of the value corre=
sponds to a
> >=20
> > s/bit/cell/
>=20
> No. Its like each bit of the 32 bit cell corresponds ...=20
>=20
> > > +  particular version of the level, and so we can have maximum 32=
 different
> > > +  values of any level. A value of 0xFFFFFFFF means that all the =
versions of the
> > > +  level are supported.
>=20
> > > +	opp_table {
> > > +		compatible =3D "operating-points-v2";
> > > +		status =3D "okay";
> > > +		opp-shared;
> > > +
> > > +		opp00 {
> > > +			/*
> > > +			 * Supports all substrate and pcode versions for 0xf
> > > +			 * cuts, i.e. only first four cuts.
> > > +			 */
> > > +			opp-cuts =3D <0xf 0xffffffff 0xffffffff>
> >=20
> > This does not avoid our issue, as it insists we have an OPP node pe=
r
> > permutation.  That's (pcodes * cuts * substrate) nodes, which if we
> > support 16 pcodes, 4 cuts and 5 substrates is </me takes shoes and
> > socks off to count> 320 nodes.  This IMHO is too many to write/
> > maintain and is the nucleus of our issue.
>=20
> Not with the bitwise logic I just tried to explain. Obviously we are
> doing all this to avoid writing so many nodes.
>=20
> > If we could index into opp-microvolt however (please see below), th=
is
> > would reduce down to (cuts * substrates) nodes, which if taking the
> > example above would only result in a more manageable 20 nodes.
>=20
> I don't want 20 nodes but only ONE. And in your case, you may only
> want to use pcode in the opp-supply-range-name property. But its fine
> if you want to enable/disable some OPPs based on that as well :)

I'm not seeing how this can be achieved with 1 node.

I guess you mean one node per frequency?

> > > +			opp-hz =3D /bits/ 64 <600000000>;
> > > +			...
> >=20
> > It's still worth putting the opp-microvolt property in these nodes.
>=20
> Okay, but I didn't wanted to confuse in the sense that opp-cuts
> doesn't have anything to do with opp-microvolt..
>=20
> > > +		};
> > > +
> > > +		opp01 {
> > > +			/*
> > > +			 * Supports all substrate and pcode versions for 0x20
> > > +			 * cuts, i.e. only the 6th cut.
> > > +			 */
> >=20
> > Not sure what you mean by 6th cut?
>=20
> Bit number 6th, i.e. 0x20.

Yes, okay.  I think we can make the description and examples easier to
understand, but I get the premise.

> > > +			opp-cuts =3D <0x20 0xffffffff 0xffffffff>
> > > +			opp-hz =3D /bits/ 64 <800000000>;
> > > +			...
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +Example 7: Multiple voltage-ranges (opp-supply-version) per supp=
ly
> > > +(example: device with 2 supplies: vcc0 and vcc1, with two possib=
le ranges of
> > > +voltages: slow and fast)
> > > +
> > > +/ {
> > > +	cpus {
> > > +		cpu@0 {
> > > +			compatible =3D "arm,cortex-a7";
> > > +			...
> > > +
> > > +			vcc0-supply =3D <&cpu_supply0>;
> > > +			vcc1-supply =3D <&cpu_supply1>;
> > > +			operating-points-v2 =3D <&cpu0_opp_table>;
> > > +		};
> > > +	};
> > > +
> > > +	cpu0_opp_table: opp_table0 {
> > > +		compatible =3D "operating-points-v2";
> > > +		supply-names =3D "vcc0", "vcc1";
> > > +		opp-supply-version =3D "slow", "fast";
> > > +
> >
> > You've broken your own convention.  In the explanation above you sa=
y,
> > "There should be one entry in opp-microvolt array, for each string
> > present here."  However, you seem to have 4 arrays of values in
> > opp-microvolt below.  I guess (supply-names * opp-supply-version)
> > gives you the 4 in your example, but the docs bear no mention of
> > this.
> >=20
> > Then each of those 4 entries are actually arrays?  What are they?  =
Are
> > they user defined?  If so, then that's great.  In our driver we can
> > choose to index by 'pcode', then our node count gets reduced
> > dramatically and our problems are solved. \o/
>=20
> Not really. So this is the logic (I perhaps need to write the
> paragraph in the bindings in a better way):
> 1. A regulator's voltage can be supplied as <target> or <target min m=
ax> now.

Understood.  I don't think we'll be using that, but if it's useful to
others, then fine.

> 2. For each regulator we need to have an array of size mentioned abov=
e.

Using 2 properties to index in a 2D array like this look scarily like
it'll be prone to all sorts of fumbling errors.

The complexity of all this will reduce massively by having a separate
node per <regulator>-supply.  Using the same nodes for this is
squeezing too much into a single node.  I was put off as soon as I saw
you using 2D arrays in DT.

> Now this is what I call as ONE entry.
>=20
> For each opp-supply-range-name string, we need a copy of this..

=46ortunately for us we'll only have single celled opp-microvolt
properties.

> > > +		opp-shared;
> > > +
> > > +		opp00 {
> > > +			opp-hz =3D /bits/ 64 <1000000000>;
> > > +			opp-microvolt =3D <900000 915000 925000>, /* Supply vcc0: slo=
w */
> > > +					<910000 925000 935000>, /* Supply vcc1: slow */
>=20
> So this is one entry for two regulators in the form <target min max>,=
 and it
> belongs to the opp-supply-range-name 'slow'.
>
> > > +					<970000 975000 985000>, /* Supply vcc0: fast */
> > > +					<960000 965000 975000>; /* Supply vcc1: fast */
>=20
> And this one is for 'fast'.

So I think our offering would look like this:

cpus {
	cpu@0 {
		compatible =3D "arm,cortex-a7";
		vcc-supply =3D <&cpu_supply0>;
		operating-points-v2 =3D <&cpu0_opp_table>;
	};
};

cpu0_opp_table: opp_table0 {
	compatible =3D "operating-points-v2";
	opp-microvolt-names =3D "1", "2",  "3",  "4",  "5",  "6",  "7",  "8"
			      "9", "10", "11", "12", "13", "14", "15", "16";

	opp0 {
		/*                  Major       Minor       Substrate */
		/*                  all         all         all       */
		opp-supported-hw =3D <0xffffffff  0xffffffff  0xffffffff>
		opp-hz           =3D <1000000000>;
		opp-microvolt    =3D <900000>, <915000>, <915000>, <925000>,
				   <925000>, <925000>, <935000>, <945000>,
				   <945000>, <945000>, <945000>, <955000>,
				   <956000>, <975000>, <975000>, <975000>,
	};

	opp1 {
		/*                  Major  Minor  Substrate */
		/*                  2      1 & 2  all       */
		opp-supported-hw =3D <0x2    0x3    0xffffffff>
		opp-hz           =3D <1100000000>;
		opp-microvolt    =3D <900000>, <915000>, <915000>, <925000>,
				   <925000>, <925000>, <935000>, <945000>,
				   <945000>, <945000>, <945000>, <955000>,
				   <956000>, <975000>, <975000>, <975000>,
	};

	opp2 {
		/*                  Major  Minor  Substrate */
		/*                  2      5      4 & 5 & 6 */
		opp-supported-hw =3D <0x2    0x10   0x38>
		opp-hz           =3D <1200000000>;
		opp-microvolt    =3D <900000>, <915000>, <915000>, <925000>,
				   <925000>, <925000>, <935000>, <945000>,
				   <945000>, <945000>, <945000>, <955000>,
				   <956000>, <975000>, <975000>, <975000>,
	};
};

Or have I got the wrong end of the stick?

NB: Note the suggested new property names.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

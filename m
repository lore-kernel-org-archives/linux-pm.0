From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 29 Jul 2015 09:14:03 +0100
Message-ID: <20150729081403.GH2284@x1>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux>
 <20150728225510.GB3159@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728225510.GB3159@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rob.herring@linaro.org, nm@ti.com, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 28 Jul 2015, Stephen Boyd wrote:

> On 07/28, Viresh Kumar wrote:
> > Cc'ing few people (whom I cc'd last time as well :)).
> >=20
> > On 27-07-15, 16:20, Lee Jones wrote:
> > > These OPPs are used in ST's CPUFreq implementation.
> > >=20
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >=20
> > > Changelog:
> > >  - None, new patch
> > >=20
> > >  Documentation/devicetree/bindings/power/opp-st.txt | 76 ++++++++=
++++++++++++++
> > >  1 file changed, 76 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/opp-s=
t.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/power/opp-st.txt b=
/Documentation/devicetree/bindings/power/opp-st.txt
> > > new file mode 100644
> > > index 0000000..6eb2a91
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/opp-st.txt
> > > @@ -0,0 +1,76 @@
> > > +STMicroelectronics OPP (Operating Performance Points) Bindings
> > > +--------------------------------------------------------------
> > > +
> > > +Frequency Scaling only
> > > +----------------------
> > > +
> > > +Located in CPU's node:
> > > +
> > > +- operating-points	: [See: ./opp.txt]
> > > +
> > > +Example [safe]
> > > +--------------
> > > +
> > > +cpus {
> > > +	cpu@0 {
> > > +				 /* kHz     uV   */
> > > +		operating-points =3D <1500000 0
> > > +				    1200000 0
> > > +				    800000  0
> > > +				    500000  0>;
> > > +	};
> > > +};
> > > +
> > > +Dynamic Voltage and Frequency Scaling (DVFS)
> > > +--------------------------------------------
> > > +
> > > +Located in 'cpu0-opp-list' node [to be provided ONLY by the boot=
loader]:
> > > +
> > > +- compatible		: Should be "operating-points-v2-sti"
> > > +- opp{1..N} 		: Each 'oppX' subnode will contain the following p=
roperties:
> >=20
> > Or should we mention:
> > - opp{1..N} 		: Each 'oppX' subnode shall contain below properties,
> >                           over what ./opp.txt defines:
> >=20
> > ?
> >=20
> >=20
> > > + - opp-hz		: CPU frequency [Hz] for this OPP [See: ./opp.txt]
> > > + - st,avs		: List of available voltages [uV] indexed by process =
code
> > > + - st,cuts		: Cut version this OPP is suitable for [0xFF means A=
LL]
> > > + - st,substrate		: Substrate version this OPP is suitable for [0=
xFF means ALL]
> > > +- st,syscfg		: Phandle to Major number register
> > > +				First cell: offset to major number
> > > +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> > > +				First cell: offset to process code
> > > +				Second cell: offset to minor number
> > > +
> > > +WARNING: The opp{1..N} nodes will be provided by the bootloader.=
  Do not attempt to
> > > +	 artificially synthesise the opp{1..N} nodes or any of their de=
scendants.
> > > +	 They are very platform specific and may damage the hardware if=
 created
> > > +	 incorrectly.
> > > +
> > > +Example [unsafe]
> > > +----------------
> > > +
> > > +cpus {
> > > +	cpu@0 {
> > > +		operating-points-v2	=3D <&cpu0_opp_list>;
> > > +	};
> > > +};
> > > +
> > > +/* ############################################################ =
*/
> > > +/* # WARNING: Do not attempt to copy/replicate this node,     # =
*/
> > > +/* #          it is only to be supplied by the bootloader !!! # =
*/
> > > +/* ############################################################ =
*/
> > > +cpu0-opp-list {
> > > +	compatible	=3D "operating-points-v2-sti";
> > > +	st,syscfg	=3D <&syscfg [major_offset]>;
> > > +	st,syscfg-eng   =3D <&syscfg_eng [pcode_offset] [minor_offset]>=
;
> > > +
> > > +	opp0 {
> > > +		opp-hz		=3D <1200000000>;
> > > +		st,avs		=3D <1110 1150 1100 1080 1040 1020 980 930>;
> > > +		st,substrate	=3D <0xff>;
> > > +		st,cuts		=3D <0xff>;
> > > +	};
> > > +	opp1 {
> > > +		opp-hz		=3D <1500000000>;
> > > +		st,avs		=3D <1200 1200 1200 1200 1170 1140 1100 1070>;
> > > +		st,substrate	=3D <0xff>;
> > > +		st,cuts		=3D <0x2>;
> > > +	};
> > > +};
> >=20
> > I don't see more problems here, unless we can move some of this to =
the
> > generic bindings.
> >=20
> > @Rob/Stephen: Please respond before it is late :)
>=20
> It's interesting to have vendor specific properties like avs,
> cuts, and substrate. That could replace our planned usage of the
> opp-names property where we encode similar information (speed
> bin, revision, etc.) into a string that we look for.
>=20
> So I wonder why the avs/cut/substrate information can't be
> encoded into the opp name? That would make these properties
> obsolete, given that all they're used for is to pick out the
> correct OPP?

You could hack the substrate and cut version into a string, but that's
exactly what it would be, a hack.  I'm struggling how you would do the
same for 'st,avs', which is an array of u32s.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 28 Jul 2015 08:34:39 +0100
Message-ID: <20150728073439.GK21114@x1>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35196 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbbG1Heo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 03:34:44 -0400
Received: by wibxm9 with SMTP id xm9so143870900wib.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 00:34:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150728022936.GB1229@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rob.herring@linaro.org, nm@ti.com, arnd.bergmann@linaro.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com

On Tue, 28 Jul 2015, Viresh Kumar wrote:

> Cc'ing few people (whom I cc'd last time as well :)).
>=20
> On 27-07-15, 16:20, Lee Jones wrote:
> > These OPPs are used in ST's CPUFreq implementation.
> >=20
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >=20
> > Changelog:
> >  - None, new patch
> >=20
> >  Documentation/devicetree/bindings/power/opp-st.txt | 76 ++++++++++=
++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/opp-st.=
txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/opp-st.txt b/D=
ocumentation/devicetree/bindings/power/opp-st.txt
> > new file mode 100644
> > index 0000000..6eb2a91
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/opp-st.txt
> > @@ -0,0 +1,76 @@
> > +STMicroelectronics OPP (Operating Performance Points) Bindings
> > +--------------------------------------------------------------
> > +
> > +Frequency Scaling only
> > +----------------------
> > +
> > +Located in CPU's node:
> > +
> > +- operating-points	: [See: ./opp.txt]
> > +
> > +Example [safe]
> > +--------------
> > +
> > +cpus {
> > +	cpu@0 {
> > +				 /* kHz     uV   */
> > +		operating-points =3D <1500000 0
> > +				    1200000 0
> > +				    800000  0
> > +				    500000  0>;
> > +	};
> > +};
> > +
> > +Dynamic Voltage and Frequency Scaling (DVFS)
> > +--------------------------------------------
> > +
> > +Located in 'cpu0-opp-list' node [to be provided ONLY by the bootlo=
ader]:
> > +
> > +- compatible		: Should be "operating-points-v2-sti"
> > +- opp{1..N} 		: Each 'oppX' subnode will contain the following pro=
perties:
>=20
> Or should we mention:
> - opp{1..N} 		: Each 'oppX' subnode shall contain below properties,
>                           over what ./opp.txt defines:
>=20
> ?

I disagree.  For one, only 'opp-hz' is defined in ./opp.tx.  Secondly
it would be annoying to have to have to keep jumping between documents
to obtain the whole picture.  Finally, generic bindings are repeated
in platform/device specific documentation all the time.  Grep for
'clocks' or 'regulator-* or 'interrupts' or 'reg' or 'clock-frequency'
(which IMHO I think you should have used instead of 'opp-hz', but
that's by the by), or any number of other generic properties.

> > + - opp-hz		: CPU frequency [Hz] for this OPP [See: ./opp.txt]
> > + - st,avs		: List of available voltages [uV] indexed by process co=
de
> > + - st,cuts		: Cut version this OPP is suitable for [0xFF means ALL=
]
> > + - st,substrate		: Substrate version this OPP is suitable for [0xF=
=46 means ALL]
> > +- st,syscfg		: Phandle to Major number register
> > +				First cell: offset to major number
> > +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> > +				First cell: offset to process code
> > +				Second cell: offset to minor number
> > +
> > +WARNING: The opp{1..N} nodes will be provided by the bootloader.  =
Do not attempt to
> > +	 artificially synthesise the opp{1..N} nodes or any of their desc=
endants.
> > +	 They are very platform specific and may damage the hardware if c=
reated
> > +	 incorrectly.
> > +
> > +Example [unsafe]
> > +----------------
> > +
> > +cpus {
> > +	cpu@0 {
> > +		operating-points-v2	=3D <&cpu0_opp_list>;
> > +	};
> > +};
> > +
> > +/* ############################################################ */
> > +/* # WARNING: Do not attempt to copy/replicate this node,     # */
> > +/* #          it is only to be supplied by the bootloader !!! # */
> > +/* ############################################################ */
> > +cpu0-opp-list {
> > +	compatible	=3D "operating-points-v2-sti";
> > +	st,syscfg	=3D <&syscfg [major_offset]>;
> > +	st,syscfg-eng   =3D <&syscfg_eng [pcode_offset] [minor_offset]>;
> > +
> > +	opp0 {
> > +		opp-hz		=3D <1200000000>;
> > +		st,avs		=3D <1110 1150 1100 1080 1040 1020 980 930>;
> > +		st,substrate	=3D <0xff>;
> > +		st,cuts		=3D <0xff>;
> > +	};
> > +	opp1 {
> > +		opp-hz		=3D <1500000000>;
> > +		st,avs		=3D <1200 1200 1200 1200 1170 1140 1100 1070>;
> > +		st,substrate	=3D <0xff>;
> > +		st,cuts		=3D <0x2>;
> > +	};
> > +};
>=20
> I don't see more problems here, unless we can move some of this to th=
e
> generic bindings.
>=20
> @Rob/Stephen: Please respond before it is late :)

No one knows this stuff better than you.  If you can't think of an
already existing binding that could suit to portray our 'cuts' and
'substrate' information (with a similar way to support our "all cuts"
and "all substrates" options, then there probably isn't one. ;)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

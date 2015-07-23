From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/1] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
Date: Thu, 23 Jul 2015 12:11:53 +0100
Message-ID: <20150723111055.GZ3061@x1>
References: <1437478420-26419-1-git-send-email-lee.jones@linaro.org>
 <20150723095254.GN5322@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34816 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbbGWLM2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 07:12:28 -0400
Received: by wibxm9 with SMTP id xm9so203266887wib.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2015 04:12:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150723095254.GN5322@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rob.herring@linaro.org, nm@ti.com, arnd.bergmann@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, kernel@stlinux.com

On Thu, 23 Jul 2015, Viresh Kumar wrote:

> Cc'ing few more people who were involved in opp-v2 discussions.
>=20
> Guys, please take a closer look as this is the first user platform
> that wants to extend opp-v2 bindings with platform specific stuff.
>=20
> On 21-07-15, 12:33, Lee Jones wrote:
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >=20
> > Only submitting the binding document as requested by Viresh.
> >=20
> > v2 =3D> v3:
> >  - Using OPP v2
> >  - Moved OPPs out of the CPU node into their own one
> >  - Using generic 'opp-hz' property
> >=20
> >  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 77 ++++++++++=
++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufr=
eq-st.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.t=
xt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> > new file mode 100644
> > index 0000000..a478eec
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
>=20
> These are used by cpufreq, but they aren't really cpufreq bindings.
>=20
> These are opp bindings and must present at:
> Documentation/devicetree/bindings/power/opp/st.txt and we should move
> opp.txt in that folder as well..

Sure.

> > @@ -0,0 +1,77 @@
> > +Binding for ST's CPUFreq driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Required properties [for working voltage scaling]:
> > +-------------------------------------------------
> > +
> > +Located in CPU's node:
>=20
> I hope below registers are used to define which OPPs are valid for th=
e
> CPU and so shouldn't these be present under opp node instead of CPU?

Yes, I neglected to change this when I moved the other bindings.

Will change.

> > +- st,syscfg		: Phandle to Major number register
> > +				First cell: offset to major number
> > +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> > +				First cell: offset to process code
> > +				Second cell: offset to minor number
> > +
> > +Located in 'cpu0-opp-list' node [to be provided ONLY by the bootlo=
ader]:
> > +
> > + - opp{1..N} 		: Each 'oppX' subnode will contain the following pr=
operties:
> > +  - opp-hz		: CPU frequency [Hz] for this OPP
>=20
> Not sure if you are required to re define it. In case you want to, th=
e
> please add a link here to the bindings that define it. So that we
> don't think they are newer bindings.

Sure.

> > +  - st,avs		: List of available voltages [uV] indexed by process c=
ode
> > +  - st,cuts		: Cut version this OPP is suitable for [0xFF means AL=
L]
> > +  - st,substrate	: Substrate version this OPP is suitable for [0xF=
=46 means ALL]
>=20
> @Stephen: Any idea if these can be relevant for other platforms and w=
e
> can move them to generic bindings?
>=20
> > +WARNING: The cpu0-opp-list will be provided by the bootloader.  Do=
 not attempt to
> > +	 artificially synthesise the cpu0-opp-list node or any of its des=
cendants.
> > +	 They are very platform specific and may damage the hardware if c=
reated
> > +	 incorrectly.
> > +
> > +Required properties [if voltage scaling properties are missing]:
> > +------------------------------------------------------------------=
-
> > +
> > +Located in CPU's node:
> > +
> > +- operating-points	: [See: ../power/opp.txt]
> > +
> > +Example [safe]:
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
>=20
> Why do you want to keep these as well?

We need this as a fall-back, in case anyone boots using a bootloader
which isn't equipped to supply the OPP list.  If this happens we can
not use voltage scaling and he best thing we can do is operate using
only frequency scaling.

> > +Example [unsafe]:
> > +----------------
> > +
> > +cpus {
> > +	cpu@0 {
> > +		st,syscfg		=3D <&syscfg [major_offset]>;
> > +		st,syscfg-eng   	=3D <&syscfg_eng [pcode_offset] [minor_offset]>=
;
> > +		operating-points-v2	=3D <&cpu0_opp_list>;
> > +	};
> > +};
> > +
> > +/* ############################################################ */
> > +/* # WARNING: Do not attempt to copy/replicate this node,     # */
> > +/* #          it is only to be supplied by the bootloader !!! # */
> > +/* ############################################################ */
> > +cpu0-opp-list {
> > +	compatible =3D "operating-points-v2-sti";
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

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

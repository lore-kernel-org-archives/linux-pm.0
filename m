From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 11 Aug 2015 16:17:36 +0100
Message-ID: <20150811151736.GO18282@x1>
References: <20150731163715.GV3159@codeaurora.org>
 <20150803034642.GV899@linux>
 <20150810132247.GH3249@x1>
 <20150811080023.GB5509@linux>
 <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux>
 <20150811115425.GE18282@x1>
 <20150811120124.GH5509@linux>
 <20150811132756.GG18282@x1>
 <20150811142812.GJ5509@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37392 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965131AbbHKPRm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 11:17:42 -0400
Received: by wibhh20 with SMTP id hh20so201135703wib.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 08:17:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811142812.GJ5509@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robherring2@gmail.com>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 11 Aug 2015, Viresh Kumar wrote:
> On 11-08-15, 14:27, Lee Jones wrote:
> > Okay, so what you're saying is that you've already made the decisio=
n
> > to create a separate node for every OPP permutation,
>=20
> Absolutely not.
>=20
> > despite the fact
> > that I've told you this could lead to more nodes than anyone would
> > care to successfully write or maintain?
>=20
> I have enough fear of yours and then I have to see you in another
> month as well. I wouldn't dare to disobey your command SIR :)

=46unny guy! ;)

> > Perhaps an example might help explain the issue.
> >=20
> > Using the current driver, we need to place the following in DT and =
the
> > driver does the rest:
> >=20
> > opp-list {
> > 	opp1 {
> > 		opp-hz =3D <1500000000>;
> > 		st,avs =3D <1200 1200 1200 1200 1170 1140 1100 1070>;
> > 		st,substrate =3D <0xff>;
> > 		st,cuts =3D <0xff>;
> > 	};
> > 	opp0 {
> > 		opp-hz =3D <1200000000>;
> > 		st,avs =3D <1110 1150 1100 1080 1040 1020 980 930>;
> > 		st,substrate =3D <0xff>;
> > 		st,cuts =3D <0x2>;
> > 	};
> > };
>=20
> Nothing is fixed as of now but this is what I am thinking of:
>=20
> 	cpu0_opp_table: opp_table0 {
> 		compatible =3D "operating-points-v2";
>                 opp-cuts =3D "10", "3c", "f0";
> 		supply-names =3D "vcc0", "vcc1", "vcc2";
> 		opp-shared;
>=20
> 		opp00 {
> 			opp-hz =3D /bits/ 64 <1000000000>;
> 			clock-latency-ns =3D <300000>;
> 			opp-microvolt-10 =3D <970000>;
> 			opp-microvolt-3c =3D <950000>;
> 			opp-microvolt-f0 =3D <930000>;
> 		};
>=20
> 		/* OR */
>=20
> 		opp00 {
> 			opp-hz =3D /bits/ 64 <1000000000>;
> 			clock-latency-ns =3D <300000>;
>                         opp-microvolt =3D <970000>, <950000>, <930000=
>;
> 		};
>         };
>=20
> And then the platform code needs to tell OPP layer:
> "Use OPPs for cut f0 for device X", and OPP layer will store that
> somewhere.
>=20
> And then it will only initialize OPPs after matching this string with
> the values.
>=20
> Out of the earlier two options, I may prefer the first one. As we wil=
l
> be soon adding support for multiple regulators, and a single regulato=
r
> can have min/max/target values.. So, a single list will become too
> long.

This would work if we only had a single variable to contend with, but
what I showed you in my previous example is that we have 3 variables
to consider; cut (version), pcode and substrate.

Using the two (simple) examples I provided, how would your suggestion
look in our case?

> But, something like this should be generic enough to capture most of
> the cases.
>=20
> @Stephen/Rob ??
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

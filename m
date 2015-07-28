From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 28 Jul 2015 16:43:30 +0100
Message-ID: <20150728154330.GZ14943@x1>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <CAL_JsqL=e+fL_67_GPKjt_7wJ81GfFx7m9gjxmBDvW_JBXWpfQ@mail.gmail.com>
 <20150728143919.GW14943@x1>
 <CAL_JsqL8YLeo2TvT=WwjBhNaXXGGFGxkhXdjuEHfs8TN7KLpTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37852 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbG1Png (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 11:43:36 -0400
Received: by wibud3 with SMTP id ud3so165523554wib.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 08:43:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL_JsqL8YLeo2TvT=WwjBhNaXXGGFGxkhXdjuEHfs8TN7KLpTA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Sebastian Reichel <sre@kernel.org>, ajitpal.singh@st.com

On Tue, 28 Jul 2015, Rob Herring wrote:

> On Tue, Jul 28, 2015 at 9:39 AM, Lee Jones <lee.jones@linaro.org> wro=
te:
> > On Tue, 28 Jul 2015, Rob Herring wrote:
> >
> >> On Mon, Jul 27, 2015 at 10:20 AM, Lee Jones <lee.jones@linaro.org>=
 wrote:
> >> > These OPPs are used in ST's CPUFreq implementation.
> >> >
> >> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> > ---
> >> >
> >> > Changelog:
> >> >  - None, new patch
> >> >
> >> >  Documentation/devicetree/bindings/power/opp-st.txt | 76 +++++++=
+++++++++++++++
> >> >  1 file changed, 76 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/power/opp-=
st.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/power/opp-st.txt =
b/Documentation/devicetree/bindings/power/opp-st.txt
> >> > new file mode 100644
> >> > index 0000000..6eb2a91
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/power/opp-st.txt
> >> > @@ -0,0 +1,76 @@
> >> > +STMicroelectronics OPP (Operating Performance Points) Bindings
> >> > +--------------------------------------------------------------
> >> > +
> >> > +Frequency Scaling only
> >> > +----------------------
> >> > +
> >> > +Located in CPU's node:
> >> > +
> >> > +- operating-points     : [See: ./opp.txt]
> >> > +
> >> > +Example [safe]
> >> > +--------------
> >> > +
> >> > +cpus {
> >> > +       cpu@0 {
> >> > +                                /* kHz     uV   */
> >> > +               operating-points =3D <1500000 0
> >> > +                                   1200000 0
> >> > +                                   800000  0
> >> > +                                   500000  0>;
> >> > +       };
> >> > +};
> >> > +
> >> > +Dynamic Voltage and Frequency Scaling (DVFS)
> >> > +--------------------------------------------
> >> > +
> >> > +Located in 'cpu0-opp-list' node [to be provided ONLY by the boo=
tloader]:
> >> > +
> >> > +- compatible           : Should be "operating-points-v2-sti"
> >> > +- opp{1..N}            : Each 'oppX' subnode will contain the f=
ollowing properties:
> >> > + - opp-hz              : CPU frequency [Hz] for this OPP [See: =
=2E/opp.txt]
> >> > + - st,avs              : List of available voltages [uV] indexe=
d by process code
> >>
> >> Add a unit suffix (-microvolt).
> >
> > Sure.
> >
> >> > + - st,cuts             : Cut version this OPP is suitable for [=
0xFF means ALL]
> >> > + - st,substrate                : Substrate version this OPP is =
suitable for [0xFF means ALL]
> >>
> >> How about not present means all?
> >
> > I think that would be an unsafe assumption.  If it's forgotten, the=
n
> > we may try to run an invalid/dangerous voltage/frequency combinatio=
n.
> >
> > I'd really like 'all' to be defined an deliberate.
>=20
> Okay.
>=20
> >> > +- st,syscfg            : Phandle to Major number register
> >> > +                               First cell: offset to major numb=
er
> >> > +- st,syscfg-eng                : Phandle to Minor number and Pc=
ode registers
> >> > +                               First cell: offset to process co=
de
> >> > +                               Second cell: offset to minor num=
ber
> >>
> >> Would the proposed nvmem binding work for this?
> >
> > We already use sysconf for all of this type of stuff, as this
> > information is contained in ST's Sysconf banks.  Moving over to a n=
ew
> > API would be a huge move and would require lots of planning
> > discussions with ST.
>=20
> Okay.

Thanks.

I'm going to fix up your suggestions above and add your Ack to make
Viresh happy. :)

Thanks Rob.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

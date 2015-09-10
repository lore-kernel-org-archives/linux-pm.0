From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Thu, 10 Sep 2015 09:31:46 +0100
Message-ID: <20150910083146.GG3260@x1>
References: <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux>
 <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux>
 <20150909133930.GE3260@x1>
 <20150909160212.GJ5266@linux>
 <20150909163620.GF3260@x1>
 <55F0C5AB.5060609@kernel.org>
 <20150910005722.GA15099@codeaurora.org>
 <20150910010426.GM5266@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36807 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbbIJIbu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 04:31:50 -0400
Received: by wicgb1 with SMTP id gb1so14844917wic.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2015 01:31:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150910010426.GM5266@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 10 Sep 2015, Viresh Kumar wrote:

> On 09-09-15, 17:57, Stephen Boyd wrote:
> > I think it will work for qcom use cases.
>=20
> Thanks for the Rant Rob, it finally got me moving :)
>=20
> > We can collapse the
> > tables down to one node and have speed bin and version as the
> > opp-supported-hw property. The opp-microvolt-names property would
>=20
> I am probably going to remove opp-microvolt-names property as well, i=
f
> we are going to use separate entries for all voltage ranges in OPP
> node. i.e. two voltage ranges, slow and fast, like this:
>=20
>                      regulator A       regulator B
> opp-microvolt-slow =3D <tarA minA maxA>, <tarB minB maxB>;
> opp-microvolt-fast =3D <tarA minA maxA>, <tarB minB maxB>;
>=20
> > be where we put the different voltage bins. What about the other
> > properties like opp-microamp or opp-suspend? Will all of those
>=20
> Lets keep them as is for now, unless we have a real user.
>=20
> > also get *-names properties to index into them based on some
> > string? I don't actually need those for my devices, but I'm just
> > pointing it out in case someone else wants to compress tables but
> > they have different microamps or clock latencies, etc.
> >=20
> > Finally, does this mean we will get rid of operating-points-names?
>=20
> That's the next thing I wanted to ask from Rob. We are surely not
> going to use them and there are no users or kernel code to support
> them today. Can we get rid of them from the DT ?

I think you answered your own question.

No users =3D=3D !ABI =3D=3D Strip it out.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 11 Aug 2015 12:54:25 +0100
Message-ID: <20150811115425.GE18282@x1>
References: <20150729081403.GH2284@x1>
 <20150729221526.GE3159@codeaurora.org>
 <20150730084634.GD9319@x1>
 <CAL_JsqKQLQ15qSt95zBZykzzPhcUrtZzhk29a76n+r_3719AiA@mail.gmail.com>
 <20150731163715.GV3159@codeaurora.org>
 <20150803034642.GV899@linux>
 <20150810132247.GH3249@x1>
 <20150811080023.GB5509@linux>
 <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38452 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934059AbbHKLya (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 07:54:30 -0400
Received: by wicja10 with SMTP id ja10so65500391wic.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 04:54:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811100941.GG5509@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robherring2@gmail.com>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 11 Aug 2015, Viresh Kumar wrote:
> On 11-08-15, 10:30, Lee Jones wrote:
> > On Tue, 11 Aug 2015, Viresh Kumar wrote:
> >=20
> > > On 10-08-15, 14:22, Lee Jones wrote:
> > > > >  Optional properties:
> > > > > +- opp-cuts: One or more strings, describing the versions of =
hardware the OPPs
> > > > > +  can support.
> > > >=20
> > > > This isn't very generic.
> > > >=20
> > > > I'm guessing some vendors my have quite a few ways to different=
iate
> > > > between board versions/revisions/cuts etc.
> > > >=20
> > > > How about another array where a vendor can choose to identify a=
 piece
> > > > of hardware however they see fit.
> > > >=20
> > > > Example 1 (simple version):
> > > >=20
> > > > /* Version 1 */
> > > > opp-version =3D <1>;
> > > >=20
> > > > Example 2 (using the kernel's versioning):
> > > >=20
> > > > /* 2.6.32-rc1 */
> > > > opp-version =3D <2 6 32 1>;
> > > >=20
> > > > Example 3 (using ST's versioning):
> > > >=20
> > > > /* Major 2, Minor 0, Cut 2, All substrates */
> > > > opp-version =3D <2 0 2 0xff>;
> > >=20
> > > But how will we parse this with generic code ?
> >=20
> > Why would you want to?
>=20
> So that individual platforms don't need to reinvent the wheel ?

The framework does not need to parse this information.  It is used
solely by the platform driver, whose job it is to decide which OPPs
are appropriate for the running platform.

Back to my question; how would you like arbitrary version information,
which means different things to different vendors to be used in
shared/generic/framework code?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

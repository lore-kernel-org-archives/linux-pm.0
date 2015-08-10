From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Mon, 10 Aug 2015 14:22:47 +0100
Message-ID: <20150810132247.GH3249@x1>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux>
 <20150728225510.GB3159@codeaurora.org>
 <20150729081403.GH2284@x1>
 <20150729221526.GE3159@codeaurora.org>
 <20150730084634.GD9319@x1>
 <CAL_JsqKQLQ15qSt95zBZykzzPhcUrtZzhk29a76n+r_3719AiA@mail.gmail.com>
 <20150731163715.GV3159@codeaurora.org>
 <20150803034642.GV899@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36861 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbbHJNWx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 09:22:53 -0400
Received: by wicja10 with SMTP id ja10so36979490wic.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2015 06:22:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150803034642.GV899@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robherring2@gmail.com>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 03 Aug 2015, Viresh Kumar wrote:

> On 31-07-15, 09:37, Stephen Boyd wrote:
> > For qcom platforms, the frequency is almost always constant.
> > There may be some tables where we have a couple higher
> > frequencies than others because the speed bin is different.
> > Otherwise the voltage/current is changing based on the silicon
> > characteristics. So the biggest duplication is the frequency
> > property.
> >=20
> > As far as I know there isn't any algorithm to generate the
> > voltage values. It's all hand tuned tables based on the silicon
> > characterization, so we're left to store these tables in DT and
> > pick the right one at runtime. With regards to the table
> > explosion, on qcom platforms we haven't worried that we have ~40
> > tables, but I'm not opposed to expressing it in a smaller set of
> > nodes, tables, etc. if that's what's desired.
> >=20
> > Do we need vendor specific properties for that though? Or do we
> > need some sort of extended frequency/voltage properties that are
> > arrays of values that we can index into based on some silicon
> > characteristics? I like the name based approach because it's
> > simple. Use this OPP table because it's called
> > x-y-z-characteristics and be done. Cramming the tables into less
> > lines may save us some typing and dtb space, but I'm not sure
> > what else it does.
>=20
> What about something like this:
>=20
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Document=
ation/devicetree/bindings/opp/opp.txt
> index 0cb44dc21f97..bad7a8299b9c 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -74,6 +74,8 @@ This describes the OPPs belonging to a device. This=
 node can have following
>    reference an OPP.
> =20
>  Optional properties:
> +- opp-cuts: One or more strings, describing the versions of hardware=
 the OPPs
> +  can support.

This isn't very generic.

I'm guessing some vendors my have quite a few ways to differentiate
between board versions/revisions/cuts etc.

How about another array where a vendor can choose to identify a piece
of hardware however they see fit.

Example 1 (simple version):

/* Version 1 */
opp-version =3D <1>;

Example 2 (using the kernel's versioning):

/* 2.6.32-rc1 */
opp-version =3D <2 6 32 1>;

Example 3 (using ST's versioning):

/* Major 2, Minor 0, Cut 2, All substrates */
opp-version =3D <2 0 2 0xff>;

Qcom (or anyone else wanting to use names to identify their revisions)
can continue to use their node name method, as it doesn't break any
convention.

>  - opp-shared: Indicates that device nodes using this OPP Table Node'=
s phandle
>    switch their DVFS state together, i.e. they share clock/voltage/cu=
rrent lines.
>    Missing property means devices have independent clock/voltage/curr=
ent lines,
> @@ -100,6 +102,9 @@ properties.
>    Entries for multiple regulators must be present in the same order =
as
>    regulators are specified in device's DT node.
> =20
> +  If used with 'opp-cuts', then the number of entries present here m=
ust match
> +  the number of strings present in 'opp-cuts'.
> +
>  - opp-microamp: The maximum current drawn by the device in microampe=
res
>    considering system specific parameters (such as transients, proces=
s, aging,
>    maximum operating temperature range etc.) as necessary. This may b=
e used to
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

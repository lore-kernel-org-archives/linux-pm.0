From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/8] ARM: STi: STiH407: Provide a node for CPUFreq
Date: Tue, 23 Jun 2015 08:10:45 +0100
Message-ID: <20150623071045.GC3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-5-git-send-email-lee.jones@linaro.org>
 <20150623021622.GA16776@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37036 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbbFWHKu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 03:10:50 -0400
Received: by wicgi11 with SMTP id gi11so7119931wic.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 00:10:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150623021622.GA16776@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rob.herring@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On Tue, 23 Jun 2015, Viresh Kumar wrote:

> [Ccing Rob]

Rob is already Cc'ed.

> On 22-06-15, 16:43, Lee Jones wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/=
dts/stih407-family.dtsi
> > index f48767e..f57fd83 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -98,6 +98,11 @@
> >  		ranges;
> >  		compatible =3D "simple-bus";
> > =20
> > +		cpufreq {
> > +			compatible =3D "st,stih407-cpufreq";
> > +			st,syscfg =3D <&syscfg_core 0x8e0>;
> > +		};
>=20
> These virtual nodes aren't allowed in DT and you have added them
> before the bindings patch :).

This isn't a virtual node, but you bring up a good point.

The compatible string should also contain "syscon".

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in

From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
Date: Tue, 23 Jun 2015 08:06:51 +0100
Message-ID: <20150623070651.GA3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
 <20150623023458.GC16776@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36022 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbFWHGz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 03:06:55 -0400
Received: by wguu7 with SMTP id u7so991060wgu.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 00:06:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150623023458.GC16776@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

> [Adding Rob]

Rob is not the only DT Maintainer, there are many of them.  The DT
list was CC'ed, which they are all part of.  Adding them all
separately is not required IMO.

> On 22-06-15, 16:43, Lee Jones wrote:
>=20
> At least some description was required here on why you need additiona=
l
> bindings are what are they.

Sure, I can do that.

> Over that, this patch should have been present before any other
> patches using these bindings.

I've never heard that one before, but it's easy to re-order the set.

> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 48 ++++++++++=
++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufr=
eq-st.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.t=
xt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> > new file mode 100644
> > index 0000000..cfa8952
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> > @@ -0,0 +1,48 @@
> > +Binding for ST's CPUFreq driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> OPP-v2 bindings are out now and you can probably use them to make lif=
e
> simple, they are part of Rafael's recent pull request:
> https://lkml.org/lkml/2015/6/22/606
>=20
> > +Required properties:
> > +-------------------
> > +- compatible		: Supported values are:
> > +				"st,stih407-cpufreq"
>=20
> Nodes for virtual devices aren't allowed in DT.

Then why do Exynos, Spear, HREF and Snowball have CPUFreq nodes?

One rule for one ... ?

> > +Required properties [for working voltage scaling]:
> > +-------------------------------------------------
> > +
> > +Located in CPUFreq's node:
> > +
> > +- st,syscfg		: Phandle to Major number register
> > +				First cell: offset to major number
> > +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> > +				First cell: offset to process code
> > +				Second cell: offset to minor number
> > +
> > +Located in CPU's node:
> > +
> > +- st,opp-list		: Bootloader provided node containing one or more '=
opp@X' sub-nodes
>=20
> I can see that this will be passed in from the bootloader. But at
> least an example on how exactly things would actually look would have
> been good. In logs if not in this file.

Sure.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in

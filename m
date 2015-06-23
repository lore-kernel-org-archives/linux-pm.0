From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
Date: Tue, 23 Jun 2015 09:38:56 +0100
Message-ID: <20150623083856.GH3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
 <20150623023458.GC16776@linux>
 <20150623070651.GA3245@x1>
 <20150623075509.GF16776@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34278 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbbFWIjC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 04:39:02 -0400
Received: by wgqq4 with SMTP id q4so3039207wgq.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 01:39:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150623075509.GF16776@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On Tue, 23 Jun 2015, Viresh Kumar wrote:
> On 23-06-15, 08:06, Lee Jones wrote:
> > > [Adding Rob]
> >=20
> > Rob is not the only DT Maintainer, there are many of them.  The DT
> > list was CC'ed, which they are all part of.  Adding them all
> > separately is not required IMO.
>=20
> I didn't Cc him because you missed him, but because we have been
> discussing opp-v2 bindings recently and this was somehow related to
> that. :)

Okay, fair point.

> > > On 22-06-15, 16:43, Lee Jones wrote:
> > >=20
> > > At least some description was required here on why you need addit=
ional
> > > bindings are what are they.
> >=20
> > Sure, I can do that.
> >=20
> > > Over that, this patch should have been present before any other
> > > patches using these bindings.
> >=20
> > I've never heard that one before, but it's easy to re-order the set=
=2E
>=20
> I don't know, but it seems obvious to me: Bindings first and then the
> code.

Do you always write your documentation before implementing a
feature?

Surely it goes;
  Requirements Gathering
  Plan and Prepare
  Implement
  Test
  Document
  Deliver

;)

=2E.. but as I say, I can re-order if required.  It's really not a prob=
lem.

> > > > +Required properties:
> > > > +-------------------
> > > > +- compatible		: Supported values are:
> > > > +				"st,stih407-cpufreq"
> > >=20
> > > Nodes for virtual devices aren't allowed in DT.
> >=20
> > Then why do Exynos, Spear, HREF and Snowball have CPUFreq nodes?
> >=20
> > One rule for one ... ?
>=20
> Not really, but I got a bit confused now with your reply.
>=20
> So, what I meant when I wrote: "Nodes for virtual devices aren't
> allowed in DT", was that we aren't supposed to do something like:
>=20
> cpufreq {
>  ...
> }
>=20
> in DT as cpufreq isn't a device here. A CPU is a device and that can
> contain whatever property we feel is reasonable.
>=20
> What SPEAr and Exyons did was putting something in the cpu-node. Not =
a
> node for cpufreq device itself. Couldn't find HREF and snowball's
> bindings though..

That's not what it looks like to me:

git grep -C20 "compatible.*cpufreq" -- arch

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

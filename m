From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
Date: Tue, 23 Jun 2015 09:59:06 +0100
Message-ID: <20150623085906.GI3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
 <20150623023458.GC16776@linux>
 <20150623070651.GA3245@x1>
 <20150623075509.GF16776@linux>
 <20150623083856.GH3245@x1>
 <CABxcv=nRiPkC8wXt02LhFF+0CGjAMKusNWGQLbL+RrvsFS1iMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35341 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbbFWI7L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 04:59:11 -0400
Received: by wgbhy7 with SMTP id hy7so3467503wgb.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 01:59:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABxcv=nRiPkC8wXt02LhFF+0CGjAMKusNWGQLbL+RrvsFS1iMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ajitpal.singh@st.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 23 Jun 2015, Javier Martinez Canillas wrote:

> Hello Lee and Viresh,
>=20
> On Tue, Jun 23, 2015 at 10:38 AM, Lee Jones <lee.jones@linaro.org> wr=
ote:
> > On Tue, 23 Jun 2015, Viresh Kumar wrote:
> >> On 23-06-15, 08:06, Lee Jones wrote:
> >> >
> >> > > Over that, this patch should have been present before any othe=
r
> >> > > patches using these bindings.
> >> >
> >> > I've never heard that one before, but it's easy to re-order the =
set.
> >>
> >> I don't know, but it seems obvious to me: Bindings first and then =
the
> >> code.
> >
> > Do you always write your documentation before implementing a
> > feature?
> >
> > Surely it goes;
> >   Requirements Gathering
> >   Plan and Prepare
> >   Implement
> >   Test
> >   Document
> >   Deliver
> >
> > ;)
> >
> > ... but as I say, I can re-order if required.  It's really not a pr=
oblem.
> >
>=20
> This is actually documented in
> Documentation/devicetree/bindings/submitting-patches.txt:
> ...
>=20
>   3) The Documentation/ portion of the patch should come in the serie=
s before
>      the code implementing the binding.
>=20
> ....
>=20
> The rationale AFAIU is that it is easier to review the implementation
> of a binding after reading the DT binding doc since then you can see
> if the code matches what the DT binding describes.

=46air enough.  Can't argue with that. :)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

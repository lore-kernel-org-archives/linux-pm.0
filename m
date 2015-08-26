From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 26 Aug 2015 13:06:28 +0100
Message-ID: <20150826120628.GZ19409@x1>
References: <20150810132247.GH3249@x1>
 <20150811080023.GB5509@linux>
 <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux>
 <20150811115425.GE18282@x1>
 <20150811120124.GH5509@linux>
 <20150811132756.GG18282@x1>
 <20150811142812.GJ5509@linux>
 <20150811151736.GO18282@x1>
 <20150812110841.GC20238@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34890 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbHZMGe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 08:06:34 -0400
Received: by wicne3 with SMTP id ne3so42732600wic.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2015 05:06:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150812110841.GC20238@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robherring2@gmail.com>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 12 Aug 2015, Viresh Kumar wrote:

> On 11-08-15, 16:17, Lee Jones wrote:
> > This would work if we only had a single variable to contend with, b=
ut
> > what I showed you in my previous example is that we have 3 variable=
s
> > to consider; cut (version), pcode and substrate.
> >=20
> > Using the two (simple) examples I provided, how would your suggesti=
on
> > look in our case?
>=20
> So the solution I gave is for picking the microvolt based on pcode.
> The other two (cut, substrate) aren't about picking microvolt, but if
> the OPP is available or not. Right?

'pcode', 'cut' and 'substrate' all determine whether a given set of
OPPs an be used on the running platform.  I do not believe that you
can differentiate between them.=20

> If these terms are generic enough, then we can add something similar
> to what you have added..

If it makes it easier, you can treat them as version numbers 2.2.1
<pcode.cut.substrate>, but I don't see how this can help.  Obviously
this becomes more difficult when you add wild cards to the OPPs, where
a particular OPP would be suitable for all cuts for example.

If you still think you can come up with a generic method to lay out
CPUFreq OPP nodes that will satisfy all vendors and not be a mass of
10's of separate nodes, then great.  Again, I'm struggling to see how
that might be possible.

What I believe we shouldn't do, is have this blocked forever for the
sake of adding a couple of vendor properties however.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

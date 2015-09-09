From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 9 Sep 2015 17:36:20 +0100
Message-ID: <20150909163620.GF3260@x1>
References: <20150811151736.GO18282@x1>
 <20150812110841.GC20238@linux>
 <20150826120628.GZ19409@x1>
 <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux>
 <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux>
 <20150909133930.GE3260@x1>
 <20150909160212.GJ5266@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36708 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbbIIQgZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 12:36:25 -0400
Received: by wicgb1 with SMTP id gb1so123569989wic.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 09:36:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150909160212.GJ5266@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> > Or have I got the wrong end of the stick?
> >=20
> > NB: Note the suggested new property names.
>=20
> Yeah, all looks fine to me.

I think these names are better:

  opp-supply-range-name =3D> opp-microvolt-names
  opp-cuts              =3D> opp-supported-hw

Apart from that, the binding is starting to come together.

Let's see what Rob and Stephen have to say about it.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

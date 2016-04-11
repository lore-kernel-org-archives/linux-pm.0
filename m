From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] PM / Domains: Define DT bindings for PM QoS device
 latencies
Date: Mon, 11 Apr 2016 08:29:42 -0500
Message-ID: <20160411132942.GA1519@rob-hp-laptop>
References: <1459432226-22562-1-git-send-email-ulf.hansson@linaro.org>
 <20160401184429.GA18950@rob-hp-laptop>
 <CAPDyKFombK0Kv-r40xbTm=Y3q07bM5woOPB63xzbrck37Vxrqw@mail.gmail.com>
 <20160407175704.GA32257@rob-hp-laptop>
 <CAPDyKFrdbxuT9kh-j1_RDjCovq80=g_q4USzYxPQgPch1sm08A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41684 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167AbcDKN3x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Apr 2016 09:29:53 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrdbxuT9kh-j1_RDjCovq80=g_q4USzYxPQgPch1sm08A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Apr 08, 2016 at 01:19:36PM +0200, Ulf Hansson wrote:
> [...]
> 
> >> >
> >> > Shouldn't this be split into latency of the domain (and in the domain's
> >> > node) and latency of the device?
> >>
> >> Yes! $Subject patch only takes device latencies into account.
> >>
> >> Perhaps what you mean is that we should document device PM QoS
> >> latencies in another place than
> >> Documentation/devicetree/bindings/power/power_domain.txt as well?
> >
> > Yes, the location is confusing that this is device latency which has
> > nothing to do with power domains other than the fact we've lost all
> > state (which a reset could cause too).
> 
> Okay, will a new file,
> Documentation/devicetree/bindings/power/device_qos.txt make sense for
> you?
> 
> >
> >> Regarding bindings for the domain latencies, I will post that as a
> >> separate patch soonish.
> >
> > It probably makes sense to look at latency bindings as a whole series.
> 
> Well, unless you insist, I would rather look at this first.
> 
> The domain latencies might be a bit more complex and those shouldn't
> affect how we describe device latencies, or you think so?

Probably not, but I was thinking at least property names would be 
common. Besides power domains, any external component can add latencies. 
For example, what's the latency for a display (subsystem) when you have 
display controller, phy, external bridge and panel? What I don't want to 
see in DT are people doing some simple latency that's added up all the 
components and then coming back later and saying they need to change it 
to be more fine grained and distributed to each component. 

Rob

> 
> Kind regards
> Uffe

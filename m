From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] PM / Domains: Define DT bindings for PM QoS device
 latencies
Date: Thu, 7 Apr 2016 12:57:04 -0500
Message-ID: <20160407175704.GA32257@rob-hp-laptop>
References: <1459432226-22562-1-git-send-email-ulf.hansson@linaro.org>
 <20160401184429.GA18950@rob-hp-laptop>
 <CAPDyKFombK0Kv-r40xbTm=Y3q07bM5woOPB63xzbrck37Vxrqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60154 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932242AbcDGR5O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Apr 2016 13:57:14 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFombK0Kv-r40xbTm=Y3q07bM5woOPB63xzbrck37Vxrqw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Apr 04, 2016 at 11:42:04AM +0200, Ulf Hansson wrote:
> On 1 April 2016 at 20:44, Rob Herring <robh@kernel.org> wrote:
> > On Thu, Mar 31, 2016 at 03:50:25PM +0200, Ulf Hansson wrote:
> >> PM QoS device latencies are properties of the hardware. Let's define some
> >> DT bindings for them.
> >>
> >> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> >> index 025b5e7..b101a20 100644
> >> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> >> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> >> @@ -65,12 +65,18 @@ Required properties:
> >>   - power-domains : A phandle and PM domain specifier as defined by bindings of
> >>                     the power controller specified by phandle.
> >>
> >> +Optional properties:
> >> + - suspend-latency: Suspend latency of the device in ns.
> >> + - resume-latency: Resume latency of the device in ns.
> >
> > The names are a bit Linux specific, but I don't have a better
> > suggestion. Could be power-up/down, but then you may have other
> > latencies such as link up times.
> >
> > Whatever we end up with, add a unit suffix (-ns).
> 
> Okay.
> 
> >
> > Shouldn't this be split into latency of the domain (and in the domain's
> > node) and latency of the device?
> 
> Yes! $Subject patch only takes device latencies into account.
> 
> Perhaps what you mean is that we should document device PM QoS
> latencies in another place than
> Documentation/devicetree/bindings/power/power_domain.txt as well?

Yes, the location is confusing that this is device latency which has 
nothing to do with power domains other than the fact we've lost all 
state (which a reset could cause too).

> Regarding bindings for the domain latencies, I will post that as a
> separate patch soonish.

It probably makes sense to look at latency bindings as a whole series.

Rob

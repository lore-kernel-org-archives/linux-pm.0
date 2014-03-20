From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states infrastructure
Date: Thu, 20 Mar 2014 11:19:40 -0700
Message-ID: <CADHgK6vGf0gfVoAWO2FiXzCf-Sf_P_u+d7Dg04xn1O5t2LeKwg@mail.gmail.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
	<CAL_Jsq+M8fCreXrd7R1m=3_LKD_+jma3Pha06hRoTPMpcOb1_g@mail.gmail.com>
	<20140318180856.GB792@e102568-lin.cambridge.arm.com>
	<CADHgK6uwUDndVHQaWU=3R7A16hc4PYJCAfMLi3uBnrDjYidPXg@mail.gmail.com>
	<20140319172338.GA31368@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:61141 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbaCTSTl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Mar 2014 14:19:41 -0400
Received: by mail-wg0-f41.google.com with SMTP id n12so884552wgh.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2014 11:19:40 -0700 (PDT)
In-Reply-To: <20140319172338.GA31368@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robherring2@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <t.figa@samsu>

On 19 March 2014 10:23, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> Rob is asking a property describing hw, and honestly unless we define
> a power consumption property value (defining what it means will be rather
> complicated though) I'd rather remove index altogether and use min_residency
> as a comparison value instead.

I like having a separate ranking for power to sort the states.  To me
it seems that min residency could be ambiguous for this.  We could
have states with inverted min_residencies: where a lower consumption
state has a lower target residency because the cost is recovered more
quickly.  Such a state might have higher latency for exit, so even
though the lower min_residency/lower power state is clearly
preferable, selection of the lower power state may be prevented by
kernel latency constraints.

Thanks,

Sebastian

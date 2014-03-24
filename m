From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states infrastructure
Date: Mon, 24 Mar 2014 12:46:47 -0500
Message-ID: <CAL_JsqJikdsna7KUjEwZ0qj-fdcC50M7e3e1D0LgfQuUuJQ0SA@mail.gmail.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
	<CAL_Jsq+M8fCreXrd7R1m=3_LKD_+jma3Pha06hRoTPMpcOb1_g@mail.gmail.com>
	<20140318180856.GB792@e102568-lin.cambridge.arm.com>
	<CADHgK6uwUDndVHQaWU=3R7A16hc4PYJCAfMLi3uBnrDjYidPXg@mail.gmail.com>
	<20140319172338.GA31368@e102568-lin.cambridge.arm.com>
	<CADHgK6vGf0gfVoAWO2FiXzCf-Sf_P_u+d7Dg04xn1O5t2LeKwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:36548 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbaCXRqt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Mar 2014 13:46:49 -0400
In-Reply-To: <CADHgK6vGf0gfVoAWO2FiXzCf-Sf_P_u+d7Dg04xn1O5t2LeKwg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>Tomasz Figa <t.>

On Thu, Mar 20, 2014 at 1:19 PM, Sebastian Capella
<sebastian.capella@linaro.org> wrote:
> On 19 March 2014 10:23, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> Rob is asking a property describing hw, and honestly unless we define
>> a power consumption property value (defining what it means will be rather
>> complicated though) I'd rather remove index altogether and use min_residency
>> as a comparison value instead.
>
> I like having a separate ranking for power to sort the states.  To me
> it seems that min residency could be ambiguous for this.  We could
> have states with inverted min_residencies: where a lower consumption
> state has a lower target residency because the cost is recovered more
> quickly.  Such a state might have higher latency for exit, so even
> though the lower min_residency/lower power state is clearly
> preferable, selection of the lower power state may be prevented by
> kernel latency constraints.

Perhaps you can add the min residency and exit latency times.

Another piece to consider is the affinity level of the state should
probably be the basis for 1st order sorting.

Rob

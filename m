From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v5 1/8] Documentation: arm: define DT idle states bindings
Date: Thu, 26 Jun 2014 13:32:52 -0500
Message-ID: <CAL_Jsq+F9i3v9CNSUKZcmHfH6bPv=475Qrs-Rbdp6Y=tVHO5Qg@mail.gmail.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20140625145849.GC15240@leverpostej> <20140625173745.GC15050@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:36332 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbaFZSdN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jun 2014 14:33:13 -0400
In-Reply-To: <20140625173745.GC15050@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@sam>

On Wed, Jun 25, 2014 at 12:37 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Jun 25, 2014 at 03:58:49PM +0100, Mark Rutland wrote:
>> Hi Lorenzo,
>>
>> On Wed, Jun 25, 2014 at 03:10:14PM +0100, Lorenzo Pieralisi wrote:
>> > ARM based platforms implement a variety of power management schemes that
>> > allow processors to enter idle states at run-time.
>> > The parameters defining these idle states vary on a per-platform basis forcing
>> > the OS to hardcode the state parameters in platform specific static tables
>> > whose size grows as the number of platforms supported in the kernel increases
>> > and hampers device drivers standardization.
>> >
>> > Therefore, this patch aims at standardizing idle state device tree bindings for
>> > ARM platforms. Bindings define idle state parameters inclusive of entry methods
>> > and state latencies, to allow operating systems to retrieve the configuration
>> > entries from the device tree and initialize the related power management
>> > drivers, paving the way for common code in the kernel to deal with idle
>> > states and removing the need for static data in current and previous kernel
>> > versions.
>> >
>> > Reviewed-by: Sebastian Capella <sebcape@gmail.com>
>> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> > ---
>> >  Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
>> >  .../devicetree/bindings/arm/idle-states.txt        | 733 +++++++++++++++++++++
>> >  2 files changed, 741 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt
>>
>> [...]


>> > +       - power-rank
>> > +               Usage: Required
>> > +               Value type: <u32>
>> > +               Definition: It represents the idle state power-rank.
>> > +                           An increasing value implies less power
>> > +                           consumption. It must be given a sequential
>> > +                           value = {0, 1, ....}, starting from 0.
>> > +                           Phandles in the cpu nodes [1] cpu-idle-states
>> > +                           array property are not allowed to point at idle
>> > +                           state nodes having the same power-rank value.
>>
>> Why can't this be implicit in the order of the cpu-idle-states list?
>> That way it's impossible to violate the ordering requirement.
>
> You mean the phandles list in the cpu nodes ? Maybe, but this would
> require the list to be the same order for all cpu nodes on which the
> idle states are valid, or just take one and use that.
>
> It can be viable, as long as everyone agrees, every time I post this
> code someone comes up with a new idea on how to sort the states and
> honestly I would like to be done with that.

power-rank feels like an index in disguise. I agree with the phandle
list defining the order.

>> > +       - entry-method-param
>> > +               Usage: See definition.
>> > +               Value type: <u32>
>> > +               Definition: Depends on the idle-states node entry-method
>> > +                           property value. Refer to the entry-method bindings
>> > +                           for this property value definition.
>>
>> Should this not be left up to the particular mechanism to describe?
>> e.g. for PSCI we could have a arm,psci-suspend-param property.
>
> It was like that in early postings, and probably was better than the
> current definition. I need to think about that but I am almost convinced
> you are right.

I think arm,psci-suspend-param is the right way to go.

Rob

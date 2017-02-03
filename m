From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
Date: Fri, 3 Feb 2017 12:06:52 -0800
Message-ID: <20170203200652.GD25384@codeaurora.org>
References: <20170119002933.7529-1-code@mmayer.net>
 <20170119002933.7529-2-code@mmayer.net>
 <20170121005202.GB8801@codeaurora.org>
 <CAGt4E5sGScHp83ufKcX3Q74vW0fo=L0FHM7tCptvqJfchHAweg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGt4E5sGScHp83ufKcX3Q74vW0fo=L0FHM7tCptvqJfchHAweg@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Markus Mayer <markus.mayer@broadcom.com>
Cc: Markus Mayer <code@mmayer.net>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/01, Markus Mayer wrote:
> On 20 January 2017 at 16:52, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >
> > Are these properties used? Please don't put these types of
> > details in DT.
> 
> Yeah, unfortunately they are. Luckily, I think the issue can be
> resolved quite easily, because the user of those properties isn't
> involved in this series.
> 
> They are currently being used by a clock driver
> ("drivers/clk/clk-brcmstb.c") that hasn't been upstreamed yet. I
> performed some code archeology. While I wasn't 100% successful in
> tracking down the origins of this interface, it looks like it was
> designed this way a while back (4+ years or so), probably before
> device tree best practices were developed or, at least, before they
> were widely known.
> 
> So, what I can do is to remove the properties from the official
> binding. (I'll send an update to that effect shortly.) Once the
> binding is accepted upstream, we can work on fixing up the design of
> clk-brcmstb.c, so it doesn't rely on these properties anymore (and
> derives them from the compatible string instead), and then proceed to
> upstream that, as well.

Ok. Sounds like some cleanup needs to be done on the way
upstream.

> > This register really looks like some offset in something larger.
> > Is there some clock controller? What's the hw block at
> > 0xf03e2000? Maybe I already asked this.
> 
> It looks this way, but in this case, looks are deceiving. The address
> and the length are really correct the way they are.
> 
> This memory area holds a range of only loosely related configuration
> registers. It's called the Bus Interface Unit Register Set and deals
> with configuring the CPU in general. At address 0xf03e257c, there
> happens to be the clock divider register we need, and it's really just
> one register, i.e. 4 bytes.

We've seen this style of hardware design before. I'd prefer we
make the "Bus Interface Unit Register Set" into one device node
and have a driver probe for it that registers this clock. If
other things need to be controlled in there then the driver will
do more than just register one clock, possibly hooking into
multiple frameworks. The compatible string can indicate which SoC
it is if the divider register offset changes or if the register
layout is a total free for all.

Either way, having reg properties end in non-zero values is
suspect on ARM systems because a device is usually aligned to at
least a 1k boundary for proper CPU addressing and mapping of the
device. We can't possibly make a smaller mapping than a page
anyway, so the registers around this one register will need to be
mapped with the same attributes, hence the desire to make one
device for the hardware block.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

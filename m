From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
Date: Mon, 6 Feb 2017 17:04:26 -0800
Message-ID: <20170207010426.GO25384@codeaurora.org>
References: <20170119002933.7529-1-code@mmayer.net>
 <20170119002933.7529-2-code@mmayer.net>
 <20170121005202.GB8801@codeaurora.org>
 <CAGt4E5sGScHp83ufKcX3Q74vW0fo=L0FHM7tCptvqJfchHAweg@mail.gmail.com>
 <20170203200652.GD25384@codeaurora.org>
 <d56c827e-41cf-fcb3-42e0-792e8bf37871@gmail.com>
 <20170206225914.GJ25384@codeaurora.org>
 <a1a11072-908b-352e-a49f-49240d430df9@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a1a11072-908b-352e-a49f-49240d430df9@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Markus Mayer <markus.mayer@broadcom.com>, Markus Mayer <code@mmayer.net>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/06, Florian Fainelli wrote:
> On 02/06/2017 02:59 PM, Stephen Boyd wrote:
> > On 02/03, Florian Fainelli wrote:
> >>
> >> We already have another piece of drive code that manipulates registers
> >> in the Bus Interface Unit located in drivers/soc/bcm/brcmstb/biuctrl.c
> >> and which has little to nothing to do with the CPU's clock ratio. And
> >> actually another one being submitted that deals with the CPU's
> >> read-ahead cache. I would very much prefer we keep all of them separate
> >> and dealing with just the register offset they need to do, but that does
> >> not mean the Device Tree binding has to look that way though.
> >>
> >> The binding for the BIUCTRL register made it here:
> >>
> >> Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
> >>
> >> so we should re-use that, and have a small piece of clock provided that
> >> just uses the relevant register range within that larger register space
> >> and provide the CLOCK_RATIO. Does that work?
> >>
> > 
> > Ok. That's fine. The existing binding will be updated to include
> > this new subnode then for the clock component?
> 
> Humm, I suppose we could do that yes, my original thought was to just
> have this CPU clock provider remap the entire BIUCTRL register range
> (of_iomap() etc.) and manipulate just the relevant register range of
> interest (CPU_CLOCK_CONFIG_REG), but if you want a sub-node to appear,
> we could probably do that as well.

One node is fine as well. I thought the plan was many subnodes
based on the binding document you mentioned earlier.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

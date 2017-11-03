From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] pinctrl: Allow indicating loss of state across
 suspend/resume
Date: Fri, 3 Nov 2017 09:11:20 -0700
Message-ID: <20171103161120.GH28152@atomide.com>
References: <20171102231551.16220-1-f.fainelli@gmail.com>
 <20171103103707.3e5wb3c7foxbuvvg@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171103103707.3e5wb3c7foxbuvvg@localhost.localdomain>
Sender: linux-gpio-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, ckeepax@opensource.wolfsonmicro.com, swarren@nvidia.com, andy.shevchenko@gmail.com, alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* Charles Keepax <ckeepax@opensource.cirrus.com> [171103 10:38]:
> On Thu, Nov 02, 2017 at 04:15:49PM -0700, Florian Fainelli wrote:
> > Hello Linus,
> > 
> > It's me again, so I have been thinking about the problem originally
> > reported in: [PATCH fixes v3] pinctrl: Really force states during suspend/resume
> > 
> > and other similar patches a while ago, and this new version allows a platform
> > using pinctrl-single to specify whether its pins are going to lose their state
> > during a system deep sleep.
> > 
> > Note that this is still checked at the pinctrl_select_state() because consumers
> > of the pinctrl API might be calling this from their suspend/resume functions
> > and should not have to know whether the provider does lose its pin states.
> > 
> 
> Still feels to me like it should be the providers job to the
> restore the state rather than expecting the consumer to
> re-request any state it had. But lets wait and see what Linus
> thinks.

But isn't it the consumer device losing it's state here? Or the
pinctrl provider losing it's state?

Anyways, the context lost flag should be managed in the PM core for
the device, so adding linux-pm and Rafael to Cc.

Regards,

Tony

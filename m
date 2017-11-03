From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] pinctrl: Allow indicating loss of state across
 suspend/resume
Date: Fri, 3 Nov 2017 10:33:53 -0700
Message-ID: <20171103173353.GJ28152@atomide.com>
References: <20171102231551.16220-1-f.fainelli@gmail.com>
 <20171103103707.3e5wb3c7foxbuvvg@localhost.localdomain>
 <20171103161120.GH28152@atomide.com>
 <da808465-dc64-6c33-0be6-e038e0f84bce@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <da808465-dc64-6c33-0be6-e038e0f84bce@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, ckeepax@opensource.wolfsonmicro.com, swarren@nvidia.com, andy.shevchenko@gmail.com, alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* Florian Fainelli <f.fainelli@gmail.com> [171103 17:04]:
> On 11/03/2017 09:11 AM, Tony Lindgren wrote:
> The pinctrl provider is losing its state, hence these two patches.

OK

> > Anyways, the context lost flag should be managed in the PM core for
> > the device, so adding linux-pm and Rafael to Cc.
> 
> I don't think it's that simple but sure, why not.

Just having bool context_lost in struct dev_pm_info would probably
be enough to allow drivers to deal with it. This flag could then
be set for a device by power domain related code that knows if
context got lost.

Anybody got better ideas?

Regards,

Tony

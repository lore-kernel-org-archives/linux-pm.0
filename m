From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
Date: Fri, 16 Feb 2018 08:54:57 -0800
Message-ID: <20180216165456.GV6364@atomide.com>
References: <20180209161456.18951-1-tony@atomide.com>
 <CAHp75VcSRxLZJxmqXWpAGypvZa6W2cEAiTF2muJWqdaOYu_TpA@mail.gmail.com>
 <CAJZ5v0gRtkBf7uu4C_k7ivNGo=JM0bB1PAdr_6Nbbs39OPevHw@mail.gmail.com>
 <CAHp75VcVNDV9FmPFTBHsJRoiHtOviwC68Wk+aCqhqteZw41ZzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcVNDV9FmPFTBHsJRoiHtOviwC68Wk+aCqhqteZw41ZzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [180216 10:40]:
> Sorry, I was thinking that Tony may test it first to see if it does
> what he wants.

Well using dev_name() for the wakeirq name might still conflict
with the device IO interrupt. But yeah I'll give it a try.

Regards,

Tony

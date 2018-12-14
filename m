From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 0/7] PM / Domains: Allow performance state propagation
Date: Fri, 14 Dec 2018 15:49:43 +0530
Message-ID: <20181214101943.3hfktljrdu6yw7aq@vireshk-i7>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
 <CAJZ5v0h9WCmBNB2K5pd6Z9VnFK4tcT5uVxmP36wHxqM5SkdXYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h9WCmBNB2K5pd6Z9VnFK4tcT5uVxmP36wHxqM5SkdXYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, niklas.cassel@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14-12-18, 11:18, Rafael J. Wysocki wrote:
> On Fri, Dec 14, 2018 at 11:15 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hi,
> >
> > This series adds performance state propagation support in genpd core.
> > The propagation happens from the sub-domains to their masters. More
> > details can be found in the individual commit logs.
> >
> > This is tested on hikey960 by faking power domains in such a way that
> > the CPU devices have two power domains and both of them have the same
> > master domain. The CPU device, as well as its power domains have
> > "required-opps" property set and the performance requirement from the
> > CPU eventually configures all the domains (2 sub-domains and 1 master).
> >
> > Based on opp/linux-next branch (which is 4.20-rc1 +
> > multiple-power-domain-support-in-opp-core + some OPP fixes).
> >
> > Rajendra has already tested the previous version of this series and so I
> > have included his Tested-by for all patches.
> 
> I'm assuming that this set will go in via the OPP tree.

Yes.

-- 
viresh

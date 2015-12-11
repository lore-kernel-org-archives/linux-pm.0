From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/2] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Date: Fri, 11 Dec 2015 07:11:46 +0530
Message-ID: <20151211014146.GE3612@ubuntu>
References: <cover.1449627691.git.viresh.kumar@linaro.org>
 <e3744c43a5ad26e9e49cf938b3ecd846cc500fce.1449627691.git.viresh.kumar@linaro.org>
 <CAF2Aj3h6u5W+H0shc+MwPpfb8spwXBZYr1+m4w62PpiHk=50UA@mail.gmail.com>
 <4979368.7DaYzKUvM2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4979368.7DaYzKUvM2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lee Jones <lee.jones@linaro.org>, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10-12-15, 22:45, Rafael J. Wysocki wrote:
> On Thursday, December 10, 2015 09:54:45 AM Lee Jones wrote:
> > On 9 December 2015 at 02:31, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > OPP bindings (for few properties) allow a platform to choose a
> > > value/range among a set of available options. The options are present as
> > > opp-<prop>-<name>, where the platform needs to supply the <name> string.
> > >
> > > The OPP properties which allow such an option are: opp-microvolt and
> > > opp-microamp.
> > >
> > > Add support to the OPP-core to parse these bindings, by introducing
> > > dev_pm_opp_{set|put}_prop_name() APIs.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/base/power/opp/core.c | 165 ++++++++++++++++++++++++++++++++++++++----
> > >  drivers/base/power/opp/opp.h  |   2 +
> > >  include/linux/pm_opp.h        |   9 +++
> > >  3 files changed, 161 insertions(+), 15 deletions(-)
> > 
> > Tested-by: Lee Jones <lee.jones@linaro.org>
> 
> OK, so tentatively I can take these two.
> 
> What exectly does depend on them and how that thing is intended to be handled?

The other two patches from Lee, Perhaps he missed mentioning that in
his cover-letter.

[PICKME 0/2] cpufreq: New ST driver

They must be rebased on my patches as they use the new APIs defined
here.

-- 
viresh

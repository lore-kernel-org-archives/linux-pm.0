From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Drop gov_cancel_work()
Date: Fri, 10 Jun 2016 08:28:25 +0530
Message-ID: <20160610025825.GD17903@vireshk-i7>
References: <31871585.32WEDJA5Kj@vostro.rjw.lan>
 <20160609032100.GB9356@vireshk-i7>
 <CAJZ5v0i5Tf+KsLRSO7A0PanPjG1XenzLpZopfOAYH-3cLbjTbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5Tf+KsLRSO7A0PanPjG1XenzLpZopfOAYH-3cLbjTbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09-06-16, 14:21, Rafael J. Wysocki wrote:
> On Thu, Jun 9, 2016 at 5:21 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 09-06-16, 01:45, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> There's no reason for gov_cancel_work() to exist at all, as it only
> >> has one caller and the only thing done by that caller is to invoke
> >> gov_cancel_work().
> >>
> >> Accordingly, drop gov_cancel_work() and move its contents to the
> >> caller.
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> >>  drivers/cpufreq/cpufreq_governor.c |   19 +++++++------------
> >>  1 file changed, 7 insertions(+), 12 deletions(-)
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Thanks!
> 
> > I am wondering what happened to your other patches around the governor callbacks
> > and why weren't they applied yet :)
> 
> They are in linux-next now, aren't they?

Yeah, they are in now.

-- 
viresh

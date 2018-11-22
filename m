From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Date: Thu, 22 Nov 2018 11:38:39 +0530
Message-ID: <20181122060839.socq3vuaa4ycftzn@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
 <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
 <20181121051718.a5yo3ibhaihgrwra@vireshk-i7>
 <20181121060622.blnlvydbc4wo5y3y@vireshk-i7>
 <0b40a76d-f779-391a-2770-4a3d368679a9@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b40a76d-f779-391a-2770-4a3d368679a9@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 21-11-18, 11:48, Rajendra Nayak wrote:
> 
> 
> On 11/21/2018 11:36 AM, Viresh Kumar wrote:
> > On 21-11-18, 10:47, Viresh Kumar wrote:
> > > On 21-11-18, 10:34, Rajendra Nayak wrote:
> > > > 
> > > > 
> > > > On 11/5/2018 12:06 PM, Viresh Kumar wrote:
> > > > > Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> > > > > be used to translate from pstate of a device to another one.
> > > > > 
> > > > > Initially this will be used by genpd to find pstate of a master domain
> > > > > using its sub-domain's pstate.
> > > > > 
> > > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > ---
> > > > >    drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
> > > > >    include/linux/pm_opp.h |  7 ++++++
> > > > >    2 files changed, 56 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > > > index 0eaa954b3f6c..010a4268e8dd 100644
> > > > > --- a/drivers/opp/core.c
> > > > > +++ b/drivers/opp/core.c
> > > > > @@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
> > > > >    		dev_err(virt_dev, "Failed to find required device entry\n");
> > > > >    }
> > > > > +/**
> > > > > + * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> > > > > + * @src_table: OPP table which has dst_table as one of its required OPP table.
> > > > 
> > > > So I have a case where the src_table and dst_table are shared/same. Can you explain how would
> > > > it work in such a case?
> > > 
> > > Can you give the example, as I am finding some issues with such shared
> > > tables. Though the code may work just fine btw.
> > 
> > I may have found the problem you are facing here. Please try this diff
> > and tell me if you hitting it, check this in dmesg.
> 
> Yes, I do seem to be hitting this.

So there are few complexities in the case where an OPP table points to itself in
the required-opp field. I looked at solving it up in the opp core but that gets
more and more messy.

Now there is actually a assumption within the OPP core. Your Mx domain should
get initialized before the Cx domain, as that is when the OPP tables are created
as well. This is because Cx's OPP table will point to Mx's OPP table (doesn't
matter if they share the same table or not) and so Mx's OPP table should come
first.

Can you check if that is already the case for you? If not, please try doing it
and lemme know if it works. It should.

I just want to avoid too much complexity in OPP core without much use.

-- 
viresh

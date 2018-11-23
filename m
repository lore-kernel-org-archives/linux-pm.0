From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Date: Fri, 23 Nov 2018 15:25:44 +0530
Message-ID: <20181123095544.qu4r6hjd2hakitth@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
 <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
 <20181121051718.a5yo3ibhaihgrwra@vireshk-i7>
 <20181121060622.blnlvydbc4wo5y3y@vireshk-i7>
 <0b40a76d-f779-391a-2770-4a3d368679a9@codeaurora.org>
 <20181122060839.socq3vuaa4ycftzn@vireshk-i7>
 <20181123091118.x73s345xhhr4simo@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123091118.x73s345xhhr4simo@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23-11-18, 14:41, Viresh Kumar wrote:
> On 22-11-18, 11:38, Viresh Kumar wrote:
> > So there are few complexities in the case where an OPP table points to itself in
> > the required-opp field. I looked at solving it up in the opp core but that gets
> > more and more messy.
> > 
> > Now there is actually a assumption within the OPP core. Your Mx domain should
> > get initialized before the Cx domain, as that is when the OPP tables are created
> > as well. This is because Cx's OPP table will point to Mx's OPP table (doesn't
> > matter if they share the same table or not) and so Mx's OPP table should come
> > first.
> > 
> > Can you check if that is already the case for you? If not, please try doing it
> > and lemme know if it works. It should.
> > 
> > I just want to avoid too much complexity in OPP core without much use.
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 7f338d39809a..09df3fbdb555 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1734,7 +1734,7 @@ unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>         int i;
>  
>         for (i = 0; i < src_table->required_opp_count; i++) {
> -               if (src_table->required_opp_tables[i] == dst_table)
> +               if (src_table->required_opp_tables[i]->np == dst_table->np)
>                         break;
>         }
> 
> Try this fix and it should make it work for you.
> 
> Having said that, the way you are representing all your domains with a
> single OPP table look incorrect. You are using the same OPP table for
> around 10 power domains, all provided by a single provider. This is
> absolutely fine. But the Mx domain doesn't have any dependency on any
> other domain actually and so its OPPs should never have the
> "required-opps" property, but it has those properties in your setup as
> you are trying to use the same OPP table. That may all work fine with
> the above patch (which is required anyway as it fixes a valid issue),
> but you may see a error warning that something failed for Mx domain,
> as it has required-opps property but no required device or genpd.
> 
> Anyway, please test above first and then you can fix your tables :)

Here is the fix you need for the case where cx and mx have 1:1 mapping
and we don't need to duplicate OPP tables in DT.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ad944d75b40b..99b71f60b6d8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1727,6 +1727,16 @@ unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
        unsigned int dest_pstate = 0;
        int i;
 
+       /*
+        * Normally the src_table will have the "required_opps" property set to
+        * point to one of the OPPs in the dst_table, but in some cases the
+        * genpd and its master have one to one mapping of performance states
+        * and so none of them have the "required-opps" property set. Return the
+        * pstate of the src_table as it is in such cases.
+        */
+       if (!src_table->required_opp_count)
+               return pstate;
+
        for (i = 0; i < src_table->required_opp_count; i++) {
                if (src_table->required_opp_tables[i]->np == dst_table->np)
                        break;

-- 
viresh

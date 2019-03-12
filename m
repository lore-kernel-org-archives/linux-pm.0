From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] OPP: Fix handling of multiple power domains
Date: Tue, 12 Mar 2019 10:36:06 +0100
Message-ID: <1695972.KL8iO62iuq@aspire.rjw.lan>
References: <20190306040726.1930-1-rnayak@codeaurora.org> <20190308043712.3aca6lygz2oya3lc@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308043712.3aca6lygz2oya3lc@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, March 8, 2019 5:37:12 AM CET Viresh Kumar wrote:
> On 06-03-19, 09:37, Rajendra Nayak wrote:
> > We seem to rely on the number of phandles specified in the
> > 'required-opps' property to identify cases where a device is
> > associated with multiple power domains and hence would have
> > multiple virtual devices that have to be dealt with.
> > 
> > In cases where we do have devices with multiple power domains
> > but with only one of them being scalable, this logic seems to
> > fail.
> > 
> > Instead read the number of power domains from DT to identify
> > such cases.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
> >  drivers/opp/of.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 06f0f632ec47..443c305ae100 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -172,7 +172,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >  	struct opp_table **required_opp_tables;
> >  	struct device **genpd_virt_devs = NULL;
> >  	struct device_node *required_np, *np;
> > -	int count, i;
> > +	int count, count_pd, i;
> >  
> >  	/* Traversing the first OPP node is all we need */
> >  	np = of_get_next_available_child(opp_np, NULL);
> > @@ -185,7 +185,19 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >  	if (!count)
> >  		goto put_np;
> >  
> > -	if (count > 1) {
> > +	/*
> > +	 * Check the number of power-domains to know if we need to deal
> > +	 * with virtual devices. In some cases we have devices with multiple
> > +	 * power domains but with only one of them being scalable, hence
> > +	 * 'count' could be 1, but we still have to deal with multiple genpds
> > +	 * and virtual devices.
> > +	 */
> > +	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> > +					      "#power-domain-cells");
> > +	if (!count_pd)
> > +		goto put_np;
> > +
> > +	if (count_pd > 1) {
> >  		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
> >  					GFP_KERNEL);
> >  		if (!genpd_virt_devs)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Rafael, please pick this up for 5.1-rc2 directly. Thanks.

Done, thanks!

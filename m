From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update x2][PATCH 7/9] PM / Runtime: Generic clock
	manipulation rountines for runtime PM (v5)
Date: Fri, 29 Apr 2011 22:29:56 +0200
Message-ID: <201104292229.56518.rjw__7345.65243260494$1304109131$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104282136.26163.rjw@sisk.pl>
	<4DBB12EF.9030000@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4DBB12EF.9030000@codeaurora.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, April 29, 2011, Stephen Boyd wrote:
> On 04/28/2011 12:36 PM, Rafael J. Wysocki wrote:
> > +/**
> > + * pm_runtime_clk_add - Start using a device clock for runtime PM.
> > + * @dev: Device whose clock is going to be used for runtime PM.
> > + * @con_id: Connection ID of the clock.
> > + *
> > + * Add the clock represented by @con_id to the list of clocks used for
> > + * the runtime PM of @dev.
> > + */
> > +int pm_runtime_clk_add(struct device *dev, const char *con_id)
> > +{
> > +	struct pm_runtime_clk_data *prd = __to_prd(dev);
> > +	struct pm_clock_entry *ce;
> > +
> > +	if (!prd)
> > +		return -EINVAL;
> > +
> > +	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
> > +	if (!ce) {
> > +		dev_err(dev, "Not enough memory for clock entry.\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	if (con_id) {
> > +		ce->con_id = kstrdup(con_id, GFP_KERNEL);
> > +		if (!ce->con_id) {
> > +			dev_err(dev,
> > +				"Not enough memory for clock conection ID.\n");
> 
> Missing an 'n' in connection.

Right, thanks!

> > +			kfree(ce);
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	mutex_lock(&prd->lock);
> > +	list_add_tail(&ce->node, &prd->clock_list);
> > +	mutex_unlock(&prd->lock);
> > +	return 0;
> > +}
> > +
> > +/**
> > + * __pm_runtime_clk_remove - Destroy runtime PM clock entry.
> > + * @ce: Runtime PM clock entry to destroy.
> > + *
> > + * This routine must be called under the mutex protecting the runtime PM list
> > + * of clocks corresponding the the @ce's device.
> > + */
> > +static void __pm_runtime_clk_remove(struct pm_clock_entry *ce)
> > +{
> > +	if (!ce)
> > +		return;
> > +
> > +	list_del(&ce->node);
> > +
> > +	if (!IS_ERR_OR_NULL(ce->clk)) {
> 
> NULL is a valid clock so you'll need to figure out some way to handle
> that throughout this code.

Well, I didn't know that, thanks!  I'll need to add the "active" flag
back, then, after all.  In addition to that, I'll need to distinguish between
the "clk == NULL because it's not initialized" and "clk == NULL becuase it's
a valid clock" cases. 

I guess I'll use combinations of two flags.

Thanks,
Rafael

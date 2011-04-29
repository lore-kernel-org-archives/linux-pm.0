From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [Update x2][PATCH 7/9] PM / Runtime: Generic clock
 manipulation rountines for runtime PM (v5)
Date: Fri, 29 Apr 2011 12:35:11 -0700
Message-ID: <4DBB12EF.9030000__9682.59326550669$1304105792$gmane$org@codeaurora.org>
References: <201104130205.26988.rjw@sisk.pl> <201104280306.13262.rjw@sisk.pl>
	<201104280333.13730.rjw@sisk.pl> <201104282136.26163.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104282136.26163.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 04/28/2011 12:36 PM, Rafael J. Wysocki wrote:
> +/**
> + * pm_runtime_clk_add - Start using a device clock for runtime PM.
> + * @dev: Device whose clock is going to be used for runtime PM.
> + * @con_id: Connection ID of the clock.
> + *
> + * Add the clock represented by @con_id to the list of clocks used for
> + * the runtime PM of @dev.
> + */
> +int pm_runtime_clk_add(struct device *dev, const char *con_id)
> +{
> +	struct pm_runtime_clk_data *prd = __to_prd(dev);
> +	struct pm_clock_entry *ce;
> +
> +	if (!prd)
> +		return -EINVAL;
> +
> +	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
> +	if (!ce) {
> +		dev_err(dev, "Not enough memory for clock entry.\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (con_id) {
> +		ce->con_id = kstrdup(con_id, GFP_KERNEL);
> +		if (!ce->con_id) {
> +			dev_err(dev,
> +				"Not enough memory for clock conection ID.\n");

Missing an 'n' in connection.

> +			kfree(ce);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	mutex_lock(&prd->lock);
> +	list_add_tail(&ce->node, &prd->clock_list);
> +	mutex_unlock(&prd->lock);
> +	return 0;
> +}
> +
> +/**
> + * __pm_runtime_clk_remove - Destroy runtime PM clock entry.
> + * @ce: Runtime PM clock entry to destroy.
> + *
> + * This routine must be called under the mutex protecting the runtime PM list
> + * of clocks corresponding the the @ce's device.
> + */
> +static void __pm_runtime_clk_remove(struct pm_clock_entry *ce)
> +{
> +	if (!ce)
> +		return;
> +
> +	list_del(&ce->node);
> +
> +	if (!IS_ERR_OR_NULL(ce->clk)) {

NULL is a valid clock so you'll need to figure out some way to handle
that throughout this code.

> +		if (ce->clock_enabled)
> +			clk_disable(ce->clk);
> +
> +		clk_put(ce->clk);
> +	}
> +
> +	if (ce->con_id)
> +		kfree(ce->con_id);
> +
> +	kfree(ce);
> +}
> +

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

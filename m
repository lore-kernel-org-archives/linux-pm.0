From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 08/13] OMAP2+: powerdomain: control power
 domains next state
Date: Fri, 29 Jul 2011 00:59:42 -0700
Message-ID: <20110729075942.GA26959__34566.4290049628$1311926451$gmane$org@google.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-9-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1311841821-10252-9-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 28, 2011 at 10:30:15AM +0200, jean.pihet@newoldbits.com wrote:
...
> +int pwrdm_set_wkup_lat_constraint(struct powerdomain *pwrdm, void *cookie,
> +				  long min_latency)
> +{
> +	struct pwrdm_wkup_constraints_entry *user = NULL;
> +	struct pwrdm_wkup_constraints_entry *tmp_user, *new_user;
> +	int ret = 0, free_new_user = 0, free_node = 0;
> +	long value = 0;
> +	unsigned long flags;
> +
> +	pr_debug("powerdomain: %s: pwrdm %s, cookie=0x%p, min_latency=%ld\n",
> +		 __func__, pwrdm->name, cookie, min_latency);
> +
> +	new_user = kzalloc(sizeof(struct pwrdm_wkup_constraints_entry),
> +			   GFP_KERNEL);
> +	if (!new_user) {
> +		pr_err("%s: FATAL ERROR: kzalloc failed\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
> +
> +	/* Check if there already is a constraint for cookie */
> +	plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_head, node) {
> +		if (tmp_user->cookie == cookie) {
> +			user = tmp_user;
> +			free_new_user = 1;
> +			break;
> +		}
> +	}
> +
> +	if (min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE) {
> +		/* If nothing to update, job done */
> +		if (user && (user->node.prio == min_latency))
> +			goto exit_ok;
> +
> +		if (!user) {
> +			/* Add new entry to the list */
> +			user = new_user;
> +			user->cookie = cookie;
> +		} else {
> +			/* Update existing entry */
> +			plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
> +		}
> +
> +		plist_node_init(&user->node, min_latency);
> +		plist_add(&user->node, &pwrdm->wkup_lat_plist_head);
> +	} else {
> +		/* Remove the constraint from the list */
> +		if (!user) {
> +			pr_err("%s: Error: no prior constraint to release\n",
> +			       __func__);
> +			ret = -EINVAL;
> +			goto exit_error;
> +		}
> +
> +		plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
> +		free_node = 1;

All min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE paths need
free_new_user = 1.  (Or maybe change the logic to check user !=
new_user and free new_user if so.)

> +	}
> +
> +exit_ok:
> +	/* Find the strongest constraint from the list */
> +	if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
> +		value = plist_first(&pwrdm->wkup_lat_plist_head)->prio;
> +
> +	spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);
> +
> +	if (free_node)
> +		kfree(user);
> +
> +	if (free_new_user)
> +		kfree(new_user);
> +
> +	/* Apply the constraint to the pwrdm */
> +	pr_debug("powerdomain: %s: pwrdm %s, value=%ld\n",
> +		 __func__, pwrdm->name, value);
> +	pwrdm_wakeuplat_update_pwrst(pwrdm, value);
> +
> +	return 0;
> +
> +exit_error:
> +	spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);

Need:
        kfree(new_user);

> +	return ret;
> +}


Todd

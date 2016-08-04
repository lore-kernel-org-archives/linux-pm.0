From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [PATCH v2 01/14] PM / Domains: Allow domain power states to be
 read from DT
Date: Thu, 4 Aug 2016 14:24:07 +0100
Message-ID: <20160804132407.GA1732@brendan-thinkstation>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1469829385-11511-2-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, khilman@kernel.org, rjw@rjwysocki.net, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Lina,

Couple of nitpicks here:

On Fri, Jul 29, 2016 at 03:56:12PM -0600, Lina Iyer wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
> This patch allows domains to define idle states in the DT. SoC's can
> define domain idle states in DT using the "power-states" property of the
> domain provider. Calling of_pm_genpd_init() will  read the idle states
> and initialize the genpd for the domain.
>

The commit message got out of sync here, the idle states property is not
"power-states" but "domain-idle-states" now.

> In addition to the entry and exit latency for idle state, also add
> residency and state-param properties. A domain idling in a state is only
> power effecient if it stays idle for a certain period in that state. The
> residency provides this minimum time for the idle state to provide power
> benefits. The state-param is a state specific u32 value that the
> platform may use for that idle state.
>

And "state-param" isn't used any more, since the patchset switched to using
arm,idle-state.

> [snip]
> +int pm_genpd_of_parse_power_states(struct generic_pm_domain *genpd)
> +{
> +	struct device_node *np;
> +	int i, err = 0;
> +
> +	for (i = 0; i < GENPD_MAX_NUM_STATES; i++) {
> +		np = of_parse_phandle(genpd->of_node, "domain-idle-states", i);
> +		if (!np)
> +			break;
> +
> +		err = genpd_of_get_power_state(&genpd->states[i], np);
> +		if (err) {
> +			pr_err
> +			    ("Parsing idle state node %s failed with err %d\n",
> +			     np->full_name, err);
> +			err = -EINVAL;

I guess there should be an of_node_put here.

> +			break;
> +		}
> +		of_node_put(np);
> +	}
> +
> +	if (err)
> +		return err;
> +
> +	genpd->state_count = i;
> +	return 0;
> +}

From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v4 2/8] reset: Add reset controller API
Date: Fri, 01 Mar 2013 13:00:56 -0700
Message-ID: <513108F8.30902@wwwdotorg.org>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
 <1361878774-6382-3-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1361878774-6382-3-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 02/26/2013 04:39 AM, Philipp Zabel wrote:
> This adds a simple API for devices to request being reset
> by separate reset controller hardware and implements the
> reset signal device tree binding.

> diff --git a/drivers/reset/core.c b/drivers/reset/core.c

> +int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
> +			  const struct of_phandle_args *reset_spec, u32 *flags)
> +{
> +	if (WARN_ON(reset_spec->args_count < rcdev->of_reset_n_cells))
> +		return -EINVAL;

Would != make more sense than < ?

> +
> +	if (reset_spec->args[0] >= rcdev->nr_resets)
> +		return -EINVAL;
> +
> +	if (flags)
> +		*flags = reset_spec->args[1];

if (flags)
    if (reset_spec->args_count > 1)
        *flags = reset_spec->args[1];
    else
        *flags = 0;

?

> +struct reset_control *reset_control_get(struct device *dev, const char *id)
...
> +	mutex_lock(&reset_controller_list_mutex);
> +	rcdev = NULL;
> +	list_for_each_entry(r, &reset_controller_list, list) {
> +		if (args.np == r->of_node) {
> +			rcdev = r;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&reset_controller_list_mutex);

At this point, rcdev could be removed from that list, and perhaps even
start to point at free'd memory.

> +	of_node_put(args.np);
> +
> +	if (!rcdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	rstc_id = rcdev->of_xlate(rcdev, &args, NULL);
> +	if (rstc_id < 0)
> +		return ERR_PTR(rstc_id);
> +
> +	try_module_get(rcdev->owner);

What about error-handling here?

I think you want to drop reset_controller_list_mutex only after the call
to try_module_get()?

> +static int devm_reset_control_match(struct device *dev, void *res, void *data)
> +{
> +	struct reset_control **rstc = res;
> +	if (!rstc || !*rstc) {
> +		WARN_ON(!rstc || !*rstc);

I think you can if (WARN_ON(...)).

I'm not sure if the error-checks are quite right though;
reset_control_get always returns an error-pointer for errors, never
NULL, so the pointer can't ever be NULL. If it somehow was (e.g. client
usage error), then that NULL pointer would never match anything, so the
error-check still wouldn't be useful.

I'm not sure why this is a ** here; below in devm_reset_control_put()
you pass a just a *; are you expected to pass &rstc there instead?

> +void devm_reset_control_put(struct reset_control *rstc)
> +{
> +	int ret;
> +
> +	ret = devres_release(rstc->dev, devm_reset_control_release,
> +			     devm_reset_control_match, rstc);
> +	if (ret)
> +		WARN_ON(ret);
> +}
> +EXPORT_SYMBOL_GPL(devm_reset_control_put);

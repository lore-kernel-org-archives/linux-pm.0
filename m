From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 1/4] of: Rename "poweroff-source" property to
 "system-power-controller"
Date: Wed, 05 Nov 2014 17:35:23 +0000
Message-ID: <20141105173523.E9E40C41C40@trevor.secretlab.ca>
References: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
	<1414568135-8311-2-git-send-email-romain.perier@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:54379 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaKERf3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Nov 2014 12:35:29 -0500
Received: by mail-ie0-f173.google.com with SMTP id tr6so1182536ieb.4
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2014 09:35:28 -0800 (PST)
In-Reply-To: <1414568135-8311-2-git-send-email-romain.perier@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Romain Perier <romain.perier@gmail.com>, heiko@sntech.de
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, johan@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org

On Wed, 29 Oct 2014 07:35:32 +0000
, Romain Perier <romain.perier@gmail.com>
 wrote:
> As discussed on the mailing list, it makes more sense to rename this property
> to "system-power-controller". Problem being that the word "source" usually tends
> to be used for inputs and that is out of control of the OS. The poweroff
> capability is an output which simply turns the system-power off. Also, this
> property might be used by drivers which power-off the system and power back on
> subsequent RTC alarms. This seems to suggest to remove "poweroff" from the
> property name and to choose "system-power-controller" as the more generic name.
> This patchs adds the required renaming changes and defines an helper function
> which is compatible with both properties, the old one prefixed by a vendor name
> and the new one without any prefix.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../devicetree/bindings/power/power-controller.txt | 18 ++++++++++++
>  .../devicetree/bindings/power/poweroff.txt         | 18 ------------

Tip: use -M when using git diff or git send-email to track renames. The
documentation should show up only as a rename, not separate add and
remove files.

>  drivers/of/base.c                                  | 34 ++++++++++++++++++++++
>  include/linux/of.h                                 | 10 ++-----
>  4 files changed, 55 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/power-controller.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/poweroff.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/power-controller.txt b/Documentation/devicetree/bindings/power/power-controller.txt
> new file mode 100644
> index 0000000..942f955
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/power-controller.txt
> @@ -0,0 +1,18 @@
> +* Generic system power control capability
> +
> +Power-management integrated circuits or miscellaneous harware components are
> +sometimes able to control the system power. The device driver associated to these
> +components might needs to define this capability, which tells to the kernel how
> +to switch off the system. The corresponding driver must have the standard
> +property "system-power-controller" in its device node. This property marks the
> +device as able to controller the system-power. In order to test if this property
> +is found programmatically, use the helper function "of_is_system_power_controller"
> +from of.h .

You've reflowed the text which makes it harder for git to recognise that
this is a renamed file. Typically you would put the rename into a
separate patch to cut down on the noise for reviewers.

> +
> +Example:
> +
> +act8846: act8846@5 {
> +	 compatible = "active-semi,act8846";
> +	 status = "okay";
> +	 system-power-controller;
> +}
> diff --git a/Documentation/devicetree/bindings/power/poweroff.txt b/Documentation/devicetree/bindings/power/poweroff.txt
> deleted file mode 100644
> index 845868b..0000000
> --- a/Documentation/devicetree/bindings/power/poweroff.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Generic Poweroff capability
> -
> -Power-management integrated circuits or miscellaneous harware components are
> -sometimes able to control the system power. The device driver associated to these
> -components might needs to define poweroff capability, which tells to the kernel
> -how to switch off the system. The corresponding driver must have the standard
> -property "poweroff-source" in its device node. This property marks the device as
> -able to shutdown the system. In order to test if this property is found
> -programmatically, use the helper function "of_system_has_poweroff_source" from
> -of.h .
> -
> -Example:
> -
> -act8846: act8846@5 {
> -	 compatible = "active-semi,act8846";
> -	 status = "okay";
> -	 poweroff-source;
> -}
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 74ab1b8..438e405 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2260,3 +2260,37 @@ struct device_node *of_graph_get_remote_port(const struct device_node *node)
>  	return of_get_next_parent(np);
>  }
>  EXPORT_SYMBOL(of_graph_get_remote_port);
> +
> +/**
> + * of_is_system_power_controller() - Tells if the property for controlling system
> + * power is found in device_node.
> + * @np: Pointer to the given device_node
> + *
> + * Return: true if present false otherwise
> + */
> +bool of_is_system_power_controller(const struct device_node *np)
> +{
> +	struct property *pp;
> +	unsigned long flags;
> +	char *sep;
> +	bool found = false;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +	for_each_property_of_node(np, pp) {
> +		if (of_prop_cmp(pp->name, "system-power-controller") == 0) {
> +			found = true;
> +			break;
> +		}
> +		/* Backward compatibility with previous property "vendor,system-power-controller",
> +		 * we just check that an non-empty vendor-prefix exists here
> +		 */
> +		sep = strchr(pp->name, ',');
> +		if (sep && sep - pp->name && of_prop_cmp(sep + 1, "system-power-controller") == 0) {
> +			found = true;
> +			break;
> +		}
> +	}

Far too complicated. Keep the code simple. The following should be sufficient:
{
	if (of_property_read_bool("system-power-controller"))
		return true;
	return of_property_read_bool("ti,system-power-controller");
}

It doesn't need to be a catch-all for every possible vendor string. Only put
in the ones that have actually been seen in the wild. If this needs to
be merged right away as a regression fix for tps65910, then put this
change, and *only* this change into a separate patch without renaming
the function and submit that for merging.

> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +	return found;
> +}
> +EXPORT_SYMBOL(of_is_system_power_controller);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 868fdad..e7177b3 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -910,15 +910,11 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
>  /* CONFIG_OF_RESOLVE api */
>  extern int of_resolve_phandles(struct device_node *tree);
>  
> -/**
> - * of_system_has_poweroff_source - Tells if poweroff-source is found for device_node
> - * @np: Pointer to the given device_node
> - *
> - * return true if present false otherwise
> - */
> +bool of_is_system_power_controller(const struct device_node *np);
> +
>  static inline bool of_system_has_poweroff_source(const struct device_node *np)
>  {
> -	return of_property_read_bool(np, "poweroff-source");
> +	return of_is_system_power_controller(np);
>  }

Instead of this, just change all of the callers to the new interface in
the same patch. It doesn't matter if the patch covers multiple
subsystems, the affected maintainers will work it out between us.

g.

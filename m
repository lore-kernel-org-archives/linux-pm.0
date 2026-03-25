Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430E344DB9
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434203; cv=pass; b=nTeP7gktFe1PPbOX03l0DnAeK7ojPhE1lKmHCqybeMUtxQq41cGgdu5GSIp+HgAI9o7c+IF5kDAD8NKPufVxp9glFr7rNAVpR1qPgZ5lblIPAqtXExc2ASZKYmwkQ+fhj94+n8vVJk8lTrUM2QzoI05AyLhWJRWVQyNhgUSwGLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434203; c=relaxed/simple;
	bh=RH8gtxQV2NDhn+3rg6SQRgAvdcumKOkFkd1aWYgdyA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6Rtzd/Cw3eSrcYHr8ZLAb3FYGlZstXtJa8gRxC75s6izPZKaSODyGEuUqemvYpXHd2+ncBTco25sKLXFMSsje0+ZCAu0iWnKiyikMypOpHFH/3yltWzAR5PRSOIJXEd+UjkVS6zptUH9f6zNMCFe9ngH+7qzBzCDFUWU+5f1Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWelJUfL; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWelJUfL"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so2561043e87.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 03:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774434200; cv=none;
        d=google.com; s=arc-20240605;
        b=dkiGp27LAbdonKJ2t1CW+l2ftW14F05TK0aRsSqoMiV6oftPMWCAcz0orickZOnFu/
         j1sMcbGSjCeXSjYcOBX6fVY1MkgGtjcECKlijVTI0Lvx6aStKzfalNfHYbpqUMn1UXOt
         8x9cQVzAeCFI0JCYcV1ijO68gnJwoYNmknM6zjvzoWIfeojL1Y6CyML1y3Bs1/3+SzC2
         yzM1l/2Xt18B19Yd3KqKaGg990Iqcj+4W9df0oMj4jECe0PuEaZG17V+7BYBSPPNG97R
         cE1UbKguA3wdB0n+/csge/dMWy8GzlZJ2LJr7rYm0d6hdhN3aw4/91q7eQmGSv+5e+1a
         B3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mBp8RLEDVIlzkv1F9VuUM1ruuuUZPFdkClJzuEAiKOA=;
        fh=9nZoz2WBhoSAABy5BR+xjy25O2R6pVvel8W/iAkpT4o=;
        b=bsgW47rTEl08OxsoUL7w4Gopsx7n+usaxhjqcKTGTLFpWgXUt8IOwX6YORGaJsKfcU
         uXLHUSt99dYsbZUL3dMtM6yhSTFg/1amxIpedqB3AQPyB5gxPYIySgbO39UIDinDl0SG
         4GHxlWdlD4mOF/S3cZy4qzDU4OhasffDAuyXO3Qp+SnZWb5/sUgL5pALNpaRjbQO+x0I
         4gAt/DQYJmMiT1lGqnzidIkajO7yd0u4lY2o0oh2Ahy9BRdyoRJEH0iaTY8kqkjkmGZF
         cqRqL2MMAf7dmxL31q4NX1f/dQ8tuqo/NOF8js9sdPD6CbGEWMCmrWbJvorHO7HQNP5U
         2OBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774434200; x=1775039000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mBp8RLEDVIlzkv1F9VuUM1ruuuUZPFdkClJzuEAiKOA=;
        b=IWelJUfLPxPiUDmgFdiz6JEChAmhJVM8b3R+N8WVcUZCXauLyZQ5pMtzrXJ6hOGdaA
         DAY964fXPUsXhVaPPhUF/wsOYG3eiNLhi78XTzNXKy882stoP75rMCn3v6Sq/gJ8XEQQ
         mdPugHj/RJfnlpvv93qo1X3HVGCvj8kBwpCJ1bFe2KJlbZi5PXpo3N0VYuTGzAYmCMwq
         a/45HNerz3+rv6/2p7RHaYPbs8dJ5IOSNWO0FVE3iRtvNR5R6MePkw95w5qpoWoqkgQA
         YjKAy8Cd4sNJxciXrJcEBAAGsgUmNYIFMWeNxCOVojERF9Trz1LDX+dJYbjO1eWRkrxA
         wyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774434200; x=1775039000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBp8RLEDVIlzkv1F9VuUM1ruuuUZPFdkClJzuEAiKOA=;
        b=nhefpfg2EIZrmqltvZVMLU0tUztnqXlps5R84KgTuXfDOZid83ot4FtZHPHX0hvqe3
         XBkJYd35yjhPY28SJIzGAPx9FP1SCx2RPl5iT/2nodItk+XrL6m1+SZIcWQBE0LNDlq1
         L6oJb0R7WIpwLcfhF2K/9ISem3+Zf496Emje8moumwpxZ1oE3XOT4y8f3GEluvxLlRoP
         Js/EC2h0pY9uQ+NOG5dHqkIrKVMsaFZbWsO3ougnJYa7W1RD3k3JABM8kqN6t62DefCC
         Hd08C4/FlCmAAa3S7mPnj9QpsN+1TWgo1sSwhPfqPxLBp7zPgXEjHMLkrTIrrIANiBz6
         7SOw==
X-Forwarded-Encrypted: i=1; AJvYcCUXNjPPRxAQnJQ/ZOF80JSxD+Bckw4FcyJNEr/1k0UBkuIyIfIA31vbJdsilIGioDKNdd2Nml+PPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54Off2XVRHOl7IxUMKGs+PSW3m6Fe9+65IfrDUTNM83Dd5WRF
	F9BmMigEKlP658F/dSbCA9Z1pwZH+mKV504KDo/ZzgZ+OH85s6xL2+RoSf7YaPfG9YCivpED0nw
	vcIa6DPANZVQAuCmg9ALacCmic/w2KvDc2si49IdiLA33W0sNnThE8khwLQ==
X-Gm-Gg: ATEYQzxRbfCejqZ0B8CyQp8vY+Tq7fpapl+XVHco7cfVOAYhChiGlWlLFajylMuE/xd
	0cfrKsZvjcAAlWytW7ffZ4D+VclTyAETlwcx1qkjoy9mr4z61UKNemljhaFevDl+Fa1uuCvzDzj
	IhYKTIyp7Ec7YsZSA6nH9N4EdRzbNrDfr0Pk0W7Jbz1C2wZXJ+PIbNx7Sz6lzCLrLAlHLuyFZNh
	LbuCs25ZAYm90cZjc6l9hHyf6/aHxs5O81i8b7KB9B2yxbr4ArwEYoectcYRkQ0K1Y1kGnNfTjX
	DQpAIEdl
X-Received: by 2002:a05:6512:39cc:b0:5a2:7f4b:8e87 with SMTP id
 2adb3069b0e04-5a29b97d9cfmr1256395e87.3.1774434199644; Wed, 25 Mar 2026
 03:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-2-5361687a18ff@baylibre.com>
In-Reply-To: <20260310-topic-lpm-pmdomain-child-ids-v1-2-5361687a18ff@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Mar 2026 11:22:43 +0100
X-Gm-Features: AQROBzCAhrnkHE2n7Vl-AWMRhbzCM0xZ4JtiJNaCMCH2pRumSmgZhFKQaLi64kk
Message-ID: <CAPDyKFquJ7K4NcWuKMr1sjrnFVVPGAeLCiSF_FhvJf9Frbn1uA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: core: add support for power-domains-child-ids
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 01:19, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>
> Currently, PM domains can only support hierarchy for simple
> providers (e.g. ones with #power-domain-cells = 0).
>
> Add support for oncell providers as well by adding a new property
> `power-domains-child-ids` to describe the parent/child relationship.
>
> For example, an SCMI PM domain provider has multiple domains, each of
> which might be a child of diffeent parent domains. In this example,
> the parent domains are MAIN_PD and WKUP_PD:
>
>     scmi_pds: protocol@11 {
>         reg = <0x11>;
>         #power-domain-cells = <1>;
>         power-domains = <&MAIN_PD>, <&WKUP_PD>;
>         power-domains-child-ids = <15>, <19>;
>     };
>
> With this example using the new property, SCMI PM domain 15 becomes a
> child domain of MAIN_PD, and SCMI domain 19 becomes a child domain of
> WKUP_PD.
>
> To support this feature, add two new core functions
>
> - of_genpd_add_child_ids()
> - of_genpd_remove_child_ids()
>
> which can be called by pmdomain providers to add/remove child domains
> if they support the new property power-domains-child-ids.
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

Thanks for working on this! It certainly is a missing feature!

> ---
>  drivers/pmdomain/core.c   | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h |  16 ++++++++++++++++
>  2 files changed, 185 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 61c2277c9ce3..acb45dd540b7 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2909,6 +2909,175 @@ static struct generic_pm_domain *genpd_get_from_provider(
>         return genpd;
>  }
>
> +/**
> + * of_genpd_add_child_ids() - Parse power-domains-child-ids property
> + * @np: Device node pointer associated with the PM domain provider.
> + * @data: Pointer to the onecell data associated with the PM domain provider.
> + *
> + * Parse the power-domains and power-domains-child-ids properties to establish
> + * parent-child relationships for PM domains. The power-domains property lists
> + * parent domains, and power-domains-child-ids lists which child domain IDs
> + * should be associated with each parent.
> + *
> + * Returns 0 on success, -ENOENT if properties don't exist, or negative error code.

I think we should avoid returning specific error codes for specific
errors, simply because it usually becomes messy.

If I understand correctly the intent here is to allow the caller to
check for -ENOENT and potentially avoid bailing out as it may not
really be an error, right?

Perhaps a better option is to return the number of children for whom
we successfully assigned parents. Hence 0 or a positive value allows
the caller to understand what happened. More importantly, a negative
error code then really becomes an error for the caller to consider.

> + */
> +int of_genpd_add_child_ids(struct device_node *np,
> +                          struct genpd_onecell_data *data)
> +{
> +       struct of_phandle_args parent_args;
> +       struct generic_pm_domain *parent_genpd, *child_genpd;
> +       struct of_phandle_iterator it;
> +       const struct property *prop;
> +       const __be32 *item;
> +       u32 child_id;
> +       int ret;
> +
> +       /* Check if both properties exist */
> +       if (of_count_phandle_with_args(np, "power-domains", "#power-domain-cells") <= 0)
> +               return -ENOENT;
> +
> +       prop = of_find_property(np, "power-domains-child-ids", NULL);
> +       if (!prop)
> +               return -ENOENT;
> +
> +       item = of_prop_next_u32(prop, NULL, &child_id);

Perhaps it's easier to check if of_property_count_u32_elems() returns
the same number as of_count_phandle_with_args() above? If it doesn't,
something is wrong, and there is no need to continue.

This way you also know the number of loops upfront that must iterate
through all indexes. This should allow us to use a simpler for-loop
below, I think. In this case you can also use
of_property_read_u32_index() instead.

> +
> +       /* Iterate over power-domains phandles and power-domains-child-ids in lockstep */
> +       of_for_each_phandle(&it, ret, np, "power-domains", "#power-domain-cells", 0) {
> +               if (!item) {
> +                       pr_err("power-domains-child-ids shorter than power-domains for %pOF\n", np);
> +                       ret = -EINVAL;
> +                       goto err_put_node;
> +               }
> +
> +               /*
> +                * Fill parent_args from the iterator. it.node is released by
> +                * the next of_phandle_iterator_next() call at the top of the
> +                * loop, or by the of_node_put() on the error path below.
> +                */
> +               parent_args.np = it.node;
> +               parent_args.args_count = of_phandle_iterator_args(&it, parent_args.args,
> +                                                                 MAX_PHANDLE_ARGS);
> +
> +               /* Get the parent domain */
> +               parent_genpd = genpd_get_from_provider(&parent_args);

Before getting the parent_genpd like this, we need to take the
gpd_list_lock. The lock must be held when genpd_add_subdomain() is
being called.

> +               if (IS_ERR(parent_genpd)) {
> +                       pr_err("Failed to get parent domain for %pOF: %ld\n",
> +                              np, PTR_ERR(parent_genpd));
> +                       ret = PTR_ERR(parent_genpd);
> +                       goto err_put_node;
> +               }
> +
> +               /* Validate child ID is within bounds */
> +               if (child_id >= data->num_domains) {
> +                       pr_err("Child ID %u out of bounds (max %u) for %pOF\n",
> +                              child_id, data->num_domains - 1, np);
> +                       ret = -EINVAL;
> +                       goto err_put_node;
> +               }
> +
> +               /* Get the child domain */
> +               child_genpd = data->domains[child_id];
> +               if (!child_genpd) {
> +                       pr_err("Child domain %u is NULL for %pOF\n", child_id, np);
> +                       ret = -EINVAL;
> +                       goto err_put_node;
> +               }
> +
> +               /* Establish parent-child relationship */
> +               ret = genpd_add_subdomain(parent_genpd, child_genpd);
> +               if (ret) {
> +                       pr_err("Failed to add child domain %u to parent in %pOF: %d\n",
> +                              child_id, np, ret);
> +                       goto err_put_node;
> +               }
> +
> +               pr_debug("Added child domain %u (%s) to parent %s for %pOF\n",
> +                        child_id, child_genpd->name, parent_genpd->name, np);
> +
> +               item = of_prop_next_u32(prop, item, &child_id);
> +       }
> +
> +       /* of_for_each_phandle returns -ENOENT at natural end-of-list */
> +       if (ret && ret != -ENOENT)
> +               return ret;
> +
> +       /* All power-domains phandles were consumed; check for trailing child IDs */
> +       if (item) {
> +               pr_err("power-domains-child-ids longer than power-domains for %pOF\n", np);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +
> +err_put_node:

This isn't a suffient error handling.

If we successfully added child domains using genpd_add_subdomain(), we
must remove them here, by calling pm_genpd_remove_subdomain() in the
reverse order as we just added them.

> +       of_node_put(it.node);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(of_genpd_add_child_ids);
> +
> +/**
> + * of_genpd_remove_child_ids() - Remove parent-child PM domain relationships
> + * @np: Device node pointer associated with the PM domain provider.
> + * @data: Pointer to the onecell data associated with the PM domain provider.
> + *
> + * Reverses the effect of of_genpd_add_child_ids() by parsing the same
> + * power-domains and power-domains-child-ids properties and calling
> + * pm_genpd_remove_subdomain() for each established relationship.
> + *
> + * Returns 0 on success, -ENOENT if properties don't exist, or negative error
> + * code on failure.
> + */
> +int of_genpd_remove_child_ids(struct device_node *np,
> +                          struct genpd_onecell_data *data)
> +{
> +       struct of_phandle_args parent_args;
> +       struct generic_pm_domain *parent_genpd, *child_genpd;
> +       struct of_phandle_iterator it;
> +       const struct property *prop;
> +       const __be32 *item;
> +       u32 child_id;
> +       int ret;
> +
> +       /* Check if both properties exist */
> +       if (of_count_phandle_with_args(np, "power-domains", "#power-domain-cells") <= 0)
> +               return -ENOENT;
> +
> +       prop = of_find_property(np, "power-domains-child-ids", NULL);
> +       if (!prop)
> +               return -ENOENT;
> +
> +       item = of_prop_next_u32(prop, NULL, &child_id);

Similar comments as for of_genpd_add_child_ids().

Moreover, I think we should remove the children in the reverse order
of how we added them.

> +
> +       of_for_each_phandle(&it, ret, np, "power-domains", "#power-domain-cells", 0) {
> +               if (!item)
> +                       break;
> +
> +               parent_args.np = it.node;
> +               parent_args.args_count = of_phandle_iterator_args(&it, parent_args.args,
> +                                                                 MAX_PHANDLE_ARGS);
> +
> +               if (child_id >= data->num_domains || !data->domains[child_id]) {
> +                       item = of_prop_next_u32(prop, item, &child_id);
> +                       continue;
> +               }
> +
> +               parent_genpd = genpd_get_from_provider(&parent_args);
> +               if (IS_ERR(parent_genpd)) {
> +                       item = of_prop_next_u32(prop, item, &child_id);
> +                       continue;
> +               }
> +
> +               child_genpd = data->domains[child_id];
> +               pm_genpd_remove_subdomain(parent_genpd, child_genpd);
> +
> +               item = of_prop_next_u32(prop, item, &child_id);
> +       }
> +
> +       return (ret == -ENOENT) ? 0 : ret;
> +}
> +EXPORT_SYMBOL_GPL(of_genpd_remove_child_ids);
> +
>  /**
>   * of_genpd_add_device() - Add a device to an I/O PM domain
>   * @genpdspec: OF phandle args to use for look-up PM domain
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f67a2cb7d781..b44615d79af6 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -465,6 +465,10 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>                                struct genpd_power_state **states, int *n);
>  void of_genpd_sync_state(struct device_node *np);
> +int of_genpd_add_child_ids(struct device_node *np,
> +                          struct genpd_onecell_data *data);
> +int of_genpd_remove_child_ids(struct device_node *np,
> +                             struct genpd_onecell_data *data);
>
>  int genpd_dev_pm_attach(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> @@ -534,6 +538,18 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
>         return ERR_PTR(-EOPNOTSUPP);
>  }
> +
> +static inline int of_genpd_add_child_ids(struct device_node *np,
> +                                        struct genpd_onecell_data *data)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline int of_genpd_remove_child_ids(struct device_node *np,
> +                                           struct genpd_onecell_data *data)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>
>  #ifdef CONFIG_PM
>
> --
> 2.51.0
>

Kind regards
Uffe

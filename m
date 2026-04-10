Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1E31354F
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 00:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781957; cv=none; b=exQ0KEN2aLgZcHb/n7R2D4JwgvH1gsXr08N6PPTi9C5bTfSIWnW7SfHwZV/x+E4vJjgOEe4n8YQw7YGWE+r3VqbErfkGhum+NT2f66gJU+kzt9ieqngT6Wj8uZ7W9ivAnzjCCTgw3yVh2CcreRO5L/jdPjc6HKUHA8sU4KYRiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781957; c=relaxed/simple;
	bh=UQhzYqt7iG9PW7NJ/l/0O3inCh2nzIcBNTSfeZv/d0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nbCZb1aikDgs2ID9hKpKdR0Hy/iVf6+9Mq5kPTvkekMaXs4ACiqCHI6BS+RLEDrS5n5V4lp6Q+FYs4l6613KOv+oVEXMz/Oju8mTMK3ZwCExV3dDwHlUiTYbJ39nse5S/gnSme3VxMZxcRGxT2qxMmVV1/Bc2nrOMEXU7HuPqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=XuSckE6r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XuSckE6r"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0c8362d93so10451345ad.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 17:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775781954; x=1776386754; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqN2cIzftfYEekrpgNPDXUdrBnoMgDEUwL6BuRfPeX8=;
        b=XuSckE6rRVwsLhH/D2vaLaS11GJyFJ6YMKE+nEo6P6AGI56RePbyxwalcqXhA3hZMs
         +9sTtGUuzQb6oznIY2tsEme5JIVxVb7O9N+FBjsuovmVcp8YYxmxHn2VjX9tkZylwv01
         y+pDb6BbEf0KQc/AcOIToh9tUIFN+PITl/wt8RYm/njW1Mrj7864RGXzSixFBrEAZMLo
         drV5TRbD0VIqr9I/WPS2t2HorrO8919/U7UmUDk5iHwhwqW2qQJbUnIefSG2WMHca2op
         EEyLawJbDEwtHxvO6kFX/c5oKlwmdluO2e9TAQDeyKUu74WlB3QOe5qwo37J8NrxRS9j
         obXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775781954; x=1776386754;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqN2cIzftfYEekrpgNPDXUdrBnoMgDEUwL6BuRfPeX8=;
        b=tYDYRW6R/GvTylDWctUI7m0LWc8hDOB7pbq6OZaT2iL5Upf5D5rXHaxVXKy9fAUlKN
         jNb9oDzSzsFvFcJQ4GEl8gHNZEfqCxwLi2PTqUrR7Q5FeP1w7EVxPLaacCE0kjUmcP73
         bRtRorbB6ENYd44xQ7diEjt0tB/biUWRG9wbxLSAcH5/iqWqPiqTVvn6ZNALMex1hJqp
         PUTND3FUo7ZUfFZVLjIe1rxBAx/3KIZsTnAQKrIUooDSUxcow8ICALuTOygnV9Br92Yy
         BY78pieF9Okf7cL3rHolfiF7jDRG+juhJI13piWGPkOu9d4j/HZSYSPXWWIqYG4XpWfL
         Ul1g==
X-Forwarded-Encrypted: i=1; AJvYcCXvGgPXVipFWEFdnyAd2oRmsUWfzYmutzajQfqmYEroYgJUjFFe66NHcbFnau8o/JyWCuqvBAKPuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw87QVeS1BbxcC00C1ULd7FmbHZtNoSie7Il5eYjg+ZrzcVqmzv
	InQN06XkhflY5G6kOYqPrXJZSJLcq7MY3iyHfnVh9Rib76rYSHrPuw9zkYwrwdgb3FU=
X-Gm-Gg: AeBDieuvrf+2EWoszfkjD2e5TNH42pUqO7q9mEp+a8i//Olw5P4WMc0UFrBWnbzp+qg
	BkC9/Zd62n1/3me1Uog8iNrlDELMOo4ZfX4TvttyiKZP081PTHvB7EUgUYTxoUxsKdCw4FIDna9
	E4nNYfokDKW52UTuRnf2PxTzcQE4kGpMbx+ZDCQ3I2XgN77wnaqMzywxqDpbmua2WN4nVyV0DeC
	+sQJLVHa8pyoJ27Q+SItl6NULkUKEP6MU1kUAPw1BEYDusvcWpMwEgY1CnXMhbuelJVJel1rVuu
	rRLY8/E2wyFzx/f9giiYjvCO6C3j4Ne1Dp1YmMFTSAOg4Csdd52xx3N/QTBBeFwS1NDCBYRE55D
	HpsREft5QlcBpT5DktfMnJRZgkqkvp7BRUsMdCLztoxzYzXesB/2V9L8D/XGS/UJ8tOjlM693jN
	oin39ILPFhRB5BFYBOSW8=
X-Received: by 2002:a17:903:1b6e:b0:2ae:3b9b:db34 with SMTP id d9443c01a7336-2b2d5aa0becmr10846795ad.42.1775781953566;
        Thu, 09 Apr 2026 17:45:53 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f469casm7488445ad.81.2026.04.09.17.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 17:45:52 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] pmdomain: core: add support for
 power-domains-child-ids
In-Reply-To: <CAPDyKFquJ7K4NcWuKMr1sjrnFVVPGAeLCiSF_FhvJf9Frbn1uA@mail.gmail.com>
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-2-5361687a18ff@baylibre.com>
 <CAPDyKFquJ7K4NcWuKMr1sjrnFVVPGAeLCiSF_FhvJf9Frbn1uA@mail.gmail.com>
Date: Thu, 09 Apr 2026 17:45:52 -0700
Message-ID: <7h4iljskvz.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Wed, 11 Mar 2026 at 01:19, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>>
>> Currently, PM domains can only support hierarchy for simple
>> providers (e.g. ones with #power-domain-cells = 0).
>>
>> Add support for oncell providers as well by adding a new property
>> `power-domains-child-ids` to describe the parent/child relationship.
>>
>> For example, an SCMI PM domain provider has multiple domains, each of
>> which might be a child of diffeent parent domains. In this example,
>> the parent domains are MAIN_PD and WKUP_PD:
>>
>>     scmi_pds: protocol@11 {
>>         reg = <0x11>;
>>         #power-domain-cells = <1>;
>>         power-domains = <&MAIN_PD>, <&WKUP_PD>;
>>         power-domains-child-ids = <15>, <19>;
>>     };
>>
>> With this example using the new property, SCMI PM domain 15 becomes a
>> child domain of MAIN_PD, and SCMI domain 19 becomes a child domain of
>> WKUP_PD.
>>
>> To support this feature, add two new core functions
>>
>> - of_genpd_add_child_ids()
>> - of_genpd_remove_child_ids()
>>
>> which can be called by pmdomain providers to add/remove child domains
>> if they support the new property power-domains-child-ids.
>>
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>
> Thanks for working on this! It certainly is a missing feature!

You're welcome, thanks for the detailed review.

>> ---
>>  drivers/pmdomain/core.c   | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h |  16 ++++++++++++++++
>>  2 files changed, 185 insertions(+)
>>
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index 61c2277c9ce3..acb45dd540b7 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -2909,6 +2909,175 @@ static struct generic_pm_domain *genpd_get_from_provider(
>>         return genpd;
>>  }
>>
>> +/**
>> + * of_genpd_add_child_ids() - Parse power-domains-child-ids property
>> + * @np: Device node pointer associated with the PM domain provider.
>> + * @data: Pointer to the onecell data associated with the PM domain provider.
>> + *
>> + * Parse the power-domains and power-domains-child-ids properties to establish
>> + * parent-child relationships for PM domains. The power-domains property lists
>> + * parent domains, and power-domains-child-ids lists which child domain IDs
>> + * should be associated with each parent.
>> + *
>> + * Returns 0 on success, -ENOENT if properties don't exist, or negative error code.
>
> I think we should avoid returning specific error codes for specific
> errors, simply because it usually becomes messy.
>
> If I understand correctly the intent here is to allow the caller to
> check for -ENOENT and potentially avoid bailing out as it may not
> really be an error, right?

Right, -ENOENT is not an error of parsing, it's to indicate that there
are no child-ids to be parsed.

> Perhaps a better option is to return the number of children for whom
> we successfully assigned parents. Hence 0 or a positive value allows
> the caller to understand what happened. More importantly, a negative
> error code then really becomes an error for the caller to consider.

I explored this a bit, but it gets messy quick.  It means we have to
track cases where only some of the children were added as well as when
all children were added.   Personally, I think this should be an "all or
nothing" thing.  If all the children cannot be parsed/added, then none
of them should be added.

This also allows the remove to not have to care about how many were
added, and just remove them all, with the additional benefit of not
having to track the state of how many children were successfully added.

>> + */
>> +int of_genpd_add_child_ids(struct device_node *np,
>> +                          struct genpd_onecell_data *data)
>> +{
>> +       struct of_phandle_args parent_args;
>> +       struct generic_pm_domain *parent_genpd, *child_genpd;
>> +       struct of_phandle_iterator it;
>> +       const struct property *prop;
>> +       const __be32 *item;
>> +       u32 child_id;
>> +       int ret;
>> +
>> +       /* Check if both properties exist */
>> +       if (of_count_phandle_with_args(np, "power-domains", "#power-domain-cells") <= 0)
>> +               return -ENOENT;
>> +
>> +       prop = of_find_property(np, "power-domains-child-ids", NULL);
>> +       if (!prop)
>> +               return -ENOENT;
>> +
>> +       item = of_prop_next_u32(prop, NULL, &child_id);
>
> Perhaps it's easier to check if of_property_count_u32_elems() returns
> the same number as of_count_phandle_with_args() above? If it doesn't,
> something is wrong, and there is no need to continue.

Agreed. Will add.

> This way you also know the number of loops upfront that must iterate
> through all indexes. This should allow us to use a simpler for-loop
> below, I think. In this case you can also use
> of_property_read_u32_index() instead.

OK.

>> +
>> +       /* Iterate over power-domains phandles and power-domains-child-ids in lockstep */
>> +       of_for_each_phandle(&it, ret, np, "power-domains", "#power-domain-cells", 0) {
>> +               if (!item) {
>> +                       pr_err("power-domains-child-ids shorter than power-domains for %pOF\n", np);
>> +                       ret = -EINVAL;
>> +                       goto err_put_node;
>> +               }
>> +
>> +               /*
>> +                * Fill parent_args from the iterator. it.node is released by
>> +                * the next of_phandle_iterator_next() call at the top of the
>> +                * loop, or by the of_node_put() on the error path below.
>> +                */
>> +               parent_args.np = it.node;
>> +               parent_args.args_count = of_phandle_iterator_args(&it, parent_args.args,
>> +                                                                 MAX_PHANDLE_ARGS);
>> +
>> +               /* Get the parent domain */
>> +               parent_genpd = genpd_get_from_provider(&parent_args);
>
> Before getting the parent_genpd like this, we need to take the
> gpd_list_lock. The lock must be held when genpd_add_subdomain() is
> being called.

Good catch, thanks.

>> +               if (IS_ERR(parent_genpd)) {
>> +                       pr_err("Failed to get parent domain for %pOF: %ld\n",
>> +                              np, PTR_ERR(parent_genpd));
>> +                       ret = PTR_ERR(parent_genpd);
>> +                       goto err_put_node;
>> +               }
>> +
>> +               /* Validate child ID is within bounds */
>> +               if (child_id >= data->num_domains) {
>> +                       pr_err("Child ID %u out of bounds (max %u) for %pOF\n",
>> +                              child_id, data->num_domains - 1, np);
>> +                       ret = -EINVAL;
>> +                       goto err_put_node;
>> +               }
>> +
>> +               /* Get the child domain */
>> +               child_genpd = data->domains[child_id];
>> +               if (!child_genpd) {
>> +                       pr_err("Child domain %u is NULL for %pOF\n", child_id, np);
>> +                       ret = -EINVAL;
>> +                       goto err_put_node;
>> +               }
>> +
>> +               /* Establish parent-child relationship */
>> +               ret = genpd_add_subdomain(parent_genpd, child_genpd);
>> +               if (ret) {
>> +                       pr_err("Failed to add child domain %u to parent in %pOF: %d\n",
>> +                              child_id, np, ret);
>> +                       goto err_put_node;
>> +               }
>> +
>> +               pr_debug("Added child domain %u (%s) to parent %s for %pOF\n",
>> +                        child_id, child_genpd->name, parent_genpd->name, np);
>> +
>> +               item = of_prop_next_u32(prop, item, &child_id);
>> +       }
>> +
>> +       /* of_for_each_phandle returns -ENOENT at natural end-of-list */
>> +       if (ret && ret != -ENOENT)
>> +               return ret;
>> +
>> +       /* All power-domains phandles were consumed; check for trailing child IDs */
>> +       if (item) {
>> +               pr_err("power-domains-child-ids longer than power-domains for %pOF\n", np);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +
>> +err_put_node:
>
> This isn't a suffient error handling.
>
> If we successfully added child domains using genpd_add_subdomain(), we
> must remove them here, by calling pm_genpd_remove_subdomain() in the
> reverse order as we just added them.

OK, I was relying on the remove function to cleanup, but you're right,
if there's a falure during the add, it should be unwound before
returning.

>> +       of_node_put(it.node);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(of_genpd_add_child_ids);
>> +
>> +/**
>> + * of_genpd_remove_child_ids() - Remove parent-child PM domain relationships
>> + * @np: Device node pointer associated with the PM domain provider.
>> + * @data: Pointer to the onecell data associated with the PM domain provider.
>> + *
>> + * Reverses the effect of of_genpd_add_child_ids() by parsing the same
>> + * power-domains and power-domains-child-ids properties and calling
>> + * pm_genpd_remove_subdomain() for each established relationship.
>> + *
>> + * Returns 0 on success, -ENOENT if properties don't exist, or negative error
>> + * code on failure.
>> + */
>> +int of_genpd_remove_child_ids(struct device_node *np,
>> +                          struct genpd_onecell_data *data)
>> +{
>> +       struct of_phandle_args parent_args;
>> +       struct generic_pm_domain *parent_genpd, *child_genpd;
>> +       struct of_phandle_iterator it;
>> +       const struct property *prop;
>> +       const __be32 *item;
>> +       u32 child_id;
>> +       int ret;
>> +
>> +       /* Check if both properties exist */
>> +       if (of_count_phandle_with_args(np, "power-domains", "#power-domain-cells") <= 0)
>> +               return -ENOENT;
>> +
>> +       prop = of_find_property(np, "power-domains-child-ids", NULL);
>> +       if (!prop)
>> +               return -ENOENT;
>> +
>> +       item = of_prop_next_u32(prop, NULL, &child_id);
>
> Similar comments as for of_genpd_add_child_ids().
>
> Moreover, I think we should remove the children in the reverse order
> of how we added them.

I'm curious why does the order matter?  The children are all siblings
(no hierarchy), so why would the order be important?

I'm not ware of a phandle iterator/helper to parse in the reverse, so
that would mean iterating once to create a list, and then walking it in
reverse.  Seems unnecessary.

Thanks again for the detailed review,

Kevin

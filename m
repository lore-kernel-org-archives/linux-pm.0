Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB62E22BD
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811486; cv=pass; b=MnNGv5K7kby3f3UZMzvOIVHxcLj93rY4L0FtqXqPFFbypemuUCnHi4XXGuaV8LeJzQjmzJ9xYADclCLCDTSY00XHWhlnJ//jk8YzPeCoqH4wOY9MgaQAPHCd5ViPJoh6PwCFiOyiT5NheCgigUtrlbm7lg0Uum55mYtpIadl0hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811486; c=relaxed/simple;
	bh=iaYKT1sl2Tr/cLZwPA0Zvqg9ubw9wCPbruk9AwA0cek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZ5Mowxn1lgHK1v0t9YbkcjINkGUZE5IIw3Miagum13+Dig/W469fFsI+Xbmpf57LVQby60y+dY5XqTTj6kt/eV3bxrVuBixKWARbOUMoGmIYYb/v/3G1UTmos0jn08x0t24N5GAYTkDsfjls8tvroMmQUzUihsSOmucKsMlmQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qW/kT/NF; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qW/kT/NF"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a3e5b4acc1so1576639e87.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 01:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775811482; cv=none;
        d=google.com; s=arc-20240605;
        b=cMzjaAtX2pK543JtLgerYy+Zq9d5YZxRuzElw+BZDscie/mxsSBK2poZjBdqD2do3O
         d3sJQmFgbHj6BoiPG7cFPSqwJ9Z6mkZAdWnq1jp9mFxg3ApOmdEUGryaYly2eYUqy9A0
         NJGm8+2Vj0OJApoRBnakkA3mqya3Ek8uMY/7qOG4j0dWOV+K53xXydH5fWhBFrBySvT5
         leAA6dlsnIZBRwydSx9hlZU5Gk05DeBq+/gMkO1OOQAserRoTUJ2420lGfTtFiFlWzuj
         l6fRfjgg1q4WBWt0gcuTUVx+Iz/l9ZpUe0jwG4WBB4cCUaCeytqFOyB5lrz1DePLzOWV
         I6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z1vmmkZcYrQbBuSPIBwVZCij2+2X5p9lbMUk5Tsb6wM=;
        fh=17B/r/6yD2jQqsXM29XKAj+cpr5LdqBZ8Qvrq22t9JQ=;
        b=PPxLfLfOu24V37KXVM2DxHzhDYPpddKled11aet8dGaUP58Pm3Mip6Q5sh2BoX86gG
         XYJW+7sGsZ6PlomGI49sXJA1+4fCTDkVmC4kMPJPIFUYmrN6EowHwCPLjRxD2baug0vo
         Jq6l37/ma2vPSgHsmXUPP39bS4OW0lq3TQn7WSYxDal5s/cgnO9HcSKZ5QMUFWjc6Lln
         2PETABxd7TBLq8fV7vd0Nzl8Cy56F0kBULCvmUQblqBsBJ7Wa+p2QwqLJli0sKMhOfCh
         dFhljv3C/ClPmD2TmP6as4WkTglnZD6Tyx0IQWOqQRiZbqZDm+Af2Pdbm0GzVm4dMGih
         FApw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775811482; x=1776416282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1vmmkZcYrQbBuSPIBwVZCij2+2X5p9lbMUk5Tsb6wM=;
        b=qW/kT/NFo+XhkEqKBwLgGwFMLH+rH4rsWbCuYQHqlqBoIVsGX3AFU8FsJ5LyrqMCgG
         u92Rw8ZKiwWCdVr5TrFD6S2Q3lVNWvAwtBiazEHryzoWM68NyEO3tEZnsuMlG94qPAaS
         REZjxiVsOILaxQzEsmhRI72TSVZia7M8617I8HHJmiQwAUwYsfJjHTHu+GiehjhH9V+x
         CcjNZzJGVadFLKT4V9EPy5EPxtzSba0ZySbSZ2s2xXc3ELq7zTclCF7ufUKFEeoUvt26
         gCsJlqO6pG2y6xGY5DqKd4T8xd847j+lbuibBPZ9HLAFJl2NsXEWieUjMOSmtuJVGnaa
         rAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775811482; x=1776416282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1vmmkZcYrQbBuSPIBwVZCij2+2X5p9lbMUk5Tsb6wM=;
        b=DyNb5Zj+CjqSkW/yZrpQPKDzLHThtuDVUyFyQ3NMMCdx1BxTZTCwN62WNwTlmaDoqg
         THtZy6BOdeiNVPh+aFcgiaSsKczVr5GbA3gdvpdinVL+VS4FNSBl7hy5furehlC1vGUb
         MmvEQ6VRlw9h6qbIJUiRU/lX1GNznb+nkUfajkCLLXLeFAZH4lIlIji5CwHTSLugPUGG
         bFFt52QK++AtMUUsEPo4TZT8rA1QacmNiFTVc1xfTeADqmqLIz2J3uQZmNw2ljIQAumK
         9wWOW8wqwiPvJNpX80NCfKmEVpTXyRLbgbIGktJ2WISDTLh/CeQQCXv7eTppemow3Wbz
         mwyA==
X-Forwarded-Encrypted: i=1; AJvYcCWWWPGrui4wzZZLvrAZkoOy8gPy6VzBITPT4Fj/7rQdbzJCVQBZZnMpFqKR1SeMvZScKHdjZvMqXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/BCcF2ZGITkzN4AVLFySqhig/AY626gqoeHXgOIbdsysTrDs
	3uHfMDUs4QqVfTxRAcDMY/Cwjo4vbnaOhQELid1v62CsKiHvwbfV2KojjNbz2YwKt/TJH6oLJ7b
	y6hddVLMdZH7Sndpa/ufuKnUj7fMVi26c6yQQn+79Qw==
X-Gm-Gg: AeBDieu8nmrDxqxRfTC5nGRobXKkedDrtgDZm51HOocxvoOZALEBSUzI+1a0cngXl1S
	J1kVak8GQcqtMgsKF6HE3gQqdUWcuFCmM0XYWmOCqgJUqoBQp44GGwF7thxN5/6fztn+pOyV/6E
	m52xf3sxG0zHatU82dI1LUaekwmV6D13hsAmCl/dawV1tctfL7FSxxGkmL8dWX/bwTy2bJKSFUb
	GDbVbC9RAY4C9TsHqZni2+TSP6/FuKls2NRg//5yq5YYsMYVyHOD23D37d3Ggff8jGU4pl/n33a
	YoAIDn9q
X-Received: by 2002:a05:6512:1396:b0:5a2:c8d9:ec4a with SMTP id
 2adb3069b0e04-5a3ef9127demr836109e87.19.1775811482189; Fri, 10 Apr 2026
 01:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-2-5361687a18ff@baylibre.com>
 <CAPDyKFquJ7K4NcWuKMr1sjrnFVVPGAeLCiSF_FhvJf9Frbn1uA@mail.gmail.com> <7h4iljskvz.fsf@baylibre.com>
In-Reply-To: <7h4iljskvz.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 Apr 2026 10:57:24 +0200
X-Gm-Features: AQROBzDhT0oW3z8LEIG1Euo0M3-dmugaTMajHzsT9TLnPM4O-8m4J3dOe0QMXE4
Message-ID: <CAPDyKFrR2zyMFXTAkKs1XRgB-u5jSP256g730s=7SLuOZKsKVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: core: add support for power-domains-child-ids
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 02:45, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > On Wed, 11 Mar 2026 at 01:19, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
> >>
> >> Currently, PM domains can only support hierarchy for simple
> >> providers (e.g. ones with #power-domain-cells = 0).
> >>
> >> Add support for oncell providers as well by adding a new property
> >> `power-domains-child-ids` to describe the parent/child relationship.
> >>
> >> For example, an SCMI PM domain provider has multiple domains, each of
> >> which might be a child of diffeent parent domains. In this example,
> >> the parent domains are MAIN_PD and WKUP_PD:
> >>
> >>     scmi_pds: protocol@11 {
> >>         reg = <0x11>;
> >>         #power-domain-cells = <1>;
> >>         power-domains = <&MAIN_PD>, <&WKUP_PD>;
> >>         power-domains-child-ids = <15>, <19>;
> >>     };
> >>
> >> With this example using the new property, SCMI PM domain 15 becomes a
> >> child domain of MAIN_PD, and SCMI domain 19 becomes a child domain of
> >> WKUP_PD.
> >>
> >> To support this feature, add two new core functions
> >>
> >> - of_genpd_add_child_ids()
> >> - of_genpd_remove_child_ids()
> >>
> >> which can be called by pmdomain providers to add/remove child domains
> >> if they support the new property power-domains-child-ids.
> >>
> >> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> >
> > Thanks for working on this! It certainly is a missing feature!
>
> You're welcome, thanks for the detailed review.
>
> >> ---
> >>  drivers/pmdomain/core.c   | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/pm_domain.h |  16 ++++++++++++++++
> >>  2 files changed, 185 insertions(+)
> >>
> >> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> >> index 61c2277c9ce3..acb45dd540b7 100644
> >> --- a/drivers/pmdomain/core.c
> >> +++ b/drivers/pmdomain/core.c
> >> @@ -2909,6 +2909,175 @@ static struct generic_pm_domain *genpd_get_from_provider(
> >>         return genpd;
> >>  }
> >>
> >> +/**
> >> + * of_genpd_add_child_ids() - Parse power-domains-child-ids property
> >> + * @np: Device node pointer associated with the PM domain provider.
> >> + * @data: Pointer to the onecell data associated with the PM domain provider.
> >> + *
> >> + * Parse the power-domains and power-domains-child-ids properties to establish
> >> + * parent-child relationships for PM domains. The power-domains property lists
> >> + * parent domains, and power-domains-child-ids lists which child domain IDs
> >> + * should be associated with each parent.
> >> + *
> >> + * Returns 0 on success, -ENOENT if properties don't exist, or negative error code.
> >
> > I think we should avoid returning specific error codes for specific
> > errors, simply because it usually becomes messy.
> >
> > If I understand correctly the intent here is to allow the caller to
> > check for -ENOENT and potentially avoid bailing out as it may not
> > really be an error, right?
>
> Right, -ENOENT is not an error of parsing, it's to indicate that there
> are no child-ids to be parsed.
>
> > Perhaps a better option is to return the number of children for whom
> > we successfully assigned parents. Hence 0 or a positive value allows
> > the caller to understand what happened. More importantly, a negative
> > error code then really becomes an error for the caller to consider.
>
> I explored this a bit, but it gets messy quick.  It means we have to
> track cases where only some of the children were added as well as when
> all children were added.   Personally, I think this should be an "all or
> nothing" thing.  If all the children cannot be parsed/added, then none
> of them should be added.
>
> This also allows the remove to not have to care about how many were
> added, and just remove them all, with the additional benefit of not
> having to track the state of how many children were successfully added.
>

I fully agree, it should be all or nothing. Failing with one
child/parent should end up with an error code being returned.

That said, it still seems to make perfect sense to return the number
of children for whom we assigned parents for, no?

[...]

> >> +int of_genpd_remove_child_ids(struct device_node *np,
> >> +                          struct genpd_onecell_data *data)
> >> +{
> >> +       struct of_phandle_args parent_args;
> >> +       struct generic_pm_domain *parent_genpd, *child_genpd;
> >> +       struct of_phandle_iterator it;
> >> +       const struct property *prop;
> >> +       const __be32 *item;
> >> +       u32 child_id;
> >> +       int ret;
> >> +
> >> +       /* Check if both properties exist */
> >> +       if (of_count_phandle_with_args(np, "power-domains", "#power-domain-cells") <= 0)
> >> +               return -ENOENT;
> >> +
> >> +       prop = of_find_property(np, "power-domains-child-ids", NULL);
> >> +       if (!prop)
> >> +               return -ENOENT;
> >> +
> >> +       item = of_prop_next_u32(prop, NULL, &child_id);
> >
> > Similar comments as for of_genpd_add_child_ids().
> >
> > Moreover, I think we should remove the children in the reverse order
> > of how we added them.
>
> I'm curious why does the order matter?  The children are all siblings
> (no hierarchy), so why would the order be important?

It might not be that important, but generally, it seems like a good
idea to me to reverse the order when undoing things.

>
> I'm not ware of a phandle iterator/helper to parse in the reverse, so
> that would mean iterating once to create a list, and then walking it in
> reverse.  Seems unnecessary.

Sure, I leave the call to you, to see what fits best.

Kind regards
Uffe

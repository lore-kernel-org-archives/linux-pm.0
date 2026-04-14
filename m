Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CF2C21C7
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174209; cv=pass; b=DdlfNh9/WiTWEDhsF7OHund6MSjotWtfi+KobU8+8Pf5F+7OSz9f2xu1BJr4r5XzoTPkl+b9buX1gyNq4gNMv2+esKZVarmsJwFrEfi4O2KfnNjxsn2xgOuYbfEqj4pP+2Mtc2uZ6AXX1QcMq0gwRnF2CIZJD95vpUobQthtnqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174209; c=relaxed/simple;
	bh=+FMcleE/RJk8JXq4ZJIsUVYV4jwK9150VQYwhJJuz3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYnSbsC6AyNStFEqY5TEqJAubsG5GVJUycc5vArEQJU7FegBNGvzGUaK7TxW6GX07UQ8476dhfhhWjENIGwftlCO3gknALBDWyx2Y8xGl4/4pFw0TFw/DVNhLeCNbmfW8hP65c9pavCWqphBSKslCErelthGW6UditWtcja0BlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MzGXfcs1; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzGXfcs1"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a4053964e3so1065425e87.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 06:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776174206; cv=none;
        d=google.com; s=arc-20240605;
        b=EbelI7NzzWFdawKewdjgA0M76a34LLRCzQZHcK04UOUQ8cfCLvy5wYCVj/7A+ehXwn
         lGp5ybqL4vJsag95gWpG1IwBvWO5k+aEZLoNHJ78jCILPdK0H3akdM013Wog/oKpXbfx
         iuWwploDHNqvM750YwkU/Fdirg/YAN4SzA2SbRR7O3QUI6EEVbJV+Zo8AXE0sK0KQP8M
         VMqOb/OLLbINTn7djHR/0HeO1Gje9yfOa3J5440dvCaRQDoD9vLrIyemlwP7zXJ3mo4I
         MdYPeCeuvaOY9FA0hgF12cbjRipqNL8xoCeKeVddMM3BvW3TOQ7pWO2/ebBfo4WJIdeL
         BsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zy/0PzEut0PvWHR237jELAY9rSr5MyVNvmg6pBAc6Og=;
        fh=PJ4WMK4ReJcpct/COnuHWfKUG2/NL4pScN5rC1HrXQI=;
        b=kss4s7HChhVE8z2MQ6YAJgJBi1Te805JqJ1hvHDCq8B5BMFl4Xhoh40bKKSf9SmT11
         LYebiOmDp7d8zpnm95/VB/GH16irx36z9SOWJt3WsQPoAr5L45wlb/MIqusjHrI/0GnS
         qdCSTRkmjU9pQigfNzhgKVS54Xga5mVEMM/O0VFTLDwHqFha0VpoemHX7GPWUGE9W05p
         1ZgNbJFBlHVJCCQGB7VwVDKfgYNTgNopNb1VJ0gjqmdb6ZG6hnWkXeFoUBYh3sY/oTHB
         c+E3LaE/psiiVd/D5EaOcTf0DnPE7F7dv4U8lYs9QdLvvMPdIw8RukiwDTpfUOk8iqMe
         1+Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776174206; x=1776779006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy/0PzEut0PvWHR237jELAY9rSr5MyVNvmg6pBAc6Og=;
        b=MzGXfcs1iOQSunlCSB7WO0Z7I5Zt2w0pLfXkAxiFTN86ZKsQkD0Kcq5WR+Ldg0ps5p
         vhYpW4hEFLI1dY9mZ9wLG7mNUuW1iihIdFpd4VMkO9FH6TZkdZsoBV9Ir6HVacdXJeUb
         0dSs5OFUKdbRs1NsrcxJetfOUIGwUKtn9dx2yaW9++G7vcwQXdaa5SaS4j/5BdHRHOsb
         LDipjcwb1SBg8JAvf5kkoFZjNU5Ezc8QLcElWRqfxYawL9o1HW7sUtEOwFiw32JFgyJg
         ZL2qznySay7+ha1NOnCez+73WpuDSzC1+VgFK4esY4Ems05DGSJr0CD3SMVMk1pMqjaS
         jL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776174206; x=1776779006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy/0PzEut0PvWHR237jELAY9rSr5MyVNvmg6pBAc6Og=;
        b=r9CyXgL1P8hjN79jseRi4MLKH2BfMpTTy89zrRvgkSLQPwW8aN6b6EQGWO5FxRrg3d
         isxew9gbomqbetcSh0ZnUxHy/kN1KFMEWZt+c69MAZCQLxZD0BL8R4Pte5yncMy23peE
         2mzQhJ2yadzWgSeZGyIIj6hkTFebbbiU4BdjAX+D0IR1D9432cxklHlT2KbvNOOwYhkM
         9UycpwZjgzXvMTDYNwbxyyREd71x4Oi4ofnSjk+JWo0J0Qb9sEbQjjGjI5yHw2ew0+Zp
         CuKZgEXisLer9VJy8GnO4AIkN3HxPhc/CcFtV5xOXjoaWZmbrbDrNz+BCjh9lV/oDIqq
         3dww==
X-Forwarded-Encrypted: i=1; AFNElJ/DrOinwjwD90MeyLtfxJcffN3bA5+IbsA7eOSKvQNUGl9h1aLAzCKprCC3aPbmBiJGvnT+uLMxrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGKYZFBHJ2fh7HNy981eE409Xjk7NkGBfa8+Yfy4QZ8ZrZOq0
	8nWL4yWVIJ0m3rKPkexf8TMZvmwe9gF5pyDeIuTPsfcL5oEbf72DgjnInGee66qsgFI+0C9GONb
	yTA7m4z0wfZjjee1x2toOj0pgIApNca0nNkkbdQhTlg==
X-Gm-Gg: AeBDiev7Y/lIk7hg2z/MAyX7wHCdLS4rZfIh3e+I+kA7L7l4MJj+NQ1XNLvsu9NKzNC
	clpcakbYhmQP7TcmPAJL1ZNBmdc0MBPSQm6HU579xq7KO4J10lVKXDCna+3ve/7pKE0h8w2HBDg
	I9R4ZGckvgdLngvcLsdOAt3pXXBEbg6OUv7ZvQpDccxRd2o8HgKUOAgt4pMp28hMTNP1P2/IPvc
	Emym9Zd6EzhgBUeAsUeb9V3I4rX/2VNT/ODEGjL6G/hiluqmKmENMSoTvr1veQAoZIcOotXqwye
	xq/4SdqbmnPiNblYAw8=
X-Received: by 2002:a05:6512:692:b0:5a3:d3ac:505e with SMTP id
 2adb3069b0e04-5a3efb62ae8mr5639501e87.44.1776174205307; Tue, 14 Apr 2026
 06:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-2-5361687a18ff@baylibre.com>
 <CAPDyKFquJ7K4NcWuKMr1sjrnFVVPGAeLCiSF_FhvJf9Frbn1uA@mail.gmail.com>
 <7h4iljskvz.fsf@baylibre.com> <CAPDyKFrR2zyMFXTAkKs1XRgB-u5jSP256g730s=7SLuOZKsKVg@mail.gmail.com>
 <7hqzomqwpv.fsf@baylibre.com>
In-Reply-To: <7hqzomqwpv.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 14 Apr 2026 15:42:47 +0200
X-Gm-Features: AQROBzD-JbDP-fgOPRrseyRbXAcHRr7LSIAAw6wp14sGFXLCR1gaiFIhrIczbGk
Message-ID: <CAPDyKFpWwwuxdU63Kuq_zoKkrFhkSjN6RrxdOCoL2u7JuH9B2w@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: core: add support for power-domains-child-ids
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Apr 2026 at 00:25, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > On Fri, 10 Apr 2026 at 02:45, Kevin Hilman <khilman@baylibre.com> wrote:
> >>
> >> Ulf Hansson <ulf.hansson@linaro.org> writes:
> >>
> >> > On Wed, 11 Mar 2026 at 01:19, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
> >> >>
> >> >> Currently, PM domains can only support hierarchy for simple
> >> >> providers (e.g. ones with #power-domain-cells = 0).
> >> >>
> >> >> Add support for oncell providers as well by adding a new property
> >> >> `power-domains-child-ids` to describe the parent/child relationship.
> >> >>
> >> >> For example, an SCMI PM domain provider has multiple domains, each of
> >> >> which might be a child of diffeent parent domains. In this example,
> >> >> the parent domains are MAIN_PD and WKUP_PD:
> >> >>
> >> >>     scmi_pds: protocol@11 {
> >> >>         reg = <0x11>;
> >> >>         #power-domain-cells = <1>;
> >> >>         power-domains = <&MAIN_PD>, <&WKUP_PD>;
> >> >>         power-domains-child-ids = <15>, <19>;
> >> >>     };
> >> >>
> >> >> With this example using the new property, SCMI PM domain 15 becomes a
> >> >> child domain of MAIN_PD, and SCMI domain 19 becomes a child domain of
> >> >> WKUP_PD.
> >> >>
> >> >> To support this feature, add two new core functions
> >> >>
> >> >> - of_genpd_add_child_ids()
> >> >> - of_genpd_remove_child_ids()
> >> >>
> >> >> which can be called by pmdomain providers to add/remove child domains
> >> >> if they support the new property power-domains-child-ids.
> >> >>
> >> >> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> >> >
> >> > Thanks for working on this! It certainly is a missing feature!
> >>
> >> You're welcome, thanks for the detailed review.
> >>
> >> >> ---
> >> >>  drivers/pmdomain/core.c   | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >> >>  include/linux/pm_domain.h |  16 ++++++++++++++++
> >> >>  2 files changed, 185 insertions(+)
> >> >>
> >> >> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> >> >> index 61c2277c9ce3..acb45dd540b7 100644
> >> >> --- a/drivers/pmdomain/core.c
> >> >> +++ b/drivers/pmdomain/core.c
> >> >> @@ -2909,6 +2909,175 @@ static struct generic_pm_domain *genpd_get_from_provider(
> >> >>         return genpd;
> >> >>  }
> >> >>
> >> >> +/**
> >> >> + * of_genpd_add_child_ids() - Parse power-domains-child-ids property
> >> >> + * @np: Device node pointer associated with the PM domain provider.
> >> >> + * @data: Pointer to the onecell data associated with the PM domain provider.
> >> >> + *
> >> >> + * Parse the power-domains and power-domains-child-ids properties to establish
> >> >> + * parent-child relationships for PM domains. The power-domains property lists
> >> >> + * parent domains, and power-domains-child-ids lists which child domain IDs
> >> >> + * should be associated with each parent.
> >> >> + *
> >> >> + * Returns 0 on success, -ENOENT if properties don't exist, or negative error code.
> >> >
> >> > I think we should avoid returning specific error codes for specific
> >> > errors, simply because it usually becomes messy.
> >> >
> >> > If I understand correctly the intent here is to allow the caller to
> >> > check for -ENOENT and potentially avoid bailing out as it may not
> >> > really be an error, right?
> >>
> >> Right, -ENOENT is not an error of parsing, it's to indicate that there
> >> are no child-ids to be parsed.
> >>
> >> > Perhaps a better option is to return the number of children for whom
> >> > we successfully assigned parents. Hence 0 or a positive value allows
> >> > the caller to understand what happened. More importantly, a negative
> >> > error code then really becomes an error for the caller to consider.
> >>
> >> I explored this a bit, but it gets messy quick.  It means we have to
> >> track cases where only some of the children were added as well as when
> >> all children were added.   Personally, I think this should be an "all or
> >> nothing" thing.  If all the children cannot be parsed/added, then none
> >> of them should be added.
> >>
> >> This also allows the remove to not have to care about how many were
> >> added, and just remove them all, with the additional benefit of not
> >> having to track the state of how many children were successfully added.
> >>
> >
> > I fully agree, it should be all or nothing. Failing with one
> > child/parent should end up with an error code being returned.
> >
> > That said, it still seems to make perfect sense to return the number
> > of children for whom we assigned parents for, no?
>
> No, because what will the caller use that number for?  If we are
> assuming "all or nothing", what would we use it for (other than a debug print?)
>
> It also makes it a bit confusing what a zero return value means.  Does
> that mean success?  Or that zero children were added (which would be
> fail.)
>
> I prefer to keep it as is.

In that case, how should we treat the scenario where the device node
lacks a "power-domains-child-ids" property? In some cases it is
probably fine, while in others it may not be.

I guess the caller of of_genpd_add_child_ids(), would then need to
pre-parse for the "power-domains-child-ids" property before deciding
to call of_genpd_add_child_ids().

At least, we don't of_genpd_add_child_ids() to return an error code if
there is no "power-domains-child-ids" in the device node, as that
would just confuse the caller.

Kind regards
Uffe

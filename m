Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9B3B2FED
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723212; cv=none; b=QA8u0njLSGqyh/S3hxU4i3Tnjmp3Md8VjAhZo1yvKV22cEL+5WCm8zbjYHbK27SEafTiXpEUAclsTJG0isYT6pdNezK/bW4012IVSzl/Vds2Yg0W8QfEbG34jt7k9pnqGdwl1PJbMN2UA4oPCqh1WgdOkHi7WVP8vKU4FVg7eeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723212; c=relaxed/simple;
	bh=z9NkR3ZW4vZK6qX1fJftBl0sOBKAjlQ9fow3/geyKVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kmtV5S3XTXZ0mVFA9tf7F7o/mIhNjme63oSAIw7XzdMhX9T4dq9jj2qyss4yinCy8x7krdrrlreuU0bWvuic4LeltRW16hImMFpyfJxEJ12XvIGOwQMA28MSSVcjxRcVPpPnZ+x3/O0qVsI51LQsSYljkrXs7WXDktifXcPZBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=HA2xoYI7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HA2xoYI7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35fb7c1a455so1439810a91.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776723209; x=1777328009; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cxzSQy02s9Bj8FdW0h2jty6fTQ6PSdmvvyWsuKJqNZM=;
        b=HA2xoYI7yu5qpxNQdkOkplIGmeRNOso5LHO5I/6jm6keP4tianzDAfJTtL1WXhtOdL
         1/VcizyId6fiZ5ofcPs0tP3dNGNwJgWIxUBm2agOF6gantHERC3TjsM5IYrwr8GwQg+W
         HhjQ7KL4mgJtkijCyh2Xx1+Tk09X3NBr92ng2mCr1j39flsRPHo29GgmbmUEmPK8ZcN7
         K1cGU3GK6eGyAnsZEfOSI/Ro/1vb4P6jQePcmxQf7k6VXIrifSgjq8hXji4HIwD5vdHD
         3OgYwgb2JDcW51NH1qZOVN/zkd22oCJhp5QSXmV1zEhyKujHt7ghsGRyBeId6+IYVsoV
         vVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776723209; x=1777328009;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxzSQy02s9Bj8FdW0h2jty6fTQ6PSdmvvyWsuKJqNZM=;
        b=SEdGD2FR5xiiGPUm99K0Smne7NEYIjAvfdn10KQhLEpjkrZKlPrZNanBn1oEOYRH0a
         drX8avEBc5pPtC2x5z5POIBCuxvPGJPGY/Hr82DggN1+50LOgjs9KGNdNkFUCnHIoRnt
         5F9tAkerh7ZiLFP5cESdejCO/hEhMDGBIzaw8qXkpG4vXwnl/zGNnM1rIA66xZpjJjvB
         tLhGtDXouWX9BlPtaqzR8zr9MWKt9tuC7pVM1MzaV8KAYa6meBWgVIoirGLYSP7lySmQ
         MDAsv2vUSRs2Kwa0RZmCciKuG9LasQZRDj/nyJKlwSlqO3yBg2x1q7Lbor0EwWpKFhZ6
         53PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/T/8xh9FsnnAkTlrTQBWypi7t5ssKcUGRSD6d8fY63j25q+iLFLXQceqOp3ISoaCGIrz3zQJLAoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTeMApEMFZNVDrK375PhOfvSd7mdYCWvyxw0ZgLuabUBJP9/v
	IY8R0KRgc2HwA9VXjnE0mmLcwndU54Han79W3hxPJc7Baov2SrBjbKKZgPS11rU0f+Y=
X-Gm-Gg: AeBDies0dM8rdSM9XjIG+s7l1cj49tPOFi7OOMwRRLwKhaGHT2nUfes2mcCFRBB8Erd
	SZRHMp69cSnKSjCXyA08A0HRdLe4jqwEpq4YYxI95+D3INpXg86aGkf75dxS4PcUOaVEl6EgV21
	qKtupeJQTUEOMQkTlc3Bd9bhVxXsaD4chzwE227d+u7HJ5/wUE4iGZ7mkUGh1ievbNVGlOo0SK9
	cZPeK5h22YDdlEAIgsYQiaYdEAYV9+s/b2OKzrIi44kR/ZdYfccVE0gAbJySf92ojVKSywN5s+V
	sb9G5aSVdvit5Tnzew387+iiIBfwaiGNz04ruygS2SCaXuwT1ncyeMWMTQ0lClmR54ho5C3mYs8
	VdQTJUUfj687XB9MJ1siL8+Ldmz4bmRSwOZFfJAmelsI+KHvPvmdUDW/U0PtEJ7GFUEurGmjjG6
	bbGgu4lnxaZYNIDPW8mvm1m6Yf8QSRtjaCzoJYCjDm
X-Received: by 2002:a17:90a:d0f:b0:361:45df:114 with SMTP id 98e67ed59e1d1-36145df0462mr8669670a91.19.1776723209365;
        Mon, 20 Apr 2026 15:13:29 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140edb04dsm11668100a91.0.2026.04.20.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 15:13:28 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] pmdomain: core: add support for
 power-domains-child-ids
In-Reply-To: <CAPDyKFrbk8SZs+-WMkbKnh12+OTBtoZ2bwtuASGvAsZwJEd4vQ@mail.gmail.com>
References: <20260410-topic-lpm-pmdomain-child-ids-v2-0-83396e4b5f8b@baylibre.com>
 <20260410-topic-lpm-pmdomain-child-ids-v2-2-83396e4b5f8b@baylibre.com>
 <CAPDyKFrbk8SZs+-WMkbKnh12+OTBtoZ2bwtuASGvAsZwJEd4vQ@mail.gmail.com>
Date: Mon, 20 Apr 2026 15:13:28 -0700
Message-ID: <7hldehqnzr.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Sat, 11 Apr 2026 at 01:44, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
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
>> The add function is "all or nothing".  If it cannot add all of the
>> child domains in the list, it will unwind any additions already made
>> and report a failure.
>>
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>>  drivers/pmdomain/core.c   | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h |  16 ++++++++++++++++
>>  2 files changed, 182 insertions(+)
>>
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index 61c2277c9ce3..f978477dd546 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -2909,6 +2909,172 @@ static struct generic_pm_domain *genpd_get_from_provider(
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
>> + * Uses "all or nothing" semantics: either all relationships are established
>> + * successfully, or none are (any partially-added relationships are unwound
>> + * on error).
>> + *
>> + * Returns 0 on success, -ENOENT if properties don't exist, or negative error code.
>> + */
>
> As I mentioned in my earlier reply for the previous version, returning
> a specific error code when the property doesn't exist will complicate
> handling for the caller. Moreover, we also need to make sure we don't
> returning the same error code (-ENOENT) for a different error further
> down the execution path in of_genpd_add_child_ids(). Otherwise it
> would the caller treat the error code in the wrong way.
>
> To me, there are two better ways to address this. For both options,
> of_genpd_add_child_ids() should return 0 when
> "power-domains-child-ids" is missing.
>
> 1) Add another helper function that checks if
> "power-domains-child-ids" exists. The caller can then use this to
> pre-parse the property and decide whether to treat it as an error.
>
> 2) As I suggested earlier, let of_genpd_add_child_ids() return the
> number of assigned parents/children, while still using the all or
> nothing approach, of course.

OK, I like (2) better.  I'll respin with that approach.

Kevin

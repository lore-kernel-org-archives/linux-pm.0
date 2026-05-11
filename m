Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF93C7E1B
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497030; cv=pass; b=fyYY0awDOTK910TVNaLAB8K9UUlurw21BJWrM0LnN+Y6Ylxy8qbVwyZUOIHLjtmgmUzl8x4L9P+AqUeH4DfA7XOE9ojq6csXby1qABejOd3qTlsSjRVTMAcS+rKT6tmToXUhQNdpgSgRGqIScsw8xmg4Spz8sbNIGJ5LKOnI68k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497030; c=relaxed/simple;
	bh=vTJLEVLprN0YEUXOPQmVZfla90xDkYrYmcqtfv4q/AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgwZvO+Ky6ilEFLiMy47YIbXDwntGuH2HXxvubzrcDoSFOHaFSW7Oq3vkJwa1rixqrjLehNwoBCK9SKWWYxubN6ahyuZ/7CLKRxtPJKQjdDgc1gf+BkX52XeVnQ894zPFRQHZBJVEoOGpiWiwsQ4Z2lFWU7Ho/gGQaCwNS5PKxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UeSDOZ5e; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeSDOZ5e"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso5373214e87.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 03:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778497027; cv=none;
        d=google.com; s=arc-20240605;
        b=gUpVyHbG+qTuxctfmT9ddfuud/d4Ff4zaMtpVWpqa0D2V6E1ozBWfB8UOTBF1ngFpe
         33NhF7tD5gYUtkBNuB7JgKDgWpDcCmvyPooboFn/vCGau6LrpdmYIE+YBOAMJzHgb6ha
         1U7LVxywD4d3DlA2MzAZZY5x/Zb3+gKJzYaCPwZsUONZgn78caZazdzbA1b3gUPDLCjI
         d3dm3RRYouhFP9pNDG/hOfiwZKOg7ZdOHBxcPV+hKGE4ZbfiuEnAnQn7upbS5GbgXVno
         9hYN9/lsrBxo/cgJGXBdw6k53Z/py7Lzt55v+Q5vJ/564Rsh6z9W+Z/j4wrVmU3NY/AM
         Yw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UNgY87VaqJb6Z7Z0eDu16xO5cNHcZbmgVwEFK0s2B6M=;
        fh=vbzBi1/x06aQtrmjdQctk9r47zdo3nrNHlw3vlj9/7Q=;
        b=I14hqMbivzVFi3Uu3JZAgz0GcqfTbWoTunZC7STTbjWdJBLiImJxdtuUfmXcfH8Kdj
         frs17huZze2UlCMYtFxfNg31tRrt7AEYrxloR1CCGp6baz9g74B39PkkWKhWuJ+OMU1Q
         ZRq7DZ5vJdVBdUeUymJ9yWdQsFBPiLkwZRbgdg4crK4WwuKRPVLBXpnCq66aoMhnZU5K
         ztThsV3cKkRSbuVhk9DYF7MbP7V7BPYiBCYk9XgfXOGMc4GMkaKDkf6+lr2jkiwsHadq
         5DWajqG485pxvWFx4tpyA6ulyPUVu0BFIB+LO4+xv6WbVW0gvPU86XvzbLYEs1ULEp0w
         6+CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778497027; x=1779101827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UNgY87VaqJb6Z7Z0eDu16xO5cNHcZbmgVwEFK0s2B6M=;
        b=UeSDOZ5eeT/pq5FepKDmyABTPObEM6q5ig+jAD4OkOLjS6W2CrM/eZJqLA3GguC7RR
         8sLFvgbFYZ/E1DVTxkA+8JEVKVLhi/gvNKeVcduidmJ7uGlgk8dy3T3K2Dgf6xz3alcz
         370NvSkutIyKaEOMcBuJ7MjOyGMuVtoABjkUiEGz4EyoJ/YdSOVancm0s2hqneqwm4Hq
         qC/ojsoiYOYfALGSaIyUGHZZvI0U/7jCsZjkk0luHT+7KWq4vOnAZ/esNVmie95+Dd7T
         FANeuoXsGYdEmP5JkB/cDIRd1Hxq2WdsjseAQ5tmnmRrN4wneWRbxGHjgvMFbNjzMc1e
         RfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778497027; x=1779101827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNgY87VaqJb6Z7Z0eDu16xO5cNHcZbmgVwEFK0s2B6M=;
        b=YqeJrCkmKoAP8y41fWQiY3Pmca14Ip+DeMMmKc1mZ7J2PkdA8Fqagix4+hhl2vQ6PZ
         VEkbnGziaSYyi51spwX/PIsS/q6E7SotgnWgKGTichLXF4L8XboL2v8PxDR3SjVJBLz+
         oVPZJ/huofH14hSqj4lnQuCK1QFklEg13x5eQuOUvnuaWac8HyArlsXUbsHg/H0lpaFv
         KGJlXY770/tf/JVncaAsZIU7vPYRQwXaVc3VePuZYu9iXFmF98GjB04Qm8Wnty44mJNd
         oFQJfhSvoRWnDAfghZmexQHWsRhZihqqAIk/vMAQzS87Th9oZmE67AFb0B3+VXbDAlpS
         d6uw==
X-Forwarded-Encrypted: i=1; AFNElJ8t1o86ZGtXlLrmVgx/rDsOZI6g+v/0IcHigVYK4s3AdW/HiEPk/JPgNGf7A8/hy1QecLd56tcE8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBthRHDmb4RBtB9/HTl81ZTnoeUwucxbJVBELki4rQnws3UOlS
	nyut2+iq0Gl1CXmysvf6FRegq1ZUpm4vTzWhqVmN1uDIhMX5IGOXhI1aaMLrf1bT8Z8jKFrXOZW
	UOdViio8g8sWW5Xf3IyFe3+Q3hqhgJP0LI7UliU1T3g==
X-Gm-Gg: Acq92OFcto5y+4624E+hHLhk2zP3QlgEr5geNHfI4vbtaJBdtkbJfq+hH03Zy3g95ii
	s52Ocrp1aVS8QyA211Gj+A+ffYWYBeiKtSWoiO9W/Fwn9f2AItTc/0ZEFFk4c28QS8tK5E1W3mb
	iahzGx49AaZBsA3cxU2DTTHRM+/HE/Qtcf35vRqg1RM4qPOZD0c+i1NDTR+TgCR/rGVhGXUm4UB
	RAY/s9PSc0RsKFrKOwkRzcfJoVZia8EgbLZQlRhFN4LDZRslS9c1nsARwMmh6ZMA7DR79hfaNVr
	+6dWu1aPcT0douMUrN32AHg+Gkh+vQ==
X-Received: by 2002:a05:6512:3b97:b0:5a8:837b:3d62 with SMTP id
 2adb3069b0e04-5a887ae201amr7135423e87.9.1778497027226; Mon, 11 May 2026
 03:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-topic-lpm-pmdomain-child-ids-v3-0-c2c40bef238c@baylibre.com>
In-Reply-To: <20260420-topic-lpm-pmdomain-child-ids-v3-0-c2c40bef238c@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 12:56:30 +0200
X-Gm-Features: AVHnY4K5Fa8XIOuKEc9fwP0nNsU7-2i8Jr2vSBdRJyGo1uaG2J7xzeVbIFlyyOo
Message-ID: <CAPDyKFr4TdLP825VrpC+gELKOnHHFK=oZ7x8HWQaKFox8Ur0Tg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] pmdomain: core: add support for domain hierarchies
 in DT
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 at 01:51, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>
> Currently, PM domains can only support hierarchy for simple
> providers (e.g. ones with #power-domain-cells = 0).
>
> Add support for oncell providers as well by adding a new property
> `power-domains-child-ids` to describe the parent/child relationship.
>
> Also adds the first user of the new API: the Arm SCMI PM domain driver.
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
> Changes in v3:
> - cleanup return codes for add_child_ids()
>   - < 0: error
>   - zero means no child domains present
>   - > 0: number of child domains added
> - arm_scmi: adopt to new return codes (only <0 is an error)
> - Link to v2: https://patch.msgid.link/20260410-topic-lpm-pmdomain-child-ids-v2-0-83396e4b5f8b@baylibre.com

The v3 series applied for next, thanks!

Kind regards
Uffe

>
> Changes compared to initial RFC[2]
> - dropped RFC
> - rewrote the parse/add function to use iterators/helpers from of.h
> - add a remove function for cleanup
> - use child domain language instead of subdomain
>
> This idea was previously discussed on the arm-scmi mailing list[1]
> where this approach was proposed by Ulf, and then an initial RFC[2]
> implementation was made.  From there, it was suggested by Rob[3] to
> use a nexus node map instead, which led to several more versions
> attempting to implement that, culminating in v5[4], where Rob and
> Geert then had second thoughts about the power-domain-map approach.
>
> Therefore, I've gone back to the approach in the initial RFC[2] to use
> the child-ids approach.
>
> [1] https://lore.kernel.org/arm-scmi/CAPDyKFo_P129sVirHHYjOQT+QUmpymcRJme9obzKJeRgO7B-1A@mail.gmail.com/
> [2] https://lore.kernel.org/all/20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com/
> [3] https://lore.kernel.org/all/20250528203532.GA704342-robh@kernel.org/
> [4] https://lore.kernel.org/r/20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com
>
> Changes in v2:
> - dt-bindings: fix warinings from make dt_binding_check
> - scmi_pm_domain: switch to dev_err()
> - pmdomain: core: fix locking around add/remove domains
> - pmdomain: error unwind if any children fail to be added
> - pmdomain: fix node reference leak
> - pmdomain: ensure power-domains and child-ids properties are same
>   length before iterating
> - Link to v1: https://patch.msgid.link/20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com
>
> ---
> Kevin Hilman (TI) (3):
>       dt-bindings: power: Add power-domains-child-ids property
>       pmdomain: core: add support for power-domains-child-ids
>       pmdomain: arm_scmi: add support for domain hierarchies
>
>  Documentation/devicetree/bindings/power/power-domain.yaml |  34 ++++++++++++++++++++++++++++++++++
>  drivers/pmdomain/arm/scmi_pm_domain.c                     |  14 +++++++++++++-
>  drivers/pmdomain/core.c                                   | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h                                 |  16 ++++++++++++++++
>  4 files changed, 230 insertions(+), 1 deletion(-)
> ---
> base-commit: f7b88edb52c8dd01b7e576390d658ae6eef0e134
> change-id: 20260310-topic-lpm-pmdomain-child-ids-e3d57ae57040
>
> Best regards,
> --
> Kevin Hilman (TI) <khilman@baylibre.com>
>

Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8425A2E06ED
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790394535; cv=none; b=lnMVjd1W09gsMCq2VNoBGdj3dUPoz/uptjlEvzAFts92BMf/gs12Xa4W/sITL/TAsQfKr+L38QAbsjoJ9hHgsY1a3zI80xRDN/PdgvDEFIbQqZplK8kK53EJMiJstetmwHSaQhxdeL0igJRiu7NB6TzVrmWjfIg8f5UrpYeJtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790394535; c=relaxed/simple;
	bh=CLrM2wPA9wxnXi7IhEgR7GfVZFShh2FdnM2mC8plLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPoJ8yJ7yDiMMgvCowkTC2WOJ9uyOnLCf4efALyrgF4sSLnu5WTPxKaqTqAmP2oTTzd4K3AMHa3Mha0DLOP3/aNPVHTTOzfBnljiR1NvFD3w7V1Zsra52+DXVBfRpJu6DlSdBGgBPlbP/PKUkUSn+Jgt2MHMbFgstuRyDhaWNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZOt4gGv; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZOt4gGv"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso1302104eec.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790394534; x=1790999334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s/TFdpTxMiYwHrmjouP2VwdkJofSRV30LB9rRr0t5Pc=;
        b=aZOt4gGvvEzchDBFSC9yD++v637Ri/q83vubCPw9DRvXUDMvTQorzc2JQ/+Qo9mW0L
         DMgTlQzLuLjzDd0Li77YnoObe9Et/pI42EUl/6mmQYxza+jx7++zJQr+CzWE+2hntHkb
         YQAFtK3hU8UQVAdSZAn40qRR5iFbNZodlSKqI9lLQeLfed2wQnr4XxMpulUqIA+fxxFk
         iBjxqnVqzcoSsI4Ls+n+s51pr974feV4KxP6HVLz7MWN2pXxcqv3K/JRS8mb0U6REyaM
         JkJ3GnH5TlM+3cQaYrc1bYaY+yoELUsq86M7VfNKeRlBqV2QZapMcsU2989dYOBtIrOT
         4eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790394534; x=1790999334;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/TFdpTxMiYwHrmjouP2VwdkJofSRV30LB9rRr0t5Pc=;
        b=AxBYsWwz/xBavH1mtn9U6Zt5KWzvf1GAN1sld0w5iGzyP6kM1o6uEUGjHxEDfopOYB
         sW0lTpVC2dnPj6VIO+0fxw1AL++2frRrTspFP4cLDUbGpyYzRAJg91oRHH6JhwCnttWl
         5Rfn3N3TvAJ3eDDieqe/1XCMbFKzliLioGMI5MaR+n9/DdJb/n+REHmXrwYlkpWI+V0P
         3/HkwCf1spocFzXlbukINmw/R7rOzp7dhq/QDYnvo865SnUj57dppjVq8JIEhd4vBcyi
         CYHWIvDQOvKx7qOy7UTfJYryV5w7GMzGE4zOFvV2FwS/DRp8h9G9HP0uaOMWmG8oKEsb
         wP6A==
X-Forwarded-Encrypted: i=1; AKwUvBzGa3XcK0UU4KtbQirp47CkBtBgodIxPFhnqbJVsmY2QfibrwjNIsnMaBuQ6/jxJrAGy0+eHbqqaA==@vger.kernel.org
X-Gm-Message-State: AFuF++nDXtRyfPbLEn+CWcg/30IJkoJIkHULcB8BefAbqTWS7sFW9wg1
	ZqS1BD0woOaMVrXXJsjglqHh7dZ7Q/l5U8NkX9Lnm59l7LvLgZPHs5XL
X-Gm-Gg: AYBFou0LQDJvB9vvqBHSvuhT84WfYmKqsaqZMPk4vAE3ZnOG1xHfLochcdSDOzmtY35
	U+PcWT+5H0r9b38PNoLLh2B07enfkQ5b2orf9J57SAcnXgxQ8dfj++Zth958M0ysiwatZSeMVdd
	KY+jEd4FIeNHiGxu3cSAnZcx6PC5tfIRpK2DoFgW91skwF5ngdVUx7aQzuyHg9Cg6xT1MFK9/c0
	yamyKqiQsvpS01f8jrQS1v4olPk0KXG5Tl2P8Ced2sljIwpA6oT9KYDH7zszuvCLcVD1pqyfrNN
	KFhqZS6fZ2yCvIRlNOzNLmGqf6r26cImhja6AhXxsFXTwA/SoHa3+mD1Tp+qIdUKCnB5NYgzbxK
	k4MiaSqQKWgSOflYIW92xDqv6b/bmwZ6wg9cOuM0P/N9Jx/XlpHL3P71jWEtJaCnsOo15f7VSEh
	n+bHirod4sCOiYTITgtgH0NZpRG2AMt5ffIwfQGLZrJS5/w5eH9/Vbvy8/cMsSmqO+cZBf9N3f6
	5wPtVGK1lrnterxgUcbn+/1yidbfA21ODNeuMmVzc+s14DxRg==
X-Received: by 2002:a05:7301:7e04:b0:33b:c122:6bd4 with SMTP id 5a478bee46e88-342701bed7amr1482746eec.6.1790394532963;
        Fri, 25 Sep 2026 20:48:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:375:19cf:5fee:be32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3434958c3adsm902665eec.22.2026.09.25.20.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 20:48:52 -0700 (PDT)
Date: Fri, 25 Sep 2026 20:48:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Vladimir <anykey196@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] Input: axp20x-pek - add AXP313a support
Message-ID: <arc-Q9D1xcFn8I1q@google.com>
References: <20260923110741.1880-1-anykey196@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923110741.1880-1-anykey196@gmail.com>

On Wed, Sep 23, 2026 at 04:07:41PM +0500, Vladimir wrote:
> The AXP313a MFD driver registers its power button cell as "axp313a-pek",
> but the axp20x-pek platform id table only matches "axp20x-pek" and
> "axp221-pek".  The power button therefore never probes on boards using the
> AXP313a PMIC (e.g. the OrangePi Zero 2W).
> 
> Add the missing id table entry.  Unlike the other variants the AXP313a has
> no PEK key/startup/shutdown registers - AXP20X_PEK_KEY (0x36) lies beyond
> its register map (max_register = AXP313A_IRQ_STATE, 0x21) - so give it its
> own axp20x_info without start-up/shutdown times and hide the corresponding
> sysfs attributes, instead of exposing files that always fail with -EIO.
> 
> Tested on: OrangePi Zero 2W (Allwinner H618 + AXP313a), kernel 7.1.13.
> 
> Signed-off-by: Vladimir <anykey196@gmail.com>

While we no longer require legal names on sign-offs we do need a "known
identity" and just the first name does not cut.

> ---
>  drivers/input/misc/axp20x-pek.c | 39 ++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index 24f9e9d893d..b912f13b607 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -85,6 +85,16 @@ static const struct axp20x_info axp221_info = {
>  	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
>  };
>  
> +static const struct axp20x_info axp313a_info = {
> +	/*
> +	 * The AXP313a has no PEK key/startup/shutdown registers: AXP20X_PEK_KEY
> +	 * (0x36) lies beyond the end of its register map (max_register =
> +	 * AXP313A_IRQ_STATE, 0x21).  Leaving startup_time/shutdown_time unset
> +	 * keeps the matching sysfs attributes from being created, so they
> +	 * cannot fail with -EIO.
> +	 */

Maybe just say:

	.startup_time = NULL, /* not supported */
	.shutdown_time = NULL, /* not supported */
> +};
> +

Thanks.

-- 
Dmitry

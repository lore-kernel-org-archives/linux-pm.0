Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC222330D4C
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938174; cv=none; b=a+JzmOyPJwvn4GX/NxKhO2YT5WAveWBF1DC8iyfgbinI48rdC2gRtGpLa7+R4Gy07YmzWJokzJyp4/AbE7rr0nVignXzV48cLyYriczz+0gQbWS72DwH9ll9YhOHXUvUkrG0zDfuGDwM2cDcW2Smt1SOVaAujkYqhgfEB8H9r9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938174; c=relaxed/simple;
	bh=TeGUevqJjKKdHILxWcVaQKAnxXmxLmDs6VfY4SGfpoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3iysy0nsvKtQrHToK3YVIRsgG2JuJuuDqd/7j4/YBaTYZBzHElwVvZqEJKvME/hQ/0f+cBAfdNC0Z/H8GmgApxLhGJupOCeQ9KdcdmA27R7XVTMgYEE1rZK+WkXcKsNn2E9JyLPBR2CsQD3IjDIALEugQKPB4YPlLYjQHzYCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvCB2X5d; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvCB2X5d"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423610ec93so3581630b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780938172; x=1781542972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IVjaYMlS8AytKKUy6WaMPwOlFtLwcyoaO4rV2Eiq+9U=;
        b=JvCB2X5dTOa3Nvr99o9JynwvR/EvPlMw6DKZ9Uxiu2FOq1yE3p220Oau7WPNhJzyFv
         FyP56qxQatasAXgHeNlh76D7NfkrDz4vSgtrUwbzzXbOsdCp0YehabQwqiV052VO7FXP
         N63a3fTkQj4z3l1FDBrio29wYsNWQLQMJKIM1jJGGzCBqq0yDXrfK41l39juX9EgFD5A
         qqqPiX9Qm+/4Cmm8drUONklQEW3g12KZ/QlB1MltoJcrErB26nTMaNzuP1P/QQdBg2jO
         mtFIxb/qVOv2VlFYNPybchqnjd4G1rcUSOEr5oLsWnGcNhEHo+iAi4f36wTI4lJh7qPb
         t46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938172; x=1781542972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVjaYMlS8AytKKUy6WaMPwOlFtLwcyoaO4rV2Eiq+9U=;
        b=n+oGswikLtqKp5bBhJ/yIe2H8D3r3pPfbXqEO3oaO8JyRzhfrpGsjIPFSkEeDZgreq
         oweR3+SZTtyXxDTxOzUX9qQ1qRyE/e7+zmxUFOtv9l9gp78D4QykbVZznM5LYi7GlA8+
         MJJlOOuJVWSQBfJYguCuvtAhZ007HqNDpbrYZKLT8az+QNYKvT4yoAauAY6DRBJot46T
         UrDiDTa2FfttF9FhajbZ8Kh364H6JWhzqFSq1c4EI5Li66OgEiEBWBdsj2nwGqcXE8IO
         PyB7Pr+uFKI2RAXPUSKOKRpYa3ew/LP7tksuWszmHq7uaqjG7yOTL4TOeHOMIhXXuzud
         l9Vg==
X-Forwarded-Encrypted: i=1; AFNElJ/FUdWPzhpe4iPUTbanP8Oj9Mp6q+D3Kpg3tAD5L6dPUpgZsMfmCBbx7b7zpTx3sZfB7EOher1D7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4KC4m+wGRBcDzRWepq8t7sshkEizuGsVYUZh4GxZhqIhy02i
	eoSAPNeiEXhhn7MmGor3UsJeW+TinXbxaELAWKJoUAEhueUpDZiz+G3yiU6WI4kBoPA=
X-Gm-Gg: Acq92OFlsJVlMOClj5k8uAkR85F4FGUjGQ6Zvz9IYSQcoI/l8VOGSG2mLH80o0+UIR+
	ofhaBe9mtG/ocIU1+irUQ8IYCUHZyH+wv/vp1NipkTQ6Vkrw923nRnaJ5GQqVl9crDP7NtKjFYh
	zq9Bp6sIdg3XoJbJTe9W7pFo/JkzS3JO+d1oZkyjXljYyAvp6L2uLQAvvo4TiD2p7dOj7ziZtWR
	/mZuPepFCPKtz8WiEUXyVnNgmhOEF6x8lXqSa1NJ8zrFJsoiF6peFgmjoWpKJzGWrAZJLlbeZsr
	5oY8j7UBEaUbAeUWKErM7vVhewkw+ov5UWXKWL7NQUvAsCdADB8vV8GS5SmC0PBY/S+b9+2r3y7
	DtoLG0JYsHvlgygTK+x93MZK4HeKoazYimwm4Rb31HpyFH4nNYmrT64RxWW25sUhWNZMzxah1Pf
	rv1dV0KGNn6jaQv1oePtp3spfh9yTFfJzsi6e+
X-Received: by 2002:a05:6a00:94d8:b0:832:e65:ddcd with SMTP id d2e1a72fcca58-842b0f4278cmr16028206b3a.45.1780938172116;
        Mon, 08 Jun 2026 10:02:52 -0700 (PDT)
Received: from google.com ([2402:7500:498:d80a:6ed1:11c1:50ff:fc30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842820e8e6asm18289053b3a.0.2026.06.08.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:02:51 -0700 (PDT)
Date: Tue, 9 Jun 2026 01:02:47 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: gregkh@linuxfoundation.org, marscheng@google.com, wllee@google.com,
	aarontian@google.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] interconnect: Fix use after free in icc_get() and
 of_icc_get_by_index()
Message-ID: <aib1t4SWw0aiJyv2@google.com>
References: <20260416190840.1753468-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416190840.1753468-1-visitorckw@gmail.com>

Hi Georgi,

On Thu, Apr 16, 2026 at 07:08:40PM +0000, Kuan-Wei Chiu wrote:
> In of_icc_get_by_index() and icc_get(), if the dynamic allocation for
> path->name fails via kasprintf(), the error handling path directly
> calls kfree(path) to free the path object and returns an error.
> 
> However, prior to this point, path_find() calls path_init(), which
> already links the path's requests into the req_list of the respective
> interconnect nodes via hlist_add_head(). Directly invoking kfree(path)
> leaves dangling pointers in the hlist. A subsequent call to icc_get()
> or icc_set_bw() will traverse or modify these corrupted lists, triggering
> a slab use afterfree.
> 
> KASAN report showing the vulnerability when reproducing via debugfs:
> 
>   BUG: KASAN: slab-use-after-free in path_find+0x6f8/0xcfc
>   Write of size 8 at addr fff000000d43f748 by task sh/1
>   ...
>   Call trace:
>    kasan_report+0xac/0xfc
>    path_find+0x6f8/0xcfc
>    icc_get+0x148/0x380
>    icc_get_set+0xf8/0x2d0
>   ...
>   Freed by task 1:
>    kfree+0x1a0/0x4a4
>    icc_get+0x2cc/0x380
>    icc_get_set+0xf8/0x2d0
> 
> Fix this by replacing kfree(path) with the proper teardown function,
> icc_put(path), which safely removes the requests from the req_list using
> hlist_del() and drops the provider usage references before freeing the
> memory.
> 
> Additionally, in icc_get(), ensure that the icc_lock mutex is released
> prior to calling icc_put(path) to avoid a deadlock, as icc_put()
> internally acquires the same lock.
> 
> Fixes: 3791163602f7 ("interconnect: Handle memory allocation errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

I haven't seen this patch show up in linux-next yet.
Since the merge window is approaching, I was wondering if you had any
comments on this?

Regards,
Kuan-Wei

> ---
> I discovered this bug while reviewing Krzysztof's patch [1]. 
> To verify my hypothesis, I injected an artificial kasprintf() failure
> into  the source code and wrote a minimal dummy icc provider module.
> This allowed  me to successfully trigger the use after free via the
> debugfs client and catch it with KASAN, confirming the issue.
> 
> [1]: https://lore.kernel.org/lkml/20260416130912.375013-2-krzysztof.kozlowski@oss.qualcomm.com/
> 
>  drivers/interconnect/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 8569b78a1851..e14280ced381 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -528,7 +528,7 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>  	path->name = kasprintf(GFP_KERNEL, "%s-%s",
>  			       src_data->node->name, dst_data->node->name);
>  	if (!path->name) {
> -		kfree(path);
> +		icc_put(path);
>  		path = ERR_PTR(-ENOMEM);
>  	}
>  
> @@ -626,8 +626,9 @@ struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
>  
>  	path->name = kasprintf(GFP_KERNEL, "%s-%s", src_node->name, dst_node->name);
>  	if (!path->name) {
> -		kfree(path);
> -		path = ERR_PTR(-ENOMEM);
> +		mutex_unlock(&icc_lock);
> +		icc_put(path);
> +		return ERR_PTR(-ENOMEM);
>  	}
>  out:
>  	mutex_unlock(&icc_lock);
> -- 
> 2.54.0.rc1.555.g9c883467ad-goog
> 

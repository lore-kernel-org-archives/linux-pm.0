Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56301468C17
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987884; cv=none; b=uruoj35t0N8evk7LIQL6MmTQrXR+WITMpHze56NHZXc+WpFMPhPEu4+5twCX8EJuBn6v4u7RjUM9Z5CSfUOEKvhEHk0RUucWdTN9DNyat0ePDeD4EoeCmJThNZiKA1USN8w/TpokCDQuF2w1/xCxN+QzNXrfbXR5C2fVZbe6TjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987884; c=relaxed/simple;
	bh=XuQIGnNEgl05hW1Pt/SRDZrKnxVKWtgOYyJNVYljJJk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3xcx1ADkkbFtyL/CRGr5E+6ZD+PhX2Wcb4iT4hNLCOESwoc7XygejbYYvMbu797kfrml8CwJLqhoVW+zBZsw0UMY5GopKqfT+2ptPfsFsQBiCDDNJIwvh0di3FY5NJBUdILJop7W5GEpDJZ4sZokZssquGFj8Wd7NMAL011FAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTw2vNHr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTw2vNHr"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so3725001e87.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786987880; x=1787592680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gdAST+PW7bd2DD1v0YjadB8+zi0iamo4AznH2c9tOUI=;
        b=eTw2vNHrPGyIV9SJRUFkqft+N4BJxLtAlV0iNfsuJt5IWSQfnFhP8uRxuMkrT9ZZsY
         8o1MUhFKKYlyBvH+51JaxIK4APixLSZ3J7q8nE7YeatdCCWCdhZ7+ZPaN8Tvbls6Icaw
         Q6eKucOBcQ3Qkpz6PMIn1OXUTlDh3tjkT6hZK/2YJ29ODCxfUsIYma2jB8ZtBeeYNFZN
         ID4shGj2VzFEF2T+GvXDdCfcj3IOGVJjQgL16l2cyNicnipDO5jJy7xCi6rvaGruKrP/
         f9mOusaNP7k/nQZ+x19zuyOFNxNwBzJRJOcx+v9BhX7dKYcf9VAT80GF4OQ3FfMezryH
         AWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987880; x=1787592680;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gdAST+PW7bd2DD1v0YjadB8+zi0iamo4AznH2c9tOUI=;
        b=Dia+q9bHZKm9+B/EcrLeArkuN8l49BJsJoAfsqG+zCKW07wCmrVhXU/MH+PAXFJv/q
         hPHtCdhod2nMqNIengwLtQHPOXKL4laDyQ39EoikvNgALl3My0RNcvupRdjDNjzqdkYp
         wGpPdr6XmCJB5WJ8XqGDy+y4hE4fTm1EOOuMy/mg4hMxEtwFUx+RMgTuLLyY49vYuUO/
         S4oUWWLfMUk53iSRRvaRmLtkY0GZgzzMQZQY+1YtaMfB42Hk4GWH7umXn2P0XEFFPQ9m
         FW3JBFWAdER11MknOF/aC5q3nLprtG1Re7VVEviHWT7qTvCNWmMfJNPx0E3EhQqKpAx5
         +J3g==
X-Forwarded-Encrypted: i=1; AHgh+Rplobr09Vs9iyXgZcmBH8Bw7jxUdmnnj/gITRQIuFxSxiJqBV6kZ+Cgm2MG5XLSFurI73XELhqmjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/DqU2oyMbSZ/EYHUjGHZ1OpaBbZ1LTcNtCNnNGDM051MJUTN
	65GZaIo1O8Jye7PZr8XHhvJu45wXwHAud105hlarWqayzycfgsXSpxJsiz14xNFjziQ=
X-Gm-Gg: AR+sD10NcbqFFdMIicFhlykHJqTKt30Gw8d4CX9/t/KPCP0VsW94Ax94nwfYZOe5B6z
	sssdZI6Y+1YNh6AeCJGfwlT545sGhhkDr8OZKhZPOysAeMey5fw21Jg8fnUlTjji5k7pAM/DK4P
	y5yHauLug1VXwcQfAeLgoqFQojDIzd0wVLX1272zLzx4DmbL43nILhbfx5bnkBDCWzdTXilqDke
	su4VGvTUXgbYa7Oz1iL7PvUyLy6Waf/G+3sXyr8qM6Ays8P+Ct/2QR2/qtn7vhFfaeLxoaigMAU
	PMcv4NFfmXOmfwPD32D2pWfsu94e4HY9nzvEG0yi1aeMzm15os+0F3ejA+7jIXU93cUoewRLNrT
	mFdaNg+Fd25jf5kTlO49VIz+5D6cI392KKgXiz/dY7RyaDxAHNL0XSt625vqnwaqbc7rm9PCBdv
	jJLXIppTDmZnYvdJ6RZzo7QpFspA==
X-Received: by 2002:a05:6512:1284:b0:5b2:9358:b854 with SMTP id 2adb3069b0e04-5b459142afbmr3869031e87.42.1786987880080;
        Mon, 17 Aug 2026 10:31:20 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b1f1852sm5885691fa.38.2026.08.17.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:31:19 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 17 Aug 2026 19:31:17 +0200
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Len Brown <lenb@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 2/6] mm/vmalloc: set area's page_order after allocation
 succeeds
Message-ID: <aoNFZU_QzghDBgbZ@milan>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-2-90944a3ad43f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-2-90944a3ad43f@kernel.org>

On Sun, Aug 16, 2026 at 01:59:25PM +0300, Mike Rapoport (Microsoft) wrote:
> __vmalloc_area_node() calls set_vm_area_page_order() to set area's
> page_order before actually allocating pages to populate the area.
> 
> If allocation of large pages in HUGE_VMAP case fails midway, this leaves
> the area with elevated page_order throughout the cleanup path.
> 
> There is no actual issue with this because the only place that currently
> relies on area->page_order on the cleanup path is the loop calculating
> the direct map alias range in vm_reset_perms() and it anyway skips
> unpopulated pages.
> 
> But having set_vm_area_page_order() in the middle of __vmalloc_area_node()
> makes things very obscure, hard to reason about and error prone against
> future changes of the cleanup path.
> 
> Move the call to set_vm_area_page_order() after __vmalloc_area_node()
> succeeded where page order is guaranteed.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/vmalloc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22566e0b6e38..6822f0fe9583 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3901,8 +3901,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		goto fail;
>  	}
>  
> -	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> -	page_order = vm_area_page_order(area);
> +	page_order = page_shift - PAGE_SHIFT;
>  
>  	/*
>  	 * High-order nofail allocations are really expensive and
> @@ -4106,6 +4105,14 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	if (!ret)
>  		goto fail;
>  
> +	/*
> +	 * Set area->page_order once it's known exactly that the order of the
> +	 * pages the area contains.
> +	 * Even if we succeeded to partially populate the area with large pages,
> +	 * still treat the area as populated with order-0 pages.
> +	 */
> +	set_vm_area_page_order(area, shift - PAGE_SHIFT);
> +
>  	/*
>  	 * Mark the pages as accessible, now that they are mapped.
>  	 * The condition for setting KASAN_VMALLOC_INIT should complement the
> 
> -- 
> 2.53.0
> 
OK, can we just set it right after the:

	area->nr_pages = vm_area_alloc_pages(
			vmalloc_gfp_adjust(gfp_mask, page_order), node,
			page_order, nr_small_pages, area->pages);


succeeds?

I am not sure there is a good reason to move it out of the
__vmalloc_area_node().

--
Uladzislau Rezki

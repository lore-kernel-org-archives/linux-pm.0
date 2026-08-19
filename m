Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266937B41E
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140130; cv=none; b=ZFcwEM5UaM15zEVAYlYy7E/CCIIbAV7iIYC/0LOUWAFmZx26mDGGUAW+c3AHJ7P4HOQjXwhv1UCBoLoFfX5gwVAcgmCI+cARiS8ROqP0AvM/J0T2yDfB4Vaq/kpQXfUpuMEuylO9ODRFaxnQ3w713U4Zfq6WDWRNBHBWbWTiBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140130; c=relaxed/simple;
	bh=hlqPu8zxYhXjAp0RnMZVNI6hpIt1GyNxw1ypjjho7mg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGYUUMjy6FYqXhsKt8X0YAEDAehBTu4BvD10z5ldwAwcQ5hG+2syQp67D0RRHDctKDtYXafiAfVcawXbz7iuGy1p8A7p2ilCwU8g582c65+pZRdgAbalediaANsZlbP57TC916lUDkOF9AF7NWnX5AbdGYaCgyg+dZyNKoRxFVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qy9iRabv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy9iRabv"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so1113213e87.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787140122; x=1787744922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Neo+1K8ghUMGN3G9vUjB7A1LbHA9OhMwHPbvzVv5Wg=;
        b=Qy9iRabvWhzH7PzgaB4eB9k6CK9pe2v2/mbUtDU4i6yoCI5CmESJAQDtouG7uGDfTU
         wXw2qdqW+EcKN0eM1benvN+Bh0GImVRBXPbZLKRY2RHZuMlZvMPB/VSajbxCivLjC+bq
         L8RPBy8R0tcBOYwxgoats7rF9GkrsAtxB2yFTpcUzdh3++d7sasVE42mw/iQHXsfAkq0
         U+Fx8X2RQvPKquEf9ZI71OB10ChTHx0UAXOP94Of/P8nywze2XSx4ei4q9a2o5Z4Q8cy
         GCVWi28FJviFLWZB5kFCWaA8Hp0B9O0MU1HQb4J+V0Xkw5+Hvl7mdcE6n4afP8AXvSD4
         GCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787140122; x=1787744922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Neo+1K8ghUMGN3G9vUjB7A1LbHA9OhMwHPbvzVv5Wg=;
        b=rIg6woiRI+25gP1CX1LZPIH46o40pfsmAOqS+/eNfTflji1jLPqSkWTC8ZB3hsdy7M
         SQuzgrqfgzIteEXm+44Bnaf1s5Xw8Hb5dnS3QOWxCLwb4CRkQJhXPqq2I9ut0O1j+4SA
         X395Z2rsX7MDKMXkF+TWjUH3RvIRPHB04WOTvpW6y5xwG1E6oQk/V2koDX76NCCGVO7b
         2zdYNYM8HAczK7FJFntIvLhdyvXdHCFcHyXSsSpLlEv9goGM6gxZHDwTkZV/+EX3A36Z
         i6NCUHPftRZ29URoeiIhg7BPTZQwoAbeCp+ZISVx+pw3gI95dp0hT+UOA7k/lFrjyC8p
         pGpw==
X-Forwarded-Encrypted: i=1; AHgh+RqkQNaNWzkSsrKMlMaOS4/9TywCdZqf4dzgYY+m2ePmLt/T8e5tWXhkNA33y7o+6XWvch6XnKoJrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv99uoAqAosDAaE+tqA+pfwjg4Hn3uMYnu1mcEwawbRComkA8k
	fhXnkm4z6mT2tdaHmgv/gtWCd5wCUN9knboEYDLe/SXiGjRvazi5HG9a
X-Gm-Gg: AR+sD11lDwJIqtAqBNo7epBMLNwwU+uKZMQwpuKW3GeNR8DUsvwKSdCRTcOlinC8MvW
	f7w687OP9BUUw+yzeSw6AbFqkZS0X7nB/tRuFhfHq7KrGBLsvFC6B+uXe16kyVRmLU8Mj56GlKg
	v5akD4dZSmU/PGCj7ipKlnPcyc24v4Ou7ceeKuhE3I0Xa7UJ+vocpk9DPMwd+NpeVNX7tsKRVlB
	cOu5fbxVSb9vAnOpqgXfRHo+u3/LN97/b6YYPzc219lSi645CEJpsiCbrPzBNxbrmgqxUIdKum8
	Zmj0yAVkfq8eW+0vK5h1uzlE6QwNpcEOVEHEIOcg3kVU4YqzPn00WyV3LmEulNeaDcfEWRuE4a0
	ukFEhuMiN8DXLdj7awVFn+uggkdtDcxsdJgfnPpX0l/LL/ArB4wPP/cSnptAk1SMzRkXVFrKbQ+
	tjRIt4QL4wIeAf12xdZaAS0YIbzsnIskvBDJ8yFkmdOrPOkBe2gwJz28y+al3J8UBP0kA4gbbUL
	9AxVp8c4F5dlCko04LA7VqxpS4TmQ==
X-Received: by 2002:a05:6512:224d:b0:5b2:f453:1073 with SMTP id 2adb3069b0e04-5b478b9070dmr1376566e87.2.1787140121681;
        Wed, 19 Aug 2026 04:48:41 -0700 (PDT)
Received: from pc636 (host-95-193-137-165.mobileonline.telia.com. [95.193.137.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478853971sm482752e87.10.2026.08.19.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:48:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 19 Aug 2026 13:48:36 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 2/6] mm/vmalloc: set area's page_order after allocation
 succeeds
Message-ID: <aoWYFH_FJXlMK8fw@pc636>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-2-90944a3ad43f@kernel.org>
 <aoNFZU_QzghDBgbZ@milan>
 <aoVUF2pgl8JYNyIU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoVUF2pgl8JYNyIU@kernel.org>

On Wed, Aug 19, 2026 at 09:58:31AM +0300, Mike Rapoport wrote:
> On Mon, Aug 17, 2026 at 07:31:17PM +0200, Uladzislau Rezki wrote:
> > On Sun, Aug 16, 2026 at 01:59:25PM +0300, Mike Rapoport (Microsoft) wrote:
> > > __vmalloc_area_node() calls set_vm_area_page_order() to set area's
> > > page_order before actually allocating pages to populate the area.
> > > 
> > > If allocation of large pages in HUGE_VMAP case fails midway, this leaves
> > > the area with elevated page_order throughout the cleanup path.
> > > 
> > > There is no actual issue with this because the only place that currently
> > > relies on area->page_order on the cleanup path is the loop calculating
> > > the direct map alias range in vm_reset_perms() and it anyway skips
> > > unpopulated pages.
> > > 
> > > But having set_vm_area_page_order() in the middle of __vmalloc_area_node()
> > > makes things very obscure, hard to reason about and error prone against
> > > future changes of the cleanup path.
> > > 
> > > Move the call to set_vm_area_page_order() after __vmalloc_area_node()
> > > succeeded where page order is guaranteed.
> > > 
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > >  mm/vmalloc.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 22566e0b6e38..6822f0fe9583 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3901,8 +3901,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >  		goto fail;
> > >  	}
> > >  
> > > -	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> > > -	page_order = vm_area_page_order(area);
> > > +	page_order = page_shift - PAGE_SHIFT;
> > >  
> > >  	/*
> > >  	 * High-order nofail allocations are really expensive and
> > > @@ -4106,6 +4105,14 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> > >  	if (!ret)
> > >  		goto fail;
> > >  
> > > +	/*
> > > +	 * Set area->page_order once it's known exactly that the order of the
> > > +	 * pages the area contains.
> > > +	 * Even if we succeeded to partially populate the area with large pages,
> > > +	 * still treat the area as populated with order-0 pages.
> > > +	 */
> > > +	set_vm_area_page_order(area, shift - PAGE_SHIFT);
> > > +
> > >  	/*
> > >  	 * Mark the pages as accessible, now that they are mapped.
> > >  	 * The condition for setting KASAN_VMALLOC_INIT should complement the
> > > 
> > > -- 
> > > 2.53.0
> > > 
> > OK, can we just set it right after the:
> > 
> > 	area->nr_pages = vm_area_alloc_pages(
> > 			vmalloc_gfp_adjust(gfp_mask, page_order), node,
> > 			page_order, nr_small_pages, area->pages);
> > 
> > 
> > succeeds?
> 
> Here it's still not clear if vm_area_page_order() succeeded :)
> 
> I can move it just before
> 
>  	return area->addr;
> 
Even better :) For next version:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

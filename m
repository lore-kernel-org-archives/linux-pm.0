Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF4471431
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140210; cv=none; b=KkHkLNj0Hrpb6kRFaEJD+oJGl8Tspo+Mj7x4PtGYDuXGxTd/6Q9UpwSNo+orqRRFWAB1/Wy85J3l2TR/cSccLE2YuJOYceXrcy/Glm4Uet8Bzx7JkY6GIO3dr8wo9S2Ki90Qk4HiskYjeqTHGZyPaqTBaEislyt1e1xfQB8jTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140210; c=relaxed/simple;
	bh=dLbO/KZ9p8AfNKJwP2FWUdac1cvSGmTwIke+Nm9losM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH6tC+mlBpPxQJDKkQOo/HObM2icyIv4lUNG7gySybekhwSy4q7FC6pkH/T9w4ncWjX1F7iT+9TZXuZB2F0G3Hz/Z2PT/mDr3YfpAjk4bNw9px+wqeP3Ld4l9FBuLxiWGO4RjHtgtVY+Td1VoJzLs2Vrz9yV70LZt1+Qq6R4LMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL5UHIHA; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL5UHIHA"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39faa67fabaso5944641fa.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787140204; x=1787745004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qb8vbO35I9ReDoy08LYZaOcpJWIqiGdFJcRUGNTu904=;
        b=AL5UHIHAef6lcN8kJ5xWmpUSc6DfKmb5R5GES6ugTd4YzL9tFeF25Oqj696fCo5iMk
         4iNI+IK4qfOa+KtCsR3TQjcAsNqWGen9z0sLlnIKNmF7g+7bG1DB0yGMy7lnpZM2sJFC
         HR2uemSYF23n6jDeQBdNgmzjIXgCLfGkPKOuKJVpod9z6jIoLWSyh7V6sk3vcxX2KIwx
         FoSWHZX21uaCSAlF8LLnjmoHg4zP8tyoGJ5IArD8snEWxgb4lmjpv4qFCimSTFi9Q2uD
         uEnxGT8IeWExka3oNuUTcb1wnn6stWEyhkQ4Hce2XGOj0GV9xNHh2uIS+tHhO6fUV0HZ
         NDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787140204; x=1787745004;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qb8vbO35I9ReDoy08LYZaOcpJWIqiGdFJcRUGNTu904=;
        b=nWBSWvFPgnm0n6mYZzIGZhMMMa50/wIdi3gNUM9mpasO7Nz8LlUyC8GWvr45kZYOoY
         cZHOB+1MhjprEEjvo6tnDTny8iVp0HbjIuJLCiYpxTjW/wtWtUCIgG4D4KW0gQ2lFfaB
         n/q/p4nnWYSMM23NUqZcPRzs2yG1dVwbY+4XHk45N6XQpRLyOOR3Eyjy+1bHR0vvIRdY
         cQKRiVdZP1tlZfNOs540kbi033rCHpJEiP47bZSrf8XMlP8rMhRCLB+fdY05sbcAWesx
         CklA1vsw1kpaW25L5eG6dQMzx7bDymTFe+XNHT8oi3TthPiLYqWfTa7P/4u9u5GGitnH
         SmYw==
X-Forwarded-Encrypted: i=1; AHgh+RqSuYWboey3G3sRrTViewnxq00wSZnYsSvPQIk4q8hlKaC/0pmGnDaH8Misj5JZqcEvvgyv9htkMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycpJU8wGFF46epinqGjRunleORCjDFSFSJg9Qp9OjPXglQ7xiq
	4CsC+TG3CSr/Onvw8o8vPuEgXXaFKb3FJdn7vsSg9z6dNRxv3MIFIDEv
X-Gm-Gg: AR+sD10jBbXhKaiJItJ2zzY9xe19o+GIlQKhL2l5P96IUDpbqsj3lso8crkLSr9UiUb
	0qU8jaOooPIRW2X6CSBJeQMwojZZmXuAmJXec5BjS/8bz0k9gIfQ1wbYa25abkfIQi6P5k/70oq
	auwGYTOObt3UN2/RebTcqtxja0rQK8e5ti8tLRUwLGLXiisgNSHJYMaMK3XOhQpvFpMAYibxaA5
	5nDu8tWU2+5nMIyWf+poSI5NfhS7cZMaMUziNlWxlJPfhwb7td8Dst0OiZvIjobM6KTL+/XjYhT
	+aSi9VmsxGxT9GKUCEkAxvWhsLKzkaY9S4XIrLpUgvilVPYIJT0gwWxf17IIDyP7TZE1Ws/jGYu
	Z9mXfukYHmo1bQDXj0XSoH++n5tlhGQlCqWI8UOl9BvCGo1fxAimbaKCGfsgzj56m5ml58tL/0/
	Qmy+DcX2TMdC4+8ZQfFCMdI+eKlw0nitc5DAQ2QOsV9jHvCmTjadmFMHB40vsOxJcEST49IFI3Z
	Bj3Uby8adjGJshZMGs=
X-Received: by 2002:a05:651c:3135:b0:39b:48c1:8cd4 with SMTP id 38308e7fff4ca-3a18996bd7dmr7858151fa.7.1787140203900;
        Wed, 19 Aug 2026 04:50:03 -0700 (PDT)
Received: from pc636 (host-95-193-137-165.mobileonline.telia.com. [95.193.137.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a18a8e8579sm4123321fa.0.2026.08.19.04.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:50:03 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 19 Aug 2026 13:49:58 +0200
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
Subject: Re: [PATCH 3/6] mm/vmalloc: constify vm parameter of
 get_vm_area_page_order()
Message-ID: <aoWYZk7xNfjwuzQ_@pc636>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-3-90944a3ad43f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-3-90944a3ad43f@kernel.org>

On Sun, Aug 16, 2026 at 01:59:26PM +0300, Mike Rapoport (Microsoft) wrote:
> get_vm_area_page_order() and vm_area_page_order() do not need to modify
> struct vm_struct passed to them.
> 
> Constify the parameter.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/vmalloc.c | 4 ++--
>  mm/vmalloc.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6822f0fe9583..fc7993db4152 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3124,7 +3124,7 @@ EXPORT_SYMBOL(vm_map_ram);
>  
>  static struct vm_struct *vmlist __initdata;
>  
> -static inline unsigned int vm_area_page_order(struct vm_struct *vm)
> +static inline unsigned int vm_area_page_order(const struct vm_struct *vm)
>  {
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
>  	return vm->page_order;
> @@ -3133,7 +3133,7 @@ static inline unsigned int vm_area_page_order(struct vm_struct *vm)
>  #endif
>  }
>  
> -unsigned int get_vm_area_page_order(struct vm_struct *vm)
> +unsigned int get_vm_area_page_order(const struct vm_struct *vm)
>  {
>  	return vm_area_page_order(vm);
>  }
> diff --git a/mm/vmalloc.h b/mm/vmalloc.h
> index 8866ddcff668..211869f36509 100644
> --- a/mm/vmalloc.h
> +++ b/mm/vmalloc.h
> @@ -12,7 +12,7 @@ void __init vmalloc_init(void);
>  int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>  		pgprot_t prot, struct page **pages,
>  		unsigned int page_shift, gfp_t gfp_mask);
> -unsigned int get_vm_area_page_order(struct vm_struct *vm);
> +unsigned int get_vm_area_page_order(const struct vm_struct *vm);
>  #else
>  static inline void vmalloc_init(void) {}
>  
> 
> -- 
> 2.53.0
> 
LGTM:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

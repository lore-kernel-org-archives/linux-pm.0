Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADEC43148A;
	Thu, 16 Jul 2026 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212515; cv=none; b=NWyTSrY3wDiUQXLwuFVjOxSRHOKq+/oYcxP5Km+42eYwx/JtmG8kMZdWG5fToglSsm/KJiZuYxASN87NIEskhfe47FHuqRqyqDFxJvbO9ElL9C1lehfDDNULoSr5OfcxZ1n1f5mnBCldXuJAqceYTg4v8yEev3sdL/hxSkJOIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212515; c=relaxed/simple;
	bh=D50zIrUT5DBNpFw5jheSQMCzDrAJxbsimzukcBUvYaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anW7e0qCCly3lM3bmIQJy+30eLbCAYK5QvnpehaBVTkjy1irJLgpIrt6PwCTIVcISguINMwaZwKOnbgommuekzb9X4RIs3FVYTBGDZqR6S+sQ4TamkaUMZbhS4nSdximgoq/L9yJsrwpmpJEHnXAgmA5zgNEf49xjsZiGgv3wEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYlxmFvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYlxmFvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D751F00A3A;
	Thu, 16 Jul 2026 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784212513;
	bh=owL0nd8B/GkhADkuaO+4Eg/4RAiod9IX3PPfyfCcTxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TYlxmFvGLxHWeT01YkmwxlcgTHqg69p9kYqzkpfVWAyU/yPb54wA0i73F2a96tCJ5
	 LGjAT/oucnWqtZufo0UFt0+B+76fr6OQ3DKvtHsAPZgI4AeEHZs6BCGeizthUniTQo
	 qHp8bxcCi/YnqiiFwp+Rj1lx3ZyUg0FMr9CAAx1uyKaFWytHu84pzRLn4gMuniMeTO
	 I5bd+ZZnWjRJKhr451fMyYjmw983hJvfVYZMiEAStxwRTZ8ncyASF1+PjVX7ipokGa
	 A/7Bu75qciiIuHD9sO7gy1Ft33Jn+OW5xJ8Nz0scRRZ6bt6JNWxFjl+Md+Alc94CTi
	 xMH8O2h0ExKIQ==
Date: Thu, 16 Jul 2026 15:35:01 +0100
From: Will Deacon <will@kernel.org>
To: Yin Tirui <yintirui@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Juergen Gross <jgross@suse.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Xu <peterx@redhat.com>, Luiz Capitulino <luizcap@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Rohan McLure <rmclure@linux.ibm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Baoquan He <bhe@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Coiby Xu <coxu@redhat.com>, Dan Williams <djbw@kernel.org>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rik van Riel <riel@surriel.com>, wangkefeng.wang@huawei.com,
	chenjun102@huawei.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH mm-unstable RFC v4 2/7] arm64/mm: use PTE-level pgprot
 for huge PFN helpers
Message-ID: <aljsFdYEH1CvYhft@willie-the-truck>
References: <20260526145003.88445-1-yintirui@huawei.com>
 <20260526145003.88445-3-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526145003.88445-3-yintirui@huawei.com>

On Tue, May 26, 2026 at 10:49:58PM +0800, Yin Tirui wrote:
> Make the arm64 PMD/PUD PFN helpers use PTE-level pgprot_t as the basic
> format.
> 
> pfn_pmd() and pfn_pud() now translate PTE-level attributes into block
> entries. pmd_pgprot() and pud_pgprot() translate block descriptor
> attributes back into PTE-level attributes.
> 
> Remove mk_pmd_sect_prot() and mk_pud_sect_prot().
> 
> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 48 ++++++++++++++++++++++----------
>  arch/arm64/mm/mmu.c              |  4 +--
>  2 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 4dfa42b7d053..c3ee12e14f86 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -511,16 +511,6 @@ static inline pmd_t pte_pmd(pte_t pte)
>  	return __pmd(pte_val(pte));
>  }
>  
> -static inline pgprot_t mk_pud_sect_prot(pgprot_t prot)
> -{
> -	return __pgprot((pgprot_val(prot) & ~PUD_TYPE_MASK) | PUD_TYPE_SECT);
> -}
> -
> -static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
> -{
> -	return __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
> -}
> -
>  static inline pte_t pte_swp_mkexclusive(pte_t pte)
>  {
>  	return set_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
> @@ -628,7 +618,13 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
>  #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
>  #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
>  #define pmd_pfn(pmd)		((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT)
> -#define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
> +static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd = __pmd(__phys_to_pmd_val((phys_addr_t)pfn << PAGE_SHIFT) |
> +			  pgprot_val(prot));
> +
> +	return pmd_mkhuge(pmd);
> +}

There's a slight potential difference in behaviour here, in that the old
mk_pXd_sect_prot() helpers would always return a pgprot_t with the valid
bit set, whereas pXd_mkhuge() preserve it from the input prot.

I couldn't find any places that cared about this, though, so:

Acked-by: Will Deacon <will@kernel.org>

Will

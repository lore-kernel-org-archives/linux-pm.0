Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1936606A;
	Tue, 26 May 2026 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809653; cv=none; b=tabzv/1YPvVXhPR3WCWKKRrPGMb35Zj55jW/3IeZYWtDC5xDKkaJ7X5iEzK6xEH2dVvovuyl5yv8qXeZZvoHeI2ekDFHpWYVr10rXnKORAVomFpHwcPbW1n+DnWp0G+8TABjT189+DbAlNu3cusfRsdLSN0lWvNmHyVGFjF3ZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809653; c=relaxed/simple;
	bh=IXtklErhcuWlv2r8L97+xvorQ7UpGoL4ZF+VJDkPygU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3CnugtlZFvtCBTXXbD3CflRj7qiWhsGfTb6LmaWd9PuRWwGWgRMquZNmxHV5/qybpyXUJ+07uBE4tw6xl3tJZs49rcnyzegA13N8sA1S8sPvZRDIcmqoz6Rya8hm23Pq2nZ159gBFlc4R29uo+u9ixZM8v44mUkAWkxaBqqtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Noq6FzjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Noq6FzjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FAF1F00A3C;
	Tue, 26 May 2026 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809651;
	bh=IXtklErhcuWlv2r8L97+xvorQ7UpGoL4ZF+VJDkPygU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Noq6FzjXAHednyJbKDsO7gWlmRYH4wZD0QhvuTN+ag2i1VdurKmvBGP3bOfMJCqvU
	 8kjwZvotf99uxGidiSuhzx7jYl16j0j9D5Yy+Ia0rEVFPucuDOg4YzNa4k3kD5Caql
	 cOvHKMZEdCkn6xBAgqAbnQEdTy1mWt1ZyuPL6nPS3yKF2BtW7gtEowzkU10F/6E0sj
	 qQ72PTZCTU8zRN6nz5ooPdaaDrJoW5P+Y3vgo8M1qA9dygwm5nF6SDZ5t2jHBQrPRo
	 Mw4mppN1KUMAVp0SjeJl63QoEfTyTcLoZY3AGxngefu9qBzd2UnGgPGypTmdUHd5W5
	 d3hKUeNpi6bxA==
Date: Tue, 26 May 2026 16:33:56 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yin Tirui <yintirui@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Jonathan Cameron <jic23@kernel.org>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Peter Xu <peterx@redhat.com>, Luiz Capitulino <luizcap@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Rohan McLure <rmclure@linux.ibm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Donnellan <andrew+kernel@donnellan.id.au>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	Coiby Xu <coxu@redhat.com>, Dan Williams <djbw@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Rik van Riel <riel@surriel.com>, wangkefeng.wang@huawei.com, 
	chenjun102@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH mm-unstable RFC v4 0/7] mm: add huge pfnmap support for
 remap_pfn_range()
Message-ID: <ahW7rut_WP17KADW@lucifer>
References: <20260526145003.88445-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526145003.88445-1-yintirui@huawei.com>

Allow me to be mildly pedantic (sorry :)

One thing I'd like to highlight here is that remap_pfn_range() is, in the long
run, deprecated.

mmap_prepare callbacks will indicate a PFN remap mmap_action, which will do the
heavy lifting (see [0]).

So perhaps worth referring to 'PFN remapping' or something?

(Since we already have mmap_prepare() in use, it's also kinda inaccurate to
say remap_pfn_range() :)

[0]: https://www.kernel.org/doc/html/next/filesystems/mmap_prepare.html

Sorry, this is pretty nitpicky :)

Cheers, Lorenzo

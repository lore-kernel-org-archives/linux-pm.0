Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D323F3D091D;
	Tue, 26 May 2026 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807384; cv=none; b=gFqwpZKNUqCROsLTa+WGuUfFVds7wDg2wz8Puuy6qu3dKuNt9qaCewTL51+PuuFmJtl0RdXSOtT1aQXWB7gM1E8sweNMiPZyn+ab23VwRydLddPc6GwR8YBRm9xpWlhf//dMqucjAO6WHh/0H/YNaPX/64ivYCLLbSfXX3I/pR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807384; c=relaxed/simple;
	bh=RN/6kATJoszWLSbFjzzLMkpAe24D9rshN9oE4jPee44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxecpG72p+3jdvE0t135R1Px5jVs1iDwSsbVLIuaALnv5gPmtRM9X/J2al5jSrUedNtp54+cYlE8hnRenOdur8vm84FvOc8PAIuUA+7TOj7e0pRsfDgGPp4gQ7ZHyzMiJL/IYlmzjWJ0BpY/P4Z0TxOeKY6Re6MEAFs0LIUNwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i0YNxHW3; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i0YNxHW3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PEJKj8MrGm98KFDNsLR6hqBdS/9XHG5DFtB7L96xDQw=;
	b=i0YNxHW3wq3lFr0pxm1PaJNgAVJTO1vRZUeYUiJLUthZy1rqBkAIdd47b8R+6cAyaooBDq9ga
	Gi+EVanp6M6ViNTwBHbOygCaz+ZLtugXoLZmkLmAljpjW4ksf3jW9FcLRD3EtMD7xBeNQvKhMW1
	e2Prn6nGp6met5Qh5OkxH2g=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gPwbt2RTYz1prmJ;
	Tue, 26 May 2026 22:48:26 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 0107540576;
	Tue, 26 May 2026 22:56:14 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 May
 2026 22:56:12 +0800
From: Yin Tirui <yintirui@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
	<ljs@kernel.org>, Juergen Gross <jgross@suse.com>, Jonathan Cameron
	<jic23@kernel.org>, Will Deacon <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Peter Xu <peterx@redhat.com>,
	Luiz Capitulino <luizcap@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Vlastimil Babka
	<vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Michal Hocko <mhocko@suse.com>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Rohan McLure <rmclure@linux.ibm.com>, Kevin
 Brodsky <kevin.brodsky@arm.com>, Alistair Popple <apopple@nvidia.com>, Andrew
 Donnellan <andrew+kernel@donnellan.id.au>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, Thomas Huth
	<thuth@redhat.com>, Coiby Xu <coxu@redhat.com>, Dan Williams
	<djbw@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Conor Dooley <conor.dooley@microchip.com>, Rik
 van Riel <riel@surriel.com>, <wangkefeng.wang@huawei.com>,
	<chenjun102@huawei.com>, <yintirui@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH mm-unstable RFC v4 3/7] powerpc/mm: use PTE-level pgprot for huge PFN helpers
Date: Tue, 26 May 2026 22:49:59 +0800
Message-ID: <20260526145003.88445-4-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526145003.88445-1-yintirui@huawei.com>
References: <20260526145003.88445-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Make the powerpc PMD PFN helper use PTE-level pgprot_t as the basic
format.

pmd_pgprot() currently derives pgprot_t from the PMD entry through
pte_pgprot(). Some PMD leaf entries can carry H_PAGE_THP_HUGE, which is
specific to huge PMDs and should not be propagated into PTE-level
pgprot_t.

Mask H_PAGE_THP_HUGE out in pmd_pgprot().

Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 arch/powerpc/include/asm/pgtable.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index d20ff2ae02f5..0f368ea64b1f 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -67,7 +67,16 @@ static inline pgprot_t pte_pgprot(pte_t pte)
 #define pmd_pgprot pmd_pgprot
 static inline pgprot_t pmd_pgprot(pmd_t pmd)
 {
-	return pte_pgprot(pmd_pte(pmd));
+	pgprot_t prot = pte_pgprot(pmd_pte(pmd));
+
+	/*
+	 * pmd_pgprot() returns PTE-level pgprot_t. H_PAGE_THP_HUGE is specific
+	 * to huge PMDs.
+	 */
+#ifdef H_PAGE_THP_HUGE
+	prot = __pgprot(pgprot_val(prot) & ~H_PAGE_THP_HUGE);
+#endif
+	return prot;
 }
 
 #define pud_pgprot pud_pgprot
-- 
2.43.0


Return-Path: <SRS0=4E8L=EB=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD0C4363A
	for <linux-pm@archiver.kernel.org>; Mon, 26 Oct 2020 09:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FC422400
	for <linux-pm@archiver.kernel.org>; Mon, 26 Oct 2020 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603704690;
	bh=UPPnXviZXmutWijYpQ9tn9fnLcQibcRuGcgbK3gvCBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J/VHXFElEhEweaAi/mQUtTxTL16n7oV45D4SXBdWmPhDF36La4LlfZxNF6UNuiMZ+
	 Mn6hpTGLrjxj3+bSXtEouKzueAut9GX7S/zAk2mAEFIo6QFP1bsSkxz4sgEZHeT8Ri
	 L1pXRBhIRk3/4qsUFUBCBQ82XoV7F/RdedX7osjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422391AbgJZJba (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Oct 2020 05:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422388AbgJZJb3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 05:31:29 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E07223EA;
        Mon, 26 Oct 2020 09:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603704688;
        bh=UPPnXviZXmutWijYpQ9tn9fnLcQibcRuGcgbK3gvCBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gay4USUBBIxHqVxLVBTGdS6UR/Xrw069y1WeVP2Fs7F0gpT/fVrp1lv3pe8IbHpLe
         RoEp88v8LxwsuyzDFoKwK7DyX3p6WzNTV//0uHT1Jgfz1rDyGmOBg1EeMCMd5+X4tM
         uKwPfXMr4FM1bIOQXZSKgycAvE2mT9oKkX0LymH4=
Date:   Mon, 26 Oct 2020 11:31:10 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "cl@linux.com" <cl@linux.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "rientjes@google.com" <rientjes@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "luto@kernel.org" <luto@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "Brown, Len" <len.brown@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: Re: [PATCH 4/4] arch, mm: make kernel_page_present() always available
Message-ID: <20201026093110.GC1154158@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-5-rppt@kernel.org>
 <979889bf987fdc7268a973fe7398198bfad1644f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979889bf987fdc7268a973fe7398198bfad1644f.camel@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 12:54:01AM +0000, Edgecombe, Rick P wrote:
> On Sun, 2020-10-25 at 12:15 +0200, Mike Rapoport wrote:
> > index 7f248fc45317..16f878c26667 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -2228,7 +2228,6 @@ void __kernel_map_pages(struct page *page, int
> > numpages, int enable)
> >  }
> >  #endif /* CONFIG_DEBUG_PAGEALLOC */
> >  
> > -#ifdef CONFIG_HIBERNATION
> >  bool kernel_page_present(struct page *page)
> >  {
> >         unsigned int level;
> > @@ -2240,7 +2239,6 @@ bool kernel_page_present(struct page *page)
> >         pte = lookup_address((unsigned long)page_address(page),
> > &level);
> >         return (pte_val(*pte) & _PAGE_PRESENT);
> >  }
> > -#endif /* CONFIG_HIBERNATION */
> 
> This is only used by hibernate today right? Makes sense that it should
> return a correct answer if someone starts to use it without looking too
> closely at the header. But could we just remove the default static
> inline return true implementation and let the linker fail if someone
> starts to use it outside hibernate? Then we could leave it compiled out
> until then.

Hmm, I'm not sure I follow you here.
We'd need some stub for architectures that have
ARCH_HIBERNATION_POSSIBLE and do not have
CONFIG_ARCH_HAS_SET_DIRECT_MAP.

I don't see how the kernel would compile for ppc or sparc with
hibernation enabled if I remove the default implementation.

> Also it looks like riscv does not have ARCH_HIBERNATION_POSSIBLE so the
> new function added here couldn't be used yet. You could also just let
> the linker catch it if riscv ever enables hibernate?

-- 
Sincerely yours,
Mike.

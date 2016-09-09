From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] PM / Hibernate: allow hibernation with PAGE_POISONING_ZERO
Date: Fri, 9 Sep 2016 11:29:49 -0700
Message-ID: <CAGXu5jLP2NmuN17HraJw2iLLB=5w=mb6-bTOpSECK_ai1ifjEg@mail.gmail.com>
References: <1473410612-6207-1-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37595 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbcIIS3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 14:29:51 -0400
Received: by mail-wm0-f42.google.com with SMTP id w12so47742541wmf.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 11:29:50 -0700 (PDT)
In-Reply-To: <1473410612-6207-1-git-send-email-anisse@astier.eu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>, Laura Abbott <labbott@fedoraproject.org>
Cc: Linux-MM <linux-mm@kvack.org>, Linux PM list <linux-pm@vger.kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Brad Spengler <spender@grsecurity.net>, Dave Hansen <dave.hansen@intel.com>, David Rientjes <rientjes@google.com>, Jianyu Zhan <nasa4836@gmail.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Mathias Krause <minipli@googlemail.com>, Michal Hocko <mhocko@suse.com>, PaX Team <pageexec@freemail.hu>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.c>

On Fri, Sep 9, 2016 at 1:43 AM, Anisse Astier <anisse@astier.eu> wrote:
> PAGE_POISONING_ZERO disables zeroing new pages on alloc, they are
> poisoned (zeroed) as they become available.
> In the hibernate use case, free pages will appear in the system without
> being cleared, left there by the loading kernel.
>
> This patch will make sure free pages are cleared on resume when
> PAGE_POISONING_ZERO is enabled. We free the pages just after resume
> because we can't do it later: going through any device resume code might
> allocate some memory and invalidate the free pages bitmap.
>
> Thus we don't need to disable hibernation when PAGE_POISONING_ZERO is
> enabled.
>
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Laura Abbott <labbott@fedoraproject.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>

Cool!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Nexus Security

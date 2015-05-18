From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH v4 2/3] mm/page_alloc.c: add config option to sanitize
 freed pages
Date: Mon, 18 May 2015 14:41:19 +0200
Message-ID: <CALUN=qLHfz5DnSKfaRf833eewOM65FNtxybY9Xw9sp1=qq+Zqw@mail.gmail.com>
References: <1431613188-4511-1-git-send-email-anisse@astier.eu>
 <1431613188-4511-3-git-send-email-anisse@astier.eu> <20150518112152.GA16999@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:34511 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbERMll (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 08:41:41 -0400
Received: by laat2 with SMTP id t2so217425985laa.1
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2015 05:41:40 -0700 (PDT)
In-Reply-To: <20150518112152.GA16999@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, May 18, 2015 at 1:21 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2015-05-14 16:19:47, Anisse Astier wrote:
>> This new config option will sanitize all freed pages. This is a pretty
>> low-level change useful to track some cases of use-after-free, help
>> kernel same-page merging in VM environments, and counter a few info
>> leaks.
>
> Could you document the "few info leaks"? We may want to fix them for
> !SANTIZE_FREED_PAGES case, too...
>

I wish I could; I'd be sending patches for those info leaks, too.

What I meant is that this feature can also be used as a general
protection mechanism against a certain class of info leaks; for
example, some drivers allocating pages that were previously used by
other subsystems, and then sending structures to userspace that
contain padding or uninitialized fields, leaking kernel pointers.
Having all pages cleared unconditionally can help a bit in some cases
(hence "a few"), but it's of course not an end-all solution.

I'll edit the commit and kconfig messages to be more precise.

Regards,

Anisse

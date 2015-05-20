From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH v4 2/3] mm/page_alloc.c: add config option to sanitize
 freed pages
Date: Wed, 20 May 2015 14:27:37 +0200
Message-ID: <CALUN=qJdiWn9BSYRq9HgXhGDaBKzApVG=JqFVb1B34Ut8U0k1w@mail.gmail.com>
References: <1431613188-4511-1-git-send-email-anisse@astier.eu>
 <1431613188-4511-3-git-send-email-anisse@astier.eu> <20150518112152.GA16999@amd>
 <CALUN=qLHfz5DnSKfaRf833eewOM65FNtxybY9Xw9sp1=qq+Zqw@mail.gmail.com>
 <20150518130213.GA771@amd> <CALUN=q+VyQgQ+F1HudumDSjFk1PFyEXdwxPNrM_VqKjDKHTfbw@mail.gmail.com>
 <CAFP4FLo9Lrr=pQzwLhj6EfiN5LgRTDMj_hBhQW58UQkC55mYHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34293 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbbETM16 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2015 08:27:58 -0400
Received: by wicmc15 with SMTP id mc15so148105975wic.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2015 05:27:57 -0700 (PDT)
In-Reply-To: <CAFP4FLo9Lrr=pQzwLhj6EfiN5LgRTDMj_hBhQW58UQkC55mYHA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: yalin wang <yalin.wang2010@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, May 19, 2015 at 3:58 AM, yalin wang <yalin.wang2010@gmail.com> wrote:
> 2015-05-18 21:04 GMT+08:00 Anisse Astier <anisse@astier.eu>:
>> On Mon, May 18, 2015 at 3:02 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>>
>>> Ok. So there is class of errors where this helps, but you are not
>>> aware of any such errors in kernel, so you can't fix them... Right?
>>
>> Correct.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> i feel your patch is the same as CONFIG_DEBUG_PAGEALLOC ,
> the difference is that CONFIG_DEBUG_PAGEALLOC  will clear
> page to a magic number, while your patch will
> clear to zero,
> do we really need this duplicated function ?

It's different because DEBUG_PAGEALLOC will only use page poisoning on
certain architectures, and clearing a page to a magic number doesn't
allow to optimize alloc with _GFP_ZERO.

Regards,

Anisse

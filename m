From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 2/3] mm/page_alloc.c: add config option to sanitize
 freed pages
Date: Mon, 18 May 2015 13:21:52 +0200
Message-ID: <20150518112152.GA16999@amd>
References: <1431613188-4511-1-git-send-email-anisse@astier.eu>
 <1431613188-4511-3-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58808 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbERLV4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 07:21:56 -0400
Content-Disposition: inline
In-Reply-To: <1431613188-4511-3-git-send-email-anisse@astier.eu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu 2015-05-14 16:19:47, Anisse Astier wrote:
> This new config option will sanitize all freed pages. This is a pretty
> low-level change useful to track some cases of use-after-free, help
> kernel same-page merging in VM environments, and counter a few info
> leaks.

Could you document the "few info leaks"? We may want to fix them for
!SANTIZE_FREED_PAGES case, too...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

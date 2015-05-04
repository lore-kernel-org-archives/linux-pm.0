From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 3/4] PM / Hibernate: fix SANITIZE_FREED_PAGES
Date: Tue, 05 May 2015 00:29:10 +0200
Message-ID: <28072506.ijDyy3q5rs@vostro.rjw.lan>
References: <1430774218-5311-1-git-send-email-anisse@astier.eu> <1430774218-5311-4-git-send-email-anisse@astier.eu> <5547E995.9980.80084D6@pageexec.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51410 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750770AbbEDWEL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 18:04:11 -0400
In-Reply-To: <5547E995.9980.80084D6@pageexec.freemail.hu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pageexec@freemail.hu
Cc: Anisse Astier <anisse@astier.eu>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>

On Monday, May 04, 2015 11:50:13 PM PaX Team wrote:
> On 4 May 2015 at 23:16, Anisse Astier wrote:
> 
> > SANITIZE_FREED_PAGES feature relies on having all pages going through
> > the free_pages_prepare path in order to be cleared before being used. In
> > the hibernate use case, pages will automagically appear in the system
> > without being cleared.
> 
> is this based on debugging/code reading/discussions with hibernation folks
> (i see none of them on CC, added them now) or is it just a brute force attempt
> to fix the symptoms? if the former, it'd be nice to share some more details
> and have Acks from the code owners.

I haven't seen it, for one, and I'm wondering why the "clearing" cannot be done
at the swsusp_free() time?

In any case, please CC hibernation-related patches and discussions thereof to
linux-pm@vger.kernel.org.

Thanks!


From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH v2 3/4] PM / Hibernate: fix SANITIZE_FREED_PAGES
Date: Tue, 5 May 2015 14:41:37 +0200
Message-ID: <CALUN=qJ8sH1nez2t0j_wO=C+JLCejP_r+Skh_QWk1=J3DOHDQw@mail.gmail.com>
References: <1430774218-5311-1-git-send-email-anisse@astier.eu>
 <1430774218-5311-4-git-send-email-anisse@astier.eu> <5547E995.9980.80084D6@pageexec.freemail.hu>
 <28072506.ijDyy3q5rs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <28072506.ijDyy3q5rs@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: PaX Team <pageexec@freemail.hu>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, linux-mm@kvack.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 5, 2015 at 12:29 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I haven't seen it, for one, and I'm wondering why the "clearing" cannot be done
> at the swsusp_free() time?

Because the validity of the free pages bitmap is short-lived since
device resume code might do some allocations.

>
> In any case, please CC hibernation-related patches and discussions thereof to
> linux-pm@vger.kernel.org.

Thanks, I had to forget something when sending this series :-/ ; I'm
preparing v3 that will be sent to linux-pm too.

Regards,

Anisse

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

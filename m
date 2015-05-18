From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH v4 2/3] mm/page_alloc.c: add config option to sanitize
 freed pages
Date: Mon, 18 May 2015 15:04:00 +0200
Message-ID: <CALUN=q+VyQgQ+F1HudumDSjFk1PFyEXdwxPNrM_VqKjDKHTfbw@mail.gmail.com>
References: <1431613188-4511-1-git-send-email-anisse@astier.eu>
 <1431613188-4511-3-git-send-email-anisse@astier.eu> <20150518112152.GA16999@amd>
 <CALUN=qLHfz5DnSKfaRf833eewOM65FNtxybY9Xw9sp1=qq+Zqw@mail.gmail.com> <20150518130213.GA771@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150518130213.GA771@amd>
Sender: owner-linux-mm@kvack.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 18, 2015 at 3:02 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Ok. So there is class of errors where this helps, but you are not
> aware of any such errors in kernel, so you can't fix them... Right?

Correct.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

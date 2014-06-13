From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 2/2] x86, kaslr: boot-time selectable with
 hibernation
Date: Fri, 13 Jun 2014 22:39:05 +0200
Message-ID: <20140613203905.GA24635@amd.pavel.ucw.cz>
References: <1402691436-20138-1-git-send-email-keescook@chromium.org>
 <1402691436-20138-3-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402691436-20138-3-git-send-email-keescook@chromium.org>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@fedoraproject.org>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2014-06-13 13:30:36, Kees Cook wrote:
> Changes kASLR from being compile-time selectable (blocked by
> CONFIG_HIBERNATION), to being boot-time selectable (with hibernation
> available by default) via the "kaslr" kernel command line.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] x86/power/64: Restore processor state before using
 per-cpu variables
Date: Fri, 12 Aug 2016 13:14:49 +0200
Message-ID: <CAJZ5v0hC28BMqgurck0oiQGxf=XhYwseiVs+DeLdv9wKHFCa7w@mail.gmail.com>
References: <1470952169-39061-1-git-send-email-thgarnie@google.com> <20160812054913.GA24303@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160812054913.GA24303@nazgul.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Thomas Garnier <thgarnie@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Jiri Kosina <jikos@kernel.org>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 12, 2016 at 7:49 AM, Borislav Petkov <bp@suse.de> wrote:
> On Thu, Aug 11, 2016 at 02:49:29PM -0700, Thomas Garnier wrote:
>> Restore the processor state before calling any other function to ensure
>> per-cpu variables can be used with KASLR memory randomization.
>>
>> Tracing functions use per-cpu variables (gs based) and one was called
>> just before restoring the processor state fully. It resulted in a double
>> fault when both the tracing & the exception handler functions tried to
>> use a per-cpu variable.
>>
>> Signed-off-by: Thomas Garnier <thgarnie@google.com>
>> ---
>> Based on next-20160808
>
> Ok, I believe before I test this, I need to apply another patch from
> Rafael. I think it is the "Always create temporary identity mapping
> correctly" thing.
>
> Yes, no?

Yes.

> Rafael, can you please apply everything on a test branch for us to run?

You can simply test my linux-next branch:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
linux-next

That's 4.8-rc1 plus 3 fixes on top of it.

Thanks,
Rafael

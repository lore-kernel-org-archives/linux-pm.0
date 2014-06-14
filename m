From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 0/2] make kASLR vs hibernation boot-time selectable
Date: Fri, 13 Jun 2014 23:09:15 -0700
Message-ID: <CAGXu5jKpSqu6-AeHoiEhBzEYSujthT_UeHNSUKQ6TXhg-S=SPg@mail.gmail.com>
References: <1402691436-20138-1-git-send-email-keescook@chromium.org>
	<2113876.sBNaASbVKF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <2113876.sBNaASbVKF@vostro.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Josh Boyer <jwboyer@fedoraproject.org>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 13, 2014 at 4:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, June 13, 2014 01:30:34 PM Kees Cook wrote:
>> Distros want to be able to offer CONFIG_RANDOMIZE_BASE as well as
>> CONFIG_HIBERNATION in a single kernel. Instead of making kASLR depend on
>> !HIBERNATION at compile time, allow kaslr to be selectable at boot time
>> (via "kaslr" kernel command line), which will disable hibernation in the
>> kernel. In this way the end user can choose which feature they want more
>> with hibernation continuing to stay enabled by default (no surprises).
>>
>> This also has the benefit of being able to entirely disable hibernation
>> from the kernel command line, regardless of kASLR, which is a separately
>> desired feature as well.
>>
>> v3:
>> - switch from EINVAL to EPERM (pavel, jwboyer)
>> v2:
>> - rework using kernel command line instead of hibernation_mode (rjw)
>
> That looks kind of OK.
>
> Do you want me to push this through my tree?

Thanks, yes, that would be great.

-Kees

-- 
Kees Cook
Chrome OS Security

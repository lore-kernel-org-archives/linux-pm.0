From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] make kASLR vs hibernation boot-time selectable
Date: Thu, 12 Jun 2014 13:27:11 -0700
Message-ID: <CAGXu5jLvAr=f2MRP4Ni86-jbM7h3Mx3RQo=7coveE8ZEt12N=Q@mail.gmail.com>
References: <1402602419-27934-1-git-send-email-keescook@chromium.org>
	<539A0422.9010000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <539A0422.9010000@zytor.com>
Sender: linux-doc-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 12, 2014 at 12:48 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 06/12/2014 12:46 PM, Kees Cook wrote:
>> Distros want to be able to offer CONFIG_RANDOMIZE_BASE as well as
>> CONFIG_HIBERNATION in a single kernel. Instead of making kASLR depend on
>> !HIBERNATION at compile time, allow kaslr to be selectable at boot time
>> (via "kaslr" kernel command line), which will disable hibernation in the
>> kernel. In this way the end user can choose which feature they want more
>> with hibernation continuing to stay enabled by default (no surprises).
>
> Any way we can make them work together instead?

I'm sure there is, but I don't know the solution. :)

At the very least this gets us one step closer (we can build them together).

-Kees

-- 
Kees Cook
Chrome OS Security

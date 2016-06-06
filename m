From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH 5/5] intel_idle: Add S0ix validation
Date: Mon, 6 Jun 2016 14:39:11 -0700
Message-ID: <CAGAzgspi2-h055gusybZcgOD=_C9NLwd9gk7Pnj4T=Fbx3A9Fw@mail.gmail.com>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
 <1464842009-21789-6-git-send-email-dbasehore@chromium.org>
 <20160602092505.GQ3206@twins.programming.kicks-ass.net> <20160602142318.2c9d2111@lxorguk.ukuu.org.uk>
 <CAGAzgspC49xNXPsV-WCT-xqVJGfNGeHkhYYLfZSTfBtjddVm8A@mail.gmail.com>
 <20160602205338.4a16760a@lxorguk.ukuu.org.uk> <CAGAzgsrgH5-v2u8kfmxzGKzTqGV1nqp+Yo4E7y96yrretKTkXA@mail.gmail.com>
 <20160604132213.18eb7d82@lxorguk.ukuu.orguk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160604132213.18eb7d82@lxorguk.ukuu.orguk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 4, 2016 at 5:22 AM, Alan <gnomes@lxorguk.ukuu.org.uk> wrote:
>> I would expect those IP blocks to do nothing and not block lower power
>> states if the firmware is not loaded. If that is not the case, I think
>> that should be fixed such that those lower power states are at least
>> available during suspend (if not during runtime). If your Skylake+
>> system is not entering S0ix during freeze, I consider that a bug that
>> needs to be addressed.
>
> You would assume wrongly. Several parts of the system do their own
> power management so if present need to have a driver loaded. Graphics
> is the example everyone is familiar with but ADSP audio and ISH are two
> others.

Okay, I remember running into this with the display actually.

>
>> configs, that's their decision. As I said, this does nothing in the
>> !CONFIG_INTEL_PMC_CORE case, but if a finer level config is warranted,
>> I can add that.
>
> IMHO it belongs as a config item because it has a power cost, and you
> can't turn it off without enabling debugfs when it's compiled in.
>

It could also be default off. It's not a lot of code being added, so
it could just be part of the Intel Idle driver.

After thinking about it, I plan on moving to exponential back off for
the freeze time (1, 10, 100, 1000 seconds). This way, the power impact
won't be measurable, yet it will still catch errors. There will just
be a sysfs entry added to the cpuidle node to enable/disable the
feature. The feature will be turned off by default.

>> I would prefer if others used this more, since there would be better
>> debug coverage and I would have to fix fewer bugs.
>
> I'd be more concerned about getting 10,000 emails bisecting the warning
> to your commit 8)
>
> Alan

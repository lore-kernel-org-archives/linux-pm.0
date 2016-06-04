From: Alan <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] intel_idle: Add S0ix validation
Date: Sat, 4 Jun 2016 13:22:13 +0100
Message-ID: <20160604132213.18eb7d82@lxorguk.ukuu.orguk>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
	<1464842009-21789-6-git-send-email-dbasehore@chromium.org>
	<20160602092505.GQ3206@twins.programming.kicks-ass.net>
	<20160602142318.2c9d2111@lxorguk.ukuu.org.uk>
	<CAGAzgspC49xNXPsV-WCT-xqVJGfNGeHkhYYLfZSTfBtjddVm8A@mail.gmail.com>
	<20160602205338.4a16760a@lxorguk.ukuu.org.uk>
	<CAGAzgsrgH5-v2u8kfmxzGKzTqGV1nqp+Yo4E7y96yrretKTkXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGAzgsrgH5-v2u8kfmxzGKzTqGV1nqp+Yo4E7y96yrretKTkXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

> I would expect those IP blocks to do nothing and not block lower power
> states if the firmware is not loaded. If that is not the case, I think
> that should be fixed such that those lower power states are at least
> available during suspend (if not during runtime). If your Skylake+
> system is not entering S0ix during freeze, I consider that a bug that
> needs to be addressed.

You would assume wrongly. Several parts of the system do their own
power management so if present need to have a driver loaded. Graphics
is the example everyone is familiar with but ADSP audio and ISH are two
others.

> configs, that's their decision. As I said, this does nothing in the
> !CONFIG_INTEL_PMC_CORE case, but if a finer level config is warranted,
> I can add that.

IMHO it belongs as a config item because it has a power cost, and you
can't turn it off without enabling debugfs when it's compiled in.

> I would prefer if others used this more, since there would be better
> debug coverage and I would have to fix fewer bugs.

I'd be more concerned about getting 10,000 emails bisecting the warning
to your commit 8)

Alan

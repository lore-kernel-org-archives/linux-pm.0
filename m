From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH 5/5] intel_idle: Add S0ix validation
Date: Thu, 2 Jun 2016 11:31:15 -0700
Message-ID: <CAGAzgspbzZYdcA20evTbbHxxu_sA17UxeK1HyUztodytXZLrog@mail.gmail.com>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
 <1464842009-21789-6-git-send-email-dbasehore@chromium.org>
 <20160602092505.GQ3206@twins.programming.kicks-ass.net> <20160602142318.2c9d2111@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:32923 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbcFBSbR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 14:31:17 -0400
Received: by mail-vk0-f46.google.com with SMTP id r140so83182338vkf.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 11:31:16 -0700 (PDT)
In-Reply-To: <20160602142318.2c9d2111@lxorguk.ukuu.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Jun 2, 2016 at 6:23 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
> On Thu, 2 Jun 2016 11:25:05 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Wed, Jun 01, 2016 at 09:33:29PM -0700, dbasehore@chromium.org wrote:
>> > +/*
>> > + * Default chosen to have <= 1% power increase while allowing fast detection of
>> > + * SLP S0 entry errors. Waking up 10 times a second shows ~30% increase in
>> > + * system power on Skylake Y. Waking up once every 10 seconds is
>> > + * indistinguishable from not waking up at all (as ~0.3% power increase would
>> > + * be). Any reasonable power increases above this will not be visible to the
>> > + * user.
>> > + */
>> > +#define DEFAULT_SLP_S0_SECONDS 10
>>
>> So I don't think anybody waits for 10 seconds to see if suspend worked.
>> After 10 seconds its in the bag and I'm out the door.
>>
>> Then what?
>>
>>
>> Why can't you fire a single timer after 0.5 seconds to see if you hit
>> C10 and leave it at that? What's the point any further wakeup, if you
>> know you hit C10, you're good continue on.

That will take care of most of the problems I have seen, but that
doesn't handle everything. Say your audio codec is misconfigured and
causes an interrupt storm when you plug in headphones. The irq handler
won't run, but it could still wake up the system repeatedly and
prevent entry into S0ix.

If this fails, it's not expected that the user catch and handle it,
unless he/she uses "echo freeze > /sys/power/state" to suspend to
idle. It's intended that whatever daemon in user space handles power
state transitions will catch the error and either retry, suspend to
RAM, or shut down the system.

What could happen is we could wake up after 1 second the first time,
then wake up at a slp_s0_seconds after that. This will allow us to
fail faster, still catch issues that happen later, and increase
DEFAULT_SLP_S0_SECONDS to something longer.

>
> There are plenty of Skylake configurations where at the moment you won't
> get s0ix entry because the ISH driver is not yet merged. Spamming those
> users with useless messages is not helpful. Likewise on systems with
> modular kernels your warning may spuriously trigger during boot until the
> ISH, i915 and audio modules and firmware have loaded and are active. I
> know Chrome doesn't like modules but the rest of us do !
>
> I'm also a bit at a loss to understand why anyone needs this except
> validation engineers for Chrome products and kernel hackers doing
> debug. It seems a bit odd to burden the entire world with a pile of
> checks they can't use that cost even 0.3% of power (that's 15 minutes on
> an 8 hour battery multiplied by every Skylake user!).

15 minutes is 4% of 8 hours, but let's take a system that has 8 hours
of battery life for use and 10 days of suspend to idle. 0.3% of 10
days is < 1 hour. That's only for suspend time, though. A user could
lose 1.5 minutes of use, but that's only if the user left his or her
machine suspended for 10 days. I'll probably add the single early wake
that I mentioned before and change this to 100 seconds. At that point,
we're looking at 0.03% power increase, which is < 9 seconds of lost
use for 10 days of suspend to idle.

>
> Having to have debugfs present to turn it off, but not to use it is also
> a bit weird...

I could look into putting this into the cpuidle sysfs.

>
> IMHO this should be one of the hacking/kernel debug options and not even
> compiled into normal kernels.

This patch isn't only about finding the bugs, but doing something more
graceful than burning a lot of power during suspend to idle. Whether
that's switching to suspend to RAM or shutting down is up to whatever
daemon handles power transitions. That doesn't necessarily cover users
that just use "echo |state| > /sys/power/state", but those users
already have spurious wakes, devices that take a long time to suspend
followed by failures, and other problems to handle.

This patch set does nothing if CONFIG_INTEL_PMC_CORE is not set. If
Linux distros don't want this running they can compile without that
config set since this is currently the only user of that. I could also
add another config flag if that's preferred or if anything else starts
using the INTEL_PMC_CORE code.

>
> Alan

Thanks for the reviews.

From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH v5 5/5] intel_idle: Add S0ix validation
Date: Wed, 12 Jul 2017 16:14:10 -0700
Message-ID: <CAGAzgsqZvfR9WtYDq5yaSDiKK8LSivE5uOTsUorVtWxfy18SEA@mail.gmail.com>
References: <20170708000303.21863-1-dbasehore@chromium.org>
 <20170708000303.21863-5-dbasehore@chromium.org> <alpine.DEB.2.20.1707130003150.2510@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36673 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdGLXON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 19:14:13 -0400
Received: by mail-wm0-f46.google.com with SMTP id 62so7805727wmw.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 16:14:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1707130003150.2510@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Wed, Jul 12, 2017 at 3:16 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 7 Jul 2017, Derek Basehore wrote:
>> This adds validation of S0ix entry and enables it on Skylake. Using
>> the new tick_set_freeze_event function, we program the CPU to wake up
>> X seconds after entering freeze. After X seconds, it will wake the CPU
>> to check the S0ix residency counters and make sure we entered the
>> lowest power state for suspend-to-idle.
>>
>> It exits freeze and reports an error to userspace when the SoC does
>> not enter S0ix on suspend-to-idle.
>>
>> One example of a bug that can prevent a Skylake CPU from entering S0ix
>> (suspend-to-idle) is a leaked reference count to one of the i915 power
>> wells. The CPU will not be able to enter Package C10 and will
>> therefore use about 4x as much power for the entire system. The issue
>> is not specific to the i915 power wells though.
>
> I really have a hard time to understand the usefulness of this.
>
> All I can see so far is detecting that something went wrong. So if this
> happens once per day all the user gets is a completely useless line in
> dmesg. Even if that message comes more often, it still tells only that
> something went wrong without the slightest information about the potential
> root cause.
>
> There are more issues with this: If there is a hrtimer scheduled on that
> last CPU which enters the idle freeze state and that timer is 10 minutes
> away, then the check timer can't be programmed and the system will happily
> stay for 10 minutes in some shallow C state without notice. Not really
> useful.

Are hrtimers not suspended after timekeeping_suspend is called?

>
> You know upfront whether the i915 power wells (or whatever other machinery)
> is not powered off to allow the system to enter a specific power state. If
> you think hard enough about creating infrastructure which allows you to
> register power related facilities and then check them in that idle freeze
> enter state, then you get immediate information WHY this happens and not
> just the by chance notification about the fact that it happened.

It's not always something that can be checked by software. There was
one case where an ordering for powering down audio hardware prevented
proper PC10 entry, but there didn't seem to be any way to check that.
Hardware watchdogs also have the same lack of clarity, but most if not
all desktop and mobile processors ship with one. Overall, this seems
to be the best that can be done at this point in freeze, and we can't
really rely on every part of the system properly validating it's state
in its suspend operation.

>
> I might be missing something, but aside of the issues I have with the
> tick/clockevents abuse, this looks like some half baken ad hoc debugging
> aid of dubious value.
>
> Thanks,
>
>         tglx
>
>
>
>

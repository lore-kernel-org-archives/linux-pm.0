From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Save and Restore Generic Interrupt Controller for System Sleep on ARM
Date: Wed, 06 Dec 2017 09:48:16 +0000
Message-ID: <87vahk6vbz.fsf@on-the-bus.cambridge.arm.com>
References: <CAGAzgsrSDF0Hs4-=m02c6ME90RvZumYxzBFFi0oH=RuwxQnB-Q@mail.gmail.com>
        <86d140xfr9.fsf@unassigned-hostname.unassigned-domain>
        <CAGAzgspYoDwbmj+cXWQJcUmmGZshQ95-a-8gBNOtxT8L2Qm-VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752373AbdLFJsU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Dec 2017 04:48:20 -0500
In-Reply-To: <CAGAzgspYoDwbmj+cXWQJcUmmGZshQ95-a-8gBNOtxT8L2Qm-VQ@mail.gmail.com>
        (dbasehore .'s message of "Thu, 30 Nov 2017 17:21:20 -0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, sudeep.holla@arm.com, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, Nov 30 2017 at  5:21:20 pm GMT, "dbasehore ." <dbasehore@chromium.org> wrote:
> On Thu, Nov 30, 2017 at 1:44 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Wed, Nov 29 2017 at 2:49:18 pm GMT, "dbasehore ."
>> <dbasehore@chromium.org> wrote:
>>> There was some work in ARM Trusted Firmware to support saving and
>>> restoring the Generic Interrupt Controller (GICv3) before and after
>>> sleep, but it seems that the plan is to have this all in the kernel
>>> now. The point of doing this is to save power during sleep. On an
>>> RK3399 system, we save about 15mW by disabling the power rail that the
>>> GIC is on.
>>>
>>> I was looking for whether anyone had anything in progress already or
>>> for preferences on how to do this. Marc suggested using a device tree
>>> entry to indicate the need to save and restore the GIC. There is
>>> another requirement to resend MAPC commands on certain implementations
>>> of the GICv3 which could be indicated by another device tree entry.
>>
>> Let's be precise: This is a GIC-500 requirement, and not something that
>> the GICv3 architecture defines (PM is *not* part of the GICv3
>> architecture).
>>
>
> Just to double check, do the register restores apply to all GICv3
> designs? If so, I can put that code in the gic-v3 code instead of
> breaking it out.

I would keep it GIC-500 specific for the time being. But that code
should live in the GICv3 driver, gated on the IIDR registers and some
form of firmware negotiation.

Again, it will be much easier to comment on this when we see the
code. So far, I feel a bit uneasy talking mostly hypothetically.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.

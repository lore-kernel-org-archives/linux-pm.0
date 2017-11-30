From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Save and Restore Generic Interrupt Controller for System Sleep on ARM
Date: Thu, 30 Nov 2017 09:44:26 +0000
Message-ID: <86d140xfr9.fsf@unassigned-hostname.unassigned-domain>
References: <CAGAzgsrSDF0Hs4-=m02c6ME90RvZumYxzBFFi0oH=RuwxQnB-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGAzgsrSDF0Hs4-=m02c6ME90RvZumYxzBFFi0oH=RuwxQnB-Q@mail.gmail.com>
        (dbasehore .'s message of "Wed, 29 Nov 2017 14:49:18 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, sudeep.holla@arm.com, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 29 2017 at  2:49:18 pm GMT, "dbasehore ." <dbasehore@chromium.org> wrote:
> There was some work in ARM Trusted Firmware to support saving and
> restoring the Generic Interrupt Controller (GICv3) before and after
> sleep, but it seems that the plan is to have this all in the kernel
> now. The point of doing this is to save power during sleep. On an
> RK3399 system, we save about 15mW by disabling the power rail that the
> GIC is on.
>
> I was looking for whether anyone had anything in progress already or
> for preferences on how to do this. Marc suggested using a device tree
> entry to indicate the need to save and restore the GIC. There is
> another requirement to resend MAPC commands on certain implementations
> of the GICv3 which could be indicated by another device tree entry.

Let's be precise: This is a GIC-500 requirement, and not something that
the GICv3 architecture defines (PM is *not* part of the GICv3
architecture).

> If someone does have patches, I'll be able to test and verify them on
> my system since we've gotten things working with the ARM Trusted
> Firmware patches.

I'm not aware of any such patch that has been posted for mainline, so
just post whatever you have and we'll take it from there.

IT is hard to comment further on what you're trying to do without seeing
the code and a description of the new API between ATF and the kernel.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.

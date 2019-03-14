From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] [RESEND] Do not modify perf bias performance setting by
 default at boot
Date: Thu, 14 Mar 2019 23:08:03 +0100
Message-ID: <CAJZ5v0h3zLrqqMXzt_cqGV1rBR0muosZwy1Zu3fV9O1kqGc6gw@mail.gmail.com>
References: <6369897.qxlu8PgE1t@house>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6369897.qxlu8PgE1t@house>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael@kernel.org>, Hannes Reinecke <hare@suse.de>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Simon Schricker <sschricker@suse.de>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 14, 2019 at 3:42 PM Thomas Renninger <trenn@suse.de> wrote:
>
> This is a revert of mainline git commits:
> commit b51ef52df71cb28e9d90cd1d48b79bf19f0bab06
> commit 17edf2d79f1ea6dfdb4c444801d928953b9f98d6
> commit abe48b108247e9b90b4c6739662a2e5c765ed114

I'm not quite convinced that reverting these is the right thing to do here.

> It is about this kernel message showing up on quite a lot servers:
> [    0.072652] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.076003] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)

What happens on boot is a matter of convention and the convention by
which the EPB is set to "neutral" at that point has been used for
quite a while.  Changing it now may confuse some users or even worse.

It would be fine to change the log level of these messages in my view, though.

> The background afaik were some BIOS which "forgot to set a default value".
> Certainly some (one?) broken laptop BIOS was meant, because
> the value zero (performance) is quite a reasonable default value on server systems
> and this is how a lot CPUs typically come up there.

That depends on the expected power/perf profile of the system and the
kernel has no information regarding that.  Arguably, user space can
set the EPB to whatever it wants at the init time according to the
information it has.  It is not quite realistic to expect that either
the BIOS or the kernel will do the right thing on all systems in that
respect anyway.

> Another sever bug with above patches:
> If you really set performance BIAS MSR value to 'performance'
> as mentioned in kernel boot log, it is reset on next CPU offline/online cycle
> (see below).

That is a bug.  There is no reason to change the EPB on CPU
offline/online and I agree that this needs to be fixed.  The reverts
would make this problem go away, but that's not the only possible way
to fix it.

Moreover, what is done during system-wide resume appears to be a bug
too.  Whatever EPB value is there during suspend should be saved and
it should be restored during resume. Reverting the commits above will
not fix that particular issue.

Thanks,
Rafael

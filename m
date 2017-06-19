From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] x86,cpufreq: unify APERF/MPERF computation
Date: Mon, 19 Jun 2017 14:45:57 +0200
Message-ID: <CAJZ5v0iCryQUDnidW_ahYz0VrO0RXMdF0Ww2efiRtoytahPZsg@mail.gmail.com>
References: <1497668594-9266-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34118 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753699AbdFSMp7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2017 08:45:59 -0400
In-Reply-To: <1497668594-9266-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Sat, Jun 17, 2017 at 5:03 AM, Len Brown <lenb@kernel.org> wrote:
>
> In-Reply-To:
>
> Hi Rafael,
>
> This patch series has 3 goals:
>
> 1. Make "cpu MHz" in /proc/cpuinfo supportable.
>
> 2. Make /sys/.../cpufreq/scaling_cur_freq meaningful
>    and consistent on modern x86 systems.
>
> 3. Use 1. and 2. to remove scheduler and cpufreq overhead
>
> There are 3 main changes since this series was proposed
> about a year ago:
>
> This update responds to distro feedback to make /proc/cpuinfo
> "cpu MHz" constant.  Originally, we had proposed making it return
> the same dynamic value as cpufreq sysfs.
>
> Some community members suggested that sysfs MHz values should
> be meaninful, even down to 10ms intervals.  So this has been
> changed, versus the original proposal to not re-compute
> at intervals shorter than 100ms.
>
> (For those who really care about observing frequency, the
>  recommendation remains to use turbostat(8) or equivalent utility,
>  which can reliably measure concurrent intervals of arbitrary length)
>
> The intel_pstate sampling mechanism has changed.
> Originally this series removed an intel_pstate timer in HWP mode.
> Now it removes the analogous scheduler call-back.
>
> Most recently, in response to posting this patch on the list
> about 10-days ago, the patch to remove frequency calculation
> from inside intel_pstate was dropped, in order to maintain compatibility
> with tracing scripts.  Also, the order of the last two patches
> has been exchanged.
>
> Please let me know if you see any issues with this series.
>
> thanks!
> Len Brown, Intel Open Source Technology Center
>
> The following changes since commit 3c2993b8c6143d8a5793746a54eba8f86f95240f:
>
>   Linux 4.12-rc4 (2017-06-04 16:47:43 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git x86
>
> for you to fetch changes up to d020eed98440faa4a529c621f881aa9fda296956:
>
>   intel_pstate: skip scheduler hook when in "performance" mode. (2017-06-16 19:11:13 -0700)
>
> ----------------------------------------------------------------
> Len Brown (4):
>       x86: do not use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
>       x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF
>       intel_pstate: delete scheduler hook in HWP mode
>       intel_pstate: skip scheduler hook when in "performance" mode.

I'd like to hear from the x86 maintainers about the first two patches.
At least I'd like to know that there are no objections there.

Thanks,
Rafael

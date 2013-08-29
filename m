From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] cpuidle: coupled: disable interrupts after entering safe state
Date: Thu, 29 Aug 2013 02:50:52 +0200
Message-ID: <4613645.5k2flX1qQg@vostro.rjw.lan>
References: <1377287112-12018-1-git-send-email-ccross@android.com> <16805669.URyPi50bbV@vostro.rjw.lan> <CAMbhsRQ4DtMUs7HJz_t4reWaehjqEN=Xg2EaFKBgdPUO_ZtNCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40590 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab3H2AkH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Aug 2013 20:40:07 -0400
In-Reply-To: <CAMbhsRQ4DtMUs7HJz_t4reWaehjqEN=Xg2EaFKBgdPUO_ZtNCA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Neil Zhang <zhangwm@marvell.com>, Joseph Lo <josephl@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>, stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

On Wednesday, August 28, 2013 03:00:58 PM Colin Cross wrote:
> On Wed, Aug 28, 2013 at 2:28 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, August 23, 2013 12:45:10 PM Colin Cross wrote:
> >> Calling cpuidle_enter_state is expected to return with interrupts
> >> enabled, but interrupts must be disabled before starting the
> >> ready loop synchronization stage.  Call local_irq_disable after
> >> each call to cpuidle_enter_state for the safe state.
> >>
> >> CC: stable@vger.kernel.org
> >> Signed-off-by: Colin Cross <ccross@android.com>
> >
> > I've queued up all thress for 3.12, but I wonder what stable versions they
> > should be included into?  All of them or just a subset?
> 
> The patches apply cleanly back to v3.6.
> 
> Joseph Lo had 2 minor comments on patch 2 (changing Tegra3 to Tegra20
> in the commit message, replacing cpuidle_coupled_poke_pending with
> cpuidle_coupled_poked in the comment above cpuidle_coupled_poked), do
> you want to fix those up locally or should I resend the series?

I'd prefer it to be resent, then, but just the patch(es) that changed.

Thanks,
Rafael


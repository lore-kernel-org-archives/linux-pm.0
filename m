From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 1/3] cpuidle: coupled: disable interrupts after entering
 safe state
Date: Wed, 28 Aug 2013 15:00:58 -0700
Message-ID: <CAMbhsRQ4DtMUs7HJz_t4reWaehjqEN=Xg2EaFKBgdPUO_ZtNCA@mail.gmail.com>
References: <1377287112-12018-1-git-send-email-ccross@android.com>
	<16805669.URyPi50bbV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <16805669.URyPi50bbV@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Neil Zhang <zhangwm@marvell.com>, Joseph Lo <josephl@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>, stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 28, 2013 at 2:28 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, August 23, 2013 12:45:10 PM Colin Cross wrote:
>> Calling cpuidle_enter_state is expected to return with interrupts
>> enabled, but interrupts must be disabled before starting the
>> ready loop synchronization stage.  Call local_irq_disable after
>> each call to cpuidle_enter_state for the safe state.
>>
>> CC: stable@vger.kernel.org
>> Signed-off-by: Colin Cross <ccross@android.com>
>
> I've queued up all thress for 3.12, but I wonder what stable versions they
> should be included into?  All of them or just a subset?

The patches apply cleanly back to v3.6.

Joseph Lo had 2 minor comments on patch 2 (changing Tegra3 to Tegra20
in the commit message, replacing cpuidle_coupled_poke_pending with
cpuidle_coupled_poked in the comment above cpuidle_coupled_poked), do
you want to fix those up locally or should I resend the series?

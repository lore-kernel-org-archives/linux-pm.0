From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] More power management updates for v4.20-rc1
Date: Tue, 30 Oct 2018 09:09:12 -0700
Message-ID: <CAHk-=wgyRsCfBqOo6F0SEq-fO=euSfHbmW2dWifgmVXSXaNwTA@mail.gmail.com>
References: <CAJZ5v0g7iRUA2=fi3+rkJcsx38YTE6fx26bnnpjeMHwv_CSMVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g7iRUA2=fi3+rkJcsx38YTE6fx26bnnpjeMHwv_CSMVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 30, 2018 at 1:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> These remove a questionable heuristic from the menu cpuidle governor,
> fix a recent build regression in the intel_pstate driver, clean up
> ARM big-Little support in cpufreq and fix up hung task watchdog's
> interaction with system-wide power management transitions.

Pulled,

                 Linus

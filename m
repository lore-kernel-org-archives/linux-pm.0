From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] cpupower update for Linux 4.18-rc1
Date: Wed, 6 Jun 2018 08:44:02 +0200
Message-ID: <CAJZ5v0jB+=cC5gJTT538Rci1kGdWK4vUqSu2c_xPBGS=nTVjbg@mail.gmail.com>
References: <559de2f1-fdf6-7010-2e01-d20765551065@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <559de2f1-fdf6-7010-2e01-d20765551065@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 5, 2018 at 12:03 AM, Shuah Khan <shuah@kernel.org> wrote:
> Hi Rafael,

Hi Shuah,

> If it isn't too late, please pull this update. A fix came in last
> week to refine the cpupower monitor command.
>
> This cpupower update for 4.18-rc1 consists of two minor fixes.
>
> diff is attached.

Pulled, thanks!

I'll queue it up for the second half of the merge window.

Cheers,
Rafael


> ----------------------------------------------------------------
>
> The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:
>
>   Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-4.18-rc1
>
> for you to fetch changes up to f9652d5cae04eb5e85303c087f5842d320499c65:
>
>   cpupower : Fix header name to read idle state name (2018-05-29 10:48:33 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-4.18-rc1
>
> This cpupower update for 4.18-rc1 consists of two minor fixes.
>
> ----------------------------------------------------------------
> Abhishek Goel (1):
>       cpupower : Fix header name to read idle state name
>
> Colin Ian King (1):
>       cpupower: fix spelling mistake: "logilename" -> "logfilename"
>
>  tools/power/cpupower/bench/parse.c                 |  2 +-
>  .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    | 15 ++++++++++
>  .../cpupower/utils/idle_monitor/cpupower-monitor.c | 35 ++++++++++++----------
>  .../cpupower/utils/idle_monitor/cpupower-monitor.h |  9 ++++++
>  4 files changed, 45 insertions(+), 16 deletions(-)
> ----------------------------------------------------------------

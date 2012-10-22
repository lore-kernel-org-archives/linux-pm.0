From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: governors: remove redundant code
Date: Mon, 22 Oct 2012 14:16:43 +0530
Message-ID: <CAKohpo=Jsy9az4PgJ-mkq_U49EOpHGES+-DaROanCOTn-L2s3Q@mail.gmail.com>
References: <32e5bed743cc6cc4e614291a7080299f5f0d0933.1350677395.git.viresh.kumar@linaro.org>
	<98478a02ae69afc01b3c7860e42a4d763b2045e8.1350677395.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <98478a02ae69afc01b3c7860e42a4d763b2045e8.1350677395.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdsw-power-team@arm.com, arvind.chauhan@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 20 October 2012 01:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Initially ondemand governor was written and then using its code conservative
> governor is written. It used a lot of code from ondemand governor, but copy of
> code was created instead of using the same routines from both governors. Which
> increased code redundancy, which is difficult to manage.
>
> This patch is an attempt to move common part of both the governors to
> cpufreq_governor.c file to come over above mentioned issues.
>
> This shouldn't change anything from functionality point of view.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>
> Hi Rafael,
>
> This patch is *NOT TESTED*... (only compiled)
> Out of office now, so can't test it on board.
>
> Floated it, so that i can get some early comments if possible.

Didn't crashed :)
Tested both ondemand and conservative governors and they are working
fine.

>  drivers/cpufreq/Makefile               |   4 +-
>  drivers/cpufreq/cpufreq_conservative.c | 558 +++++++------------------
>  drivers/cpufreq/cpufreq_governor.c     | 314 ++++++++++++++
>  drivers/cpufreq/cpufreq_governor.h     | 177 ++++++++
>  drivers/cpufreq/cpufreq_ondemand.c     | 728 ++++++++++-----------------------
>  include/linux/cpufreq.h                |   2 +-
>  6 files changed, 864 insertions(+), 919 deletions(-)

diffstat might not look awesome, but considering two new files with
file headers, #includes, etc added.. this looks reasonable :)

--
viresh

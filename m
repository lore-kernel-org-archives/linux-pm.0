From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Convert the cpufreq_driver_lock to a rwlock
Date: Tue, 5 Feb 2013 13:41:59 +0530
Message-ID: <CAOh2x=kwADoQTv4jA9gcrVUyCP5HvA4FyZp7kfpB8nptgs+8UA@mail.gmail.com>
References: <1360017913-25667-1-git-send-email-nzimmer@sgi.com>
	<1360017913-25667-2-git-send-email-nzimmer@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1360017913-25667-2-git-send-email-nzimmer@sgi.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 5, 2013 at 4:15 AM, Nathan Zimmer <nzimmer@sgi.com> wrote:
> This completely eliminates the contention I am seeing in __cpufreq_cpu_get.
> It also nicely stages the lock to be replaced by the rcu.
>
> CC: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
> ---
>  drivers/cpufreq/cpufreq.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

You have rebased it against an old version of this file. Please rebase it on
latest Rafael's linux-next branch.

The patch looks good otherwise.

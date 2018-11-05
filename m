From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Documentation: cpufreq: Correct a typo
Date: Mon, 5 Nov 2018 10:40:12 +0530
Message-ID: <CAOh2x=nSWwN90GsyRokUoCZo5OLHN-LyVS3t3rpcAMn0v6+yVA@mail.gmail.com>
References: <20181101013257.659-1-zhaoweiliew@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101013257.659-1-zhaoweiliew@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhaoweiliew@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Documentation <linux-doc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

+Rafael

On Thu, Nov 1, 2018 at 7:06 AM Zhao Wei Liew <zhaoweiliew@gmail.com> wrote:
>
> Fix a typo in the admin-guide documentation for cpufreq.
>
> Signed-off-by: Zhao Wei Liew <zhaoweiliew@gmail.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index 47153e64dfb5..7eca9026a9ed 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -150,7 +150,7 @@ data structures necessary to handle the given policy and, possibly, to add
>  a governor ``sysfs`` interface to it.  Next, the governor is started by
>  invoking its ``->start()`` callback.
>
> -That callback it expected to register per-CPU utilization update callbacks for
> +That callback is expected to register per-CPU utilization update callbacks for
>  all of the online CPUs belonging to the given policy with the CPU scheduler.
>  The utilization update callbacks will be invoked by the CPU scheduler on
>  important events, like task enqueue and dequeue, on every iteration of the

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

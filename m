From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] cpufreq: Fix NULL pointer comparison warning
Date: Tue, 6 Dec 2016 22:03:44 +0100
Message-ID: <CAJZ5v0hrA5iCvE2q6T7sqF2Oq2tenhgF--mw9zRoKb0jJXSK=w@mail.gmail.com>
References: <1481019475-26636-1-git-send-email-m.wasif@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481019475-26636-1-git-send-email-m.wasif@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mohamed Wasif <m.wasif@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vidushi.koul@samsung.com
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 6, 2016 at 11:17 AM, Mohamed Wasif <m.wasif@samsung.com> wrote:
> Replace direct comparisons to NULL
> This problem was detected by checkpatch.
>
> Signed-off-by: Mohamed Wasif <m.wasif@samsung.com>
> ---
>  drivers/cpufreq/cpufreq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6e6c1fb..ca3542e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -590,7 +590,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
>
>                 t = find_governor(str_governor);
>
> -               if (t == NULL) {
> +               if (!t) {
>                         int ret;
>
>                         mutex_unlock(&cpufreq_governor_mutex);
> @@ -601,7 +601,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
>                                 t = find_governor(str_governor);
>                 }
>
> -               if (t != NULL) {
> +               if (t) {
>                         *governor = t;
>                         err = 0;
>                 }
> --

The code is correct as is and this patch doesn't fix anything.

Besides, you are supposed to run checkpatch against *patches* and not
against existing code.

Thanks,
Rafael

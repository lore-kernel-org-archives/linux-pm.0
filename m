From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: stats: Refactor common code into
 __cpufreq_stats_create_table()
Date: Thu, 27 Feb 2014 11:09:45 +0530
Message-ID: <CAKohpo=Xf+5OxjAuYkh_jCJ92MPuutgpHXL8fxOLq_3B18cSEA@mail.gmail.com>
References: <1393445858-7062-3-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393445858-7062-3-git-send-email-skannan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 27 February 2014 01:47, Saravana Kannan <skannan@codeaurora.org> wrote:
> cpufreq_frequency_get_table() is called from all callers of
> __cpufreq_stats_create_table(). So, move it inside.
>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index c52b440..9d9e366 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -180,13 +180,18 @@ static void cpufreq_stats_free_table(unsigned int cpu)
>         cpufreq_cpu_put(policy);
>  }
>
> -static int __cpufreq_stats_create_table(struct cpufreq_policy *policy,
> -               struct cpufreq_frequency_table *table)
> +static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  {
>         unsigned int i, j, count = 0, ret = 0;
>         struct cpufreq_stats *stat;
>         unsigned int alloc_size;
>         unsigned int cpu = policy->cpu;
> +       struct cpufreq_frequency_table *table;
> +
> +       table = cpufreq_frequency_get_table(policy->cpu);

s/policy->cpu/cpu

Otherwise, Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

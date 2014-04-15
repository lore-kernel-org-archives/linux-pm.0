From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/20] cpufreq: dbx500: Use cpufreq_for_each_entry macro
 for iteration
Date: Tue, 15 Apr 2014 11:06:33 +0530
Message-ID: <CAKohpo=6fK0DzvPq_a=kEKV4kSBWjyEBzQoS5eqVAAGstb6=2A@mail.gmail.com>
References: <534C4E5D.40508@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <534C4E5D.40508@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15 April 2014 02:38, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> The cpufreq core supports the cpufreq_for_each_entry macro helper
> for iteration over the cpufreq_frequency_table, so use it.
>
> It should have no functional changes.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/dbx500-cpufreq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
> index 412a78b..2a0635c 100644
> --- a/drivers/cpufreq/dbx500-cpufreq.c
> +++ b/drivers/cpufreq/dbx500-cpufreq.c
> @@ -45,7 +45,7 @@ static struct cpufreq_driver dbx500_cpufreq_driver = {
>
>  static int dbx500_cpufreq_probe(struct platform_device *pdev)
>  {
> -       int i = 0;
> +       struct cpufreq_frequency_table *pos;
>
>         freq_table = dev_get_platdata(&pdev->dev);
>         if (!freq_table) {
> @@ -60,9 +60,8 @@ static int dbx500_cpufreq_probe(struct platform_device *pdev)
>         }
>
>         pr_info("dbx500-cpufreq: Available frequencies:\n");
> -       while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
> -               pr_info("  %d Mhz\n", freq_table[i].frequency/1000);
> -               i++;
> +       cpufreq_for_each_entry(pos, freq_table) {
> +               pr_info("  %d Mhz\n", pos->frequency / 1000);
>         }

Remove {}

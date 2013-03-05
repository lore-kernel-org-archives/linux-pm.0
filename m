From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH linux-next] cpufreq: conservative: Fix sampling_down_factor
 functionality
Date: Tue, 5 Mar 2013 08:23:02 +0800
Message-ID: <CAOh2x=m0KLbjGKvLvTH7-yQb4SU5-v=-r4Ba3LSZz=NvfvO6mg@mail.gmail.com>
References: <51351CC3.4010301@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:51028 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab3CEAXF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 19:23:05 -0500
In-Reply-To: <51351CC3.4010301@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 5, 2013 at 6:14 AM, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> sampling_down_factor tunable is unused since commit
> 8e677ce83bf41ba9c74e5b6d9ee60b07d4e5ed93 (4 years ago).
>
> This patch restores the original functionality.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 4fd0006..4b27c21 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -87,6 +87,12 @@ static void cs_check_cpu(int cpu, unsigned int load)
>                 return;
>         }
>
> +       /* if sampling_down_factor is active break out early */
> +       if (++dbs_info->down_skip < cs_tuners.sampling_down_factor)
> +               return;
> +
> +       dbs_info->down_skip = 0;
> +

Interesting. Because it was removed earlier and no body complained :)

I got following from Documentation:

sampling_down_factor: this parameter controls the rate at which the
kernel makes a decision on when to decrease the frequency while running
at top speed. When set to 1 (the default) decisions to reevaluate load
are made at the same interval regardless of current clock speed. But
when set to greater than 1 (e.g. 100) it acts as a multiplier for the
scheduling interval for reevaluating load when the CPU is at its top
speed due to high load. This improves performance by reducing the overhead
of load evaluation and helping the CPU stay at its top speed when truly
busy, rather than shifting back and forth in speed. This tunable has no
effect on behavior at lower speeds/lower CPU loads.

And i believe we are supposed to check if we are at the top speed or not.
Over that i believe the code should be like:

While setting speed to top speed, set the timer to delay * sampling_down_factor,
so that we actually don't reevaluate the load. What do you say?

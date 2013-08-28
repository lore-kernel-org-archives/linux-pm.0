From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governors: Remove duplicate check of target freq
 in supported range
Date: Wed, 28 Aug 2013 11:05:52 +0530
Message-ID: <CAKohpon9mokWAg-cfyKtSKRTu2vyQ9oKnM6XYD+sAzmzXoU9fg@mail.gmail.com>
References: <521BA068.8030003@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <521BA068.8030003@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 August 2013 00:07, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> Function __cpufreq_driver_target checks if target_freq is within
> policy->min and policy->max range. generic_powersave_bias_target also
> checks if target_freq is valid through cpufreq_frequency_table_target
> call. So, drop the unnecessary duplicate check in *_check_cpu functions.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 4 ----
>  drivers/cpufreq/cpufreq_ondemand.c     | 3 ---
>  2 files changed, 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

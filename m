From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RESEND] cpufreq: Break out early when frequency equals target_freq
Date: Thu, 15 May 2014 10:09:47 +0530
Message-ID: <CAKohpoktAkaA=do3or6VYzVEjyZcSe+eexqxvTj1HPrx-3+vfw@mail.gmail.com>
References: <5373B080.3050907@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5373B080.3050907@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14 May 2014 23:35, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> Many drivers keep frequencies in frequency table in ascending
> or descending order. When governor tries to change to policy->min
> or policy->max respectively then the cpufreq_frequency_table_target
> could return on first iteration. This will save some iteration cycles.
>
> So, break out early when a frequency in cpufreq_frequency_table
> equals to target one.
>
> Testing this during kernel compilation using ondemand governor
> with a frequency table in ascending order, the
> cpufreq_frequency_table_target returned early on the first
> iteration at about 30% of times called.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/freq_table.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ondemand: Replace down_differential tuner with adj_up_threshold
Date: Wed, 6 Feb 2013 11:05:45 +0530
Message-ID: <CAOh2x=ksAibntsfGm51r+JiQOAhHYYmHF1o=_H97fSKqGcq_mQ@mail.gmail.com>
References: <511173DF.8060308@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <511173DF.8060308@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 6, 2013 at 2:34 AM, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> In order to avoid the calculation of up_threshold - down_differential
> every time that the frequency must be decreased, we replace the
> down_differential tuner with the adj_up_threshold which keeps the
> difference across multiple checks.
>
> Update the adj_up_threshold only when the up_theshold is also updated.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq_governor.h |  2 +-
>  drivers/cpufreq/cpufreq_ondemand.c | 16 ++++++++++------
>  2 files changed, 11 insertions(+), 7 deletions(-)

Makes sense.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

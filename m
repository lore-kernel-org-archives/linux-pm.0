From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3 linux-next] cpufreq: conservative: Fix the logic in
 frequency decrease checking
Date: Wed, 6 Mar 2013 14:49:50 +0800
Message-ID: <CAKohpo=aofVQGe3KMOqXpb67i627pH3sgBhFqwgxHR3pP3TBqQ@mail.gmail.com>
References: <51366C70.3020406@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51366C70.3020406@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 6 March 2013 06:06, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> When we evaluate the CPU load for frequency decrease we have to compare
> the load against down_threshold. There is no need to subtract 10 points
> from down_threshold.
>
> Instead, we have to use the default down_threshold or user's selection
> unmodified.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

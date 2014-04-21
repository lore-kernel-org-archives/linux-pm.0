From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/2] cpufreq: exynos: Use dev_err/info function instead of
 pr_err/info
Date: Mon, 21 Apr 2014 16:03:43 +0900
Message-ID: <5354C2CF.5020206@samsung.com>
References: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
 <1397787634-9334-2-git-send-email-cw00.choi@samsung.com>
 <CAKohpo=-Oxu6ZoB4B2H4552meq46iXrVzKbP5ZwnG==sCc2_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAKohpo=-Oxu6ZoB4B2H4552meq46iXrVzKbP5ZwnG==sCc2_MA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/21/2014 03:05 PM, Viresh Kumar wrote:
> On 18 April 2014 07:50, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch uses dev_err/info function to show accurate log message with device name
>> instead of pr_err/info function.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/cpufreq/exynos-cpufreq.c | 21 ++++++++++++---------
>>  drivers/cpufreq/exynos-cpufreq.h |  1 +
>>  2 files changed, 13 insertions(+), 9 deletions(-)
> 
> This still looks fine even if we don't take the new driver ?
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for your review.

Best regards,
Chanwoo Choi

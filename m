From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 6/8] PM / Domains: Abstract genpd locking
Date: Thu, 6 Oct 2016 09:56:47 -0600
Message-ID: <20161006155647.GH28930@linaro.org>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
 <1475699519-109623-7-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFrzPbr_njosTxO9y0V3KKG0stfhA3XejmQk_3RJMr3=Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrzPbr_njosTxO9y0V3KKG0stfhA3XejmQk_3RJMr3=Tg@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 06 2016 at 04:56 -0600, Ulf Hansson wrote:
>On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Abstract genpd lock/unlock calls, in preparation for domain specific
>> locks added in the following patches.
>>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 121 +++++++++++++++++++++++++++++---------------
>>  include/linux/pm_domain.h   |   5 +-
>>  2 files changed, 85 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 52fcdb2..82e6a33 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -39,6 +39,46 @@
>>  static LIST_HEAD(gpd_list);
>>  static DEFINE_MUTEX(gpd_list_lock);
>>
>> +struct genpd_lock_fns {
>
>May I suggest you to rename the struct to "genpd_lock_ops"?
>
>I think "*_ops" is in general what we use in the kernel for callbacks
>and functions pointers like these.
>
OK.

Thanks,
Lina

>> +       void (*lock)(struct generic_pm_domain *genpd);
>> +       void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
>> +       int (*lock_interruptible)(struct generic_pm_domain *genpd);
>> +       void (*unlock)(struct generic_pm_domain *genpd);
>> +};
>> +
>
>[...]
>
>Otherwise this looks good to me!
>
>Kind regards
>Uffe

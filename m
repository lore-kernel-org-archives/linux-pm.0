From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [BUG FIX] PM / cpu_domains: Check for NULL callbacks
Date: Thu, 18 Feb 2016 15:51:46 -0700
Message-ID: <20160218225146.GB1313@linaro.org>
References: <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
 <1455816573-43849-1-git-send-email-lina.iyer@linaro.org>
 <CAJZ5v0gXd573OM_xQBsqqaZoRWvT_px64Cx2avR5dCxCwmMWjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gXd573OM_xQBsqqaZoRWvT_px64Cx2avR5dCxCwmMWjA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 18 2016 at 10:46 -0700, Rafael J. Wysocki wrote:
>On Thu, Feb 18, 2016 at 6:29 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Check for NULL platform callback before calling.
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/cpu_domains.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
>> index 7069411..bcaa474 100644
>> --- a/drivers/base/power/cpu_domains.c
>> +++ b/drivers/base/power/cpu_domains.c
>> @@ -157,16 +157,22 @@ static int cpu_pd_power_on(struct generic_pm_domain *genpd)
>>  {
>>         struct cpu_pm_domain *pd = to_cpu_pd(genpd);
>>
>> -       return pd->ops.power_on();
>> +       if (pd->ops.power_on)
>> +               return pd->ops.power_on();
>> +
>> +       return 0;
>>  }
>
>I usually write things like that as
>
>return pd->ops.power_on ? pd->ops.power_on() : 0;
>
>That gets the job done in just one line of code instead of 4 and in
>one statement instead of 3.
>
Sure. Thanks. Will roll this in with the next submission.

Thanks,
Lina

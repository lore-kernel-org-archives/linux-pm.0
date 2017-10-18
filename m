From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] PM / OPP: Move error message to debug level
Date: Wed, 18 Oct 2017 10:01:44 -0200
Message-ID: <CAOMZO5Cqq3HMFwSan5K0EwRfQvA1Uof+MkT9J3BzZzQq9avSWQ@mail.gmail.com>
References: <1506706789-7717-1-git-send-email-fabio.estevam@nxp.com> <20171004064900.GA28593@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:50916 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933141AbdJRMBp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2017 08:01:45 -0400
Received: by mail-oi0-f65.google.com with SMTP id q4so8360724oic.7
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2017 05:01:45 -0700 (PDT)
In-Reply-To: <20171004064900.GA28593@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, vireshk@kernel.org, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Yongcai Huang <anson.huang@nxp.com>

Hi Viresh,

On Wed, Oct 4, 2017 at 3:49 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29-09-17, 14:39, Fabio Estevam wrote:
>> On some i.MX6 platforms which do not have speed grading
>> check, opp table will not be created in platform code,
>> so cpufreq driver prints the following error message:
>>
>> cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)
>>
>> However, this is not really an error in this case because the
>> imx6q-cpufreq driver first calls dev_pm_opp_get_opp_count()
>> and if it fails, it means that platform code does not provide
>> OPP and then dev_pm_opp_of_add_table() will be called.
>>
>> In order to avoid such confusing error message, move it to
>> debug level.
>>
>> It is up to the caller of dev_pm_opp_get_opp_count() to check its
>> return value and decide if it will print an error or not.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>> ---
>> Previous discussion on this topic:
>> https://patchwork.kernel.org/patch/9295059/
>>
>>  drivers/base/power/opp/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
>> index a6de325..0459b12 100644
>> --- a/drivers/base/power/opp/core.c
>> +++ b/drivers/base/power/opp/core.c
>> @@ -296,7 +296,7 @@ int dev_pm_opp_get_opp_count(struct device *dev)
>>       opp_table = _find_opp_table(dev);
>>       if (IS_ERR(opp_table)) {
>>               count = PTR_ERR(opp_table);
>> -             dev_err(dev, "%s: OPP table not found (%d)\n",
>> +             dev_dbg(dev, "%s: OPP table not found (%d)\n",
>>                       __func__, count);
>>               return count;
>>       }
>
> Applied. Thanks.

I do not see this patch in your tree nor in linux-next.

In linux-next I noticed that this file has been renamed as drivers/opp/core.c.

Would you like me to submit a new patch with this new file path?

Thanks

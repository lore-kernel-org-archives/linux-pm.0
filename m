From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH -next] PM / OPP: Make local function ti_opp_supply_set_opp()
 static
Date: Thu, 21 Dec 2017 02:19:36 +0100
Message-ID: <CAJZ5v0jNBhGzvmSShK=42SoD1Q0V2CZYfxRUv9SSV6nw2sozYw@mail.gmail.com>
References: <1513748680-163750-1-git-send-email-weiyongjun1@huawei.com> <20171220054202.GU19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34661 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755864AbdLUBTh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 20:19:37 -0500
Received: by mail-oi0-f68.google.com with SMTP id u193so15880864oie.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2017 17:19:37 -0800 (PST)
In-Reply-To: <20171220054202.GU19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, Dave Gerlach <d-gerlach@ti.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wed, Dec 20, 2017 at 6:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> +Dave/Rafael,
>
> On 20-12-17, 05:44, Wei Yongjun wrote:
>> Fixes the following sparse warning:
>>
>> drivers/opp/ti-opp-supply.c:276:5: warning:
>>  symbol 'ti_opp_supply_set_opp' was not declared. Should it be static?
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/opp/ti-opp-supply.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
>> index 44dae3e..370eff3 100644
>> --- a/drivers/opp/ti-opp-supply.c
>> +++ b/drivers/opp/ti-opp-supply.c
>> @@ -273,7 +273,7 @@ static int _opp_set_voltage(struct device *dev,
>>   *
>>   * Return: If successful, 0, else appropriate error value.
>>   */
>> -int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
>> +static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
>>  {
>>       struct dev_pm_opp_supply *old_supply_vdd = &data->old_opp.supplies[0];
>>       struct dev_pm_opp_supply *old_supply_vbb = &data->old_opp.supplies[1];
>
> Maybe this should be folded to the original patch ?

That is against the latest series from Dave, right?

I can apply it.

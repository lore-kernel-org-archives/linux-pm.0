From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH -next] PM / OPP: Make local function
 ti_opp_supply_set_opp() static
Date: Wed, 20 Dec 2017 11:12:02 +0530
Message-ID: <20171220054202.GU19815@vireshk-i7>
References: <1513748680-163750-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45114 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932090AbdLTFmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 00:42:05 -0500
Received: by mail-pl0-f65.google.com with SMTP id o2so8426970plk.12
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2017 21:42:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1513748680-163750-1-git-send-email-weiyongjun1@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>, d-gerlach@ti.com
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net

+Dave/Rafael,

On 20-12-17, 05:44, Wei Yongjun wrote:
> Fixes the following sparse warning:
> 
> drivers/opp/ti-opp-supply.c:276:5: warning:
>  symbol 'ti_opp_supply_set_opp' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/opp/ti-opp-supply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index 44dae3e..370eff3 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -273,7 +273,7 @@ static int _opp_set_voltage(struct device *dev,
>   *
>   * Return: If successful, 0, else appropriate error value.
>   */
> -int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
> +static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
>  {
>  	struct dev_pm_opp_supply *old_supply_vdd = &data->old_opp.supplies[0];
>  	struct dev_pm_opp_supply *old_supply_vbb = &data->old_opp.supplies[1];

Maybe this should be folded to the original patch ?

-- 
viresh

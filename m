From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] thermal: rockchip: improve the warning log
Date: Tue, 11 Oct 2016 09:16:10 +0800
Message-ID: <53da8218-049a-086a-bbb7-45031cc05872@rock-chips.com>
References: <1476017358-26143-1-git-send-email-shawn.lin@rock-chips.com>
 <1729478.KIY7mRhFMh@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:33736 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbcJKBQc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 21:16:32 -0400
In-Reply-To: <1729478.KIY7mRhFMh@phil>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: shawn.lin@rock-chips.com, Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org

在 2016/10/11 4:28, Heiko Stuebner 写道:
> Am Sonntag, 9. Oktober 2016, 20:49:18 CEST schrieb Shawn Lin:
>> There is no necessary to print warning agian and
>
> It is not necessary to print a warning again and ...
>

Ah, actually I mean 'necessity', will fix it anyway.

>> again if we don't add rockchip,grf for dt, otherwise
>> I saw the following log when doning suspend-2-resume.
> 								^ doing

sure.

>
>> We only need to print it once when parsing dt. It looks
>> quite trivial but the log is apparently verbose.
>>
>> [   26.615415] PM: early resume of devices complete after 1.539 msecs
>> [   26.622002] rk_tsadcv2_initialize: Missing rockchip,grf property
>> [   26.629359] rk_gmac-dwmac ff290000.ethernet: init for RGMII
>> [   26.639794] PM: resume of devices complete after 18.109 msecs
>> [   26.646925] Restarting tasks ... done.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/thermal/rockchip_thermal.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c
>> b/drivers/thermal/rockchip_thermal.c index e227a9f..b811b0f 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -524,11 +524,6 @@ static void rk_tsadcv2_initialize(struct regmap *grf,
>> void __iomem *regs, regs + TSADCV2_AUTO_PERIOD_HT);
>>  	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
>>  		       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
>> -
>> -	if (IS_ERR(grf)) {
>> -		pr_warn("%s: Missing rockchip,grf property\n", __func__);
>> -		return;
>> -	}
>
> dropping the pr_warn here is ok, as the v2 tsadc does not access it anyway
>
>>  }
>>
>>  /**
>> @@ -971,6 +966,8 @@ static int rockchip_configure_from_dt(struct device
>> *dev, * need this property.
>>  	 */
>>  	thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
>> +	if (IS_ERR(thermal->grf))
>> +		dev_warn(dev, "Missing rockchip,grf property\n");
>
> but I'm not sure if we need this warning here. As said above v2-tsadc does not
> need it at all and the v3 tsadc seems to work around a missing grf regmap?

I didn't look into the driver but just want to drop the pr_warn there.

And yes, v2-tsadc doesn't use it at all and v3 does work around if
missing grf there. I think it it okay to carry on the log here since
it would be fine to cast a warning for folks to debug. Also we could
see that rockchip_configure_from_dt actually cast some similar warnings
there when failing to parse some properties properly which isn't
critical, i.e hw-tshut-temp, hw-tshut-mode, etc.. And that should
be harmless. :)

>
> So maybe don't do any warning at all or something like that?
>
> Btw. it also seems like the binding txt document is missing an entry for the
> rockchip,grf property. So maybe you could do another patch to add that
> optional property to the binding doc?

I will.

>
>
> Heiko
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>


-- 
Best Regards
Shawn Lin


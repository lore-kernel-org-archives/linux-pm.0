From: "rocky.hao" <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 1/5] dt-bindings: rockchip-thermal: Support the RV1108 SoC
 compatible
Date: Fri, 15 Sep 2017 11:20:33 +0800
Message-ID: <ce37b9e1-2095-f5ad-e414-2663b4b43755@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
 <1503570475-7850-2-git-send-email-rocky.hao@rock-chips.com>
 <12073627-41af-3480-6379-839e07f5e8f3@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <12073627-41af-3480-6379-839e07f5e8f3-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, william.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xxx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Caesar,

Thanks for the reply.

在 2017/9/15 9:49, Caesar Wang 写道:
> Hi Rocky,
> 
> 在 2017年08月24日 18:27, Rocky Hao 写道:
>> Add a new compatible for thermal founding on RV1108 SoCs.
>>
>> Signed-off-by: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt 
>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> index e3a6234fb1ac..43d744e5305e 100644
>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -2,6 +2,7 @@
>>   Required properties:
>>   - compatible : should be "rockchip,<name>-tsadc"
>> +   "rockchip,rv1108-tsadc": found on RV1108 SoCs
> 
> According to the order,  we should put the string after the 
> "rockchip,rk3399-tsadc"..., not here.
It is okay for me.
>>      "rockchip,rk3228-tsadc": found on RK3228 SoCs
>>      "rockchip,rk3288-tsadc": found on RK3288 SoCs
>>      "rockchip,rk3328-tsadc": found on RK3328 SoCs
> 
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

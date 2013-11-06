From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] thermal: Fix binding problem when there is thermal zone
 params
Date: Wed, 6 Nov 2013 14:04:06 +0800
Message-ID: <5279DBD6.9090708@nvidia.com>
References: <1382090587-9602-1-git-send-email-wni@nvidia.com>
 <1383715752.2073.11.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383715752.2073.11.camel@rzhang1-mobl4>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jinyoung Park <jinyoungp-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11/06/2013 01:29 PM, Zhang Rui wrote:
> On Fri, 2013-10-18 at 18:03 +0800, Wei Ni wrote:
>> @@ -247,7 +247,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
>>  		if (!pos->tzp && !pos->ops->bind)
>>  			continue;
>>  
>> -		if (!pos->tzp && pos->ops->bind) {
>> +		if (pos->ops->bind) {
>>  			ret = pos->ops->bind(pos, cdev);
>>  			if (ret)
>>  				print_bind_err_msg(pos, cdev, ret);
> IMO, we should also add
> +		continue;
> after binding with pos->ops->bind(), to void binding via pos->tzp->tbp
> again, no?

Oh, yes, you are right. I will add it.

> 
> thanks,
> rui
>> @@ -282,8 +282,8 @@ static void bind_tz(struct thermal_zone_device *tz)
>>  
>>  	mutex_lock(&thermal_list_lock);
>>  
>> -	/* If there is no platform data, try to use ops->bind */
>> -	if (!tzp && tz->ops->bind) {
>> +	/* If there is ops->bind, try to use ops->bind */
>> +	if (tz->ops->bind) {
>>  		list_for_each_entry(pos, &thermal_cdev_list, node) {
>>  			ret = tz->ops->bind(tz, pos);
>>  			if (ret)
> 
> 

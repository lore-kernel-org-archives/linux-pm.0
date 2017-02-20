From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: mt8173: minor mtk_thermal.c cleanups
Date: Mon, 20 Feb 2017 12:30:44 +0100
Message-ID: <46d6c448-a669-a748-acfa-8ed129c65b51@gmail.com>
References: <1486531862-31945-1-git-send-email-dawei.chien@mediatek.com>
 <ebdf54af-6290-9654-c475-53dd580582a0@gmail.com>
 <1486976518.24087.7.camel@mtksdaap41>
 <20170219012306.GA28525@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170219012306.GA28525-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fan Chen <fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 19/02/17 02:23, Eduardo Valentin wrote:
> On Mon, Feb 13, 2017 at 05:01:58PM +0800, Dawei Chien wrote:
>> Hi, Matthias,
>>
>> On Thu, 2017-02-09 at 22:25 +0100, Matthias Brugger wrote:
>>>
>>> On 02/08/2017 06:31 AM, Dawei Chien wrote:
>>>> Thermal driver should read TEMP_MSR3 if thermal bank with 4 sensors.
>>>> However, Currently thermal driver don't need read TEMP_MSR3 since
>>>> thermal controller only use 3 sensors for each thermal bank.
>>>>
>>>> Signed-off-by: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>>>> ---
>>>
>>> Actually the commit message should state:
>>> Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
>>>
>>> ...and get backported to v4.9 and v4.10.
>>>
>>> Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>> Regards,
>>> Matthias
>>
>> Thank you for your review. I would add below commit message on next
>> version. However, currently 8173 thermal driver would not read TEMP_MSR3
>> since thermal driver only use 3 sensors on each bank, this patch would
>> not effect temperature.
>> Only if thermal driver use 4 sensors on any thermal bank, would read
>> third sensor two times, and lose fourth sensor of vale.
>> Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
>>
>
> Please send a new version with the tag in the commit message.
>

And don't forget to add stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org so that the fix ends up 
in the older kernels as well.

Regards,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

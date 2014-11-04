From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/5] ARM: keystone: pm: switch to use generic pm domains
Date: Tue, 4 Nov 2014 15:41:05 +0200
Message-ID: <5458D771.1080109@ti.com>
References: <1414074182-25980-1-git-send-email-grygorii.strashko@ti.com> <544A99B2.8080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <544A99B2.8080507-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Santosh,

On 10/24/2014 09:25 PM, Santosh Shilimkar wrote:
> On 10/23/2014 07:22 AM, Grygorii Strashko wrote:
>> Hi Santosh, Kevin,
>>
>> This series switches Keystone 2 PM code to use Generic PM domains
>> instead of PM clock domains because of the lack of DT support
>> for the last.
>> It will finally allow to enable Runtime PM for Keystone 2.
>>
>> Patch 1 was reused from [1].
>>
>> RFC version of patches can be found at [2].
>>
>> Changes in v3:
>>   - handling of the case when !CONFIG_PM_RUNTIME has been
>>     moved in PM clock framework.
>>
>> Changes in v2:
>> - minor comments applied and rebased on top of Linux 3.18-rc1.
>>
>> Links on previous versions:
>> v2:  https://lkml.org/lkml/2014/10/20/248
>> v1:  https://lkml.org/lkml/2014/9/29/382
>>
>> [1] "[PATCH/RFC 0/4] of: Register clocks for Runtime PM with PM core"
>>    https://lkml.org/lkml/2014/4/24/1118
>>
>> [2] "[RFC PATCH 0/4] ARM: keystone: pm: switch to use generic pm domains"
>>    https://lkml.org/lkml/2014/9/25/364
>>
>> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> CC: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> CC: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>> CC: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Geert Uytterhoeven (1):
>>    PM / clock_ops: Add pm_clk_add_clk()
>>
>> Grygorii Strashko (4):
>>    PM / clock_ops: make __pm_clk_enable more generic
>>    PM / clock_ops: add and enable clocks always if !CONFIG_PM_RUNTIME
>>    ARM: keystone: pm: switch to use generic pm domains
>>    ARM: dts: keystone: add generic pm controller node
>>
> You can split this series. Lets get first 3 patches sorted out as
> there have been active discussion on those. Once they get direction
> and merged then you can post the keystone ones which I will be
> happy to merge.

Sure, will do.

Sorry, for delayed reply - I was ooo last week.

regards,
-grygorii

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

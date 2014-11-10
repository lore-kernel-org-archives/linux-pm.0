From: "santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org" <santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 0/2] ARM: keystone: pm: switch to use generic pm domains
Date: Mon, 10 Nov 2014 10:51:10 -0800
Message-ID: <5461091E.6090708@oracle.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com> <5460D601.70504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5460D601.70504-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11/10/14 7:13 AM, Grygorii Strashko wrote:
> Hi Santosh,
>
> On 11/10/2014 04:59 PM, Grygorii Strashko wrote:
>> Hi Santosh, Kevin,
>>
>> This series switches Keystone 2 PM code to use Generic PM domains
>> instead of PM clock domains because of the lack of DT support
>> for the last.
>> It will finally allow to enable Runtime PM for Keystone 2.
>>
>> This series based on top
>>
>> Changes in v4:
>>    - changes for Generic clock manipulation PM callbacks (clock_ops.c)
>>      were separated in standalone series [3] and Keystone 2 specific
>>      patches were rebased on top of it.
>
> I've just found that prerequisite patches have been taken by Rafael in linux-pm.git/linux-next,
> first two patches from series:
>   "[PATCH v4 0/3] PM / clock_ops: add pm_clk_add_clk()"
>   https://lkml.org/lkml/2014/11/6/319
>
> Thanks a lot Rafael.
>
> So, if no complains, this series is ready.
>
Thanks for the note and good to see the series is converged. To avoid
dependency issues, I will merge them immediately after the upcoming
merge window. Meanwhile please continue to sort out any outstanding
comments/concerns like the one you are discussing with Arnd.

regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

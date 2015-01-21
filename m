From: Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: [PATCH v6 0/7] Add initial support for DA9150 Charger & Fuel-Gauge IC
Date: Wed, 21 Jan 2015 17:19:38 +0000
Message-ID: <C1079F30-5D1D-45AA-A129-FE1E68EA5DC5@jic23.retrosnub.co.uk>
References: <cover.1421854282.git.Adam.Thomson.Opensource@diasemi.com> <20150121165250.GG13715@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150121165250.GG13715-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 21 January 2015 16:52:50 GMT+00:00, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>Hi,
>
>On Wed, Jan 21, 2015 at 03:46:25PM +0000, Adam Thomson wrote:
>> This patch set adds initial support for the Dialog DA9150 Integrated
>Charger &
>> Fuel-Gauge IC. The device also provides GPIO and GPADC functionality.
>> 
>> In this patch set the following is provided:
>>  - MFD Core support and DT bindings documentation.
>>  - IIO GPADC support and DT bindings documentation.
>>  - Power Supply Charger support and DT bindings documentation.
>>  - Update to MAINTAINERS file to add DA9150 files to Dialog support
>list.
>> 
>> To keep patch submission from being too large, support for GPIO and
>Fuel-Gauge
>> will come after initial support patches are accepted.
>> 
>> This patch set is baselined against the v3.19-rc5 kernel version.
>> 
>> Changes in v6:
>> - For GPADC driver, Use lower case extended names for IIO GPADC
>channels, and
>>   remove extended names for GPIO related channels.
>> - For charger driver, revert to no devm IRQ request/free functions as
>ordering
>>   is important, and probe failure scenario was not being correctly
>covered. A
>>   helper function for free IRQs has been added to make code cleaner.
>
>Probably a devm_ variant of power_supply_register should be created,
>but for now this is ok for me.
>
>Jonathan, Lee: I assume you are ok with the whole patchset going
>through the power supply subsystem?
>
Fine by me if either power supply or MFD.

Jonathan
>-- Sebastian

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

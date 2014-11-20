From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCHv5 1/1] thermal: of: improve of-thermal sensor registration
 API
Date: Thu, 20 Nov 2014 06:23:29 -0800
Message-ID: <546DF961.3050509@roeck-us.net>
References: <1416492733-1624-1-git-send-email-edubezval@gmail.com> <1416492733-1624-2-git-send-email-edubezval@gmail.com> <20141120141806.GA1746@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141120141806.GA1746@developer>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11/20/2014 06:18 AM, Eduardo Valentin wrote:
> Hi Guenter,
>
> On Thu, Nov 20, 2014 at 10:12:13AM -0400, Eduardo Valentin wrote:
>> Different drivers request API extensions in of-thermal. For this reason,
>> additional callbacks are required to fit the new drivers needs.
>>
>> The current API implementation expects the registering sensor driver
>> to provide a get_temp and get_trend callbacks as function parameters.
>> As the amount of callbacks is growing, this patch changes the existing
>> implementation to use a .ops field to hold all the of thermal callbacks
>> to sensor drivers.
>>
>> This patch also changes the existing of-thermal users to fit the new
>> API design. No functional change is introduced in this patch.
>>
>> Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
>> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
>> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
>> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Tested-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
>> Reviewed-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
>> Reviewed-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> Reviewed-by: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>   drivers/hwmon/lm75.c                               |  9 +++--
>>   drivers/hwmon/ntc_thermistor.c                     |  6 +++-
>>   drivers/hwmon/tmp102.c                             |  6 +++-
>
> Do you have objections if I queue this one for 3.19?
>

No.

Guenter

From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2 0/6]  thermal: add devm_ version of thermal_zone register
 and driver for max77620
Date: Thu, 10 Mar 2016 12:25:03 +0530
Message-ID: <56E11A47.60601@nvidia.com>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com> <20160309193249.GE2422@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160309193249.GE2422-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On Thursday 10 March 2016 01:02 AM, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>
> On Wed, Mar 09, 2016 at 06:40:04PM +0530, Laxman Dewangan wrote:
>> The series add the devm_ version of thermal_zone_of_sensor_register/
>> unregister, interface details, and use this in new thermal driver
>> for max77620.
>>
>> The header file for max77620 is part of MFD patch
>> 	https://lkml.org/lkml/2016/2/11/186
>>
>> Changes from V1:
>> - Run checkpatch with --strict and fix all warnings.
>> - Added details of interfaces in spifs-api.txt
>> - Added DT binding doc.
>>
>> Laxman Dewangan (6):
>>    thermal: doc: Add details of
>>      thermal_zone_of_sensor_{register,unregister}
>>    thermal: of-thermal: Add devm version of
>>      thermal_zone_of_sensor_register
>>    thermal: Add devm_thermal_zone_of_sensor_register() in managed devices
>>      list
>>    thermal: doc: Add details of
>>      devm_thermal_zone_of_sensor_{register,unregister}
>>    thermal: max77620: Add thermal driver for reporting junction temp
>>    thermal: Add DT binding doc for thermal of PMIC max77620
>
> Add patches 1-3 in my tree. Patch 4 should probably go via documentation
> tree. And patch 5 needs dependency to be sorted, and 6 need minor changes.
>
Thanks for accepting patches.

patch 5 needs mfd patches which is under review. So until that is 
merged, compilation will fail due to header dependency.

Will add complete information on example of patch 6.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

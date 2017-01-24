From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/3] PM / devfreq: Fix available_governor sysfs
Date: Tue, 24 Jan 2017 15:23:22 +0900
Message-ID: <5886F2DA.9000102@samsung.com>
References: <1484722611-10555-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170118065653epcas5p2b1b4a964772e300b56356a26ec5cb9e5@epcas5p2.samsung.com>
 <20170124035158epcms1p3b2e59563cfb7fd2ec404102e0552ed78@epcms1p3>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170124035158epcms1p3b2e59563cfb7fd2ec404102e0552ed78@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2017년 01월 24일 12:51, MyungJoo Ham wrote:
>> The devfreq using passive governor is not able to change the governor.
>> So, the user can not change the governor through 'available_governor' sysfs
>> entry. Also, the devfreq which don't use the passive governor is not able to
>> change to 'passive' governor on the fly.
> 
> Another thoughts on the characteristics of 'passive' governor:
> 
> 1. Should we prohibit moving from "others" to "passive"?

The relation between parent devfreq and passive devfreq
is fixed by h/w because they share the one power line. 

But,
if you want to permit that some devfreq change 
their governor to passive governor. The current design
of devfreq does not support it. We must need to
rework the devfreq for the moving from 'others' to 'passive'.

The devfreq should consider the multiple dependency on hierachry 
as CCF (Common Clock Framework).

	devfreq2 (passive)
		devfreq5 (passive)
		devfreq6 (passive)
	devfreq3 (passive)
	devfreq4 (passive)
		devfreq7 (passive)
		devfreq8 (passive)
	

I add some examples as following:

Example1,
There is one parent devfreq which includes
the four passive devfreqs as following:
parent-dev1 (ondemand)
	passive-dev1 (passive)
	passive-dev2 (passive)
	passive-dev3 (passive)
	passive-dev4 (passive)
new-parent-dev2 (ondemand)


If changing the governor of 'parent-dev1' from ondemand to passive,
the user have to inform the information of new parent devfreq(new-parent-dev2).
Maybe, following command should be executed.
	echo [new-parent-dev2] > /sys/class/devfreq/[parent-dev1]/parent
		new-parent-dev2 
	echo passive > /sys/class/devfreq/[parent-dev1]/governor

After that, the final hierarchy will be following:

new-parent-dev2 (ondemand)
	parent-dev1 (passive)
		passive-dev1 (passive)
		passive-dev2 (passive)
		passive-dev3 (passive)
		passive-dev4 (passive)


Example2,
Before,
parent-dev1 (ondemand)
	passive-dev1 (passive)
	passive-dev2 (passive)
	passive-dev3 (passive)
	passive-dev4 (passive)
new-parent-dev2 (ondemand)

After that, if new-parent-dev2 use the passive governor with parent-dev1 device.

parent-dev1 (ondemand) - control voltage and freq
	passive-dev1 (passive) - control freq
 	passive-dev2 (passive) - control freq
	passive-dev3 (passive) - control freq
	passive-dev4 (passive) - control freq
	new-parent-dev2 (passive) - control voltage and freq


Example3,
There is one parent devfreq which includes
the four passive devfreqs as following:

parent-dev2 (ondemand)
	new-parent-dev3 (passive)
parent-dev1 (ondemand)
	passive-dev1 (passive)
	passive-dev2 (passive)
	passive-dev3 (passive)
	passive-dev4 (passive)

After that, if parent-dev1 use the passive governor with new-parent-dev3 device.

parent-dev2 (ondemand)
	new-parent-dev3 (passive)
		parent-dev1 (passive)
			passive-dev1 (passive)
			passive-dev2 (passive)
			passive-dev3 (passive)
			passive-dev4 (passive)


> 2. Should we show "passive" in the available list if it's not passive now?

Yes. I added the test result on cover letter about this.

Even if the parent devfreq device doesn't support the passive governor,
their 'available_governor' shows the 'passive' governor.

> 3. Why don't we show anyway and reject it when actually tries to change?

I think that the sysfs entry have to provide the correct information
to user-space. If available_governor shows the name of unsupported
governor, it is not reasonable and appropriate.
- cat /sys/class/devfreq/[devfreq name]/available_governor

So, the 'available_governor' should only show the supported governors.

> 4. Or should we add a value in devfreq struct that is confired at devfreq
> device add, which prohibits changing governors? (and passive will
> return error if that flag is not set or it will set the value automatically)

If we add some flags to devfreq for passive govenror,
devfreq will prohibits the changing governors. 

And, avaiable_governor function will use the new flags
to show the only supported governors.

I tried to use the existing fields of struct devfreq
without new field. But if you want to add new field,
I'll do.

> 
> Cheers,
> MyungJoo
> 
>>
>> Fixes: 996133119f57 ("PM / devfreq: Add new passive governor")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 34 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 33 insertions(+), 1 deletion(-)


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

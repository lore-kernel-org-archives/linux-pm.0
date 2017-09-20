From: arvind <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] PM / OPP: Handle return value of kasprintf
Date: Wed, 20 Sep 2017 22:28:36 +0530
Message-ID: <59C29E3C.5010703@gmail.com>
References: <15cec6eac63ffc9f12f1d16aff913eccad670f77.1505817563.git.arvind.yadav.cs@gmail.com>
 <1505906255.2153.3.camel@perches.com> <20170920144902.GL30848@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170920144902.GL30848@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Joe Perches <joe@perches.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 20 September 2017 08:19 PM, Viresh Kumar wrote:
> On 20-09-17, 04:17, Joe Perches wrote:
>> On Wed, 2017-09-20 at 12:29 +0530, Arvind Yadav wrote:
>>> kasprintf() can fail here and we must check its return value.
>> []
>>> diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
>> []
>>> @@ -45,7 +45,8 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
>>>   
>>>   	for (i = 0; i < opp_table->regulator_count; i++) {
>>>   		name = kasprintf(GFP_KERNEL, "supply-%d", i);
>>> -
>>> +		if (!name)
>>> +			return false;
>>>   		/* Create per-opp directory */
>>>   		d = debugfs_create_dir(name, pdentry);
>> Probably more sensible to avoid the kasprintf/kfree
>> and just have
>> 	char name[20];
>> on the stack
> Sure.
>
> @Arvind: I will let you write that patch.
Yes, I will do.
>
~arvind

From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v2] power: Replace printks with dev_* and pr_* routines
Date: Tue, 19 Nov 2013 13:00:14 -0700
Message-ID: <528BC34E.9010008@samsung.com>
References: <1384886818-11861-1-git-send-email-shuah.kh@samsung.com>
 <1384887205.17783.40.camel@joe-AO722> <528BB492.8090404@samsung.com>
 <1384888035.17783.45.camel@joe-AO722>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]:16543 "EHLO
	usmailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab3KSUAS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2013 15:00:18 -0500
In-reply-to: <1384888035.17783.45.camel@joe-AO722>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, Shuah Khan <shuah.kh@samsung.com>

On 11/19/2013 12:07 PM, Joe Perches wrote:
> On Tue, 2013-11-19 at 11:57 -0700, Shuah Khan wrote:
>> On 11/19/2013 11:53 AM, Joe Perches wrote:
>>> On Tue, 2013-11-19 at 11:46 -0700, Shuah Khan wrote:
>>>> Replaced printks with dev_* and pr_* routines. Replacing printk in
>>>> __suspend_report_result() will require passing in struct device *
>>>> pointer from calling routines and this will require changes to
>>>> external interface suspend_report_result() which is used by several
>>>> drivers. Hence, this one instance is replaced by pr_err().
>>> []
>>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>> []
>>>> @@ -1308,9 +1308,8 @@ int dpm_prepare(pm_message_t state)
>>>>    				error = 0;
>>>>    				continue;
>>>>    			}
>>>> -			printk(KERN_INFO "PM: Device %s not prepared "
>>>> -				"for power transition: code %d\n",
>>>> -				dev_name(dev), error);
>>>> +			dev_info("PM: not prepared for power transition: ",
>>>> +				 "code %d\n", error);
>>>
>>> Shuah, you have to make sure the files modified by
>>> your patches compile successfully before sending
>>> patches like this.
>> Oops. I did compile. Missed the warning. Sorry about that.
>
> btw:
>
> When you're doing patches like this, not bugfixes,
> not something that's going to be applied to current
> or stable, please make them against -next and not
> against Linus' tree.

ok. Makes sense changes like this don't need to be rushed. They could 
use soak time in linux-next.

>
> Also, I would make the larger change that modifies
> all the drivers like I suggested.  What you've done
> I think is a half-measure and is incomplete.
>

I was a bit reluctant to change all the drivers since the original 
message didn't include device information. However, adding device 
information would make this message more useful.

I will re-do the patch to make the larger change.

-- Shuah


-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658

From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH] power: Replace printks with pr_* routines
Date: Fri, 15 Nov 2013 15:27:51 -0700
Message-ID: <52869FE7.3050101@samsung.com>
References: <1384531806-11500-1-git-send-email-shuah.kh@samsung.com>
 <20131115211922.GB14410@kroah.com> <1384551981.18739.36.camel@joe-AO722>
 <20131115221057.GA16530@kroah.com>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:38298 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab3KOW2J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2013 17:28:09 -0500
In-reply-to: <20131115221057.GA16530@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, Shuah Khan <shuah.kh@samsung.com>

On 11/15/2013 03:10 PM, Greg KH wrote:
> On Fri, Nov 15, 2013 at 01:46:21PM -0800, Joe Perches wrote:
>> On Sat, 2013-11-16 at 06:19 +0900, Greg KH wrote:
>>> On Fri, Nov 15, 2013 at 09:10:06AM -0700, Shuah Khan wrote:
>>>> Replaced printks with pr_* routines. dev_* routines could have been used,
>>>> but chose to use pr_* to avoid breaking scripts that might be relying on
>>>> a specific text.
>>>
>>> I'd really like to switch to dev_* instead, even changing to pr_* should
>>> change the output prefix (if it's set for this file, odds are it isn't
>>> though...)
>>
>> It's not.
>>
>> Something like this?
>>
>> Pass a struct device * through to the PM
>> suspend logging routines.  Use dev_<level>
>> instead of printks.
>
> That looks good to me, Shuah, does it work for you?
>
> greg k-h
>

Looks good to me. I will update and re-send the patch.

-- Shuah
-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658

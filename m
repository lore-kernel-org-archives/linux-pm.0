From: Mayuresh Kulkarni <mkulkarni@nvidia.com>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Thu, 14 Mar 2013 19:42:15 +0530
Message-ID: <5141DABF.9050002@nvidia.com>
References: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com> <20130312134913.GD3514@kroah.com> <513F4208.4040207@nvidia.com> <87zjy7m77d.fsf@linaro.org> <20130314085916.GC18519@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:7051 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757367Ab3CNOMZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Mar 2013 10:12:25 -0400
In-Reply-To: <20130314085916.GC18519@tbergstrom-lnx.Nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Kevin Hilman <khilman@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, Mayuresh Kulkarni <mkulkarni@nvidia.com>

On Thursday 14 March 2013 02:29 PM, Peter De Schrijver wrote:
> On Wed, Mar 13, 2013 at 08:27:02PM +0100, Kevin Hilman wrote:
>> Mayuresh Kulkarni <mkulkarni@nvidia.com> writes:
>>
>>> On Tuesday 12 March 2013 07:19 PM, Greg KH wrote:
>>>> On Tue, Mar 12, 2013 at 02:19:19PM +0530, Mayuresh Kulkarni wrote:
>>>>> - this commit adds a capability to delay the powering off
>>>>> of the domain
>>>>
>>>> Why?
>>>>
>>>
>>> - As I mentioned below (sorry for mentioning below rather than at
>>> start), powering off a domain means the context save needs to be done
>>> && it needs to be restored during power on.
>>> - It often observed that saving and restoring of context is expensive
>>> in terms of power consumed as well as overall system response.
>>
>> Are you talking about per-device context save/restore?
>>
>> Your drivers should be using runtime PM, which has an autosuspend
>> timeout feature.  Using autosuspend on any device in the power domain
>> will have the same effect as this proposed patch.
>>
>> Using runtime PM to target specific devices that have expensive
>> save/restore paths is also more understandable and maintainable IMO,
>> because the "fix" is targetted.
>>
>
> No. The goal of this patch is to introduce something similar to autosuspend
> for turning off domains. Even if all peripherals in a domain are idle, you
> might not want to turn off the domain immediately, but wait a little in case
> a new request comes in. We are using this scheme today in our GPU driver and
> it works quite well, but that's done entirely without PM domains.
>
> Cheers,
>
> Peter.
>

- As Peter mentioned above, the idea is to wait for some time before 
turning off a domain with the anticipation that it will be needed soon 
for a particular use case.
- My previous comments would sound valid if you imagine a domain that 
has a single device attached to it. In such case, there are 2 things 
that happen during power-on/off: context save/restore of the device and 
powering on/off of a domain. Both of them needs energy and possibly time 
to settle down (stabilize the domain power).
- If such a domain is going to be needed very soon in future, it makes 
sense to avoid its power down for at-least that much amount of time 
(which is what the proposed patch does).

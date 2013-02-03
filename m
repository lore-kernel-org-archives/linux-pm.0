From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/4] davinci: cpuidle - some cleanups
Date: Sun, 3 Feb 2013 18:30:10 +0530
Message-ID: <510E5F5A.7020406@ti.com>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org> <510C0E4E.3010008@kernel.org> <510E4FEF.9040506@ti.com> <510E5693.5000003@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36037 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab3BCNAX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Feb 2013 08:00:23 -0500
In-Reply-To: <510E5693.5000003@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, linux-pm@vger.kernel.org

On 2/3/2013 5:52 PM, Daniel Lezcano wrote:
> On 02/03/2013 12:54 PM, Sekhar Nori wrote:
>> On 2/2/2013 12:19 AM, Len Brown wrote:
>>> On 02/01/2013 08:48 AM, Daniel Lezcano wrote:
>>>> This patchset does some cleanup. It could have been folded in a single
>>>> patch but the review would have been less clean than splitting it into
>>>> small and trivial patches.
>>>>
>>>> The main purpose of this patch is to remove the usage of the driver_data
>>>> field from the state_usage structure. Len Brown is doing this cleanup in
>>>> the intel_idle.c file. With this patchset, the processor_idle.c file will
>>>> be the last user of this field.
>>>
>>> Daniel,
>>> Thanks for this cleanup.
>>> Hopefully we can hear from somebody with davinci HW who can test it?
>>
>> Can someone forward the patches to
>> davinci-linux-open-source@linux.davincidsp.com? I can help verify.
> 
> I cc'ed this mailing list but I have not subscribed to it. The mailing
> list description says "moderated for non-subscribers" in the MAINTAINERS
> file.
> 
> I assumed the moderator will accept the patchset.
> 
> Shall I subscribe and resend ?

No need. I see the patches on the list. I will test and get back.

Thanks,
Sekhar

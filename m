From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V4] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
Date: Wed, 18 Feb 2015 11:48:23 +0530
Message-ID: <54E42EAF.1080609@linux.vnet.ibm.com>
References: <20150203061709.13097.7035.stgit@preeti.in.ibm.com> <4031451.QMQakQrpsN@vostro.rjw.lan> <54E4186B.40605@linux.vnet.ibm.com> <3335960.mm4nUDCbyI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:45872 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbBRGUJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 01:20:09 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Tue, 17 Feb 2015 23:20:08 -0700
In-Reply-To: <3335960.mm4nUDCbyI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org



On 02/18/2015 11:21 AM, Rafael J. Wysocki wrote:
> On Wednesday, February 18, 2015 10:13:23 AM Preeti U Murthy wrote:
>>
>> On 02/17/2015 11:23 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, February 17, 2015 01:29:10 PM Preeti U Murthy wrote:
>>>> Hi Rafael,
>>>
>>> Hi,
>>>
>>>> Can you please pull this patch ?
>>>
>>> Sorry, I wasn't sure whether or not the patch was for me to take and then
>>> I've been traveling lately.  Applied now.
>>
>> Hi Rafael,
>>
>> I saw that the kbuild bot reported build issues around pr_warn() in this patch.
>> I have fixed this and below is the corrected patch. Do let me know if I have
>> to send it out as a separate version/RESEND tag.
> 
> I've applied it, thanks!
> 
>>>> Another patch based on top of this is waiting to be pulled:
>>>> [PATCH] driver/cpuidle-powernv: Avoid endianness conversions while parsing DT
>>>
>>> OK, have you posted it already?
>> Yes I have. https://lkml.org/lkml/2015/2/3/24.
> 
> OK, so this one does not apply for me on top of the other.  Can you rebase it
> on top of my current linux-next branch and resend it, please?
> 
> Also I'd appreciate it if someone could ACK DT-related stuff for me.

Yes Ill get this done.
> 
>> This patch is also waiting to be pulled by you. There was some confusion
>> around who should pull this, but since it all the code is in the driver, we
>> thought it would be best if you pulled it.
> 
> Well, OK.  If you want me to apply a patch, send it To: me and not To: someone
> else.  If you send it To: someone else, I'll ignore it.
> 
> Also ask people to review and ACK things you want me to pull, especially if
> that's not stuff I'm particularly familiar with (like related to DT bindings
> specific to your platform etc.).
> 

Sure Ill do that. Thanks!

Regards
Preeti U Murthy
> 


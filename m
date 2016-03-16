From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: Questions about sleep states on ARM Juno R0
Date: Wed, 16 Mar 2016 16:51:28 +0000
Message-ID: <56E98F10.2030804@arm.com>
References: <56E80519.1040400@bsc.es>
 <CAPKp9uZ28sYvAsz2H2gid=_DStcFrRnVw70mYDkHUAcXJZy9Bw@mail.gmail.com>
 <56E98711.801@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43696 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933053AbcCPQvc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Mar 2016 12:51:32 -0400
In-Reply-To: <56E98711.801@bsc.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nishtala <rajiv.nishtala@bsc.es>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Punit Agrawal <punit.agrawal@arm.com>



On 16/03/16 16:17, nishtala wrote:
> Thanks for your reply. I have one more question.
>
> I ran a single instance of blackscholes (compute bounded
> application) with 4 threads on 4 small cores at 0.65GHz
> and then I ran it on 1 big core at 0.6GHz.
>
> The power as read from the 4 energy registers shows that the
> 1Big core at 0.6GHz consumes as much power as 4 small cores at 0.65GHz.
> Do this power proportionality number make sense?
>

Yes that seems sensible.

>>> - When the system is idle, that is, no user initiated tasks are
>>> running; I
>>> expected the counter for "usage" in CLUSTER_SLEEP_0 to remain constant,
>>> because you don't exit
>>> until any kernel interrupts occur, and is guaranteed to stay atleast for
>>> 3500us while the "time" in the same category to increase.
>>>
>> Are you not seeing any increase in interrupt count on that cpu where
>> CLUSTER_SLEEP_0 usage is increasing. Also there's not guarantee that
>> it will stay in  CLUSTER_SLEEP_0 for 3500us, it can be woken up by
>> interrupts.
> Yes, the interrupt count is also increasing.

That explains.

>>> - When I run an application only on small OR big cores, the counter
>>> "usage"
>>> for CPU_SLEEP_0 on the other type of core (big/small) still isn't
>>> updated.
>>> Am I missing something here?
>>>
>> Is this a question or your observation ? You are assuming that only your
>> applications will be running ? It depends also on several background
>> tasks
>> that are running.
> it is a question, but i believe that background tasks are running

Yes

>> [...]
>>
>>> WARNING / LEGAL TEXT: This message is intended only for the use of the
>>> individual or entity to which it is addressed and may contain
>>> information which is privileged, confidential, proprietary, or exempt
>>> from disclosure under applicable law. If you are not the intended
>>> recipient or the person responsible for delivering the message to the
>>> intended recipient, you are strictly prohibited from disclosing,
>>> distributing, copying, or in any way using this message. If you have
>>> received this communication in error, please notify the sender and
>>> destroy and delete any copies you may have received.
>>>
>> You need to fix this, please get rid of this disclaimer if you want
>> people to respond to you.
>
> I unticked add signature in my mail client. Hope it works now.
>
>
> WARNING / LEGAL TEXT: This message is intended only for the use of the
> individual or entity to which it is addressed and may contain
> information which is privileged, confidential, proprietary, or exempt
> from disclosure under applicable law. If you are not the intended
> recipient or the person responsible for delivering the message to the
> intended recipient, you are strictly prohibited from disclosing,
> distributing, copying, or in any way using this message. If you have
> received this communication in error, please notify the sender and
> destroy and delete any copies you may have received.
>
> http://www.bsc.es/disclaimer
>

Unfortunately, not yet.

-- 
Regards,
Sudeep

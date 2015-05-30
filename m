From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle: powernv/pseries: Decrease the snooze residency
Date: Sat, 30 May 2015 13:30:23 +0530
Message-ID: <55696E17.2030700@linux.vnet.ibm.com>
References: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <55686DE5.6010001@linux.vnet.ibm.com> <20150530060141.GA19134@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:38324 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbE3IAb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 May 2015 04:00:31 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Sat, 30 May 2015 04:00:30 -0400
In-Reply-To: <20150530060141.GA19134@dirshya.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: svaidy@linux.vnet.ibm.com
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, anton@samba.org, linux-pm@vger.kernel.org

On 05/30/2015 11:31 AM, Vaidyanathan Srinivasan wrote:
> * Preeti U Murthy <preeti@linux.vnet.ibm.com> [2015-05-29 19:17:17]:
> 
> [snip]
> 
>>> +	if (max_idle_state > 1) {
>>> +		snooze_timeout_en = true;
>>> +		snooze_timeout = cpuidle_state_table[1].target_residency *
>>> +				 tb_ticks_per_usec;
>>> +	}
>>
>> Any idea why we don't have snooze defined on the shared lpar configuration ?
> 
> In shared lpar case, spinning in guest context may potentially take
> away cycles from other lpars waiting to run on the same physical cpu.
> 
> So the policy in shared lpar case is to let PowerVM hypervisor know
> immediately that the guest cpu is idle which will allow the hypervisor
> to use the cycles for other tasks/lpars.
> 

Oh Ok! Thanks for the clarification !

Regards
Preeti U Murthy
> --Vaidy
> 


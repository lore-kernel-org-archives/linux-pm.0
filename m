From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/3] firmware: scpi: add device power domain support
 using genpd
Date: Fri, 17 Jun 2016 09:38:23 +0100
Message-ID: <5763B6FF.2040105@arm.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
 <1466073481-697-4-git-send-email-sudeep.holla@arm.com>
 <1466099274.20208.65.camel@linaro.org> <5762E8F1.1040401@arm.com>
 <1466151552.2841.10.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48319 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337AbcFQIi1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jun 2016 04:38:27 -0400
In-Reply-To: <1466151552.2841.10.camel@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>



On 17/06/16 09:19, Jon Medhurst (Tixy) wrote:
> On Thu, 2016-06-16 at 18:59 +0100, Sudeep Holla wrote:
>>
>> On 16/06/16 18:47, Jon Medhurst (Tixy) wrote:
>>> On Thu, 2016-06-16 at 11:38 +0100, Sudeep Holla wrote:
>>> [...]
>>>> +enum scpi_power_domain_state {
>>>> +	SCPI_PD_STATE_ON = 0,
>>>> +	SCPI_PD_STATE_OFF = 3,
>>>> +};
>>>
>>> The SCPI doc defines the meaning of these numbers (0 and 3) in the 'Juno
>>> specifics' chapter. So does these values need to come from device-tree
>>> to allow for other hardware or SCP implementations?
>>>
>>
>> Ah unfortunately true :(. I had not noticed that. But I would like to
>> check if this can be made as part of the standard protocol. Adding such
>> details to DT seems overkill and defeat of the whole purpose of the
>> standard protocol.
>
> Well. it seems to me the 'standard protocol' is whatever the current
> implementation of ARM's closed source SCP firmware is. It also seems to
> me that people are making things up as they go along, without a clue as
> to how to make things generic, robust and future proof.

Totally agree. There's an effort to come up with more standard version
of this involving partners/users soon. It's still under discussion and
the aim is to make it as good as PSCI. Let's see where it goes...

-- 
Regards,
Sudeep

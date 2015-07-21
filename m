From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH RFC] intel_pstate: play well with frequency limits set
 by acpi
Date: Tue, 21 Jul 2015 19:37:43 +0300
Message-ID: <55AE7557.5010605@yandex-team.ru>
References: <20150716181706.6500.64386.stgit@buzz>	 <1437084536.2377.117.camel@spandruv-DESK3.jf.intel.com>	 <CALYGNiMOMWY2Ng9yLQ04Ghr6fKnO_6BRLCRE2b-rnvoPJmauqQ@mail.gmail.com>	 <1437426504.2377.162.camel@spandruv-DESK3.jf.intel.com>	 <55AE1DFC.3090209@yandex-team.ru> <1437493051.2377.170.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from forward-corp1g.mail.yandex.net ([95.108.253.251]:35602 "EHLO
	forward-corp1g.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755778AbbGUQhs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 12:37:48 -0400
In-Reply-To: <1437493051.2377.170.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, Len Brown <lenb@kernel.org>, Ethan Zhao <ethan.zhao@oracle.com>

On 21.07.2015 18:37, Srinivas Pandruvada wrote:
> On Tue, 2015-07-21 at 13:25 +0300, Konstantin Khlebnikov wrote:
>> On 21.07.2015 00:08, Srinivas Pandruvada wrote:
>>> On Fri, 2015-07-17 at 07:36 +0300, Konstantin Khlebnikov wrote:
>>>> On Fri, Jul 17, 2015 at 1:08 AM, Srinivas Pandruvada
>>>> <srinivas.pandruvada@linux.intel.com> wrote:
>>>>> On Thu, 2015-07-16 at 21:17 +0300, Konstantin Khlebnikov wrote:
>>>>>> IPMI can control CPU P-states remotely: configuration is reported via
>>>>>> common ACPI interface (_PPC/_PSS/etc). This patch adds required minimal
>>>>>> support in intel_pstate to receive and use these P-state limits.
>>>>>>
>>>>>> * ignore limit of top state in _PPC: it lower than turbo boost frequency
>>>>>> * register intel_pstate in acpi-processor to get states from _PSS
>>>>>> * link acpi_processor_get_bios_limit: this adds attribute "bios_limit"
>>>>>>
>>>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>>>> ---
>>>>>>    drivers/acpi/processor_perflib.c |    3 +-
>>>>>>    drivers/cpufreq/intel_pstate.c   |   57 ++++++++++++++++++++++++++++++++++++++
>>>>>>    2 files changed, 59 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
>>>>>> index cfc8aba72f86..781e328c9d5f 100644
>>>>>> --- a/drivers/acpi/processor_perflib.c
>>>>>> +++ b/drivers/acpi/processor_perflib.c
>>>>>> @@ -98,7 +98,8 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
>>>>>>
>>>>>>         ppc = (unsigned int)pr->performance_platform_limit;
>>>>>>
>>>>>> -     if (ppc >= pr->performance->state_count)
>>>>>> +     /* Ignore limit of top state: it lower than turbo boost frequency */
>>>>>> +     if (!ppc || ppc >= pr->performance->state_count)
>>>>> Why? Isn't the previous check enough?
>>>>
>>>> Zero _PPC state must be top performance state but as I see frequency in
>>>> _PSS is lower than maximum possible turbo frequency. So, in this case
>>>> intel_pstate cannnot get "100%"  for max bound even it there is no limit set.
>>>>
>>>> For example: I saw _PSS[0] = 2601 Mhz, PSS[1] = 2600 Mhz while turbo
>>>> state is 3400 Mhz.
>>>>
>>> Have you tested dynamic _PPC modification with acpi cpufreq with this
>>> change (after boot)? Suppose _PPC is changed from 3 to 0, then
>>> cpufreq_verify_within_limits will not be called to change to new max
>>> turbo performance state.
>>>
>>
>> I haven't checked that but as I see acpi_processor_ppc_notifier()
>> can only reduce maximum frequency. So, there should be no problem
>> in this case.
> No, it can also be used in both ways. Once reduced, it can increase as
> well. _PPC can be dynamically modified by BIOS to reduce and also to
> increase.

Well, in this case BIOS will trigger ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
kernel evaluate new _PPC and call cpufreq_update_policy()
which set initial frequency min/max range according to user setup and
apply all limits after that. Initial policy->user_policy.min/max stay
unchanged. So, that dynamic modification works in both ways.

-- 
Konstantin
